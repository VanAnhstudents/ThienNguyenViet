using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class QuyenGop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            if (int.TryParse(Request.QueryString["id"], out int maCD))
            {
                DataRow dr = ChienDichDAO.LayTheoMa(maCD);

                if (dr != null)
                {
                    // Đổ dữ liệu vào giao diện y như form
                    string ten = dr["TenChienDich"].ToString();
                    litTenCDMain.Text = ten;
                    litTenCDSidebar.Text = ten;
                    imgCD.ImageUrl = dr["AnhBia"].ToString();

                    litBank.Text = dr["TenNganHang"].ToString();
                    litSTK.Text = dr["SoTaiKhoan"].ToString();
                    litAccHolder.Text = dr["TenChuTaiKhoan"].ToString();
                    litNoiDung.Text = "TNV " + maCD;

                    // Tính toán tiền và tiến độ
                    decimal mucTieu = Convert.ToDecimal(dr["MucTieu"]);
                    decimal daQuyen = Convert.ToDecimal(dr["SoTienDaQuyen"]);
                    double phanTram = mucTieu > 0 ? (double)(daQuyen / mucTieu * 100) : 0;

                    litGoal.Text = string.Format("{0:N0}", mucTieu);
                    litPercent.Text = phanTram.ToString("F1");
                    divProgress.Style["width"] = (phanTram > 100 ? 100 : phanTram) + "%";

                    // Các thông số thống kê (Lấy tạm dữ liệu mẫu từ DB nếu có cột)
                    litCount.Text = "1.240"; // Bạn có thể thay bằng hàm đếm thực tế

                    DateTime ngayKetThuc = Convert.ToDateTime(dr["NgayKetThuc"]);
                    int conLai = (ngayKetThuc - DateTime.Now).Days;
                    litDays.Text = conLai > 0 ? conLai.ToString() : "0";
                }
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            // Logic xử lý khi nhấn nút
            string msg = "alert('Hệ thống đã ghi nhận thông tin chuyển khoản của bạn!'); window.location='Default.aspx';";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", msg, true);
        }
    }
}