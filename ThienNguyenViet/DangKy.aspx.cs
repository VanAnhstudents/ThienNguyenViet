using System;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) lblError.Visible = false;
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string sdt = txtSoDienThoai.Text.Trim();
            string pass = txtMatKhau.Text;
            string confirm = txtXacNhanMK.Text;

            if (string.IsNullOrWhiteSpace(hoTen) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(sdt))
            {
                HienLoi("Vui lòng nhập đầy đủ thông tin!");
                return;
            }
            if (pass.Length < 6)
            {
                HienLoi("Mật khẩu phải có ít nhất 6 ký tự!");
                return;
            }
            if (pass != confirm)
            {
                HienLoi("Mật khẩu xác nhận không khớp!");
                return;
            }
            if (!chkDongY.Checked)
            {
                HienLoi("Bạn phải đồng ý với Điều khoản dịch vụ và Chính sách bảo mật!");
                return;
            }

            try
            {
                int maNguoiDung = NguoiDungDAO.DangKy(hoTen, email, pass, sdt);
                Session["RegisterSuccess"] = "Đăng ký tài khoản thành công! Vui lòng đăng nhập.";
                Response.Redirect("DangNhap.aspx", false);
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("UNIQUE") || ex.Message.Contains("duplicate") || ex.Message.Contains("trùng"))
                    HienLoi("Email này đã được đăng ký! Vui lòng dùng email khác.");
                else
                    HienLoi("Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại sau.");
            }
        }

        private void HienLoi(string msg)
        {
            lblError.Text = msg;
            lblError.Visible = true;
        }
    }
}
