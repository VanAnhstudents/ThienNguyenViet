using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class DanhSachChienDich : System.Web.UI.Page
    {// ── Hero stats ─────────────────────────────────────────────────
        protected int TongChienDich { get; private set; }
        protected string TongQuyenGop { get; private set; }   // "47.200"
        protected string TongTienHuyDong { get; private set; }   // "32,4 tỷ"

        // ── Sidebar category counts ────────────────────────────────────
        protected int DemThienTai { get; private set; }
        protected int DemGiaoDuc { get; private set; }
        protected int DemYTe { get; private set; }
        protected int DemMoiTruong { get; private set; }

        // ── JSON data cho JavaScript ───────────────────────────────────
        protected string CampaignJson { get; private set; }

        // ──────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadData();
        }

        // ──────────────────────────────────────────────────────────────
        private void LoadData()
        {
            DataTable dt = ChienDichDAO.LayDanhSachCongKhai();

            TongChienDich = dt.Rows.Count;

            long tongGop = 0;
            long tongTien = 0;

            foreach (DataRow r in dt.Rows)
            {
                int maDM = Convert.ToInt32(r["MaDanhMuc"]);
                switch (maDM)
                {
                    case 1: DemThienTai++; break;
                    case 2: DemGiaoDuc++; break;
                    case 3: DemYTe++; break;
                    case 4: DemMoiTruong++; break;
                }

                tongGop += r["SoLuotGop"] == DBNull.Value ? 0 : Convert.ToInt64(r["SoLuotGop"]);
                tongTien += r["SoTienDaQuyen"] == DBNull.Value ? 0 : Convert.ToInt64(r["SoTienDaQuyen"]);
            }

            TongQuyenGop = tongGop.ToString("N0", new CultureInfo("vi-VN"));
            TongTienHuyDong = FormatTien(tongTien);
            CampaignJson = BuildJson(dt);
        }

        // ── Helpers ────────────────────────────────────────────────────
        private static string FormatTien(long n)
        {
            if (n >= 1_000_000_000)
            {
                double ty = (double)n / 1e9;
                return ty.ToString("0.#", new CultureInfo("vi-VN")) + " tỷ";
            }
            if (n >= 1_000_000)
                return (n / 1_000_000).ToString("N0", new CultureInfo("vi-VN")) + " triệu";
            return n.ToString("N0", new CultureInfo("vi-VN"));
        }

        private static string EscapeJs(string s)
        {
            if (s == null) return "";
            return s.Replace("\\", "\\\\")
                    .Replace("\"", "\\\"")
                    .Replace("\r", " ")
                    .Replace("\n", " ");
        }

        // ── Xây JSON từ DataTable ──────────────────────────────────────
        // Mapping MaDanhMuc → slug dùng trong JS filter
        //   1 = Cứu trợ thiên tai  → thien-tai
        //   2 = Học bổng & Giáo dục → giao-duc
        //   3 = Y tế cộng đồng      → y-te
        //   4 = Môi trường & Cây xanh → moi-truong
        private static string BuildJson(DataTable dt)
        {
            var catSlug = new System.Collections.Generic.Dictionary<int, string>
            {
                { 1, "thien-tai" }, { 2, "giao-duc" },
                { 3, "y-te"      }, { 4, "moi-truong" }
            };

            // Màu gradient dự phòng khi không có ảnh bìa, theo danh mục
            var gradFrom = new System.Collections.Generic.Dictionary<int, string>
            {
                { 1, "#7F1D1D" }, { 2, "#1E3A8A" },
                { 3, "#78350F" }, { 4, "#14532D" }
            };
            var gradTo = new System.Collections.Generic.Dictionary<int, string>
            {
                { 1, "#EF4444" }, { 2, "#60A5FA" },
                { 3, "#FBBF24" }, { 4, "#4ADE80" }
            };

            var sb = new StringBuilder("[");
            bool first = true;

            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;

                int ma = Convert.ToInt32(r["MaChienDich"]);
                int maDM = Convert.ToInt32(r["MaDanhMuc"]);
                int dbStat = Convert.ToInt32(r["TrangThai"]);
                int daysLeft = r["NgayConLai"] == DBNull.Value ? 0 : Math.Max(0, Convert.ToInt32(r["NgayConLai"]));
                long raised = r["SoTienDaQuyen"] == DBNull.Value ? 0 : Convert.ToInt64(r["SoTienDaQuyen"]);
                long goal = r["MucTieu"] == DBNull.Value ? 0 : Convert.ToInt64(r["MucTieu"]);
                int donors = r["SoLuotGop"] == DBNull.Value ? 0 : Convert.ToInt32(r["SoLuotGop"]);
                int createdAgo = r["NgayDaTao"] == DBNull.Value ? 0 : Convert.ToInt32(r["NgayDaTao"]);
                double pct = goal > 0 ? Math.Round((double)raised * 100.0 / goal, 1) : 0;

                string cat = catSlug.ContainsKey(maDM) ? catSlug[maDM] : "thien-tai";
                string gFrom = gradFrom.ContainsKey(maDM) ? gradFrom[maDM] : "#1E3A8A";
                string gTo = gradTo.ContainsKey(maDM) ? gradTo[maDM] : "#60A5FA";
                string anhBia = r["AnhBia"] == DBNull.Value ? "" : r["AnhBia"].ToString();

                // Ánh xạ TrangThai DB → trạng thái JS
                // DB: 1=Đang chạy, 3=Đã kết thúc
                string jsStatus;
                if (dbStat == 3 || daysLeft == 0) jsStatus = "done";
                else if (daysLeft <= 7) jsStatus = "urgent";
                else if (daysLeft <= 14) jsStatus = "ending";
                else jsStatus = "active";

                sb.AppendFormat(CultureInfo.InvariantCulture,
                    "{{id:{0},cat:\"{1}\",status:\"{2}\"," +
                    "title:\"{3}\",desc:\"{4}\"," +
                    "raised:{5},goal:{6},donors:{7},daysLeft:{8}," +
                    "gradFrom:\"{9}\",gradTo:\"{10}\"," +
                    "createdDaysAgo:{11},pct:{12}," +
                    "anhBia:\"{13}\"}}",
                    ma,
                    cat,
                    jsStatus,
                    EscapeJs(r["TenChienDich"].ToString()),
                    EscapeJs(r["MoTaNgan"] == DBNull.Value ? "" : r["MoTaNgan"].ToString()),
                    raised, goal, donors, daysLeft,
                    gFrom, gTo,
                    createdAgo,
                    pct.ToString("0.0", CultureInfo.InvariantCulture),
                    EscapeJs(anhBia)
                );
            }

            sb.Append("]");
            return sb.ToString();
        }
    }
}