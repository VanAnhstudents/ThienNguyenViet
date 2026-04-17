using System;
using System.Data;

namespace ThienNguyenViet.DAO
{
    public class ChienDichDAO
    {
        // ===================================================================
        // 1. DÙNG CHO TRANG DANH SÁCH CHIẾN DỊCH
        // ===================================================================
        public static DataTable LayDanhSachCongKhai()
        {
            const string sql = @"
SELECT
    cd.MaChienDich,
    cd.MaDanhMuc,
    cd.TenChienDich,
    cd.MoTaNgan,
    cd.AnhBia,
    cd.SoTienDaQuyen,
    cd.MucTieu,
    cd.TrangThai,
    cd.NoiBat,
    ISNULL(qg.SoLuotQuyenGop, 0)                       AS SoLuotGop,
    DATEDIFF(DAY, GETDATE(), cd.NgayKetThuc)           AS NgayConLai,
    DATEDIFF(DAY, cd.NgayTao, GETDATE())               AS NgayDaTao
FROM dbo.ChienDich cd
LEFT JOIN (
    SELECT MaChienDich, COUNT(*) AS SoLuotQuyenGop
    FROM dbo.QuyenGop WHERE TrangThai = 1
    GROUP BY MaChienDich
) qg ON cd.MaChienDich = qg.MaChienDich
WHERE cd.TrangThai = 1
ORDER BY cd.NgayTao DESC;";

            return KetNoiDB.GetDataTable(sql, CommandType.Text);
        }

        // ===================================================================
        // 2. CHIẾN DỊCH NỔI BẬT CHO TRANG CHỦ (ĐÃ SỬA %)
        // ===================================================================
        public static DataTable LayChienDichNoiBat(int soLuong = 6)
        {
            const string sql = @"
SELECT TOP (@n)
    MaChienDich,
    TenChienDich,
    AnhBia,
    MucTieu,
    SoTienDaQuyen,
    CASE 
        WHEN MucTieu = 0 THEN 0
        WHEN SoTienDaQuyen >= MucTieu THEN 100.0
        ELSE CAST(SoTienDaQuyen * 100.0 / MucTieu AS DECIMAL(5,1))
    END AS PhanTram
FROM dbo.ChienDich
WHERE NoiBat = 1 AND TrangThai = 1
ORDER BY NgayTao DESC";

            return KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }

        // ===================================================================
        // 3. THÊM / SỬA CHIẾN DỊCH (đã sửa signature cho FormChienDich)
        // ===================================================================
        public static int Them(string ten, string moTa, string noiDung,
            long mucTieu, DateTime ngayBD, DateTime ngayKT,
            string toChuc, string nganHang, string stk, string chuTK,
            string anhBia, int maDanhMuc, bool noiBat, int trangThai, int maNguoiTao)
        {
            const string sql = @"
INSERT INTO dbo.ChienDich
    (TenChienDich, MaDanhMuc, MoTaNgan, NoiDungChiTiet, AnhBia,
     MucTieu, NgayBatDau, NgayKetThuc, TrangThai, NoiBat,
     TenNganHang, SoTaiKhoan, TenChuTaiKhoan, ToChucChuTri,
     MaNguoiTao, NgayTao)
VALUES
    (@ten, @maDanhMuc, @moTa, @noiDung, @anhBia,
     @mucTieu, @ngayBD, @ngayKT, @trangThai, @noiBat,
     @nganHang, @stk, @chuTK, @toChuc,
     @maNguoiTao, GETDATE());
SELECT SCOPE_IDENTITY();";

            object val = KetNoiDB.ExecuteScalar(sql, CommandType.Text,
                KetNoiDB.P("@ten", ten),
                KetNoiDB.P("@maDanhMuc", maDanhMuc),
                KetNoiDB.P("@moTa", moTa),
                KetNoiDB.P("@noiDung", noiDung),
                KetNoiDB.P("@anhBia", anhBia),
                KetNoiDB.P("@mucTieu", mucTieu),
                KetNoiDB.P("@ngayBD", ngayBD),
                KetNoiDB.P("@ngayKT", ngayKT),
                KetNoiDB.P("@trangThai", trangThai),
                KetNoiDB.P("@noiBat", noiBat),
                KetNoiDB.P("@nganHang", nganHang),
                KetNoiDB.P("@stk", stk),
                KetNoiDB.P("@chuTK", chuTK),
                KetNoiDB.P("@toChuc", toChuc),
                KetNoiDB.P("@maNguoiTao", maNguoiTao));

            return val == null || val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        public static bool Sua(int id, string ten, string moTa, string noiDung,
            long mucTieu, DateTime ngayBD, DateTime ngayKT,
            string toChuc, string nganHang, string stk, string chuTK,
            string anhBia, int maDanhMuc, bool noiBat, int trangThai)
        {
            try
            {
                const string sql = @"
UPDATE dbo.ChienDich SET
    TenChienDich    = @ten,
    MaDanhMuc       = @maDanhMuc,
    MoTaNgan        = @moTa,
    NoiDungChiTiet  = @noiDung,
    AnhBia          = @anhBia,
    MucTieu         = @mucTieu,
    NgayBatDau      = @ngayBD,
    NgayKetThuc     = @ngayKT,
    TrangThai       = @trangThai,
    NoiBat          = @noiBat,
    TenNganHang     = @nganHang,
    SoTaiKhoan      = @stk,
    TenChuTaiKhoan  = @chuTK,
    ToChucChuTri    = @toChuc,
    NgayCapNhat     = GETDATE()
WHERE MaChienDich = @id";

                KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                    KetNoiDB.P("@id", id),
                    KetNoiDB.P("@ten", ten),
                    KetNoiDB.P("@maDanhMuc", maDanhMuc),
                    KetNoiDB.P("@moTa", moTa),
                    KetNoiDB.P("@noiDung", noiDung),
                    KetNoiDB.P("@anhBia", anhBia),
                    KetNoiDB.P("@mucTieu", mucTieu),
                    KetNoiDB.P("@ngayBD", ngayBD),
                    KetNoiDB.P("@ngayKT", ngayKT),
                    KetNoiDB.P("@trangThai", trangThai),
                    KetNoiDB.P("@noiBat", noiBat),
                    KetNoiDB.P("@nganHang", nganHang),
                    KetNoiDB.P("@stk", stk),
                    KetNoiDB.P("@chuTK", chuTK),
                    KetNoiDB.P("@toChuc", toChuc));

                return true;
            }
            catch { return false; }
        }

        // ===================================================================
        // Các phương thức cũ khác (giữ nguyên)
        // ===================================================================
        public static DataTable LayTatCa() { /* ... code cũ ... */ return null; }
        public static DataRow LayTheoMa(int ma)
        {
            const string sql = @"
SELECT TOP 1 *
FROM dbo.ChienDich
WHERE MaChienDich = @ma";

            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@ma", ma));

            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }
        public static DataTable LayDanhMuc() { /* ... */ return null; }
        public static DataTable LayTienDo(int maChienDich) { /* ... */ return null; }
        public static bool Xoa(int ma) { /* ... */ return false; }
        public static bool ThemTienDo(int maChienDich, string tieuDe, string noiDung, DateTime ngayDang, int maNguoiDang)
        { /* ... */ return false; }
        public static int DemTheoTrangThai(int trangThai) { /* ... */ return 0; }
        public static DataRow TaoRowRong() { /* ... */ return null; }
    }
}