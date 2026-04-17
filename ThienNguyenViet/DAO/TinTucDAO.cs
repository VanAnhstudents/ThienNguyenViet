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

        // ══════════════════════════════════════════════════════════
        // HELPER — dùng trong Eval() của Repeater
        // Ánh xạ MaDanhMuc theo bảng DanhMucTinTuc:
        //   1 = Hoạt động  | 2 = Câu chuyện | 3 = Thông báo
        // ══════════════════════════════════════════════════════════

        /// <summary>Trả về slug CSS dùng cho data-cat và class tag-*.</summary>
        public static string GetCatSlug(int maDanhMuc)
        {
            switch (maDanhMuc)
            {
                case 1: return "hoatdong";
                case 2: return "cauchuy";
                case 3: return "thongbao";
                default: return "all";
            }
        }

        /// <summary>Trả về emoji icon hiển thị trên badge danh mục.</summary>
        public static string GetCatIcon(int maDanhMuc)
        {
            switch (maDanhMuc)
            {
                case 1: return "🤝";
                case 2: return "❤️";
                case 3: return "📢";
                default: return "📋";
            }
        }

        /// <summary>Trả về emoji dự phòng khi bài viết không có ảnh bìa.</summary>
        public static string GetCatEmoji(int maDanhMuc)
        {
            switch (maDanhMuc)
            {
                case 1: return "🤝";
                case 2: return "❤️‍🩹";
                case 3: return "📢";
                default: return "📰";
            }
        }
    }
}