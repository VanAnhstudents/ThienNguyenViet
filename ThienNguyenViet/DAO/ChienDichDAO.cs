using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ThienNguyenViet.DAO
{
    /// <summary>
    /// DAO thao tác bảng ChienDich.
    /// </summary>
    public class ChienDichDAO
    {
        /// <summary>Lấy top N chiến dịch nổi bật (NoiBat=1) kèm % tiến độ.</summary>
        public static DataTable LayChienDichNoiBat(int soLuong = 5)
        {
            const string sql = @"
SELECT TOP (@n)
    MaChienDich,
    TenChienDich,
    MucTieu,
    SoTienDaQuyen,
    CASE WHEN MucTieu = 0 THEN 0
         ELSE CAST(SoTienDaQuyen * 100.0 / MucTieu AS DECIMAL(5,1))
    END AS PhanTram
FROM dbo.ChienDich
WHERE NoiBat = 1 AND TrangThai = 1
ORDER BY NgayTao DESC";
            return KetNoiDB.GetDataTable(sql,
                CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }

        /// <summary>Đếm chiến dịch theo trạng thái.</summary>
        public static int DemTheoTrangThai(int trangThai)
        {
            const string sql = "SELECT COUNT(*) FROM dbo.ChienDich WHERE TrangThai = @ts";
            object val = KetNoiDB.ExecuteScalar(sql,
                CommandType.Text,
                KetNoiDB.P("@ts", trangThai));
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }
    }
}