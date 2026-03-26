using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThienNguyenViet
{
    public partial class QuyenGop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Xác nhận chuyển khoản thành công!');</script>");
        }
    
    }
}