using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
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
                        case "stats": HandleStats(); break;
                        case "list": HandleList(); break;
                        case "get": HandleGet(); break;
                        case "lock": HandleLockUnlock(0); break;
                        case "unlock": HandleLockUnlock(1); break;
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

        /* ── Stats ──────────────────────────────────────────────────── */
        private void HandleStats()
        {
            const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.NguoiDung)                                                 AS TongTaiKhoan,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1)                 AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE TrangThai=0)                              AS TaiKhoanKhoa,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1),0)                  AS TongQuyenGop";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false}"); return; }
            DataRow r = dt.Rows[0];
            Response.Write(string.Format(
                "{{\"ok\":true,\"data\":{{\"tongTaiKhoan\":{0},\"nguoiDungHoatDong\":{1},\"taiKhoanKhoa\":{2},\"tongQuyenGop\":{3}}}}}",
                r["TongTaiKhoan"], r["NguoiDungHoatDong"], r["TaiKhoanKhoa"], r["TongQuyenGop"]));
        }

        /* ── List (paginated) ────────────────────────────────────────── */
        private void HandleList()
        {
            string tuKhoa = Request.QueryString["tuKhoa"] ?? "";
            string ttStr = Request.QueryString["trangThai"] ?? "";
            string vtStr = Request.QueryString["vaiTro"] ?? "";
            int trang = int.TryParse(Request.QueryString["trang"], out int t) ? t : 1;
            int soDong = int.TryParse(Request.QueryString["soDong"], out int s) ? s : 10;
            int offset = (trang - 1) * soDong;

            var sb = new StringBuilder();
            sb.Append(@"
SELECT nd.MaNguoiDung, nd.HoTen, nd.Email, nd.SoDienThoai,
       nd.VaiTro, nd.TrangThai,
       CONVERT(NVARCHAR(10), nd.NgayTao, 103) AS NgayTao,
       ISNULL(SUM(CASE WHEN qg.TrangThai=1 THEN qg.SoTien ELSE 0 END),0) AS TongGop,
       COUNT(CASE WHEN qg.TrangThai=1 THEN 1 ELSE NULL END)               AS SoLanGop
FROM dbo.NguoiDung nd
LEFT JOIN dbo.QuyenGop qg ON nd.MaNguoiDung = qg.MaNguoiDung
WHERE 1=1");
            if (!string.IsNullOrWhiteSpace(tuKhoa))
                sb.Append(" AND (nd.HoTen LIKE N'%'+@TuKhoa+'%' OR nd.Email LIKE N'%'+@TuKhoa+'%')");
            if (ttStr == "0" || ttStr == "1")
                sb.Append(" AND nd.TrangThai = " + ttStr);
            if (vtStr == "0" || vtStr == "1")
                sb.Append(" AND nd.VaiTro = " + vtStr);
            sb.Append(@"
GROUP BY nd.MaNguoiDung, nd.HoTen, nd.Email, nd.SoDienThoai, nd.VaiTro, nd.TrangThai, nd.NgayTao
ORDER BY nd.NgayTao DESC
OFFSET " + offset + " ROWS FETCH NEXT " + soDong + " ROWS ONLY");

            // Count
            var sbCount = new StringBuilder();
            sbCount.Append("SELECT COUNT(*) FROM dbo.NguoiDung nd WHERE 1=1");
            if (!string.IsNullOrWhiteSpace(tuKhoa))
                sbCount.Append(" AND (nd.HoTen LIKE N'%'+@TuKhoa+'%' OR nd.Email LIKE N'%'+@TuKhoa+'%')");
            if (ttStr == "0" || ttStr == "1")
                sbCount.Append(" AND nd.TrangThai = " + ttStr);
            if (vtStr == "0" || vtStr == "1")
                sbCount.Append(" AND nd.VaiTro = " + vtStr);

            var prm = string.IsNullOrWhiteSpace(tuKhoa)
                ? new System.Data.SqlClient.SqlParameter[0]
                : new[] { KetNoiDB.P("@TuKhoa", tuKhoa.Trim()) };

            int total = Convert.ToInt32(KetNoiDB.ExecuteScalar(sbCount.ToString(), CommandType.Text, prm));
            DataTable dt = KetNoiDB.GetDataTable(sb.ToString(), CommandType.Text, prm);

            var jss = new JavaScriptSerializer();
            var rows = new System.Collections.Generic.List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    MaNguoiDung = r["MaNguoiDung"],
                    HoTen = r["HoTen"].ToString(),
                    Email = r["Email"].ToString(),
                    SoDienThoai = r["SoDienThoai"] == DBNull.Value ? "" : r["SoDienThoai"].ToString(),
                    VaiTro = Convert.ToInt32(r["VaiTro"]),
                    TrangThai = Convert.ToInt32(r["TrangThai"]),
                    NgayTao = r["NgayTao"].ToString(),
                    TongGop = Convert.ToDecimal(r["TongGop"]),
                    SoLanGop = Convert.ToInt32(r["SoLanGop"])
                });
            }
            Response.Write("{\"ok\":true,\"total\":" + total + ",\"data\":" + jss.Serialize(rows) + "}");
        }

        /* ── Get single user ────────────────────────────────────────── */
        private void HandleGet()
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"Invalid id\"}"); return; }

            const string sqlUser = @"
SELECT nd.MaNguoiDung, nd.HoTen, nd.Email, nd.SoDienThoai, nd.VaiTro, nd.TrangThai,
       CONVERT(NVARCHAR(10), nd.NgayTao, 103) AS NgayTao,
       ISNULL(SUM(CASE WHEN qg.TrangThai=1 THEN qg.SoTien ELSE 0 END),0) AS TongGop,
       COUNT(CASE WHEN qg.TrangThai=1 THEN 1 ELSE NULL END)               AS SoLanGop
FROM dbo.NguoiDung nd
LEFT JOIN dbo.QuyenGop qg ON nd.MaNguoiDung=qg.MaNguoiDung
WHERE nd.MaNguoiDung=@id
GROUP BY nd.MaNguoiDung,nd.HoTen,nd.Email,nd.SoDienThoai,nd.VaiTro,nd.TrangThai,nd.NgayTao";

            DataTable dtUser = KetNoiDB.GetDataTable(sqlUser, CommandType.Text, KetNoiDB.P("@id", id));
            if (dtUser.Rows.Count == 0) { Response.Write("{\"ok\":false,\"msg\":\"Not found\"}"); return; }
            DataRow u = dtUser.Rows[0];

            const string sqlDon = @"
SELECT TOP 5 cd.TenChienDich, qg.SoTien, qg.TrangThai,
       CONVERT(NVARCHAR(10), qg.NgayTao, 103) AS NgayTao
FROM dbo.QuyenGop qg
INNER JOIN dbo.ChienDich cd ON qg.MaChienDich=cd.MaChienDich
WHERE qg.MaNguoiDung=@id
ORDER BY qg.NgayTao DESC";
            DataTable dtDon = KetNoiDB.GetDataTable(sqlDon, CommandType.Text, KetNoiDB.P("@id", id));

            var donations = new System.Collections.Generic.List<object>();
            foreach (DataRow d in dtDon.Rows)
            {
                donations.Add(new
                {
                    TenChienDich = d["TenChienDich"].ToString(),
                    SoTien = Convert.ToDecimal(d["SoTien"]),
                    TrangThai = Convert.ToInt32(d["TrangThai"]),
                    NgayTao = d["NgayTao"].ToString()
                });
            }

            var jss = new JavaScriptSerializer();
            var user = new
            {
                MaNguoiDung = Convert.ToInt32(u["MaNguoiDung"]),
                HoTen = u["HoTen"].ToString(),
                Email = u["Email"].ToString(),
                SoDienThoai = u["SoDienThoai"] == DBNull.Value ? "" : u["SoDienThoai"].ToString(),
                VaiTro = Convert.ToInt32(u["VaiTro"]),
                TrangThai = Convert.ToInt32(u["TrangThai"]),
                NgayTao = u["NgayTao"].ToString(),
                TongGop = Convert.ToDecimal(u["TongGop"]),
                SoLanGop = Convert.ToInt32(u["SoLanGop"]),
                Donations = donations
            };
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(user) + "}");
        }

        /* ── Lock / Unlock ───────────────────────────────────────────── */
        private void HandleLockUnlock(int newStatus)
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"Invalid id\"}"); return; }

            // Không cho khóa admin
            object vaiTro = KetNoiDB.ExecuteScalar(
                "SELECT VaiTro FROM dbo.NguoiDung WHERE MaNguoiDung=@id",
                CommandType.Text, KetNoiDB.P("@id", id));
            if (vaiTro != null && Convert.ToInt32(vaiTro) == 1)
            {
                Response.Write("{\"ok\":false,\"msg\":\"Không thể thao tác với tài khoản Admin.\"}");
                return;
            }

            int rows = KetNoiDB.ExecuteNonQuery(
                "UPDATE dbo.NguoiDung SET TrangThai=@ts, NgayCapNhat=GETDATE() WHERE MaNguoiDung=@id",
                CommandType.Text,
                KetNoiDB.P("@ts", newStatus),
                KetNoiDB.P("@id", id));

            if (rows > 0) Response.Write("{\"ok\":true}");
            else Response.Write("{\"ok\":false,\"msg\":\"Không tìm thấy người dùng.\"}");
        }

        /* ── Helper ──────────────────────────────────────────────────── */
        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }
    }
}