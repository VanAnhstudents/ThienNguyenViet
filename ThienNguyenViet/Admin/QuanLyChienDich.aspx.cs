using System;
using System.Data;
using System.Web;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyChienDich : System.Web.UI.Page
    {
        // === PROPERTIES BIND LÊN ASPX ===
        protected DataTable DtChienDich { get; private set; }
        protected DataTable DtDanhMuc { get; private set; }
        protected int TotalItems { get; private set; }
        protected int CurrentPage { get; private set; } = 1;
        protected int PageSize { get; private set; } = 8;
        protected string FilterStatus { get; private set; } = "";
        protected string FilterDanhMuc { get; private set; } = "";
        protected string SearchKeyword { get; private set; } = "";

        // HiddenField controls (declared in aspx)
        protected System.Web.UI.WebControls.HiddenField hfPage;
        protected System.Web.UI.WebControls.HiddenField hfFilterStatus;
        protected System.Web.UI.WebControls.HiddenField hfFilterDM;
        protected System.Web.UI.WebControls.HiddenField hfAction;
        protected System.Web.UI.WebControls.HiddenField hfParam;
        protected System.Web.UI.WebControls.TextBox txtSearch;

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            // Xử lý hành động postback (xóa)
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
        }

        // Load data trong PreRender để đảm bảo button events đã xử lý xong
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            CurrentPage = int.TryParse(hfPage.Value, out int p) && p > 0 ? p : 1;
            FilterStatus = hfFilterStatus.Value ?? "";
            FilterDanhMuc = hfFilterDM.Value ?? "";
            SearchKeyword = (txtSearch.Text ?? "").Trim();

            LoadDanhMuc();
            LoadData();
        }

        private void XuLyHanhDong(string action, string param)
        {
            if (action == "delete" && int.TryParse(param, out int id))
            {
                try
                {
                    KetNoiDB.ExecuteNonQuery("SP_XoaChienDich", CommandType.StoredProcedure,
                        KetNoiDB.P("@MaChienDich", id));
                }
                catch { /* FK constraint - có dữ liệu liên quan */ }
            }
        }

        private void LoadDanhMuc()
        {
            DtDanhMuc = ChienDichDAO.LayDanhMuc();
        }

        private void LoadData()
        {
            try
            {
                int? maDanhMuc = null;
                if (int.TryParse(FilterDanhMuc, out int dm)) maDanhMuc = dm;

                byte? trangThai = null;
                if (byte.TryParse(FilterStatus, out byte tt)) trangThai = tt;

                string tuKhoa = string.IsNullOrWhiteSpace(SearchKeyword) ? null : SearchKeyword;

                DtChienDich = KetNoiDB.GetDataTable("SP_LayDanhSachChienDich",
                    CommandType.StoredProcedure,
                    KetNoiDB.P("@MaDanhMuc", maDanhMuc),
                    KetNoiDB.P("@TrangThai", trangThai),
                    KetNoiDB.P("@TuKhoa", tuKhoa),
                    KetNoiDB.P("@SapXepTheo", "NgayTao"),
                    KetNoiDB.P("@TrangHienTai", CurrentPage),
                    KetNoiDB.P("@SoDoiMoiTrang", PageSize));

                object totalObj = KetNoiDB.ExecuteScalar(@"
SELECT COUNT(*) FROM dbo.ChienDich
WHERE (@MaDanhMuc IS NULL OR MaDanhMuc = @MaDanhMuc)
  AND (@TrangThai IS NULL OR TrangThai = @TrangThai)
  AND (@TuKhoa IS NULL OR TenChienDich LIKE '%' + @TuKhoa + '%')",
                    CommandType.Text,
                    KetNoiDB.P("@MaDanhMuc", maDanhMuc),
                    KetNoiDB.P("@TrangThai", trangThai),
                    KetNoiDB.P("@TuKhoa", tuKhoa));

                TotalItems = totalObj == DBNull.Value ? 0 : Convert.ToInt32(totalObj);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[QuanLyChienDich] LoadData error: " + ex.Message);
            }
        }

        protected int TotalPages
        {
            get { return TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / PageSize) : 1; }
        }

        // === EVENT: Tìm kiếm (đặt trang về 1) ===
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            hfPage.Value = "1";
        }

        // === EVENT: Đặt lại tất cả bộ lọc ===
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            hfFilterStatus.Value = "";
            hfFilterDM.Value = "";
            hfPage.Value = "1";
        }
    }
}
