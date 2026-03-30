using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ThienNguyenViet.DAO
{
    /// <summary>
    /// DAO thao tác bảng QuyenGop và các thống kê liên quan.
    /// </summary>
    public class QuyenGopDAO
    {
        // ─────────────────────────────────────────────
        //  THỐNG KÊ TỔNG QUAN (dùng cho TongQuan.aspx)
        // ─────────────────────────────────────────────

        /// <summary>Gọi SP_ThongKeTongQuan – trả 1 dòng tổng hợp.</summary>
        public static DataRow LayThongKeTongQuan()
        {
            DataTable dt = KetNoiDB.GetDataTable("SP_ThongKeTongQuan",
                CommandType.StoredProcedure);
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        /// <summary>Gọi SP_ThongKeQuyenGopTheoThang – 12 dòng (tháng có dữ liệu).</summary>
        public static DataTable LayQuyenGopTheoThang(int nam)
        {
            return KetNoiDB.GetDataTable("SP_ThongKeQuyenGopTheoThang",
                CommandType.StoredProcedure,
                KetNoiDB.P("@Nam", nam));
        }

        /// <summary>10 giao dịch mới nhất (tất cả trạng thái) cho bảng gần đây.</summary>
        public static DataTable LayGiaoDichGanDay(int soLuong = 10)
        {
            const string sql = @"
SELECT TOP (@n)
    qg.MaQuyenGop,
    CASE WHEN qg.AnDanh = 1 THEN N'Ẩn danh'
         ELSE nd.HoTen END        AS HoTen,
    nd.Email,
    cd.TenChienDich,
    qg.SoTien,
    qg.NgayTao,
    qg.TrangThai,
    qg.AnDanh
FROM dbo.QuyenGop qg
LEFT JOIN  dbo.NguoiDung  nd ON qg.MaNguoiDung  = nd.MaNguoiDung
INNER JOIN dbo.ChienDich  cd ON qg.MaChienDich   = cd.MaChienDich
ORDER BY qg.NgayTao DESC";
            return KetNoiDB.GetDataTable(sql,
                CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }

        /// <summary>Đếm tổng số giao dịch trong tháng hiện tại.</summary>
        public static int DemGiaoDichThang(int thang, int nam)
        {
            const string sql = @"
SELECT COUNT(*) FROM dbo.QuyenGop
WHERE MONTH(NgayTao) = @thang AND YEAR(NgayTao) = @nam";
            object val = KetNoiDB.ExecuteScalar(sql,
                CommandType.Text,
                KetNoiDB.P("@thang", thang),
                KetNoiDB.P("@nam", nam));
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        /// <summary>Đếm giao dịch đã duyệt trong tháng.</summary>
        public static int DemDaDuyetThang(int thang, int nam)
        {
            const string sql = @"
SELECT COUNT(*) FROM dbo.QuyenGop
WHERE TrangThai = 1
  AND MONTH(NgayDuyet) = @thang AND YEAR(NgayDuyet) = @nam";
            object val = KetNoiDB.ExecuteScalar(sql,
                CommandType.Text,
                KetNoiDB.P("@thang", thang),
                KetNoiDB.P("@nam", nam));
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        /// <summary>Đếm chiến dịch đã hoàn thành mục tiêu.</summary>
        public static int DemChienDichHoanThanh()
        {
            const string sql = @"
SELECT COUNT(*) FROM dbo.ChienDich
WHERE SoTienDaQuyen >= MucTieu AND TrangThai IN (1, 3)";
            object val = KetNoiDB.ExecuteScalar(sql, CommandType.Text);
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        // ─────────────────────────────────────────────
        //  DUYỆT / TỪ CHỐI – gọi từ AJAX handler
        // ─────────────────────────────────────────────

        /// <summary>
        /// Duyệt hoặc từ chối một giao dịch quyên góp.
        /// Trả về true nếu thành công.
        /// </summary>
        public static bool DuyetQuyenGop(int maQuyenGop, int trangThai,
            int maNguoiDuyet, string lyDoTuChoi = null)
        {
            try
            {
                KetNoiDB.ExecuteNonQuery("SP_DuyetQuyenGop",
                    CommandType.StoredProcedure,
                    KetNoiDB.P("@MaQuyenGop", maQuyenGop),
                    KetNoiDB.P("@TrangThai", trangThai),
                    KetNoiDB.P("@MaNguoiDuyet", maNguoiDuyet),
                    KetNoiDB.P("@LyDoTuChoi", lyDoTuChoi));
                return true;
            }
            catch { return false; }
        }
    }
}