using System;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class FormTinTuc : System.Web.UI.Page
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
                        case "get": HandleGet(); break;
                        case "insert": HandleSave(false); break;
                        case "update": HandleSave(true); break;
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

        // Lay bai viet theo ID
        private void HandleGet()
        {
            int id = int.TryParse(Request.QueryString["id"], out int i) ? i : 0;
            if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            const string sql = @"
SELECT tt.MaTinTuc, tt.TieuDe, tt.TomTat, tt.NoiDung, tt.AnhBia,
       tt.MaDanhMuc, tt.TrangThai, tt.LuotXem,
       CONVERT(NVARCHAR(10), tt.NgayDang, 23) AS NgayDang,
       nd.HoTen AS NguoiDang
FROM dbo.TinTuc tt
INNER JOIN dbo.NguoiDung nd ON tt.MaNguoiDang = nd.MaNguoiDung
WHERE tt.MaTinTuc = @id";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@id", id));
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false,\"msg\":\"Khong tim thay bai viet.\"}"); return; }

            DataRow r = dt.Rows[0];
            var jss = new JavaScriptSerializer();
            var data = new
            {
                MaTinTuc = Convert.ToInt32(r["MaTinTuc"]),
                TieuDe = r["TieuDe"].ToString(),
                TomTat = r["TomTat"] == DBNull.Value ? "" : r["TomTat"].ToString(),
                NoiDung = r["NoiDung"] == DBNull.Value ? "" : r["NoiDung"].ToString(),
                AnhBia = r["AnhBia"] == DBNull.Value ? "" : r["AnhBia"].ToString(),
                MaDanhMuc = Convert.ToInt32(r["MaDanhMuc"]),
                TrangThai = Convert.ToInt32(r["TrangThai"]),
                LuotXem = Convert.ToInt32(r["LuotXem"]),
                NgayDang = r["NgayDang"].ToString(),
                NguoiDang = r["NguoiDang"].ToString()
            };
            Response.Write("{\"ok\":true,\"data\":" + jss.Serialize(data) + "}");
        }

        // Them moi hoac cap nhat
        private void HandleSave(bool isUpdate)
        {
            string tieuDe = Request.QueryString["tieuDe"] ?? "";
            string tomTat = Request.QueryString["tomTat"] ?? "";
            string noiDung = Request.QueryString["noiDung"] ?? "";
            string anhBia = Request.QueryString["anhBia"] ?? "";
            string ngayDang = Request.QueryString["ngayDang"] ?? "";
            int maDanhMuc = int.TryParse(Request.QueryString["maDanhMuc"], out int dm) ? dm : 0;
            int trangThai = int.TryParse(Request.QueryString["trangThai"], out int ts) ? ts : 1;

            if (string.IsNullOrWhiteSpace(tieuDe))
            { Response.Write("{\"ok\":false,\"msg\":\"Tieu de khong duoc trong.\"}"); return; }
            if (maDanhMuc <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"Vui long chon danh muc.\"}"); return; }

            int maNguoiDang = PhanQuyenHelper.LayMa(Session);
            if (maNguoiDang <= 0) maNguoiDang = 1;
            DateTime ngay = DateTime.TryParse(ngayDang, out DateTime nd) ? nd : DateTime.Now;

            if (!isUpdate)
            {
                const string sql = @"
INSERT INTO dbo.TinTuc
    (TieuDe, MaDanhMuc, AnhBia, TomTat, NoiDung, LuotXem, TrangThai, MaNguoiDang, NgayDang)
VALUES
    (@tieu, @dm, @anh, @tomtat, @noidung, 0, @ts, @nguoi, @ngay);
SELECT SCOPE_IDENTITY();";
                object newId = KetNoiDB.ExecuteScalar(sql, CommandType.Text,
                    KetNoiDB.P("@tieu", tieuDe),
                    KetNoiDB.P("@dm", maDanhMuc),
                    KetNoiDB.P("@anh", string.IsNullOrWhiteSpace(anhBia) ? (object)DBNull.Value : anhBia),
                    KetNoiDB.P("@tomtat", string.IsNullOrWhiteSpace(tomTat) ? (object)DBNull.Value : tomTat),
                    KetNoiDB.P("@noidung", string.IsNullOrWhiteSpace(noiDung) ? (object)DBNull.Value : noiDung),
                    KetNoiDB.P("@ts", trangThai),
                    KetNoiDB.P("@nguoi", maNguoiDang),
                    KetNoiDB.P("@ngay", ngay));
                Response.Write("{\"ok\":true,\"id\":" + newId + "}");
            }
            else
            {
                int id = int.TryParse(Request.QueryString["id"], out int ii) ? ii : 0;
                if (id <= 0) { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

                const string sql = @"
UPDATE dbo.TinTuc SET
    TieuDe = @tieu, MaDanhMuc = @dm, AnhBia = @anh,
    TomTat = @tomtat, NoiDung = @noidung,
    TrangThai = @ts, NgayDang = @ngay, NgayCapNhat = GETDATE()
WHERE MaTinTuc = @id";

                KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                    KetNoiDB.P("@tieu", tieuDe),
                    KetNoiDB.P("@dm", maDanhMuc),
                    KetNoiDB.P("@anh", string.IsNullOrWhiteSpace(anhBia) ? (object)DBNull.Value : anhBia),
                    KetNoiDB.P("@tomtat", string.IsNullOrWhiteSpace(tomTat) ? (object)DBNull.Value : tomTat),
                    KetNoiDB.P("@noidung", string.IsNullOrWhiteSpace(noiDung) ? (object)DBNull.Value : noiDung),
                    KetNoiDB.P("@ts", trangThai),
                    KetNoiDB.P("@ngay", ngay),
                    KetNoiDB.P("@id", id));
                Response.Write("{\"ok\":true,\"id\":" + id + "}");
            }
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }
    }
}
