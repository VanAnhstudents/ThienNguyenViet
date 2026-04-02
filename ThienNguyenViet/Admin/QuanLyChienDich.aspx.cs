using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ThienNguyenViet.DAO;

namespace ThienNguyenViet.Admin
{
    public partial class QuanLyChienDich : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PhanQuyenHelper.YeuCauAdmin(this);

            if (Request["__ajax"] == "true")
            {
                HandleAjax();
                Response.End();
            }
        }

        private void HandleAjax()
        {
            Response.ContentType = "application/json";
            Response.ContentEncoding = Encoding.UTF8;

            string action = Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "list":
                        AjaxList();
                        break;
                    case "delete":
                        AjaxDelete();
                        break;
                    default:
                        Response.Write("{\"ok\":false,\"msg\":\"Action không hợp lệ\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                Response.Write("{\"ok\":false,\"msg\":\"" + ex.Message.Replace("\"", "\\\"") + "\"}");
            }
        }

        private void AjaxList()
        {
            int? maDanhMuc = null;
            if (int.TryParse(Request["MaDanhMuc"], out int dm)) maDanhMuc = dm;

            byte? trangThai = null;
            if (byte.TryParse(Request["TrangThai"], out byte tt)) trangThai = tt;

            string tuKhoa = Request["TuKhoa"]?.Trim();
            string sapXep = Request["SapXepTheo"] ?? "NgayTao";
            int page = int.TryParse(Request["TrangHienTai"], out int p) ? p : 1;
            int pageSize = int.TryParse(Request["SoDoiMoiTrang"], out int ps) ? ps : 8;

            DataTable dt = KetNoiDB.GetDataTable("SP_LayDanhSachChienDich",
                CommandType.StoredProcedure,
                KetNoiDB.P("@MaDanhMuc", maDanhMuc),
                KetNoiDB.P("@TrangThai", trangThai),
                KetNoiDB.P("@TuKhoa", tuKhoa),
                KetNoiDB.P("@SapXepTheo", sapXep),
                KetNoiDB.P("@TrangHienTai", page),
                KetNoiDB.P("@SoDoiMoiTrang", pageSize));

            object totalObj = KetNoiDB.ExecuteScalar(
                @"SELECT COUNT(*) FROM dbo.ChienDich 
                  WHERE (@MaDanhMuc IS NULL OR MaDanhMuc = @MaDanhMuc)
                    AND (@TrangThai IS NULL OR TrangThai = @TrangThai)
                    AND (@TuKhoa IS NULL OR TenChienDich LIKE '%' + @TuKhoa + '%')",
                CommandType.Text,
                KetNoiDB.P("@MaDanhMuc", maDanhMuc),
                KetNoiDB.P("@TrangThai", trangThai),
                KetNoiDB.P("@TuKhoa", tuKhoa));

            int total = totalObj == DBNull.Value ? 0 : Convert.ToInt32(totalObj);

            var sb = new StringBuilder("{\"ok\":true,\"total\":");
            sb.Append(total);
            sb.Append(",\"data\":[");
            bool first = true;

            foreach (DataRow r in dt.Rows)
            {
                if (!first) sb.Append(",");
                first = false;

                string isNoiBat = (r["NoiBat"] != DBNull.Value && Convert.ToBoolean(r["NoiBat"])) ? "true" : "false";

                sb.Append("{");
                sb.AppendFormat("\"MaChienDich\":{0},", r["MaChienDich"]);
                sb.AppendFormat("\"TenChienDich\":\"{0}\",", HttpUtility.JavaScriptStringEncode(r["TenChienDich"].ToString()));
                sb.AppendFormat("\"MoTaNgan\":\"{0}\",", HttpUtility.JavaScriptStringEncode(r["MoTaNgan"]?.ToString() ?? ""));
                sb.AppendFormat("\"MucTieu\":{0},", r["MucTieu"]);
                sb.AppendFormat("\"SoTienDaQuyen\":{0},", r["SoTienDaQuyen"]);
                sb.AppendFormat("\"NgayKetThuc\":\"{0:dd/MM/yyyy}\",", r["NgayKetThuc"]);
                sb.AppendFormat("\"SoNgayCon\":{0},", r["SoNgayCon"]);
                sb.AppendFormat("\"TrangThai\":{0},", r["TrangThai"]);
                sb.AppendFormat("\"NoiBat\":{0},", isNoiBat);
                sb.AppendFormat("\"TenDanhMuc\":\"{0}\",", HttpUtility.JavaScriptStringEncode(r["TenDanhMuc"].ToString()));
                sb.AppendFormat("\"MauDanhMuc\":\"{0}\"", r["MauDanhMuc"]);
                sb.Append("}");
            }
            sb.Append("]}");

            Response.Write(sb.ToString());
        }

        private void AjaxDelete()
        {
            if (!int.TryParse(Request["id"], out int id))
            {
                Response.Write("{\"ok\":false,\"msg\":\"Mã không hợp lệ\"}");
                return;
            }
            try
            {
                KetNoiDB.ExecuteNonQuery("SP_XoaChienDich", CommandType.StoredProcedure, KetNoiDB.P("@MaChienDich", id));
                Response.Write("{\"ok\":true,\"msg\":\"Đã xóa thành công\"}");
            }
            catch
            {
                Response.Write("{\"ok\":false,\"msg\":\"Lỗi: Chiến dịch này có dữ liệu liên quan không thể xóa.\"}");
            }
        }
    }
}