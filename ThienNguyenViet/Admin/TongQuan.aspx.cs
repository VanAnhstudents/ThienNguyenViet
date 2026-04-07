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
        // ── Dữ liệu bind lên ASPX ─────────────────────────────
        protected long TongTienDaQuyen { get; private set; }
        protected int ChienDichDangChay { get; private set; }
        protected int TongNguoiDung { get; private set; }
        protected int TongChoXuLy { get; private set; }
        protected int GiaoDichThang { get; private set; }
        protected int GiaoDichDaDuyet { get; private set; }
        protected int ChienDichHoanThanh { get; private set; }

        protected DataTable DtGiaoDich { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request.HttpMethod == "POST" && Request["__ajax"] == "true")
            {
                HandleAjax();
                Response.End();
                return;
            }

            if (!IsPostBack) LoadData();
        }

        // ── Tải dữ liệu ───────────────────────────────────────
        private void LoadData()
        {
            try
            {
                DataRow row = QuyenGopDAO.LayThongKeTongQuan();
                if (row != null)
                {
                    TongTienDaQuyen = Convert.ToInt64(row["TongTienDaQuyen"]);
                    ChienDichDangChay = Convert.ToInt32(row["TongChienDichDangChay"]);
                    TongNguoiDung = Convert.ToInt32(row["TongNguoiDung"]);
                    TongChoXuLy = Convert.ToInt32(row["TongChoXuLy"]);
                }

                int thang = DateTime.Now.Month, nam = DateTime.Now.Year;
                GiaoDichThang = QuyenGopDAO.DemGiaoDichThang(thang, nam);
                GiaoDichDaDuyet = QuyenGopDAO.DemDaDuyetThang(thang, nam);
                ChienDichHoanThanh = QuyenGopDAO.DemChienDichHoanThanh();

                // Query mở rộng: bổ sung LoiNhan + AnhXacNhan để modal Xem dùng được
                DtGiaoDich = KetNoiDB.GetDataTable(@"
SELECT TOP 10
    qg.MaQuyenGop,
    CASE WHEN qg.AnDanh = 1 THEN N'Ẩn danh'
         ELSE ISNULL(nd.HoTen, N'Ẩn danh') END AS HoTen,
    nd.Email,
    cd.TenChienDich,
    qg.SoTien,
    qg.NgayTao,
    qg.TrangThai,
    qg.AnDanh,
    ISNULL(qg.LoiNhan,    N'') AS LoiNhan,
    ISNULL(qg.AnhXacNhan, N'') AS AnhXacNhan
FROM       dbo.QuyenGop   qg
LEFT JOIN  dbo.NguoiDung  nd ON qg.MaNguoiDung  = nd.MaNguoiDung
INNER JOIN dbo.ChienDich  cd ON qg.MaChienDich   = cd.MaChienDich
ORDER BY qg.NgayTao DESC", CommandType.Text);

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
                System.Diagnostics.Debug.WriteLine("[TongQuan] LoadData error: " + ex.Message);
            }
        }

        // ── AJAX dispatcher ────────────────────────────────────
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
                Response.Write("{\"ok\":false,\"msg\":" + JsonStr("Lỗi: " + ex.Message) + "}");
            }
        }

        private void AjaxDuyetQuyenGop(int trangThai)
        {
            if (!int.TryParse(Request["id"], out int maQG))
            { Response.Write("{\"ok\":false,\"msg\":\"Mã giao dịch không hợp lệ.\"}"); return; }

            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);
            string lyDo = Request["lydo"];
            bool ok = QuyenGopDAO.DuyetQuyenGop(maQG, trangThai, maNguoiDuyet, lyDo);

            if (ok)
            {
                string verb = trangThai == 1 ? "Đã duyệt" : "Đã từ chối";
                Response.Write("{\"ok\":true,\"msg\":" + JsonStr(verb + " giao dịch #" + maQG) + "}");
            }
            else
                Response.Write("{\"ok\":false,\"msg\":\"Giao dịch đã được xử lý hoặc có lỗi xảy ra.\"}");
        }

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

        private void AjaxCampaigns()
        {
            DataTable dt = ChienDichDAO.LayChienDichNoiBat(5);
            var sb = new StringBuilder("[");
            bool first = true;
            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat("{{\"ten\":{0},\"pct\":{1},\"quyen\":{2},\"muctieu\":{3}}}",
                    JsonStr(r["TenChienDich"].ToString()),
                    r["PhanTram"], r["SoTienDaQuyen"], r["MucTieu"]);
            }
            sb.Append("]");
            Response.Write("{\"ok\":true,\"data\":" + sb + "}");
        }

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

        // ── Helpers ────────────────────────────────────────────
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000) return string.Format("{0:0.##} tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000) return string.Format("{0:0.#} tr", (double)so / 1_000_000);
            return string.Format("{0:N0}", so);
        }

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

        protected string Initials(string name)
        {
            if (string.IsNullOrWhiteSpace(name) || name == "Ẩn danh") return "?";
            var parts = name.Trim().Split(' ');
            return parts[parts.Length - 1].Substring(0, 1).ToUpper();
        }

        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
    }
}