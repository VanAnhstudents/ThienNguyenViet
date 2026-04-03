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
    public partial class QuanLyQuyenGop : System.Web.UI.Page
    {
        // ── Thống kê stat cards ────────────────────────────────────
        protected long TongTienDaDuyet { get; private set; }
        protected int TongGiaoDich { get; private set; }
        protected int SoChoDuyet { get; private set; }
        protected int SoDaDuyet { get; private set; }
        protected int SoTuChoi { get; private set; }

        // ── DataTable chiến dịch cho dropdown ─────────────────────
        protected DataTable DtChienDich { get; private set; }

        // ── Trang hiện tại + filter lưu lại để giữ state ──────────
        protected int CurrentPage { get; private set; } = 1;
        protected int TongSoDong { get; private set; } = 0;
        protected const int PAGE_SIZE = 10;

        // ─────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            // Chặn truy cập nếu chưa đăng nhập / không phải admin
            PhanQuyenHelper.YeuCauAdmin(this);

            // ── AJAX request ─────────────────────────────────────────
            if (Request.HttpMethod == "POST" && Request["__ajax"] == "true")
            {
                Response.ContentType = "application/json";
                Response.ContentEncoding = Encoding.UTF8;
                try
                {
                    HandleAjax();
                }
                catch (Exception ex)
                {
                    Response.Write("{\"ok\":false,\"msg\":" +
                        JsonStr("Lỗi máy chủ: " + ex.Message) + "}");
                }
                Response.End();
                return;
            }

            // ── GET bình thường ───────────────────────────────────────
            if (!IsPostBack)
            {
                LoadStatCards();
                LoadChienDichDropdown();
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  Tải thống kê stat cards
        // ─────────────────────────────────────────────────────────────
        private void LoadStatCards()
        {
            try
            {
                DataRow row = QuyenGopDAO.LayThongKeTrangQuanLy();
                if (row != null)
                {
                    TongGiaoDich = Convert.ToInt32(row["TongGiaoDich"]);
                    SoChoDuyet = Convert.ToInt32(row["SoChoDuyet"]);
                    SoDaDuyet = Convert.ToInt32(row["SoDaDuyet"]);
                    SoTuChoi = Convert.ToInt32(row["SoTuChoi"]);
                    TongTienDaDuyet = Convert.ToInt64(row["TongTienDaDuyet"]);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[QuanLyQuyenGop] LoadStatCards: " + ex.Message);
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  Tải dropdown chiến dịch
        // ─────────────────────────────────────────────────────────────
        private void LoadChienDichDropdown()
        {
            try
            {
                DtChienDich = QuyenGopDAO.LayChienDichDropdown();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[QuanLyQuyenGop] LoadChienDichDropdown: " + ex.Message);
                DtChienDich = new DataTable();
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  AJAX dispatcher
        // ─────────────────────────────────────────────────────────────
        private void HandleAjax()
        {
            string action = Request["action"] ?? "";
            switch (action)
            {
                case "list": AjaxList(); break;
                case "duyet": AjaxDuyet(1); break;
                case "tuchoi": AjaxDuyet(2); break;
                case "stats": AjaxStats(); break;
                default:
                    Response.Write("{\"ok\":false,\"msg\":\"Action không hợp lệ.\"}");
                    break;
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  AJAX: Lấy danh sách (GET params: tab, cd, q, page)
        // ─────────────────────────────────────────────────────────────
        private void AjaxList()
        {
            // Đọc tham số
            int? trangThai = null;
            int? maChienDich = null;
            string tuKhoa = Request["q"];
            int page = 1;

            string tabVal = Request["tab"];
            if (!string.IsNullOrEmpty(tabVal) && int.TryParse(tabVal, out int tt))
                trangThai = tt;

            string cdVal = Request["cd"];
            if (!string.IsNullOrEmpty(cdVal) && int.TryParse(cdVal, out int cd))
                maChienDich = cd;

            string pageVal = Request["page"];
            if (!string.IsNullOrEmpty(pageVal) && int.TryParse(pageVal, out int pg) && pg > 0)
                page = pg;

            int tongSo;
            DataTable dt = QuyenGopDAO.LayQuyenGopCoLoc(
                trangThai, maChienDich, tuKhoa, page, PAGE_SIZE, out tongSo);

            // Build JSON
            var sb = new StringBuilder();
            sb.Append("{\"ok\":true,");
            sb.AppendFormat("\"total\":{0},\"page\":{1},\"pageSize\":{2},", tongSo, page, PAGE_SIZE);
            sb.Append("\"rows\":[");

            bool first = true;
            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;

                long soTien = r["SoTien"] == DBNull.Value ? 0 : Convert.ToInt64(r["SoTien"]);
                int ts = r["TrangThai"] == DBNull.Value ? 0 : Convert.ToInt32(r["TrangThai"]);
                string hoTen = r["HoTen"].ToString();
                string email = r["Email"] == DBNull.Value ? "" : r["Email"].ToString();
                string tenCD = r["TenChienDich"].ToString();
                string loiNhan = r["LoiNhan"] == DBNull.Value ? "" : r["LoiNhan"].ToString();
                string lyDo = r["LyDoTuChoi"] == DBNull.Value ? "" : r["LyDoTuChoi"].ToString();
                string anhXN = r["AnhXacNhan"] == DBNull.Value ? "" : r["AnhXacNhan"].ToString();
                bool anDanh = r["AnDanh"] != DBNull.Value && Convert.ToBoolean(r["AnDanh"]);
                int maQG = Convert.ToInt32(r["MaQuyenGop"]);
                int maCD = Convert.ToInt32(r["MaChienDich"]);

                string ngayTao = r["NgayTao"] == DBNull.Value ? "" :
                    Convert.ToDateTime(r["NgayTao"]).ToString("dd/MM/yyyy HH:mm");
                string ngayDuyet = r["NgayDuyet"] == DBNull.Value ? "" :
                    Convert.ToDateTime(r["NgayDuyet"]).ToString("dd/MM/yyyy HH:mm");

                sb.AppendFormat(
                    "{{\"id\":{0},\"maCD\":{1},\"tenCD\":{2},\"hoTen\":{3},\"email\":{4}," +
                    "\"soTien\":{5},\"loiNhan\":{6},\"lyDo\":{7},\"anhXN\":{8}," +
                    "\"anDanh\":{9},\"trangThai\":{10},\"ngayTao\":{11},\"ngayDuyet\":{12}}}",
                    maQG,
                    maCD,
                    JsonStr(tenCD),
                    JsonStr(hoTen),
                    JsonStr(email),
                    soTien,
                    JsonStr(loiNhan),
                    JsonStr(lyDo),
                    JsonStr(anhXN),
                    anDanh ? "true" : "false",
                    ts,
                    JsonStr(ngayTao),
                    JsonStr(ngayDuyet));
            }

            sb.Append("]}");
            Response.Write(sb.ToString());
        }

        // ─────────────────────────────────────────────────────────────
        //  AJAX: Duyệt / Từ chối
        // ─────────────────────────────────────────────────────────────
        private void AjaxDuyet(int trangThai)
        {
            if (!int.TryParse(Request["id"], out int maQG))
            {
                Response.Write("{\"ok\":false,\"msg\":\"Mã giao dịch không hợp lệ.\"}");
                return;
            }

            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);
            string lyDo = Request["lydo"];

            bool ok = QuyenGopDAO.DuyetQuyenGop(maQG, trangThai, maNguoiDuyet, lyDo);
            if (ok)
            {
                string verb = trangThai == 1 ? "Đã duyệt" : "Đã từ chối";
                Response.Write("{\"ok\":true,\"msg\":" +
                    JsonStr(verb + " giao dịch #" + maQG) + "}");
            }
            else
            {
                Response.Write("{\"ok\":false,\"msg\":\"Giao dịch đã được xử lý hoặc có lỗi xảy ra.\"}");
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  AJAX: Thống kê (refresh stat cards sau khi duyệt/từ chối)
        // ─────────────────────────────────────────────────────────────
        private void AjaxStats()
        {
            DataRow row = QuyenGopDAO.LayThongKeTrangQuanLy();
            if (row == null)
            {
                Response.Write("{\"ok\":false,\"msg\":\"Không lấy được thống kê.\"}");
                return;
            }

            Response.Write(string.Format(
                "{{\"ok\":true,\"tongGD\":{0},\"choDuyet\":{1},\"daDuyet\":{2},\"tuChoi\":{3},\"tongTien\":{4}}}",
                row["TongGiaoDich"],
                row["SoChoDuyet"],
                row["SoDaDuyet"],
                row["SoTuChoi"],
                row["TongTienDaDuyet"]));
        }

        // ─────────────────────────────────────────────────────────────
        //  Helpers
        // ─────────────────────────────────────────────────────────────
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000)
                return string.Format("{0:0.##} tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000)
                return string.Format("{0:0.#} tr", (double)so / 1_000_000);
            return string.Format("{0:N0}", so) + " đ";
        }

        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"")
                               .Replace("\r", "\\r").Replace("\n", "\\n") + "\"";
    }
}