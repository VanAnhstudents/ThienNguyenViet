using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyTinTuc : System.Web.UI.Page
    {
        // === PROPERTIES BIND LÊN ASPX ===
        protected int TongBaiViet { get; private set; }
        protected int SoXuatBan { get; private set; }
        protected int SoBanNhap { get; private set; }
        protected long TongLuotXem { get; private set; }
        protected DataTable DtTinTuc { get; private set; }
        protected DataTable DtDanhMuc { get; private set; }
        protected int TotalItems { get; private set; }
        protected int CurrentPage { get; private set; } = 1;
        protected int PageSize { get; private set; } = 10;
        protected string FilterTT { get; private set; } = "";
        protected string FilterDM { get; private set; } = "";
        protected string SearchKeyword { get; private set; } = "";

        // HiddenField controls (declared in aspx)
        protected System.Web.UI.WebControls.HiddenField hfPage;
        protected System.Web.UI.WebControls.HiddenField hfFilterTT;
        protected System.Web.UI.WebControls.HiddenField hfFilterDM;
        protected System.Web.UI.WebControls.HiddenField hfAction;
        protected System.Web.UI.WebControls.HiddenField hfParam;
        protected System.Web.UI.WebControls.TextBox txtSearch;

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            // Xử lý hành động postback (toggle/delete)
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
            FilterDM = hfFilterDM.Value ?? "";
            SearchKeyword = (txtSearch.Text ?? "").Trim();

            LoadStats();
            LoadDanhMuc();
            LoadData();
        }

        private void XuLyHanhDong(string action, string param)
        {
            if (!int.TryParse(param, out int id) || id <= 0) return;

            switch (action)
            {
                case "toggle":
                    KetNoiDB.ExecuteNonQuery(
                        "UPDATE dbo.TinTuc SET TrangThai = CASE WHEN TrangThai=1 THEN 0 ELSE 1 END WHERE MaTinTuc=@id",
                        CommandType.Text, KetNoiDB.P("@id", id));
                    break;
                case "delete":
                    try
                    {
                        KetNoiDB.ExecuteNonQuery("DELETE FROM dbo.TinTuc WHERE MaTinTuc=@id",
                            CommandType.Text, KetNoiDB.P("@id", id));
                    }
                    catch { }
                    break;
            }
        }

        private void LoadStats()
        {
            try
            {
                const string sql = @"
SELECT
    COUNT(*) AS Tong,
    SUM(CASE WHEN TrangThai=1 THEN 1 ELSE 0 END) AS XuatBan,
    SUM(CASE WHEN TrangThai=0 THEN 1 ELSE 0 END) AS Nhap,
    ISNULL(SUM(LuotXem),0) AS LuotXem
FROM dbo.TinTuc";
                DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    TongBaiViet = Convert.ToInt32(r["Tong"]);
                    SoXuatBan = Convert.ToInt32(r["XuatBan"]);
                    SoBanNhap = Convert.ToInt32(r["Nhap"]);
                    TongLuotXem = Convert.ToInt64(r["LuotXem"]);
                }
            }
            catch { }
        }

        private void LoadDanhMuc()
        {
            DtDanhMuc = KetNoiDB.GetDataTable(
                "SELECT MaDanhMuc, TenDanhMuc FROM dbo.DanhMucTinTuc ORDER BY TenDanhMuc",
                CommandType.Text);
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
                    where.Append(" AND tt.TieuDe LIKE N'%'+@TuKhoa+'%'");
                    prms.Add(KetNoiDB.P("@TuKhoa", SearchKeyword));
                }
                if (FilterTT == "0" || FilterTT == "1")
                    where.Append(" AND tt.TrangThai=" + FilterTT);
                if (!string.IsNullOrWhiteSpace(FilterDM) && int.TryParse(FilterDM, out int dmId))
                    where.Append(" AND tt.MaDanhMuc=" + dmId);

                // Count
                string sqlCount = "SELECT COUNT(*) FROM dbo.TinTuc tt" + where;
                TotalItems = Convert.ToInt32(KetNoiDB.ExecuteScalar(sqlCount, CommandType.Text, prms.ToArray()));

                // Data (tạo params mới)
                var prms2 = new List<SqlParameter>();
                if (!string.IsNullOrWhiteSpace(SearchKeyword))
                    prms2.Add(KetNoiDB.P("@TuKhoa", SearchKeyword));

                string sqlData = @"
SELECT tt.MaTinTuc, tt.TieuDe, tt.TomTat, tt.AnhBia, tt.LuotXem,
       tt.TrangThai, tt.MaDanhMuc,
       CONVERT(NVARCHAR(10), tt.NgayDang, 103) AS NgayDang,
       nd.HoTen AS NguoiDang
FROM dbo.TinTuc tt
INNER JOIN dbo.NguoiDung nd ON tt.MaNguoiDang = nd.MaNguoiDung"
                    + where
                    + " ORDER BY tt.NgayDang DESC OFFSET " + offset + " ROWS FETCH NEXT " + PageSize + " ROWS ONLY";

                DtTinTuc = KetNoiDB.GetDataTable(sqlData, CommandType.Text, prms2.ToArray());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[QuanLyTinTuc] LoadData error: " + ex.Message);
            }
        }

        protected int TotalPages
        {
            get { return TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / PageSize) : 1; }
        }

        protected string FormatLuotXem(long so)
        {
            if (so >= 1_000_000) return string.Format("{0:0.#}M", (double)so / 1_000_000);
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
            hfFilterDM.Value = "";
            hfPage.Value = "1";
        }

    }
}