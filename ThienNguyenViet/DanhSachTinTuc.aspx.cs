using System;
using System.Data;
using System.Web.UI;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class DanhSachTinTuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTinTuc();
            }
        }

        private void BindTinTuc()
        {
            DataTable dt = TinTucDAO.LayTinGanDay(50);

            if (dt == null || dt.Rows.Count == 0)
            {
                pnlFeatured.Visible = false;
                pnlGrid.Visible = false;
                pnlEmpty.Visible = true;
                return;
            }

            // ── Featured card: bài đầu tiên (mới nhất) ──────────
            DataTable dtFeatured = dt.Clone();
            dtFeatured.ImportRow(dt.Rows[0]);
            rptFeatured.DataSource = dtFeatured;
            rptFeatured.DataBind();
            pnlFeatured.Visible = true;

            // ── Cards grid: các bài còn lại ─────────────────────
            if (dt.Rows.Count > 1)
            {
                DataTable dtCards = dt.Clone();
                for (int i = 1; i < dt.Rows.Count; i++)
                    dtCards.ImportRow(dt.Rows[i]);

                rptCards.DataSource = dtCards;
                rptCards.DataBind();
                pnlGrid.Visible = true;
            }
            else
            {
                pnlGrid.Visible = false;
            }

            pnlEmpty.Visible = false;
        }
    }
}