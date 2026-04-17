using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class HoSo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!PhanQuyenHelper.DaDangNhap(Session))
            {
                Response.Redirect("~/DangNhap.aspx", true);
                return;
            }

            if (!IsPostBack)
            {
                LoadHoSo();
                LoadLichSuQuyenGop();
            }
        }

        private void LoadHoSo()
        {
            int ma = PhanQuyenHelper.LayMa(Session);
            DataRow dr = NguoiDungDAO.LayThongTinHoSo(ma);
            if (dr == null) return;

            string hoTenFull = dr["HoTen"].ToString();
            string[] parts = hoTenFull.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            txtHoDem.Text = parts.Length > 1 ? string.Join(" ", parts.Take(parts.Length - 1)) : "";
            txtTen.Text = parts.Length > 0 ? parts.Last() : hoTenFull;

            txtEmail.Text = dr["Email"].ToString();
            txtSoDienThoai.Text = dr["SoDienThoai"]?.ToString() ?? "";

            // Avatar
            string anh = dr["AnhDaiDien"]?.ToString();
            if (!string.IsNullOrEmpty(anh))
            {
                avatarPreview.InnerHtml = $"<img src='{ResolveUrl(anh)}' alt='Avatar' style='width:100%; height:100%; object-fit:cover;' />";
            }
            else
            {
                avatarPreview.InnerHtml = hoTenFull.Length > 0 ? hoTenFull.Substring(0, 1).ToUpper() : "N";
            }

            lblAvatarName.Text = hoTenFull;
            lblAvatarEmail.Text = dr["Email"].ToString();
        }

        private void LoadLichSuQuyenGop()
        {
            int ma = PhanQuyenHelper.LayMa(Session);
            DataTable dt = QuyenGopDAO.LayLichSuQuyenGopCuaNguoiDung(ma, 1, 5);
            rptLichSu.DataSource = dt;
            rptLichSu.DataBind();
        }

        protected void btnSaveInfo_Click(object sender, EventArgs e)
        {
            int ma = PhanQuyenHelper.LayMa(Session);
            string hoTen = (txtHoDem.Text.Trim() + " " + txtTen.Text.Trim()).Trim();
            string sdt = txtSoDienThoai.Text.Trim();
            string anhDaiDien = null;

            if (avatarInput.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/Avatars/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

                string ext = Path.GetExtension(avatarInput.FileName).ToLower();
                string fileName = $"avatar_{ma}_{DateTime.Now:yyyyMMddHHmmss}{ext}";
                avatarInput.SaveAs(Path.Combine(folder, fileName));
                anhDaiDien = $"/Uploads/Avatars/{fileName}";
            }

            bool ok = NguoiDungDAO.CapNhatHoSo(ma, hoTen, sdt, anhDaiDien);
            if (ok)
            {
                LoadHoSo(); // reload avatar + tên
                ScriptManager.RegisterStartupScript(this, GetType(), "success",
                    "alert('✅ Thông tin cá nhân đã được cập nhật thành công!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    "alert('❌ Có lỗi khi cập nhật thông tin!');", true);
            }
        }

        protected void btnSavePwd_Click(object sender, EventArgs e)
        {
            int ma = PhanQuyenHelper.LayMa(Session);
            string oldPass = txtOldPwd.Text;
            string newPass = txtNewPwd.Text;
            string confirm = txtConfirmPwd.Text;

            if (string.IsNullOrEmpty(oldPass) || string.IsNullOrEmpty(newPass) || newPass != confirm)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "pwdErr",
                    "alert('Mật khẩu mới không khớp hoặc chưa nhập đầy đủ!');", true);
                return;
            }

            bool ok = NguoiDungDAO.DoiMatKhau(ma, oldPass, newPass);
            if (ok)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "pwdSuccess",
                    "alert('✅ Mật khẩu đã được thay đổi thành công!');", true);
                txtOldPwd.Text = txtNewPwd.Text = txtConfirmPwd.Text = "";
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "pwdErr",
                    "alert('❌ Mật khẩu hiện tại không đúng!');", true);
            }
        }
    }
}