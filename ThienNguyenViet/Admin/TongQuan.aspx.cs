using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThienNguyenViet.Admin
{
    // ================================================================
    // MODELS
    // ================================================================

    /// <summary>4 thống kê dashboard.</summary>
    internal class ThongKeTongQuan
    {
        public int TongChienDichDangChay { get; set; }
        public int TongChienDich { get; set; }
        public int TongNguoiDung { get; set; }
        public int TongChoXuLy { get; set; }
        public decimal TongTienDaQuyen { get; set; }
        public int TongLuotQuyenGop { get; set; }
    }

    /// <summary>Một dòng trong bảng Đóng góp gần đây</summary>
    internal class QuyenGopGanDay
    {
        public int MaQuyenGop { get; set; }
        public string TenChienDich { get; set; }
        public string HoTen { get; set; }
        public decimal SoTien { get; set; }
        public string LoiNhan { get; set; }
        public byte TrangThai { get; set; }   // 0=Cho, 1=Duyet, 2=Tu choi
        public DateTime NgayTao { get; set; }
    }

    /// <summary>Một điểm dữ liệu trên biểu đồ theo tháng.</summary>
    internal class ThongKeThang
    {
        public int Thang { get; set; }
        public int SoLuot { get; set; }
        public decimal TongTien { get; set; }
    }

    // ================================================================
    // DATA ACCESS
    // ================================================================
    internal class TongQuanDAO
    {
        /// <summary>Mở SqlConnection từ connectionString trong Web.config.</summary>
        private static SqlConnection GetConn()
        {
            string cs = ConfigurationManager
                            .ConnectionStrings["cnn-vanhdev-ThienNguyenViet"]
                            .ConnectionString;
            return new SqlConnection(cs);
        }

        // 1. Thong ke tong quan -- goi SP_ThongKeTongQuan
        public ThongKeTongQuan LayThongKeTongQuan()
        {
            var result = new ThongKeTongQuan();

            using (var conn = GetConn())
            using (var cmd = new SqlCommand("SP_ThongKeTongQuan", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();

                using (var rdr = cmd.ExecuteReader(CommandBehavior.SingleRow))
                {
                    if (rdr.Read())
                    {
                        result.TongChienDichDangChay = Convert.ToInt32(rdr["TongChienDichDangChay"]);
                        result.TongChienDich = Convert.ToInt32(rdr["TongChienDich"]);
                        result.TongNguoiDung = Convert.ToInt32(rdr["TongNguoiDung"]);
                        result.TongChoXuLy = Convert.ToInt32(rdr["TongChoXuLy"]);
                        result.TongTienDaQuyen = Convert.ToDecimal(rdr["TongTienDaQuyen"]);
                        result.TongLuotQuyenGop = Convert.ToInt32(rdr["TongLuotQuyenGop"]);
                    }
                }
            }

            return result;
        }

        // 2. Quyen gop gan day -- 10 giao dich moi nhat
        public List<QuyenGopGanDay> LayQuyenGopGanDay(int soLuong = 10)
        {
            var list = new List<QuyenGopGanDay>();

            const string sql = @"
                SELECT TOP (@SoLuong)
                    qg.MaQuyenGop,
                    cd.TenChienDich,
                    CASE
                        WHEN qg.AnDanh = 1 OR qg.MaNguoiDung IS NULL
                        THEN N'Ẩn danh'
                        ELSE nd.HoTen
                    END          AS HoTen,
                    qg.SoTien,
                    qg.LoiNhan,
                    qg.TrangThai,
                    qg.NgayTao
                FROM       dbo.QuyenGop   qg
                INNER JOIN dbo.ChienDich  cd ON qg.MaChienDich = cd.MaChienDich
                LEFT JOIN  dbo.NguoiDung  nd ON qg.MaNguoiDung = nd.MaNguoiDung
                ORDER BY qg.NgayTao DESC";

            using (var conn = GetConn())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@SoLuong", soLuong);
                conn.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        list.Add(new QuyenGopGanDay
                        {
                            MaQuyenGop = Convert.ToInt32(rdr["MaQuyenGop"]),
                            TenChienDich = rdr["TenChienDich"].ToString(),
                            HoTen = rdr["HoTen"].ToString(),
                            SoTien = Convert.ToDecimal(rdr["SoTien"]),
                            LoiNhan = rdr["LoiNhan"] == DBNull.Value ? "" : rdr["LoiNhan"].ToString(),
                            TrangThai = Convert.ToByte(rdr["TrangThai"]),
                            NgayTao = Convert.ToDateTime(rdr["NgayTao"])
                        });
                    }
                }
            }

            return list;
        }

        // 3. Thong ke theo thang -- goi SP_ThongKeQuyenGopTheoThang
        public List<ThongKeThang> LayThongKeTheoThang(int? nam = null)
        {
            // Khoi tao du 12 thang, gia tri mac dinh = 0
            var dict = new Dictionary<int, ThongKeThang>();
            for (int i = 1; i <= 12; i++)
                dict[i] = new ThongKeThang { Thang = i };

            using (var conn = GetConn())
            using (var cmd = new SqlCommand("SP_ThongKeQuyenGopTheoThang", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Nam", (object)nam ?? DBNull.Value);
                conn.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        int t = Convert.ToInt32(rdr["Thang"]);
                        if (dict.ContainsKey(t))
                        {
                            dict[t].SoLuot = Convert.ToInt32(rdr["SoLuot"]);
                            dict[t].TongTien = Convert.ToDecimal(rdr["TongTien"]);
                        }
                    }
                }
            }

            var list = new List<ThongKeThang>();
            for (int i = 1; i <= 12; i++) list.Add(dict[i]);
            return list;
        }
    }

    // ================================================================
    // PAGE CODE-BEHIND
    // ================================================================
    public partial class TongQuan : System.Web.UI.Page
    {
        private readonly TongQuanDAO _dao = new TongQuanDAO();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Bat kiem tra quyen Admin khi tich hop dang nhap:
            // if (Session["VaiTro"] == null || Convert.ToByte(Session["VaiTro"]) != 1)
            //     Response.Redirect("~/DangNhap.aspx");

            if (!IsPostBack)
            {
                int nam = GetSelectedYear();
                hfNamHienTai.Value = nam.ToString();

                LoadThongKe();
                LoadQuyenGopGanDay();
                LoadChart(nam);
                BuildYearOptions(nam);
            }
        }

        // Load 4 the thong ke
        private void LoadThongKe()
        {
            ThongKeTongQuan tk = _dao.LayThongKeTongQuan();

            ltlChienDichDangChay.Text = tk.TongChienDichDangChay.ToString("N0");
            ltlTongChienDich.Text = tk.TongChienDich.ToString("N0");
            ltlTongNguoiDung.Text = tk.TongNguoiDung.ToString("N0");
            ltlChoXuLy.Text = tk.TongChoXuLy.ToString("N0");
            ltlTongTien.Text = FormatMoney(tk.TongTienDaQuyen);
            ltlTongLuot.Text = tk.TongLuotQuyenGop.ToString("N0");

            // Cot phai - tom tat nhanh
            ltlQS_DangChay.Text = tk.TongChienDichDangChay.ToString("N0");
            ltlQS_KetThuc.Text = (tk.TongChienDich - tk.TongChienDichDangChay).ToString("N0");
            ltlQS_ChoDuyet.Text = tk.TongChoXuLy.ToString("N0");
            ltlQS_TongLuot.Text = tk.TongLuotQuyenGop.ToString("N0");
        }

        // Load bang quyen gop gan day
        private void LoadQuyenGopGanDay()
        {
            List<QuyenGopGanDay> list = _dao.LayQuyenGopGanDay(10);

            if (list.Count == 0)
            {
                pnlEmpty.Visible = true;
                return;
            }

            rptQuyenGop.DataSource = list;
            rptQuyenGop.DataBind();
        }

        // ItemDataBound: render badge trang thai
        protected void rptQuyenGop_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            var item = (QuyenGopGanDay)e.Item.DataItem;
            var ltl = (Literal)e.Item.FindControl("ltlTrangThai");
            if (ltl != null) ltl.Text = GetBadgeHTML(item.TrangThai);
        }

        // Build JSON cho Chart.js
        private void LoadChart(int nam)
        {
            List<ThongKeThang> data = _dao.LayThongKeTheoThang(nam);

            var sb = new StringBuilder("[");
            for (int i = 0; i < data.Count; i++)
            {
                var t = data[i];
                sb.AppendFormat("{0}\"Thang\":{1},\"SoLuot\":{2},\"TongTien\":{3}{4}",
                                "{", t.Thang, t.SoLuot, (long)t.TongTien, "}");
                if (i < data.Count - 1) sb.Append(",");
            }
            sb.Append("]");

            hfChartData.Value = sb.ToString();
        }

        // Build option nam cho dropdown
        private void BuildYearOptions(int selectedYear)
        {
            int cur = DateTime.Now.Year;
            var sb = new StringBuilder();

            for (int y = cur; y >= cur - 2; y--)
            {
                string sel = (y == selectedYear) ? " selected=\"selected\"" : "";
                sb.AppendFormat("<option value=\"{0}\"{1}>Năm {0}</option>", y, sel);
            }

            ltlNamOptions.Text = sb.ToString();
        }

        // Doc nam tu QueryString
        private int GetSelectedYear()
        {
            int y;
            if (int.TryParse(Request.QueryString["nam"], out y) &&
                y >= 2000 && y <= DateTime.Now.Year)
                return y;
            return DateTime.Now.Year;
        }

        // Format tien VND
        protected string FormatMoney(object val)
        {
            if (val == null || val == DBNull.Value) return "0 đ";
            decimal n = Convert.ToDecimal(val);

            if (n >= 1000000000m)
                return (n / 1000000000m).ToString("0.##") + " tỷ đ";
            if (n >= 1000000m)
                return (n / 1000000m).ToString("0.#") + " triệu đ";

            return n.ToString("N0") + " đ";
        }

        // Format ngay gio
        protected string FormatDateTime(object val)
        {
            if (val == null || val == DBNull.Value) return "-";
            DateTime dt = Convert.ToDateTime(val);

            if (dt.Date == DateTime.Today) return dt.ToString("HH:mm");
            if (dt.Year == DateTime.Now.Year) return dt.ToString("dd/MM");
            return dt.ToString("dd/MM/yy");
        }

        // HTML badge trang thai
        private static string GetBadgeHTML(byte ts)
        {
            switch (ts)
            {
                case 1: return "<span class=\"badge-admin badge-thanh-cong\">Đã duyệt</span>";
                case 2: return "<span class=\"badge-admin badge-tu-choi\">Từ chối</span>";
                default: return "<span class=\"badge-admin badge-cho-duyet\">CHờ duyệt</span>";
            }
        }
    }
}