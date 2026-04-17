using System;
using System.Data;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class TrangChu : System.Web.UI.Page
    {
        // ===== BIẾN COUNTER =====
        public decimal TongTienRaw = 0;
        public int TongChienDich = 0;
        public int TongNguoiThamGia = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                LoadThongKe();
                LoadTinTuc();
            }
        }

        // ===== LOAD DANH SÁCH =====
        private void LoadData()
        {
            DataTable dt = ChienDichDAO.LayChienDichNoiBat(6);
            rptChienDich.DataSource = dt;
            rptChienDich.DataBind();
        }

        // ===== LOAD THỐNG KÊ (DÙNG HELPER) =====
        private void LoadThongKe()
        {
            // Tổng tiền
            object tongTien = KetNoiDB.ExecuteScalar("SELECT SUM(SoTienDaQuyen) FROM ChienDich");
            TongTienRaw = tongTien != DBNull.Value && tongTien != null
                ? Convert.ToDecimal(tongTien)
                : 0;

            // Tổng chiến dịch
            object tongCD = KetNoiDB.ExecuteScalar("SELECT COUNT(*) FROM ChienDich");
            TongChienDich = tongCD != null ? Convert.ToInt32(tongCD) : 0;

            object nguoiTG = KetNoiDB.ExecuteScalar(
     "SELECT COUNT(DISTINCT MaNguoiDung) FROM QuyenGop");

            TongNguoiThamGia = nguoiTG != null ? Convert.ToInt32(nguoiTG) : 0;
        }

        // ===== LẤY ẢNH =====
        protected string GetImage(object anhBia)
        {
            if (anhBia == null || anhBia == DBNull.Value)
                return "/Content/images/banner.png";

            string path = anhBia.ToString().Trim();

            if (string.IsNullOrEmpty(path))
                return "/Content/images/banner.png";

            return path;
        }
        private void LoadTinTuc()
        {
            DataTable dt = KetNoiDB.GetDataTable(
                "SELECT TOP 3 * FROM TinTuc"
            );

            rptTinTuc.DataSource = dt;
            rptTinTuc.DataBind();
        }

    }
}