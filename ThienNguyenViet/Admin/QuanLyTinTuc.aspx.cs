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
    public partial class QuanLyTinTuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request.QueryString["__ajax"] == "true")
            {
                Response.ContentType = "application/json; charset=utf-8";
                Response.Cache.SetNoStore();
                try { HandleAjax(); }
                catch (Exception ex)
                {
                    Response.Write("{\"ok\":false,\"msg\":\"" +
                        ex.Message.Replace("\"", "\\\"") + "\"}");
                }
                Response.End();
            }
        }

        private void HandleAjax()
        {
            switch (Request.QueryString["action"] ?? "")
            {
                case "stats": HandleStats(); break;
                case "danhMuc": HandleDanhMuc(); break;
                case "list": HandleList(); break;
                case "toggle": HandleToggle(); break;
                case "delete": HandleDelete(); break;
                default:
                    Response.Write("{\"ok\":false,\"msg\":\"Action khong hop le\"}");
                    break;
            }
        }

        // Thong ke
        private void HandleStats()
        {
            const string sql = @"
SELECT
    COUNT(*) AS Tong,
    SUM(CASE WHEN TrangThai=1 THEN 1 ELSE 0 END) AS XuatBan,
    SUM(CASE WHEN TrangThai=0 THEN 1 ELSE 0 END) AS Nhap,
    ISNULL(SUM(LuotXem),0) AS LuotXem
FROM dbo.TinTuc";
            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false}"); return; }
            DataRow r = dt.Rows[0];
            Response.Write(string.Format(
                "{{\"ok\":true,\"tong\":{0},\"xuatBan\":{1},\"nhap\":{2},\"luotXem\":{3}}}",
                r["Tong"], r["XuatBan"], r["Nhap"], r["LuotXem"]));
        }

        // Danh muc tin tuc
        private void HandleDanhMuc()
        {
            DataTable dt = KetNoiDB.GetDataTable(
                "SELECT MaDanhMuc, TenDanhMuc FROM dbo.DanhMucTinTuc ORDER BY TenDanhMuc",
                CommandType.Text);
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new { MaDanhMuc = r["MaDanhMuc"], TenDanhMuc = r["TenDanhMuc"].ToString() });
            }
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(rows) + "}");
        }

        // Danh sach bai viet
        private void HandleList()
        {
            string tuKhoa = Request.QueryString["tuKhoa"] ?? "";
            string ttStr = Request.QueryString["trangThai"] ?? "";
            string dmStr = Request.QueryString["maDanhMuc"] ?? "";
            int trang = int.TryParse(Request.QueryString["trang"], out int t) ? t : 1;
            int soDong = int.TryParse(Request.QueryString["soDong"], out int s) ? s : 10;
            int offset = (trang - 1) * soDong;

            var prms = new List<SqlParameter>();
            var where = new StringBuilder(" WHERE 1=1");

            if (!string.IsNullOrWhiteSpace(tuKhoa))
            {
                where.Append(" AND tt.TieuDe LIKE N'%'+@TuKhoa+'%'");
                prms.Add(KetNoiDB.P("@TuKhoa", tuKhoa.Trim()));
            }
            if (ttStr == "0" || ttStr == "1")
                where.Append(" AND tt.TrangThai=" + ttStr);
            if (!string.IsNullOrWhiteSpace(dmStr) && int.TryParse(dmStr, out int dmId))
                where.Append(" AND tt.MaDanhMuc=" + dmId);

            string sqlCount = "SELECT COUNT(*) FROM dbo.TinTuc tt" + where.ToString();
            int total = Convert.ToInt32(KetNoiDB.ExecuteScalar(sqlCount, CommandType.Text, prms.ToArray()));

            string sqlData = @"
SELECT tt.MaTinTuc, tt.TieuDe, tt.TomTat, tt.AnhBia, tt.LuotXem,
       tt.TrangThai, tt.MaDanhMuc,
       CONVERT(NVARCHAR(10), tt.NgayDang, 103) AS NgayDang,
       nd.HoTen AS NguoiDang
FROM dbo.TinTuc tt
INNER JOIN dbo.NguoiDung nd ON tt.MaNguoiDang = nd.MaNguoiDung"
                + where.ToString()
                + " ORDER BY tt.NgayDang DESC OFFSET " + offset + " ROWS FETCH NEXT " + soDong + " ROWS ONLY";

            DataTable dt = KetNoiDB.GetDataTable(sqlData, CommandType.Text, prms.ToArray());
            var jss = new JavaScriptSerializer();
            var rows = new List<object>();
            foreach (DataRow r in dt.Rows)
            {
                rows.Add(new
                {
                    MaTinTuc = r["MaTinTuc"],
                    TieuDe = r["TieuDe"].ToString(),
                    TomTat = r["TomTat"] == DBNull.Value ? "" : r["TomTat"].ToString(),
                    AnhBia = r["AnhBia"] == DBNull.Value ? "" : r["AnhBia"].ToString(),
                    LuotXem = Convert.ToInt32(r["LuotXem"]),
                    TrangThai = Convert.ToInt32(r["TrangThai"]),
                    MaDanhMuc = Convert.ToInt32(r["MaDanhMuc"]),
                    NgayDang = r["NgayDang"].ToString(),
                    NguoiDang = r["NguoiDang"].ToString()
                });
            }
            Response.Write("{\"ok\":true,\"total\":" + total + ",\"data\":" + jss.Serialize(rows) + "}");
        }

        // Toggle trang thai (an/hien)
        private void HandleToggle()
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            KetNoiDB.ExecuteNonQuery(
                "UPDATE dbo.TinTuc SET TrangThai = CASE WHEN TrangThai=1 THEN 0 ELSE 1 END WHERE MaTinTuc=@id",
                CommandType.Text, KetNoiDB.P("@id", id));
            Response.Write("{\"ok\":true}");
        }

        // Xoa bai viet
        private void HandleDelete()
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            try
            {
                KetNoiDB.ExecuteNonQuery("DELETE FROM dbo.TinTuc WHERE MaTinTuc=@id",
                    CommandType.Text, KetNoiDB.P("@id", id));
                Response.Write("{\"ok\":true}");
            }
            catch
            {
                Response.Write("{\"ok\":false,\"msg\":\"Khong the xoa bai viet nay.\"}");
            }
        }
    }
}