using System;
using System.Data;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlMsg.Visible = false;
                if (Session["RegisterSuccess"] != null)
                {
                    HienThongBao(Session["RegisterSuccess"].ToString(), false);
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
                HienThongBao("Vui lòng nhập email và mật khẩu!", true);
                return;
            }

            DataRow nguoiDung = NguoiDungDAO.DangNhap(email, pass);

            if (nguoiDung != null)
            {
                int ma = Convert.ToInt32(nguoiDung["MaNguoiDung"]);
                string hoTen = nguoiDung["HoTen"].ToString();
                string dbEmail = nguoiDung["Email"].ToString();
                int vaiTro = Convert.ToInt32(nguoiDung["VaiTro"]);

                PhanQuyenHelper.LuuSession(Session, ma, hoTen, dbEmail, vaiTro);
                Response.Redirect("~/TrangChu.aspx", false);
            }
            else
            {
                HienThongBao("Email hoặc mật khẩu không đúng!", true);
            }
        }

        private void HienThongBao(string noiDung, bool laLoi)
        {
            pnlMsg.Visible = true;
            lblError.Text = noiDung;
            msgBox.Attributes["class"] = laLoi ? "msg-box show error" : "msg-box show success";
        }
    }
}
