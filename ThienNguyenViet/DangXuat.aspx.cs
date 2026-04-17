using System;

namespace ThienNguyenViet
{
    public partial class DangXuat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("TrangChu.aspx");
        }
    }
}