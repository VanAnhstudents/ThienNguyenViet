using System;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ND_Ma"] != null)
            {
                lnkLogin.Visible = false;
                pnlUser.Visible = true;

                string hoTen = Session["ND_HoTen"].ToString();
                litAvatar.Text = hoTen.Substring(0, 1).ToUpper();
            }
            else
            {
                lnkLogin.Visible = true;
                pnlUser.Visible = false;
            }
            SetActiveMenu();

        }
        private void SetActiveMenu()
        {
            string url = Request.Url.AbsolutePath.ToLower();

            if (url.Contains("trangchu"))
                menuTrangChu.Attributes["class"] += " active";

            else if (url.Contains("danhsachchiendich"))
                menuChienDich.Attributes["class"] += " active";

            else if (url.Contains("danhsachtintuc") || url.Contains("chitiettintuc"))
                menuTinTuc.Attributes["class"] += " active";

            else if (url.Contains("lienhe"))
                menuLienHe.Attributes["class"] += " active";

            else if (url.Contains("hoso"))
                menuHoSo.Attributes["class"] += " active";
        }
    }
}