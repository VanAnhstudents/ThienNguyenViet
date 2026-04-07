using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class BaoCao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // PhanQuyenHelper.YeuCauAdmin(this);

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
                        case "export": HandleExport(); break;
                        default:
                            Response.Write("{\"ok\":false,\"msg\":\"Unknown action\"}");
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

        /* ── Summary Cards ───────────────────────────────────────────── */
        private void HandleSummary()
        {
            int year = int.TryParse(Request.QueryString["year"], out int y) ? y : DateTime.Now.Year;

            const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.ChienDich WHERE TrangThai=1)                              AS ChienDichDangChay,
    (SELECT COUNT(*) FROM dbo.ChienDich)                                                AS TongChienDich,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1)                AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0)                                AS TongNguoiDung,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year),0) AS TongTienQuyen,
    (SELECT COUNT(*) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year)    AS TongLuotQuyen,
    (SELECT COUNT(DISTINCT MONTH(NgayDuyet)) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year) AS SoThangCoDuLieu";

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
                "\"tongLuotQuyen\":{5}," +
                "\"soThangCoDuLieu\":{6}" +
                "}}}}",
                r["ChienDichDangChay"],
                r["TongChienDich"],
                r["NguoiDungHoatDong"],
                r["TongNguoiDung"],
                r["TongTienQuyen"],
                r["TongLuotQuyen"],
                r["SoThangCoDuLieu"]
            ));
        }

        /* ── Monthly Chart Data ──────────────────────────────────────── */
        private void HandleMonthly()
        {
            int year = int.TryParse(Request.QueryString["year"], out int y) ? y : DateTime.Now.Year;

            const string sql = @"
SELECT MONTH(NgayDuyet) AS Thang, ISNULL(SUM(SoTien),0) AS TongTien
FROM dbo.QuyenGop
WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year
GROUP BY MONTH(NgayDuyet)
ORDER BY Thang";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", year));
            var jss = new JavaScriptSerializer();
            var rows = new System.Collections.Generic.List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new { Thang = Convert.ToInt32(r["Thang"]), TongTien = Convert.ToDecimal(r["TongTien"]) });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        /* ── Pie — phân bổ theo danh mục ────────────────────────────── */
        private void HandlePie()
        {
            const string sql = @"
SELECT dm.TenDanhMuc, dm.MauSac,
       ISNULL(SUM(qg.SoTien),0) AS TongTien
FROM dbo.DanhMucChienDich dm
LEFT JOIN dbo.ChienDich cd ON cd.MaDanhMuc = dm.MaDanhMuc
LEFT JOIN dbo.QuyenGop  qg ON qg.MaChienDich = cd.MaChienDich AND qg.TrangThai=1
GROUP BY dm.MaDanhMuc, dm.TenDanhMuc, dm.MauSac, dm.ThuTuHienThi
ORDER BY dm.ThuTuHienThi";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new System.Collections.Generic.List<object>();
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

        /* ── Top 10 Chiến dịch ───────────────────────────────────────── */
        private void HandleTopCD()
        {
            const string sql = @"
SELECT TOP 10
    cd.TenChienDich, cd.SoTienDaQuyen, cd.MucTieu,
    dm.TenDanhMuc, dm.MauSac AS MauDanhMuc
FROM dbo.ChienDich cd
INNER JOIN dbo.DanhMucChienDich dm ON cd.MaDanhMuc=dm.MaDanhMuc
ORDER BY cd.SoTienDaQuyen DESC";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new System.Collections.Generic.List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    TenChienDich = r["TenChienDich"].ToString(),
                    SoTienDaQuyen = Convert.ToDecimal(r["SoTienDaQuyen"]),
                    MucTieu = Convert.ToDecimal(r["MucTieu"]),
                    TenDanhMuc = r["TenDanhMuc"].ToString(),
                    MauDanhMuc = r["MauDanhMuc"] == DBNull.Value ? "#3182CE" : r["MauDanhMuc"].ToString()
                });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        /* ── Top 10 Donors ───────────────────────────────────────────── */
        private void HandleTopDonors()
        {
            const string sql = @"
SELECT TOP 10
    nd.MaNguoiDung, nd.HoTen, nd.Email,
    COUNT(qg.MaQuyenGop)  AS SoLanQuyen,
    SUM(qg.SoTien)         AS TongTienDaQuyen
FROM dbo.QuyenGop qg
INNER JOIN dbo.NguoiDung nd ON qg.MaNguoiDung=nd.MaNguoiDung
WHERE qg.TrangThai=1 AND qg.AnDanh=0
GROUP BY nd.MaNguoiDung, nd.HoTen, nd.Email
ORDER BY TongTienDaQuyen DESC";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new System.Collections.Generic.List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    MaNguoiDung = Convert.ToInt32(r["MaNguoiDung"]),
                    HoTen = r["HoTen"].ToString(),
                    Email = r["Email"].ToString(),
                    SoLanQuyen = Convert.ToInt32(r["SoLanQuyen"]),
                    TongTienDaQuyen = Convert.ToDecimal(r["TongTienDaQuyen"])
                });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        /* ── Export Excel placeholder ────────────────────────────────── */
        private void HandleExport()
        {
            int year = int.TryParse(Request.QueryString["year"], out int y) ? y : DateTime.Now.Year;
            // Placeholder — có thể tích hợp ClosedXML hoặc EPPlus ở đây
            Response.ContentType = "application/json";
            Response.Write("{\"ok\":false,\"msg\":\"Chức năng xuất Excel cần tích hợp thư viện ClosedXML.\"}");
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }
    }
}