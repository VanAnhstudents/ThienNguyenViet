using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
        //  QuanLyQuyenGop — lấy danh sách + phân trang
        // ─────────────────────────────────────────────

        /// <summary>
        /// Thống kê 5 số cho trang QuanLyQuyenGop (dùng SP_ThongKeQuyenGopTongQuan).
        /// </summary>
        public static DataRow LayThongKeTrangQuanLy()
        {
            DataTable dt = KetNoiDB.GetDataTable("SP_ThongKeQuyenGopTongQuan",
                CommandType.StoredProcedure);
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        /// <summary>
        /// Lấy danh sách chiến dịch để bind dropdown lọc.
        /// </summary>
        public static DataTable LayChienDichDropdown()
        {
            return KetNoiDB.GetDataTable("SP_LayDanhSachChienDichDropdown",
                CommandType.StoredProcedure);
        }

        /// <summary>
        /// Lấy danh sách quyên góp có lọc + phân trang.
        /// Trả về DataTable và gán totalRows qua output param.
        /// </summary>
        public static DataTable LayQuyenGopCoLoc(
            int? trangThai,
            int? maChienDich,
            string tuKhoa,
            int trangHienTai,
            int soDong,
            out int tongSoDong)
        {
            tongSoDong = 0;

            var pTongSo = new SqlParameter("@TongSoDong", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            var prms = new List<SqlParameter>
            {
                KetNoiDB.P("@TrangThai",    trangThai.HasValue   ? (object)trangThai.Value   : DBNull.Value),
                KetNoiDB.P("@MaChienDich",  maChienDich.HasValue ? (object)maChienDich.Value : DBNull.Value),
                KetNoiDB.P("@TuKhoa",       string.IsNullOrWhiteSpace(tuKhoa) ? (object)DBNull.Value : tuKhoa.Trim()),
                KetNoiDB.P("@TrangHienTai", trangHienTai),
                KetNoiDB.P("@SoDong",       soDong),
                pTongSo
            };

            DataTable dt;
            using (var conn = KetNoiDB.MoKetNoi())
            using (var cmd = new SqlCommand("SP_LayQuyenGopCoLoc", conn)
            { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddRange(prms.ToArray());
                using (var da = new System.Data.SqlClient.SqlDataAdapter(cmd))
                {
                    dt = new DataTable();
                    da.Fill(dt);
                }
            }

            if (pTongSo.Value != DBNull.Value)
                tongSoDong = Convert.ToInt32(pTongSo.Value);

            return dt;
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
        /// <summary>Lấy lịch sử quyên góp của người dùng (dùng SP đã có trong Schema).</summary>
        public static DataTable LayLichSuQuyenGopCuaNguoiDung(int maNguoiDung, int trangHienTai = 1, int soDong = 5)
        {
            return KetNoiDB.GetDataTable("SP_LayLichSuQuyenGop",
                CommandType.StoredProcedure,
                KetNoiDB.P("@MaNguoiDung", maNguoiDung),
                KetNoiDB.P("@TrangHienTai", trangHienTai),
                KetNoiDB.P("@SoDoiMoiTrang", soDong));
        }
    }
}