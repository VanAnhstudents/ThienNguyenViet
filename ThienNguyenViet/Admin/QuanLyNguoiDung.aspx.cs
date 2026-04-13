using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
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
                        case "stats": HandleStats(); break;
                        case "list": HandleList(); break;
                        case "get": HandleGet(); break;
                        case "lock": HandleLockUnlock(0); break;
                        case "unlock": HandleLockUnlock(1); break;
                        default:
                            Response.Write("{\"ok\":false,\"msg\":\"Action khong hop le\"}");
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

        // Thong ke
        private void HandleStats()
        {
            const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.NguoiDung) AS TongTaiKhoan,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1) AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE TrangThai=0) AS TaiKhoanKhoa,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1),0) AS TongQuyenGop";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false}"); return; }
            DataRow r = dt.Rows[0];
            Response.Write(string.Format(
                "{{\"ok\":true,\"data\":{{\"tongTaiKhoan\":{0},\"nguoiDungHoatDong\":{1},\"taiKhoanKhoa\":{2},\"tongQuyenGop\":{3}}}}}",
                r["TongTaiKhoan"], r["NguoiDungHoatDong"], r["TaiKhoanKhoa"], r["TongQuyenGop"]));
        }

        // Danh sach nguoi dung (phan trang + loc)
        private void HandleList()
        {
            string tuKhoa = Request.QueryString["tuKhoa"] ?? "";
            string ttStr = Request.QueryString["trangThai"] ?? "";
            string vtStr = Request.QueryString["vaiTro"] ?? "";
            int trang = int.TryParse(Request.QueryString["trang"], out int t) ? t : 1;
            int soDong = int.TryParse(Request.QueryString["soDong"], out int s) ? s : 10;
            int offset = (trang - 1) * soDong;

            var prms = new List<SqlParameter>();
            var where = new StringBuilder(" WHERE 1=1");

            if (!string.IsNullOrWhiteSpace(tuKhoa))
            {
                where.Append(" AND (nd.HoTen LIKE N'%'+@Kw+'%' OR nd.Email LIKE N'%'+@Kw+'%')");
                prms.Add(KetNoiDB.P("@Kw", tuKhoa.Trim()));
            }
            if (ttStr == "0" || ttStr == "1")
                where.Append(" AND nd.TrangThai=" + ttStr);
            if (vtStr == "0" || vtStr == "1")
                where.Append(" AND nd.VaiTro=" + vtStr);

            // Count
            string sqlCount = "SELECT COUNT(*) FROM dbo.NguoiDung nd" + where;
            int total = Convert.ToInt32(KetNoiDB.ExecuteScalar(sqlCount, CommandType.Text, prms.ToArray()));

            // Data
            string sqlData = @"
SELECT nd.MaNguoiDung, nd.HoTen, nd.Email, nd.SoDienThoai,
       nd.VaiTro, nd.TrangThai,
       CONVERT(NVARCHAR(10), nd.NgayTao, 103) AS NgayTao,
       ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE MaNguoiDung=nd.MaNguoiDung AND TrangThai=1), 0) AS TongQuyenGop
FROM dbo.NguoiDung nd" + where +
                " ORDER BY nd.NgayTao DESC OFFSET " + offset + " ROWS FETCH NEXT " + soDong + " ROWS ONLY";

            DataTable dt = KetNoiDB.GetDataTable(sqlData, CommandType.Text, prms.ToArray());
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    MaNguoiDung = Convert.ToInt32(r["MaNguoiDung"]),
                    HoTen = r["HoTen"].ToString(),
                    Email = r["Email"] == DBNull.Value ? "" : r["Email"].ToString(),
                    SoDienThoai = r["SoDienThoai"] == DBNull.Value ? "" : r["SoDienThoai"].ToString(),
                    VaiTro = Convert.ToInt32(r["VaiTro"]),
                    TrangThai = Convert.ToInt32(r["TrangThai"]),
                    NgayTao = r["NgayTao"].ToString(),
                    TongQuyenGop = Convert.ToDecimal(r["TongQuyenGop"])
                });
            }
            Response.Write("{\"ok\":true,\"total\":" + total + ",\"data\":" + jss.Serialize(rows) + "}");
        }

        // Lay chi tiet 1 nguoi dung
        private void HandleGet()
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            const string sql = @"
SELECT nd.*, ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE MaNguoiDung=nd.MaNguoiDung AND TrangThai=1),0) AS TongQuyenGop
FROM dbo.NguoiDung nd WHERE nd.MaNguoiDung=@id";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@id", id));
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false,\"msg\":\"Khong tim thay\"}"); return; }

            DataRow r = dt.Rows[0];
            var jss = new JavaScriptSerializer();
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(new
            {
                MaNguoiDung = Convert.ToInt32(r["MaNguoiDung"]),
                HoTen = r["HoTen"].ToString(),
                Email = r["Email"]?.ToString() ?? "",
                SoDienThoai = r["SoDienThoai"]?.ToString() ?? "",
                VaiTro = Convert.ToInt32(r["VaiTro"]),
                TrangThai = Convert.ToInt32(r["TrangThai"]),
                TongQuyenGop = Convert.ToDecimal(r["TongQuyenGop"])
            }) + "}");
        }

        // Khoa hoac mo khoa tai khoan
        private void HandleLockUnlock(int trangThai)
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            KetNoiDB.ExecuteNonQuery(
                "UPDATE dbo.NguoiDung SET TrangThai=@tt WHERE MaNguoiDung=@id",
                CommandType.Text,
                KetNoiDB.P("@tt", trangThai),
                KetNoiDB.P("@id", id));

            string verb = trangThai == 1 ? "mo khoa" : "khoa";
            Response.Write("{\"ok\":true,\"msg\":\"Da " + verb + " tai khoan #" + id + "\"}");
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }
    }
}
