using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class BaoCao : System.Web.UI.Page
    {
        // === PROPERTIES BIND LÊN ASPX ===
        protected int SelectedYear { get; private set; }
        protected long TongTienQuyen { get; private set; }
        protected int TongLuotQuyen { get; private set; }
        protected int ChienDichDangChay { get; private set; }
        protected int TongChienDich { get; private set; }
        protected int NguoiDungHoatDong { get; private set; }
        protected int TongNguoiDung { get; private set; }
        protected string ChartMonthlyJson { get; private set; } = "[]";
        protected string ChartPieLabelsJson { get; private set; } = "[]";
        protected string ChartPieValuesJson { get; private set; } = "[]";
        protected string ChartPieColorsJson { get; private set; } = "[]";
        protected DataTable DtTopChienDich { get; private set; }
        protected DataTable DtTopDonors { get; private set; }

        // HiddenField controls
        protected System.Web.UI.WebControls.HiddenField hfYear;

        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            // Set default year on first load
            if (!IsPostBack && string.IsNullOrEmpty(hfYear.Value))
                hfYear.Value = DateTime.Now.Year.ToString();

            // Đọc năm từ hidden field
            SelectedYear = int.TryParse(hfYear.Value, out int y) && y >= 2020 ? y : DateTime.Now.Year;

            LoadSummary();
            LoadMonthlyChart();
            LoadPieChart();
            LoadTopCD();
            LoadTopDonors();
        }

        private void LoadSummary()
        {
            try
            {
                const string sql = @"
SELECT
    (SELECT COUNT(*) FROM dbo.ChienDich WHERE TrangThai=1) AS ChienDichDangChay,
    (SELECT COUNT(*) FROM dbo.ChienDich) AS TongChienDich,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0 AND TrangThai=1) AS NguoiDungHoatDong,
    (SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro=0) AS TongNguoiDung,
    ISNULL((SELECT SUM(SoTien) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year),0) AS TongTienQuyen,
    (SELECT COUNT(*) FROM dbo.QuyenGop WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year) AS TongLuotQuyen";

                DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", SelectedYear));
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    ChienDichDangChay = Convert.ToInt32(r["ChienDichDangChay"]);
                    TongChienDich = Convert.ToInt32(r["TongChienDich"]);
                    NguoiDungHoatDong = Convert.ToInt32(r["NguoiDungHoatDong"]);
                    TongNguoiDung = Convert.ToInt32(r["TongNguoiDung"]);
                    TongTienQuyen = Convert.ToInt64(r["TongTienQuyen"]);
                    TongLuotQuyen = Convert.ToInt32(r["TongLuotQuyen"]);
                }
            }
            catch { }
        }

        private void LoadMonthlyChart()
        {
            try
            {
                const string sql = @"
SELECT MONTH(NgayDuyet) AS Thang, SUM(SoTien) AS Tien
FROM dbo.QuyenGop
WHERE TrangThai=1 AND YEAR(NgayDuyet)=@year
GROUP BY MONTH(NgayDuyet)
ORDER BY Thang";

                DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", SelectedYear));
                long[] tien = new long[12];
                foreach (DataRow r in dt.Rows)
                {
                    int m = Convert.ToInt32(r["Thang"]) - 1;
                    tien[m] = Convert.ToInt64(r["Tien"]);
                }
                ChartMonthlyJson = "[" + string.Join(",", tien) + "]";
            }
            catch { }
        }

        private void LoadPieChart()
        {
            try
            {
                const string sql = @"
SELECT dm.TenDanhMuc, dm.MauSac,
       ISNULL(SUM(qg.SoTien),0) AS TongTien
FROM dbo.DanhMucChienDich dm
LEFT JOIN dbo.ChienDich cd ON dm.MaDanhMuc = cd.MaDanhMuc
LEFT JOIN dbo.QuyenGop qg ON cd.MaChienDich = qg.MaChienDich AND qg.TrangThai=1
    AND YEAR(qg.NgayDuyet) = @year
GROUP BY dm.TenDanhMuc, dm.MauSac
HAVING ISNULL(SUM(qg.SoTien),0) > 0
ORDER BY TongTien DESC";

                DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text, KetNoiDB.P("@year", SelectedYear));
                var labels = new List<string>();
                var values = new List<string>();
                var colors = new List<string>();

                foreach (DataRow r in dt.Rows)
                {
                    labels.Add("\"" + r["TenDanhMuc"].ToString().Replace("\"", "\\\"") + "\"");
                    values.Add(Convert.ToDecimal(r["TongTien"]).ToString("0"));
                    string mau = r["MauSac"] == DBNull.Value ? "#3182CE" : r["MauSac"].ToString();
                    colors.Add("\"" + mau + "\"");
                }

                ChartPieLabelsJson = "[" + string.Join(",", labels) + "]";
                ChartPieValuesJson = "[" + string.Join(",", values) + "]";
                ChartPieColorsJson = "[" + string.Join(",", colors) + "]";
            }
            catch { }
        }

        private void LoadTopCD()
        {
            try
            {
                const string sql = @"
SELECT TOP 10
    cd.TenChienDich, cd.MucTieu,
    ISNULL(SUM(qg.SoTien),0) AS TongTienDaQuyen
FROM dbo.ChienDich cd
LEFT JOIN dbo.QuyenGop qg ON cd.MaChienDich = qg.MaChienDich AND qg.TrangThai=1
GROUP BY cd.MaChienDich, cd.TenChienDich, cd.MucTieu
ORDER BY TongTienDaQuyen DESC";

                DtTopChienDich = KetNoiDB.GetDataTable(sql, CommandType.Text);
            }
            catch { }
        }

        private void LoadTopDonors()
        {
            try
            {
                const string sql = @"
SELECT TOP 10
    nd.HoTen, nd.Email,
    COUNT(qg.MaQuyenGop) AS SoLanQuyen,
    SUM(qg.SoTien) AS TongTienDaQuyen
FROM dbo.QuyenGop qg
INNER JOIN dbo.NguoiDung nd ON qg.MaNguoiDung=nd.MaNguoiDung
WHERE qg.TrangThai=1 AND qg.AnDanh=0
GROUP BY nd.MaNguoiDung, nd.HoTen, nd.Email
ORDER BY TongTienDaQuyen DESC";

                DtTopDonors = KetNoiDB.GetDataTable(sql, CommandType.Text);
            }
            catch { }
        }

        // === HELPERS ===
        protected string FormatTien(long so)
        {
            if (so >= 1_000_000_000) return string.Format("{0:0.#} tỷ", (double)so / 1_000_000_000);
            if (so >= 1_000_000) return string.Format("{0:0.#} triệu", (double)so / 1_000_000);
            return so.ToString("N0") + " VNĐ";
        }
    }
}
