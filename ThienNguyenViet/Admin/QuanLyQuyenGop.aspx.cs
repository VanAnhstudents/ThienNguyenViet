using System;
using System.Data;
using System.Text;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyQuyenGop : System.Web.UI.Page
    {
        private const int PAGE_SIZE = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request["__ajax"] == "true")
            {
                Response.ContentType = "application/json; charset=utf-8";
                Response.Cache.SetNoStore();
                try { HandleAjax(); }
                catch (Exception ex)
                {
                    Response.Write("{\"ok\":false,\"msg\":" + JsonStr(ex.Message) + "}");
                }
                Response.End();
            }
        }

        private void HandleAjax()
        {
            string action = Request["action"] ?? "";
            switch (action)
            {
                case "stats": HandleStats(); break;
                case "list": HandleList(); break;
                case "approve": HandleDuyet(1); break;
                case "reject": HandleDuyet(2); break;
                default:
                    Response.Write("{\"ok\":false,\"msg\":\"Action khong hop le\"}");
                    break;
            }
        }

        // Thong ke nhanh
        private void HandleStats()
        {
            const string sql = @"
SELECT
    COUNT(*) AS Tong,
    SUM(CASE WHEN TrangThai=0 THEN 1 ELSE 0 END) AS Cho,
    SUM(CASE WHEN TrangThai=1 THEN 1 ELSE 0 END) AS Duyet,
    SUM(CASE WHEN TrangThai=2 THEN 1 ELSE 0 END) AS TuChoi,
    ISNULL(SUM(CASE WHEN TrangThai=1 THEN SoTien ELSE 0 END),0) AS TongTien
FROM dbo.QuyenGop";
            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
            if (dt.Rows.Count == 0) { Response.Write("{\"ok\":false}"); return; }
            DataRow r = dt.Rows[0];
            Response.Write(string.Format(
                "{{\"ok\":true,\"total\":{0},\"cho\":{1},\"duyet\":{2},\"tuchoi\":{3},\"tongTien\":{4}}}",
                r["Tong"], r["Cho"], r["Duyet"], r["TuChoi"], r["TongTien"]));
        }

        // Danh sach quyen gop co loc + phan trang
        private void HandleList()
        {
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

                string ngayTao = r["NgayTao"] == DBNull.Value ? "" :
                    Convert.ToDateTime(r["NgayTao"]).ToString("dd/MM/yyyy HH:mm");

                sb.Append("{");
                sb.AppendFormat("\"maQG\":{0},", maQG);
                sb.AppendFormat("\"hoTen\":{0},", JsonStr(hoTen));
                sb.AppendFormat("\"email\":{0},", JsonStr(email));
                sb.AppendFormat("\"tenCD\":{0},", JsonStr(tenCD));
                sb.AppendFormat("\"soTien\":{0},", soTien);
                sb.AppendFormat("\"trangThai\":{0},", ts);
                sb.AppendFormat("\"anDanh\":{0},", anDanh ? "true" : "false");
                sb.AppendFormat("\"ngayTao\":{0},", JsonStr(ngayTao));
                sb.AppendFormat("\"loiNhan\":{0},", JsonStr(loiNhan));
                sb.AppendFormat("\"lyDo\":{0},", JsonStr(lyDo));
                sb.AppendFormat("\"anhXN\":{0}", JsonStr(anhXN));
                sb.Append("}");
            }
            sb.Append("]}");
            Response.Write(sb.ToString());
        }

        // Duyet hoac tu choi
        private void HandleDuyet(int trangThai)
        {
            if (!int.TryParse(Request["id"], out int maQG))
            { Response.Write("{\"ok\":false,\"msg\":\"Ma khong hop le\"}"); return; }

            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);
            string lyDo = Request["lydo"];
            bool ok = QuyenGopDAO.DuyetQuyenGop(maQG, trangThai, maNguoiDuyet, lyDo);

            string verb = trangThai == 1 ? "duyet" : "tu choi";
            Response.Write(ok
                ? "{\"ok\":true,\"msg\":\"Da " + verb + " giao dich #" + maQG + "\"}"
                : "{\"ok\":false,\"msg\":\"Khong the cap nhat.\"}");
        }

        private static string JsonStr(string s)
            => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"")
                               .Replace("\r", "\\r").Replace("\n", "\\n") + "\"";
    }
}
