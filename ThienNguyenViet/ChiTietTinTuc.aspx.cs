using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThienNguyenViet
{
    public partial class ChiTietTinTuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int maTin = Convert.ToInt32(Request.QueryString["id"]);
                    LoadChiTiet(maTin);
                }
            }
        }

        private void LoadChiTiet(int maTin)
        {
            var row = DAO.TinTucDAO.LayChiTiet(maTin);

            if (row != null)
            {
                lblTieuDe.Text = row["TieuDe"].ToString();
                imgAnhBia.ImageUrl = row["AnhBia"].ToString();
                lblNgayDang.Text = Convert.ToDateTime(row["NgayDang"]).ToString("dd/MM/yyyy");

                // Quan trọng: nội dung HTML
                litNoiDung.Text = row["NoiDung"].ToString();
            }
        }
    }
}