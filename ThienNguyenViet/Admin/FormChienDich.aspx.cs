using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
                catch (Exception ex) { Response.Write("{\"ok\":false,\"msg\":" + JsonStr("Lỗi: " + ex.Message) + "}"); }
                Response.End();
            }
        }

        /* ── Dispatcher ─────────────────────────────────────────── */
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
                    Response.Write("{\"ok\":false,\"msg\":\"Action không hợp lệ\"}");
                    break;
            }
        }

        /* ── Lấy danh mục ───────────────────────────────────────── */
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

        /* ── Lấy chi tiết 1 chiến dịch (edit mode) ─────────────── */
        private void AjaxGet()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID không hợp lệ\"}"); return; }

            DataRow r = ChienDichDAO.LayTheoMa(id);
            if (r == null)
            { Response.Write("{\"ok\":false,\"msg\":\"Không tìm thấy chiến dịch\"}"); return; }

            DataTable dtTD = ChienDichDAO.LayTienDo(id);

            var sb = new StringBuilder("{\"ok\":true,\"data\":{");
            sb.AppendFormat("\"MaChienDich\":{0},", r["MaChienDich"]);
            sb.AppendFormat("\"TenChienDich\":{0},", JsonStr(r["TenChienDich"].ToString()));
            sb.AppendFormat("\"MoTaNgan\":{0},", JsonStr(r["MoTaNgan"]?.ToString() ?? ""));
            sb.AppendFormat("\"NoiDungChiTiet\":{0},", JsonStr(r["NoiDungChiTiet"]?.ToString() ?? ""));
            sb.AppendFormat("\"AnhBia\":{0},", JsonStr(r["AnhBia"]?.ToString() ?? ""));
            sb.AppendFormat("\"MucTieu\":{0},", r["MucTieu"]);
            sb.AppendFormat("\"NgayBatDau\":\"{0}\",", ((DateTime)r["NgayBatDau"]).ToString("yyyy-MM-dd"));
            sb.AppendFormat("\"NgayKetThuc\":\"{0}\",", ((DateTime)r["NgayKetThuc"]).ToString("yyyy-MM-dd"));
            sb.AppendFormat("\"TrangThai\":{0},", r["TrangThai"]);
            sb.AppendFormat("\"NoiBat\":{0},", Convert.ToBoolean(r["NoiBat"]) ? "true" : "false");
            sb.AppendFormat("\"MaDanhMuc\":{0},", r["MaDanhMuc"]);
            sb.AppendFormat("\"TenNganHang\":{0},", JsonStr(r["TenNganHang"]?.ToString() ?? ""));
            sb.AppendFormat("\"SoTaiKhoan\":{0},", JsonStr(r["SoTaiKhoan"]?.ToString() ?? ""));
            sb.AppendFormat("\"TenChuTaiKhoan\":{0},", JsonStr(r["TenChuTaiKhoan"]?.ToString() ?? ""));
            sb.AppendFormat("\"ToChucChuTri\":{0},", JsonStr(r["ToChucChuTri"]?.ToString() ?? ""));
            sb.AppendFormat("\"NgayTao\":{0},",
                r["NgayTao"] == DBNull.Value ? "\"\"" :
                JsonStr(Convert.ToDateTime(r["NgayTao"]).ToString("dd/MM/yyyy")));
            sb.AppendFormat("\"NgayCapNhat\":{0},",
                r["NgayCapNhat"] == DBNull.Value ? "\"\"" :
                JsonStr(Convert.ToDateTime(r["NgayCapNhat"]).ToString("dd/MM/yyyy")));

            sb.Append("\"TienDo\":[");
            bool first = true;
            foreach (DataRow td in dtTD.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat("{{\"TieuDe\":{0},\"NoiDung\":{1},\"NgayDang\":{2}}}",
                    JsonStr(td["TieuDe"].ToString()),
                    JsonStr(td["NoiDung"].ToString()),
                    JsonStr(td["NgayDang"] == DBNull.Value ? "" :
                        Convert.ToDateTime(td["NgayDang"]).ToString("dd/MM/yyyy")));
            }
            sb.Append("]}}");
            Response.Write(sb.ToString());
        }

        /* ── Thêm mới chiến dịch ────────────────────────────────── */
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
                Response.Write("{\"ok\":true,\"id\":" + newId + ",\"msg\":" + JsonStr("Thêm chiến dịch thành công") + "}");
            else
                Response.Write("{\"ok\":false,\"msg\":\"Lỗi khi thêm chiến dịch\"}");
        }

        /* ── Cập nhật chiến dịch ────────────────────────────────── */
        private void AjaxUpdate()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID không hợp lệ\"}"); return; }

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
                ? "{\"ok\":true,\"msg\":" + JsonStr("Cập nhật chiến dịch thành công") + "}"
                : "{\"ok\":false,\"msg\":\"Lỗi khi cập nhật chiến dịch\"}");
        }

        /* ── Thêm cập nhật tiến độ ──────────────────────────────── */
        private void AjaxAddTienDo()
        {
            if (!int.TryParse(Request["id"], out int id) || id <= 0)
            { Response.Write("{\"ok\":false,\"msg\":\"ID không hợp lệ\"}"); return; }

            string tieuDe = Request["tieu"] ?? "";
            string noiDung = Request["noi"] ?? "";
            DateTime ngay = DateTime.TryParse(Request["ngay"], out DateTime dt) ? dt : DateTime.Now;
            int maNguoiDang = PhanQuyenHelper.LayMa(Session);

            bool ok = ChienDichDAO.ThemTienDo(id, tieuDe, noiDung, ngay, maNguoiDang);

            Response.Write(ok
                ? "{\"ok\":true,\"msg\":\"Đã thêm cập nhật tiến độ\"}"
                : "{\"ok\":false,\"msg\":\"Lỗi khi thêm tiến độ\"}");
        }

        /* ── Helper ─────────────────────────────────────────────── */
        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"")
                               .Replace("\r", "\\r").Replace("\n", "\\n") + "\"";
    }
}