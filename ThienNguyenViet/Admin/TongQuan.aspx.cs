using System;
using System.Data;
using System.Text;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class TongQuan : System.Web.UI.Page
    {
        // === PROPERTIES BIND LÊN ASPX ===
        protected long TongTienDaQuyen { get; private set; }
        protected int ChienDichDangChay { get; private set; }
        protected int TongNguoiDung { get; private set; }
        protected int TongChoXuLy { get; private set; }
        protected DataTable DtGiaoDich { get; private set; }
        protected DataTable DtChienDichNoiBat { get; private set; }
        protected string ChartDataJson { get; private set; } = "[]";

        // HiddenField controls (declared in aspx)
        protected System.Web.UI.WebControls.HiddenField hfAction;
        protected System.Web.UI.WebControls.HiddenField hfParam;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "UTF-8";
            PhanQuyenHelper.YeuCauAdmin(this);

            // Xử lý hành động postback (Duyệt / Từ chối)
            if (IsPostBack)
            {
                string action = hfAction.Value;
                string param = hfParam.Value;
                if (!string.IsNullOrEmpty(action))
                {
                    XuLyHanhDong(action, param);
                    hfAction.Value = "";
                    hfParam.Value = "";
                }
            }

            LoadData();
        }

        private void XuLyHanhDong(string action, string param)
        {
            if (!int.TryParse(param, out int maQG)) return;
            int maNguoiDuyet = PhanQuyenHelper.LayMa(Session);

            switch (action)
            {
                case "duyet":
                    QuyenGopDAO.DuyetQuyenGop(maQG, 1, maNguoiDuyet, null);
                    break;
                case "tuchoi":
                    QuyenGopDAO.DuyetQuyenGop(maQG, 2, maNguoiDuyet, "Từ chối từ tổng quan");
                    break;
            }
        }

        private void LoadData()
        {
            try
            {
                // Thống kê tổng quan
                DataRow row = QuyenGopDAO.LayThongKeTongQuan();
                if (row != null)
                {
                    TongTienDaQuyen = Convert.ToInt64(row["TongTienDaQuyen"]);
                    ChienDichDangChay = Convert.ToInt32(row["TongChienDichDangChay"]);
                    TongNguoiDung = Convert.ToInt32(row["TongNguoiDung"]);
                    TongChoXuLy = Convert.ToInt32(row["TongChoXuLy"]);
                }

                // Giao dịch gần đây (10 dòng mới nhất)
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
    ISNULL(qg.LoiNhan, N'') AS LoiNhan,
    ISNULL(qg.AnhXacNhan, N'') AS AnhXacNhan
FROM dbo.QuyenGop qg
LEFT JOIN dbo.NguoiDung nd ON qg.MaNguoiDung = nd.MaNguoiDung
INNER JOIN dbo.ChienDich cd ON qg.MaChienDich = cd.MaChienDich
ORDER BY qg.NgayTao DESC", CommandType.Text);

                // Chiến dịch tiêu biểu (server-side)
                DtChienDichNoiBat = ChienDichDAO.LayChienDichNoiBat(5);

                // Dữ liệu biểu đồ (server-side JSON)
                ChartDataJson = BuildChartJson(DateTime.Now.Year);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[TongQuan] LoadData error: " + ex.Message);
            }
        }

        private string BuildChartJson(int nam)
        {
            DataTable dt = KetNoiDB.GetDataTable(@"
SELECT MONTH(NgayDuyet) AS Thang, SUM(SoTien) AS Tien
FROM dbo.QuyenGop
WHERE TrangThai = 1 AND YEAR(NgayDuyet) = @nam
GROUP BY MONTH(NgayDuyet)", CommandType.Text, KetNoiDB.P("@nam", nam));

            long[] tien = new long[12];
            foreach (DataRow r in dt.Rows)
            {
                int m = Convert.ToInt32(r["Thang"]) - 1;
                tien[m] = Convert.ToInt64(r["Tien"]);
            }
            return "[" + string.Join(",", tien) + "]";
        }

        // === HELPERS ===
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000) return string.Format("{0:0.##} tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000) return string.Format("{0:0.#} tr", (double)so / 1_000_000);
            return string.Format("{0:N0}", so);
        }
    }
}
