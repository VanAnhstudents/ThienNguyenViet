using System;
using System.IO;
using System.Web.UI;

namespace ThienNguyenViet.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Tra ve "active" neu trang hien tai khop voi ten file ASPX.
        /// </summary>
        protected string IsActive(string pageName)
        {
            string currentPage = Path.GetFileNameWithoutExtension(Request.AppRelativeCurrentExecutionFilePath);
            return currentPage != null && currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase)
                ? "active"
                : string.Empty;
        }
    }
}
