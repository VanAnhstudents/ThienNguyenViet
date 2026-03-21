using System;
using System.Web.UI;

namespace ThienNguyenViet.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Trả về "active" nếu trang hiện tại khớp với tên file ASPX,
        /// dùng để highlight menu item đang chọn.
        /// </summary>
        protected string IsActive(string pageName)
        {
            string currentPage = System.IO.Path.GetFileNameWithoutExtension(
                                     Request.Url.AbsolutePath);
            return currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase)
                   ? "active"
                   : string.Empty;
        }
    }
}
