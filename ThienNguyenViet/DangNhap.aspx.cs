using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThienNguyenViet
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Visible = false;
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            // Demo - bạn có thể thay bằng kiểm tra Database sau này
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();

            if (email == "user@example.com" && pass == "123456")
            {
                Session["UserEmail"] = email;
                Session["IsLoggedIn"] = true;
                Response.Redirect("Default.aspx"); // ← Thay bằng trang chủ của bạn
            }
            else
            {
                lblError.Text = "Email hoặc mật khẩu không đúng!";
                lblError.Visible = true;
            }
        }
    }
}﻿
