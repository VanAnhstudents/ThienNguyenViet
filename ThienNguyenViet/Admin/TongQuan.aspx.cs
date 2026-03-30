using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class TongQuan : System.Web.UI.Page
    {
        // ── Dữ liệu được bind lên ASPX ────────────────────────────
        protected long TongTienDaQuyen { get; private set; }
        protected int ChienDichDangChay { get; private set; }
        protected int TongNguoiDung { get; private set; }
        protected int TongChoXuLy { get; private set; }
        protected int GiaoDichThang { get; private set; }
        protected int GiaoDichDaDuyet { get; private set; }
        protected int ChienDichHoanThanh { get; private set; }

        // Dữ liệu bảng giao dịch
        protected DataTable DtGiaoDich { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Xử lý AJAX requests (POST với __ajax=true) ────────
            if (Request.HttpMethod == "POST" && Request["__ajax"] == "true")
            {
                HandleAjax();
                Response.End();
                return;
            }

            // ── GET: tải trang bình thường ────────────────────────
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        // ── Tải toàn bộ dữ liệu từ DB ─────────────────────────────
        private void LoadData()
        {
            try
            {
                // 1. Thống kê tổng quan (gọi SP)
                DataRow row = QuyenGopDAO.LayThongKeTongQuan();
                if (row != null)
                {
                    TongTienDaQuyen = Convert.ToInt64(row["TongTienDaQuyen"]);
                    ChienDichDangChay = Convert.ToInt32(row["TongChienDichDangChay"]);
                    TongNguoiDung = Convert.ToInt32(row["TongNguoiDung"]);
                    TongChoXuLy = Convert.ToInt32(row["TongChoXuLy"]);
                }

                // 2. Thống kê tháng hiện tại
                int thang = DateTime.Now.Month;
                int nam = DateTime.Now.Year;
                GiaoDichThang = QuyenGopDAO.DemGiaoDichThang(thang, nam);
                GiaoDichDaDuyet = QuyenGopDAO.DemDaDuyetThang(thang, nam);
                ChienDichHoanThanh = QuyenGopDAO.DemChienDichHoanThanh();

                // 3. Bảng giao dịch gần đây
                DtGiaoDich = QuyenGopDAO.LayGiaoDichGanDay(10);

                // Lưu Application-level cache đơn giản cho chart data
                // (refresh mỗi 5 phút)
                string cacheKey = "ChartData_" + nam;
                if (Application[cacheKey] == null ||
                    (DateTime)Application["ChartData_Ts"] < DateTime.Now.AddMinutes(-5))
                {
                    Application[cacheKey] = BuildChartJson(nam);
                    Application["ChartData_Ts"] = DateTime.Now;
                }
            }
            catch (Exception ex)
            {
                // Ghi lỗi vào Server log — trang vẫn load với dữ liệu mặc định (0)
                System.Diagnostics.Debug.WriteLine("[TongQuan] LoadData error: " + ex.Message);
            }
        }

        // ── AJAX dispatcher ───────────────────────────────────────
        private void HandleAjax()
        {
            Response.ContentType = "application/json";
            Response.ContentEncoding = Encoding.UTF8;

            string action = Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "duyet": AjaxDuyetQuyenGop(1); break;
                    case "tuchoi": AjaxDuyetQuyenGop(2); break;
                    case "chartdata": AjaxChartData(); break;
                    case "campaigns": AjaxCampaigns(); break;
                    default:
                        Response.Write("{\"ok\":false,\"msg\":\"Action không hợp lệ.\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                Response.Write("{\"ok\":false,\"msg\":" +
                    JsonStr("Lỗi máy chủ: " + ex.Message) + "}");
            }
        }

        // ── AJAX: Duyệt / Từ chối quyên góp ──────────────────────
        private void AjaxDuyetQuyenGop(int trangThai)
        {
            if (!int.TryParse(Request["id"], out int maQG))
            {
                Response.Write("{\"ok\":false,\"msg\":\"Mã giao dịch không hợp lệ.\"}");
                return;
            }

            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);
            string lyDo = Request["lydo"] ?? null;

            bool ok = QuyenGopDAO.DuyetQuyenGop(maQG, trangThai, maNguoiDuyet, lyDo);

            if (ok)
            {
                string verb = trangThai == 1 ? "Đã duyệt" : "Đã từ chối";
                Response.Write("{\"ok\":true,\"msg\":" + JsonStr(verb + " giao dịch #" + maQG) + "}");
            }
            else
            {
                Response.Write("{\"ok\":false,\"msg\":\"Giao dịch đã được xử lý hoặc có lỗi xảy ra.\"}");
            }
        }

        // ── AJAX: Dữ liệu biểu đồ ────────────────────────────────
        private void AjaxChartData()
        {
            int nam = DateTime.Now.Year;
            string cacheKey = "ChartData_" + nam;

            string json = Application[cacheKey] as string;
            if (string.IsNullOrEmpty(json))
            {
                json = BuildChartJson(nam);
                Application[cacheKey] = json;
                Application["ChartData_Ts"] = DateTime.Now;
            }
            Response.Write(json);
        }

        // ── AJAX: Danh sách chiến dịch nổi bật ──────────────────
        private void AjaxCampaigns()
        {
            DataTable dt = ChienDichDAO.LayChienDichNoiBat(5);
            var sb = new StringBuilder("[");
            bool first = true;
            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat(
                    "{{\"ten\":{0},\"pct\":{1},\"quyen\":{2},\"muctieu\":{3}}}",
                    JsonStr(r["TenChienDich"].ToString()),
                    r["PhanTram"],
                    r["SoTienDaQuyen"],
                    r["MucTieu"]);
            }
            sb.Append("]");
            Response.Write("{\"ok\":true,\"data\":" + sb + "}");
        }

        // ── Build chart JSON (12 tháng, điền 0 cho tháng thiếu) ─
        private string BuildChartJson(int nam)
        {
            DataTable dt = QuyenGopDAO.LayQuyenGopTheoThang(nam);

            long[] tien = new long[12];
            int[] luot = new int[12];

            foreach (DataRow r in dt.Rows)
            {
                int idx = Convert.ToInt32(r["Thang"]) - 1;
                if (idx >= 0 && idx < 12)
                {
                    tien[idx] = Convert.ToInt64(r["TongTien"]);
                    luot[idx] = Convert.ToInt32(r["SoLuot"]);
                }
            }

            var sb = new StringBuilder("{\"ok\":true,");
            sb.Append("\"tien\":["); sb.Append(string.Join(",", tien)); sb.Append("],");
            sb.Append("\"luot\":["); sb.Append(string.Join(",", luot)); sb.Append("]}");
            return sb.ToString();
        }

        // ── Helpers ───────────────────────────────────────────────

        /// <summary>Format tiền VNĐ: 1.240.000.000 → "1,24 tỷ" / "320 tr" / "500.000"</summary>
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000)
                return string.Format("{0:0.##} tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000)
                return string.Format("{0:0.#} tr", (double)so / 1_000_000);
            return string.Format("{0:N0}", so);
        }

        /// <summary>Lấy badge HTML theo trạng thái quyên góp.</summary>
        protected string BadgeTrangThai(int ts)
        {
            switch (ts)
            {
                case 0: return "<span class=\"badge badge-wait\">Chờ duyệt</span>";
                case 1: return "<span class=\"badge badge-ok\">Đã duyệt</span>";
                case 2: return "<span class=\"badge badge-reject\">Từ chối</span>";
                default: return "";
            }
        }

        /// <summary>Trả về initials avatar cho tên người dùng.</summary>
        protected string Initials(string name)
        {
            if (string.IsNullOrWhiteSpace(name) || name == "Ẩn danh")
                return "?";
            var parts = name.Trim().Split(' ');
            return parts[parts.Length - 1].Substring(0, 1).ToUpper();
        }

        /// <summary>Escape string thành JSON string literal.</summary>
        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
    }
}