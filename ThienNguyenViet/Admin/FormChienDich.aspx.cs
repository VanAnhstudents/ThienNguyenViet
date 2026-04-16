using System;
using System.Data;
using System.Text;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class FormChienDich : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request["__ajax"] == "true")
            {
                Response.ContentType = "application/json";
                Response.ContentEncoding = Encoding.UTF8;
                try { HandleAjax(); }
                catch (Exception ex) { Response.Write("{\"ok\":false,\"msg\":" + JsonStr("Loi: " + ex.Message) + "}"); }
                Response.End();
            }
        }

        private void HandleAjax()
        {
            switch (Request["action"] ?? "")
            {
                case "danhMuc": AjaxDanhMuc(); break;
                case "get": AjaxGet(); break;
                case "insert": AjaxInsert(); break;
                case "update": AjaxUpdate(); break;
                case "addTienDo": AjaxAddTienDo(); break;
                default:
                    Response.Write("{\"ok\":false,\"msg\":\"Action khong hop le\"}");
                    break;
            }
        }

        // Lay danh muc
        private void AjaxDanhMuc()
        {
            DataTable dt = ChienDichDAO.LayDanhMuc();
            var sb = new StringBuilder("{\"ok\":true,\"data\":[");
            bool first = true;
            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat("{{\"ma\":{0},\"ten\":{1},\"mau\":{2}}}",
                    r["MaDanhMuc"],
                    JsonStr(r["TenDanhMuc"].ToString()),
                    JsonStr(r["MauSac"]?.ToString() ?? "#3182CE"));
            }
            sb.Append("]}");
            Response.Write(sb.ToString());
        }

        // Lay chi tiet 1 chien dich (edit mode)
        private void AjaxGet()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            DataRow r = ChienDichDAO.LayTheoMa(id);
            if (r == null)
            { Response.Write("{\"ok\":false,\"msg\":\"Khong tim thay chien dich\"}"); return; }

            DataTable dtTD = ChienDichDAO.LayTienDo(id);

            var sb = new StringBuilder("{\"ok\":true,\"data\":{");
            sb.AppendFormat("\"MaChienDich\":{0},", r["MaChienDich"]);
            sb.AppendFormat("\"TenChienDich\":{0},", JsonStr(r["TenChienDich"].ToString()));
            sb.AppendFormat("\"MoTaNgan\":{0},", JsonStr(r["MoTaNgan"]?.ToString() ?? ""));
            sb.AppendFormat("\"NoiDung\":{0},", JsonStr(r["NoiDungChiTiet"]?.ToString() ?? ""));
            sb.AppendFormat("\"MucTieu\":{0},", r["MucTieu"]);
            sb.AppendFormat("\"MaDanhMuc\":{0},", r["MaDanhMuc"]);
            sb.AppendFormat("\"TrangThai\":{0},", r["TrangThai"]);

            bool nb = r["NoiBat"] != DBNull.Value && Convert.ToBoolean(r["NoiBat"]);
            sb.AppendFormat("\"NoiBat\":{0},", nb ? "true" : "false");

            sb.AppendFormat("\"NgayBatDau\":\"{0:yyyy-MM-dd}\",", r["NgayBatDau"]);
            sb.AppendFormat("\"NgayKetThuc\":\"{0:yyyy-MM-dd}\",", r["NgayKetThuc"]);
            sb.AppendFormat("\"ToChuc\":{0},", JsonStr(r["ToChucChuTri"]?.ToString() ?? ""));
            sb.AppendFormat("\"NganHang\":{0},", JsonStr(r["TenNganHang"]?.ToString() ?? ""));
            sb.AppendFormat("\"SoTaiKhoan\":{0},", JsonStr(r["SoTaiKhoan"]?.ToString() ?? ""));
            sb.AppendFormat("\"ChuTaiKhoan\":{0},", JsonStr(r["TenChuTaiKhoan"]?.ToString() ?? ""));
            sb.AppendFormat("\"AnhBia\":{0},", JsonStr(r["AnhBia"]?.ToString() ?? ""));

            // Tien do
            sb.Append("\"tienDo\":[");
            bool first = true;
            foreach (DataRow td in dtTD.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat("{{\"TieuDe\":{0},\"NoiDung\":{1},\"NgayDang\":\"{2:dd/MM/yyyy}\"}}",
                    JsonStr(td["TieuDe"].ToString()),
                    JsonStr(td["NoiDung"]?.ToString() ?? ""),
                    td["NgayDang"]);
            }
            sb.Append("]}}");
            Response.Write(sb.ToString());
        }

        // Them chien dich moi
        private void AjaxInsert()
        {
            int maNguoiTao = PhanQuyenHelper.LayMa(Session);
            string ten = Request["ten"] ?? "";
            string moTa = Request["moTa"] ?? "";
            string noiDung = Request["noiDung"] ?? "";
            long mucTieu = long.TryParse(Request["mucTieu"], out long mt) ? mt : 0;
            DateTime ngayBD = DateTime.Parse(Request["ngayBD"]);
            DateTime ngayKT = DateTime.Parse(Request["ngayKT"]);
            string toChuc = Request["toChuc"] ?? "";
            string nganHang = Request["nganHang"] ?? "";
            string stk = Request["stk"] ?? "";
            string chuTK = Request["chuTK"] ?? "";
            string anhBia = Request["anhBia"] ?? "";
            int maDanhMuc = int.TryParse(Request["maDanhMuc"], out int dm) ? dm : 1;
            bool noiBat = Request["noiBat"] == "1";
            int trangThai = int.TryParse(Request["trangThai"], out int ts) ? ts : 0;

            int newId = ChienDichDAO.Them(ten, moTa, noiDung, mucTieu, ngayBD, ngayKT,
                toChuc, nganHang, stk, chuTK, anhBia, maDanhMuc, noiBat, trangThai, maNguoiTao);

            if (newId > 0)
                Response.Write("{\"ok\":true,\"id\":" + newId + ",\"msg\":" + JsonStr("Them chien dich thanh cong") + "}");
            else
                Response.Write("{\"ok\":false,\"msg\":\"Loi khi them chien dich\"}");
        }

        // Cap nhat chien dich
        private void AjaxUpdate()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            string ten = Request["ten"] ?? "";
            string moTa = Request["moTa"] ?? "";
            string noiDung = Request["noiDung"] ?? "";
            long mucTieu = long.TryParse(Request["mucTieu"], out long mt) ? mt : 0;
            DateTime ngayBD = DateTime.Parse(Request["ngayBD"]);
            DateTime ngayKT = DateTime.Parse(Request["ngayKT"]);
            string toChuc = Request["toChuc"] ?? "";
            string nganHang = Request["nganHang"] ?? "";
            string stk = Request["stk"] ?? "";
            string chuTK = Request["chuTK"] ?? "";
            string anhBia = Request["anhBia"] ?? "";
            int maDanhMuc = int.TryParse(Request["maDanhMuc"], out int dm) ? dm : 1;
            bool noiBat = Request["noiBat"] == "1";
            int trangThai = int.TryParse(Request["trangThai"], out int ts) ? ts : 0;

            bool ok = ChienDichDAO.Sua(id, ten, moTa, noiDung, mucTieu, ngayBD, ngayKT,
                toChuc, nganHang, stk, chuTK, anhBia, maDanhMuc, noiBat, trangThai);

            Response.Write(ok
                ? "{\"ok\":true,\"msg\":" + JsonStr("Cap nhat chien dich thanh cong") + "}"
                : "{\"ok\":false,\"msg\":\"Loi khi cap nhat chien dich\"}");
        }

        // Them cap nhat tien do
        private void AjaxAddTienDo()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID khong hop le\"}"); return; }

            string tieuDe = Request["tieu"] ?? "";
            string noiDung = Request["noi"] ?? "";
            DateTime ngay = DateTime.TryParse(Request["ngay"], out DateTime dt) ? dt : DateTime.Now;
            int maNguoiDang = PhanQuyenHelper.LayMa(Session);

            bool ok = ChienDichDAO.ThemTienDo(id, tieuDe, noiDung, ngay, maNguoiDang);

            Response.Write(ok
                ? "{\"ok\":true,\"msg\":\"Da them cap nhat tien do\"}"
                : "{\"ok\":false,\"msg\":\"Loi khi them tien do\"}");
        }

        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"")
                               .Replace("\r", "\\r").Replace("\n", "\\n") + "\"";
    }
}
