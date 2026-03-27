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

                if (Session["RegisterSuccess"] != null)
                {
                    lblError.Text = Session["RegisterSuccess"].ToString();
                    lblError.Visible = true;
                    Session.Remove("RegisterSuccess");
                }
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string user = txtEmail.Text.Trim().ToLower();
            string pass = txtPassword.Text;

            // Test accounts: admin/admin -> Admin dashboard | user/user -> Homepage
            if (user == "admin" && pass == "admin")
            {
                Session["IsLoggedIn"] = true;
                Session["UserEmail"] = "admin";
                Session["UserRole"] = "Admin";
                Response.Redirect("~/Admin/TongQuan.aspx");
                return;
            }

            if (user == "user" && pass == "user")
            {
                Session["IsLoggedIn"] = true;
                Session["UserEmail"] = "user";
                Session["UserRole"] = "User";
                Response.Redirect("~/TrangChu.aspx");
                return;
            }

            lblError.Text = "Ten dang nhap hoac mat khau khong dung!";
            lblError.Visible = true;
        }
    }
}﻿
