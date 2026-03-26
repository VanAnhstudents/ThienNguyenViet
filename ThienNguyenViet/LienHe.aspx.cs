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
        protected void BtnGui_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // xử lý gửi
                Response.Write("<script>alert('Gửi thành công!');</script>");
                Clear_Form();
            }
        }
        private void Clear_Form()
        {
            txtHoTen.Text = "";
            txtEmail.Text = "";
            txtNoiDung.Text = "";
            ddlChuDe.SelectedIndex = 0; // reset về "-- Chọn chủ đề --"
        }
    }
}