using System;
using System.Data;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet
{
    public partial class ChiTietTinTuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra có id không
                if (Request.QueryString["id"] != null)
                {
                    int id;
                    if (int.TryParse(Request.QueryString["id"], out id))
                    {
                        LoadTin(id);
                        TangLuotXem(id);
                        LoadRelated(id);
                    }
                    else
                    {
                        Response.Redirect("DanhSachTinTuc.aspx");
                    }
                }
                else
                {
                    Response.Redirect("DanhSachTinTuc.aspx");
                }
            }
        }

        // ═══════════════════════════════════════════════
        // LOAD CHI TIẾT TIN
        // ═══════════════════════════════════════════════
        private void LoadTin(int id)
        {
            DataRow row = TinTucDAO.LayChiTiet(id);

            if (row != null)
            {
                // Tiêu đề
                lblTieuDe.Text = row["TieuDe"].ToString();
                lblTieuDe2.Text = row["TieuDe"].ToString();

                // Danh mục
                lblDanhMuc.Text = row["TenDanhMuc"].ToString();
                lblDanhMuc2.Text = row["TenDanhMuc"].ToString();

                // Ảnh bìa
                imgAnhBia.ImageUrl = row["AnhBia"].ToString();

                // Người đăng
                string nguoiDang = row["NguoiDang"].ToString();
                lblNguoiDang.Text = nguoiDang;
                lblNguoiDang2.Text = nguoiDang;

                // Avatar chữ cái đầu
                lblAvatar.Text = !string.IsNullOrEmpty(nguoiDang)
                    ? nguoiDang.Substring(0, 1)
                    : "A";

                // Ngày đăng
                string ngay = Convert.ToDateTime(row["NgayDang"])
                                    .ToString("dd/MM/yyyy");
                lblNgayDang.Text = ngay;
                lblNgayDang2.Text = ngay;

                // Lượt xem
                string luotXem = row["LuotXem"].ToString();
                lblLuotXem.Text = luotXem;
                lblLuotXem2.Text = luotXem;

                // Nội dung (HTML)
                litNoiDung.Text = row["NoiDung"].ToString().Replace("\n", "<br/>");
                lblBinhLuan.Text = "0";
                lblShare.Text = "0";
            }
            else
            {
                Response.Redirect("DanhSachTinTuc.aspx");
            }
        
        }

        // ═══════════════════════════════════════════════
        // TĂNG LƯỢT XEM
        // ═══════════════════════════════════════════════
        private void TangLuotXem(int id)
        {
            KetNoiDB.ExecuteNonQuery(
                "UPDATE TinTuc SET LuotXem = LuotXem + 1 WHERE MaTinTuc = @id",
                CommandType.Text,
                KetNoiDB.P("@id", id)
            );
        }

        // ═══════════════════════════════════════════════
        // LOAD BÀI LIÊN QUAN
        // ═══════════════════════════════════════════════
        private void LoadRelated(int id)
        {
            // Lấy 3 bài mới nhất (có thể nâng cấp sau)
            DataTable dt = TinTucDAO.LayTinGanDay(3);

            rptRelated.DataSource = dt;
            rptRelated.DataBind();
        }
    }
}