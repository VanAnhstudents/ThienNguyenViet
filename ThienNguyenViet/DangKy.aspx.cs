using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ThienNguyenViet
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Visible = false;
            }
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtHoTen.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtSoDienThoai.Text) ||
                txtMatKhau.Text != txtXacNhanMK.Text ||
                txtMatKhau.Text.Length < 6 ||
                !chkDongY.Checked)
            {
                lblError.Text = "Vui lòng kiểm tra lại thông tin!";
                lblError.Visible = true;
                return;
            }

            string email = txtEmail.Text.Trim().ToLower();
            string pass = txtMatKhau.Text;

            // Lưu tài khoản vừa đăng ký vào Session (dùng Dictionary)
            if (Session["RegisteredUsers"] == null)
            {
                Session["RegisteredUsers"] = new Dictionary<string, string>();
            }

            var registered = (Dictionary<string, string>)Session["RegisteredUsers"];

            if (registered.ContainsKey(email))
            {
                lblError.Text = "Email này đã được đăng ký!";
                lblError.Visible = true;
                return;
            }

            registered.Add(email, pass);

            // Thông báo thành công và chuyển về đăng nhập
            Session["RegisterSuccess"] = "Đăng ký tài khoản thành công!<br/>Vui lòng đăng nhập để tiếp tục.";

            Response.Redirect("DangNhap.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}