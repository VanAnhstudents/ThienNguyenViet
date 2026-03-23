using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            // Validation server-side (bổ sung cho JS)
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

            // Thành công → chuyển về trang đăng nhập
            Session["RegisterSuccess"] = "Đăng ký thành công! Vui lòng đăng nhập.";
            Response.Redirect("DangNhap.aspx");
        }
    }
}
