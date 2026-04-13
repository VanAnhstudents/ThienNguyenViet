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
        // Du lieu bind len ASPX
        protected long TongTienDaQuyen { get; private set; }
        protected int ChienDichDangChay { get; private set; }
        protected int TongNguoiDung { get; private set; }
        protected int TongChoXuLy { get; private set; }
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

        // Tai du lieu thong ke + giao dich gan day
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

                // Giao dich gan day (10 dong moi nhat)
                DtGiaoDich = KetNoiDB.GetDataTable(@"
SELECT TOP 10
    qg.MaQuyenGop,
    CASE WHEN qg.AnDanh = 1 THEN N'An danh'
         ELSE ISNULL(nd.HoTen, N'An danh') END AS HoTen,
    nd.Email,
    cd.TenChienDich,
    qg.SoTien,
    qg.NgayTao,
    qg.TrangThai,
    qg.AnDanh,
    ISNULL(qg.LoiNhan, N'') AS LoiNhan,
    ISNULL(qg.AnhXacNhan, N'') AS AnhXacNhan
FROM dbo.QuyenGop qg
LEFT JOIN dbo.NguoiDung nd ON qg.MaNguoiDung = nd.MaNguoiDung
INNER JOIN dbo.ChienDich cd ON qg.MaChienDich = cd.MaChienDich
ORDER BY qg.NgayTao DESC", CommandType.Text);

                // Cache chart data
                int nam = DateTime.Now.Year;
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

        // AJAX dispatcher
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
                        Response.Write("{\"ok\":false,\"msg\":\"Action khong hop le.\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                Response.Write("{\"ok\":false,\"msg\":" + JsonStr("Loi: " + ex.Message) + "}");
            }
        }

        // Duyet hoac tu choi quyen gop
        private void AjaxDuyetQuyenGop(int trangThai)
        {
            if (!int.TryParse(Request["id"], out int maQG))
            { Response.Write("{\"ok\":false,\"msg\":\"Ma giao dich khong hop le.\"}"); return; }

            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);
            string lyDo = Request["lydo"];
            bool ok = QuyenGopDAO.DuyetQuyenGop(maQG, trangThai, maNguoiDuyet, lyDo);

            if (ok)
            {
                string verb = trangThai == 1 ? "duyet" : "tu choi";
                Response.Write("{\"ok\":true,\"msg\":\"Da " + verb + " giao dich #" + maQG + "\"}");
            }
            else
                Response.Write("{\"ok\":false,\"msg\":\"Khong the cap nhat giao dich nay.\"}");
        }

        // Tra ve du lieu bieu do
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

        // Tra ve chien dich tieu bieu
        private void AjaxCampaigns()
        {
            DataTable dt = ChienDichDAO.LayChienDichNoiBat(5);
            var sb = new StringBuilder("{\"ok\":true,\"data\":[");
            bool first = true;
            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;
                sb.AppendFormat("{{\"TenChienDich\":{0},\"PhanTram\":{1}}}",
                    JsonStr(r["TenChienDich"].ToString()),
                    r["PhanTram"]);
            }
            sb.Append("]}");
            Response.Write(sb.ToString());
        }

        // Build JSON bieu do 12 thang
        private string BuildChartJson(int nam)
        {
            DataTable dt = KetNoiDB.GetDataTable(@"
SELECT MONTH(NgayDuyet) AS Thang,
       SUM(SoTien) AS Tien,
       COUNT(*) AS Luot
FROM dbo.QuyenGop
WHERE TrangThai = 1 AND YEAR(NgayDuyet) = @nam
GROUP BY MONTH(NgayDuyet)", CommandType.Text, KetNoiDB.P("@nam", nam));

            long[] tien = new long[12];
            int[] luot = new int[12];
            foreach (DataRow r in dt.Rows)
            {
                int m = Convert.ToInt32(r["Thang"]) - 1;
                tien[m] = Convert.ToInt64(r["Tien"]);
                luot[m] = Convert.ToInt32(r["Luot"]);
            }

            var sb = new StringBuilder("{\"ok\":true,\"tien\":[");
            sb.Append(string.Join(",", tien));
            sb.Append("],\"luot\":[");
            sb.Append(string.Join(",", luot));
            sb.Append("]}");
            return sb.ToString();
        }

        // Helpers
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000) return string.Format("{0:0.##} ty", (double)so / 1_000_000_000);
            if (so >= 1_000_000) return string.Format("{0:0.#} tr", (double)so / 1_000_000);
            return string.Format("{0:N0}", so);
        }

        protected string BadgeTrangThai(int ts)
        {
            switch (ts)
            {
                case 0: return "<span class=\"badge badge-warn\">Cho duyet</span>";
                case 1: return "<span class=\"badge badge-ok\">Da duyet</span>";
                case 2: return "<span class=\"badge badge-err\">Tu choi</span>";
                default: return "";
            }
        }

        protected string Initials(string name)
        {
            if (string.IsNullOrWhiteSpace(name) || name == "An danh") return "?";
            var parts = name.Trim().Split(' ');
            return parts[parts.Length - 1].Substring(0, 1).ToUpper();
        }

        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
    }
}