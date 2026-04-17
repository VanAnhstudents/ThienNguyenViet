using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ThienNguyenViet.DAO
{
    /// <summary>DAO thao tác bảng TinTuc.</summary>
    public class TinTucDAO
    {
        // ══════════════════════════════════════════════════════════
        // QUERY
        // ══════════════════════════════════════════════════════════

        /// <summary>Đếm tổng tin tức đã đăng (TrangThai = 1).</summary>
        public static int DemTinDaDang()
        {
            object val = KetNoiDB.ExecuteScalar(
                "SELECT COUNT(*) FROM dbo.TinTuc WHERE TrangThai = 1",
                CommandType.Text);
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        /// <summary>
        /// Lấy danh sách tin tức đã đăng, sắp xếp theo ngày mới nhất.
        /// Trả về: MaTinTuc, TieuDe, TomTat, AnhBia, LuotXem, NgayDang,
        ///         TrangThai, MaDanhMuc, TenDanhMuc, NguoiDang.
        /// </summary>
        public static DataTable LayTinGanDay(int soLuong = 20)
        {
            const string sql = @"
SELECT TOP (@n)
    tt.MaTinTuc,
    tt.TieuDe,
    tt.TomTat,
    tt.AnhBia,
    tt.LuotXem,
    tt.NgayDang,
    tt.TrangThai,
    tt.MaDanhMuc,
    dm.TenDanhMuc,
    nd.HoTen AS NguoiDang
FROM dbo.TinTuc tt
INNER JOIN dbo.DanhMucTinTuc dm ON tt.MaDanhMuc = dm.MaDanhMuc
INNER JOIN dbo.NguoiDung     nd ON tt.MaNguoiDang = nd.MaNguoiDung
WHERE tt.TrangThai = 1
ORDER BY tt.NgayDang DESC";

            return KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }
        public static DataRow LayChiTiet(int maTin)
        {
            string sql = @"
        SELECT *
        FROM dbo.TinTuc
        WHERE MaTinTuc = @id AND TrangThai = 1";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@id", maTin));

            if (dt.Rows.Count > 0)
                return dt.Rows[0];

            return null;
        }
    }
}