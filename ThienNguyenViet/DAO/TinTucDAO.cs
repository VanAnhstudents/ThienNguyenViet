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
        /// <summary>Đếm tổng tin tức đã đăng (TrangThai = 1).</summary>
        public static int DemTinDaDang()
        {
            object val = KetNoiDB.ExecuteScalar(
                "SELECT COUNT(*) FROM dbo.TinTuc WHERE TrangThai = 1",
                CommandType.Text);
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        /// <summary>Lấy danh sách tin tức gần nhất.</summary>
        public static DataTable LayTinGanDay(int soLuong = 5)
        {
            const string sql = @"
SELECT TOP (@n)
    MaTinTuc, TieuDe, AnhBia, LuotXem, NgayDang, TrangThai
FROM dbo.TinTuc
ORDER BY NgayDang DESC";
            return KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }
    }
}