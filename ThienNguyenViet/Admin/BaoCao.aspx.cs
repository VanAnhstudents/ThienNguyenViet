using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class BaoCao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request.QueryString["__ajax"] == "true")
            {
                Response.ContentType = "application/json; charset=utf-8";
                Response.Cache.SetNoStore();
                string action = Request.QueryString["action"] ?? "";
                try
                {
                    switch (action)
                    {
                        case "summary": HandleSummary(); break;
                        case "monthly": HandleMonthly(); break;
                        case "pie": HandlePie(); break;
                        case "topCD": HandleTopCD(); break;
                        case "topDonors": HandleTopDonors(); break;
                        default:
                            Response.Write("{\"ok\":false,\"msg\":\"Action không hợp lệ\"}");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("{\"ok\":false,\"msg\":" + JsonStr(ex.Message) + "}");
                }
                Response.End();
            }
        }

        // Thong ke tong hop theo nam
        private void HandleSummary()
        {
            int year = int.TryParse(Request.QueryString["year"], out int y) ? y : DateTime.Now.Year;

            const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.ChienDich WHERE TrangThai=1) AS ChienDichDangChay,
    (SELECT COUNT(*) FROM dbo.ChienDich) AS TongChienDich,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1) AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0) AS TongNguoiDung,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year),0) AS TongTienQuyen,
    (SELECT COUNT(*) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year) AS TongLuotQuyen";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", year));
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false}"); return; }
            DataRow r = dt.Rows[0];

            Response.Write(string.Format(
                "{{\"ok\":true,\"data\":{{" +
                "\"chiendichDangChay\":{0}," +
                "\"tongChienDich\":{1}," +
                "\"nguoiDungHoatDong\":{2}," +
                "\"tongNguoiDung\":{3}," +
                "\"tongTienQuyen\":{4}," +
                "\"tongLuotQuyen\":{5}" +
                "}}}}",
                r["ChienDichDangChay"], r["TongChienDich"],
                r["NguoiDungHoatDong"], r["TongNguoiDung"],
                r["TongTienQuyen"], r["TongLuotQuyen"]));
        }

        // Du lieu bieu do theo thang
        private void HandleMonthly()
        {
            int year = int.TryParse(Request.QueryString["year"], out int y) ? y : DateTime.Now.Year;

            const string sql = @"
SELECT MONTH(NgayDuyet) AS Thang,
       SUM(SoTien) AS Tien,
       COUNT(*) AS Luot
FROM dbo.QuyenGop
WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year
GROUP BY MONTH(NgayDuyet)
ORDER BY Thang";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", year));

            // Tao mang 12 thang
            var months = new List<object>();
            var dict = new Dictionary<int, DataRow>();
            foreach (DataRow r in dt.Rows)
                dict[Convert.ToInt32(r["Thang"])] = r;

            for (int m = 1; m <= 12; m++)
            {
                if (dict.ContainsKey(m))
                    months.Add(new { thang = m, tien = Convert.ToDecimal(dict[m]["Tien"]), luot = Convert.ToInt32(dict[m]["Luot"]) });
                else
                    months.Add(new { thang = m, tien = 0m, luot = 0 });
            }

            var jss = new JavaScriptSerializer();
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(months) + "}");
        }

        // Phan bo theo danh muc (pie chart)
        private void HandlePie()
        {
            const string sql = @"
SELECT dm.TenDanhMuc, dm.MauSac,
       ISNULL(SUM(qg.SoTien),0) AS TongTien
FROM dbo.DanhMucChienDich dm
LEFT JOIN dbo.ChienDich cd ON dm.MaDanhMuc = cd.MaDanhMuc
LEFT JOIN dbo.QuyenGop qg ON cd.MaChienDich = qg.MaChienDich AND qg.TrangThai=1
GROUP BY dm.TenDanhMuc, dm.MauSac
HAVING ISNULL(SUM(qg.SoTien),0) > 0
ORDER BY TongTien DESC";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    TenDanhMuc = r["TenDanhMuc"].ToString(),
                    MauSac = r["MauSac"] == DBNull.Value ? "#3182CE" : r["MauSac"].ToString(),
                    TongTien = Convert.ToDecimal(r["TongTien"])
                });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        // Top 10 chien dich
        private void HandleTopCD()
        {
            const string sql = @"
SELECT TOP 10
    cd.TenChienDich, cd.MucTieu,
    ISNULL(SUM(qg.SoTien),0) AS TongTienDaQuyen
FROM dbo.ChienDich cd
LEFT JOIN dbo.QuyenGop qg ON cd.MaChienDich = qg.MaChienDich AND qg.TrangThai=1
GROUP BY cd.MaChienDich, cd.TenChienDich, cd.MucTieu
ORDER BY TongTienDaQuyen DESC";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    TenChienDich = r["TenChienDich"].ToString(),
                    MucTieu = Convert.ToDecimal(r["MucTieu"]),
                    TongTienDaQuyen = Convert.ToDecimal(r["TongTienDaQuyen"])
                });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        // Top 10 nha hao tam
        private void HandleTopDonors()
        {
            const string sql = @"
SELECT TOP 10
    nd.MaNguoiDung, nd.HoTen, nd.Email,
    COUNT(qg.MaQuyenGop) AS SoLanQuyen,
    SUM(qg.SoTien) AS TongTienDaQuyen
FROM dbo.QuyenGop qg
INNER JOIN dbo.NguoiDung nd ON qg.MaNguoiDung=nd.MaNguoiDung
WHERE qg.TrangThai=1 AND qg.AnDanh=0
GROUP BY nd.MaNguoiDung, nd.HoTen, nd.Email
ORDER BY TongTienDaQuyen DESC";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    HoTen = r["HoTen"].ToString(),
                    Email = r["Email"].ToString(),
                    SoLanQuyen = Convert.ToInt32(r["SoLanQuyen"]),
                    TongTienDaQuyen = Convert.ToDecimal(r["TongTienDaQuyen"])
                });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }
    }
}
