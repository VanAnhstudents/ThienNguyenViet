using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    /// <summary>
    /// Trang xử lý đăng xuất — không có giao diện, chỉ xử lý rồi redirect.
    /// </summary>
    public partial class DangXuat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.DangXuat(Response, Session, Request);
            Response.Redirect("~/DangNhap.aspx", true);
        }
    }
}