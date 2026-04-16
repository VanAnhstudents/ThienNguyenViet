using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
    {
        // === PROPERTIES BIND LÊN ASPX ===
        protected int TongTaiKhoan { get; private set; }
        protected int NguoiDungHoatDong { get; private set; }
        protected int TaiKhoanKhoa { get; private set; }
        protected long TongQuyenGop { get; private set; }
        protected DataTable DtNguoiDung { get; private set; }
        protected int TotalItems { get; private set; }
        protected int CurrentPage { get; private set; } = 1;
        protected int PageSize { get; private set; } = 10;
        protected string FilterTT { get; private set; } = "";
        protected string FilterVT { get; private set; } = "";
        protected string SearchKeyword { get; private set; } = "";

        // HiddenField controls (declared in aspx)
        protected System.Web.UI.WebControls.HiddenField hfPage;
        protected System.Web.UI.WebControls.HiddenField hfFilterTT;
        protected System.Web.UI.WebControls.HiddenField hfFilterVT;
        protected System.Web.UI.WebControls.HiddenField hfAction;
        protected System.Web.UI.WebControls.HiddenField hfParam;
        protected System.Web.UI.WebControls.TextBox txtSearch;

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            // Xử lý hành động postback (khóa/mở khóa)
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
            FilterTT = hfFilterTT.Value ?? "";
            FilterVT = hfFilterVT.Value ?? "";
            SearchKeyword = (txtSearch.Text ?? "").Trim();

            LoadStats();
            LoadData();
        }

        private void XuLyHanhDong(string action, string param)
        {
            if (!int.TryParse(param, out int id) || id <= 0) return;

            switch (action)
            {
                case "lock":
                    KetNoiDB.ExecuteNonQuery(
                        "UPDATE dbo.NguoiDung SET TrangThai=0 WHERE MaNguoiDung=@id",
                        CommandType.Text, KetNoiDB.P("@id", id));
                    break;
                case "unlock":
                    KetNoiDB.ExecuteNonQuery(
                        "UPDATE dbo.NguoiDung SET TrangThai=1 WHERE MaNguoiDung=@id",
                        CommandType.Text, KetNoiDB.P("@id", id));
                    break;
            }
        }

        private void LoadStats()
        {
            try
            {
                const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.NguoiDung) AS TongTaiKhoan,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1) AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE TrangThai=0) AS TaiKhoanKhoa,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1),0) AS TongQuyenGop";

                DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    TongTaiKhoan = Convert.ToInt32(r["TongTaiKhoan"]);
                    NguoiDungHoatDong = Convert.ToInt32(r["NguoiDungHoatDong"]);
                    TaiKhoanKhoa = Convert.ToInt32(r["TaiKhoanKhoa"]);
                    TongQuyenGop = Convert.ToInt64(r["TongQuyenGop"]);
                }
            }
            catch { }
        }

        private void LoadData()
        {
            try
            {
                int offset = (CurrentPage - 1) * PageSize;
                var prms = new List<SqlParameter>();
                var where = new System.Text.StringBuilder(" WHERE 1=1");

                if (!string.IsNullOrWhiteSpace(SearchKeyword))
                {
                    where.Append(" AND (nd.HoTen LIKE N'%'+@Kw+'%' OR nd.Email LIKE N'%'+@Kw+'%')");
                    prms.Add(KetNoiDB.P("@Kw", SearchKeyword));
                }
                if (FilterTT == "0" || FilterTT == "1")
                    where.Append(" AND nd.TrangThai=" + FilterTT);
                if (FilterVT == "0" || FilterVT == "1")
                    where.Append(" AND nd.VaiTro=" + FilterVT);

                // Count
                string sqlCount = "SELECT COUNT(*) FROM dbo.NguoiDung nd" + where;
                TotalItems = Convert.ToInt32(KetNoiDB.ExecuteScalar(sqlCount, CommandType.Text, prms.ToArray()));

                // Data (tạo params mới vì SqlParameter chỉ dùng 1 lần)
                var prms2 = new List<SqlParameter>();
                if (!string.IsNullOrWhiteSpace(SearchKeyword))
                    prms2.Add(KetNoiDB.P("@Kw", SearchKeyword));

                string sqlData = @"
SELECT nd.MaNguoiDung, nd.HoTen, nd.Email, nd.SoDienThoai,
       nd.VaiTro, nd.TrangThai,
       CONVERT(NVARCHAR(10), nd.NgayTao, 103) AS NgayTao,
       ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE MaNguoiDung=nd.MaNguoiDung AND TrangThai=1), 0) AS TongQuyenGop
FROM dbo.NguoiDung nd" + where +
                    " ORDER BY nd.NgayTao DESC OFFSET " + offset + " ROWS FETCH NEXT " + PageSize + " ROWS ONLY";

                DtNguoiDung = KetNoiDB.GetDataTable(sqlData, CommandType.Text, prms2.ToArray());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[QuanLyNguoiDung] LoadData error: " + ex.Message);
            }
        }

        protected int TotalPages
        {
            get { return TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / PageSize) : 1; }
        }

        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000) return string.Format("{0:0.#} Tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000) return string.Format("{0:0.#} Tr", (double)so / 1_000_000);
            if (so >= 1_000) return string.Format("{0:0.#}K", (double)so / 1_000);
            return so.ToString("N0");
        }

        // === EVENT: Tìm kiếm ===
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            hfPage.Value = "1";
        }

        // === EVENT: Đặt lại ===
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            hfFilterTT.Value = "";
            hfFilterVT.Value = "";
            hfPage.Value = "1";
        }
    }
}
