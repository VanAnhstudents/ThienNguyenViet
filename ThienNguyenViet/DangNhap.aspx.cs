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
                    lblError.ForeColor = System.Drawing.Color.Green;
                    lblError.Visible = true;
                    Session.Remove("RegisterSuccess");
                }
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string passRaw = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(passRaw))
            {
                ShowError("Vui lòng nhập email và mật khẩu!");
                return;
            }

            System.Diagnostics.Debug.WriteLine($"[DEBUG] Email nhập: {email}");
            System.Diagnostics.Debug.WriteLine($"[DEBUG] Mật khẩu nhập: {passRaw}");

            try
            {
                DataRow user = NguoiDungDAO.DangNhap(email, passRaw);

                if (user != null)
                {
                    int ma = Convert.ToInt32(user["MaNguoiDung"]);
                    string hoTen = user["HoTen"].ToString();
                    int vaiTro = Convert.ToInt32(user["VaiTro"]);

                    System.Diagnostics.Debug.WriteLine($"[DEBUG] ĐĂNG NHẬP THÀNH CÔNG! Ma={ma}, HoTen={hoTen}, VaiTro={vaiTro}");

                    PhanQuyenHelper.LuuSession(Session, ma, hoTen, email, vaiTro);

                    // === SỬA LỖI REDIRECT Ở ĐÂY ===
                    if (vaiTro == 1)
                    {
                        Response.Redirect("~/Admin/TongQuan.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("~/TrangChu.aspx", false);
                    }

                    // Kết thúc response an toàn
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    ShowError("Email hoặc mật khẩu không đúng!<br/>Kiểm tra lại:<br/>• admin@thiennguyen.vn / Admin@123<br/>• user@thiennguyen.vn / User@123");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[ERROR] DangNhap_Click: {ex}");
                ShowError("Lỗi hệ thống: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Visible = true;
        }
    }
}﻿
