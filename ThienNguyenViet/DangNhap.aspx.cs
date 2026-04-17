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

                // Nếu vừa đăng ký thành công -> hiển thị thông báo xanh
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
            string pass  = txtPassword.Text;

            // --- Validate cơ bản ---
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
            {
                HienThongBao("Vui lòng nhập email và mật khẩu!", true);
                return;
            }

            // --- Gọi DAO kiểm tra đăng nhập từ database ---
            DataRow nguoiDung = NguoiDungDAO.DangNhap(email, pass);

            if (nguoiDung != null)
            {
                // Lấy thông tin từ DataRow trả về
                int    ma     = Convert.ToInt32(nguoiDung["MaNguoiDung"]);
                string hoTen  = nguoiDung["HoTen"].ToString();
                string dbEmail = nguoiDung["Email"].ToString();
                int    vaiTro = Convert.ToInt32(nguoiDung["VaiTro"]);

                // Lưu thông tin vào Session
                PhanQuyenHelper.LuuSession(Session, ma, hoTen, dbEmail, vaiTro);

                // Chuyển về trang chủ
                Response.Redirect("~/TrangChu.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                HienThongBao("Email hoặc mật khẩu không đúng!", true);
            }
        }

        /// <summary>
        /// Hiển thị thông báo trên giao diện.
        /// laLoi = true  -> khung đỏ (lỗi)
        /// laLoi = false -> khung xanh (thành công)
        /// </summary>
        private void HienThongBao(string noiDung, bool laLoi)
        {
            pnlMsg.Visible = true;
            lblError.Text = noiDung;

            if (laLoi)
            {
                msgBox.Attributes["class"] = "msg-box show error";
            }
            else
            {
                msgBox.Attributes["class"] = "msg-box show success";
            }
        }
    }
}
