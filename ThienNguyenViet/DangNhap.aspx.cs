using System;
using System.Collections.Generic;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class DangNhap : System.Web.UI.Page
    {
        // Danh sách tài khoản hợp lệ (có thể mở rộng sau)
        private static readonly Dictionary<string, string> ValidAccounts = new Dictionary<string, string>
        {
            { "admin@thiennguyen.vn", "Admin@123" },
            { "user@thiennguyen.vn", "User@123" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Visible = false;

                if (Session["RegisterSuccess"] != null)
                {
                    lblError.Text = Session["RegisterSuccess"].ToString();
                    lblError.ForeColor = System.Drawing.Color.LimeGreen;
                    lblError.Visible = true;
                    Session.Remove("RegisterSuccess");
                }
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
            {
                ShowError("Vui lòng nhập email và mật khẩu!");
                return;
            }

            string emailLower = email.ToLower();
            bool loginOK = false;
            string hoTen = "";
            int vaiTro = 2;

            // Kiểm tra tài khoản hardcode
            if (ValidAccounts.ContainsKey(emailLower) && ValidAccounts[emailLower] == pass)
            {
                loginOK = true;
                hoTen = emailLower == "admin" ? "Administrator" : "Người dùng thử nghiệm";
                vaiTro = emailLower == "admin" ? 1 : 2;
            }
            // Kiểm tra tài khoản vừa đăng ký (lưu tạm trong Session)
            else if (Session["RegisteredUsers"] != null)
            {
                var registered = (Dictionary<string, string>)Session["RegisteredUsers"];
                if (registered.ContainsKey(emailLower) && registered[emailLower] == pass)
                {
                    loginOK = true;
                    hoTen = "Người dùng mới";
                    vaiTro = 2;
                }
            }

            if (loginOK)
            {
                PhanQuyenHelper.LuuSession(Session, 1000, hoTen, email, vaiTro);
                Response.Redirect("~/TrangChu.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                ShowError("Email hoặc mật khẩu không đúng!<br/>Thử dùng:<br/>• admin@thiennguyen.vn / Admin@123<br/>• user@thiennguyen.vn / User@123<br/>Hoặc đăng ký tài khoản trước.");
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Visible = true;
        }
    }
}