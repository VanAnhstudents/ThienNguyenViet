using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThienNguyenViet
{
    public partial class LienHe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnGui_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string hoTen = txtHoTen.Text;
                string email = txtEmail.Text;
                string chuDe = ddlChuDe.SelectedValue;
                string noiDung = txtNoiDung.Text;

                // Demo: chỉ hiển thị thông báo
                lblThongBao.Text = "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi sớm.";

                // TODO:
                // - Lưu DB (bảng liên hệ)
                // - Hoặc gửi email SMTP
            }
        }
    }
}