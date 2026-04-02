using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ThienNguyenViet.DAO
{
    public class ChienDichDAO
    {
        // ── Lấy danh sách ────────────────────────────────────────────
        /// <summary>Lấy toàn bộ chiến dịch kèm tên danh mục (dùng cho QuanLyChienDich).</summary>
        public static DataTable LayTatCa()
        {
            const string sql = @"
SELECT
    cd.MaChienDich,
    cd.TenChienDich,
    cd.MoTaNgan,
    cd.MaDanhMuc,
    cd.MucTieu,
    cd.SoTienDaQuyen,
    cd.NgayBatDau,
    cd.NgayKetThuc,
    cd.TrangThai,
    cd.NoiBat,
    cd.NgayTao,
    dm.TenDanhMuc,
    dm.MauSac AS MauDanhMuc
FROM dbo.ChienDich cd
INNER JOIN dbo.DanhMucChienDich dm ON cd.MaDanhMuc = dm.MaDanhMuc
ORDER BY cd.NgayTao DESC";
            return KetNoiDB.GetDataTable(sql, CommandType.Text);
        }

        /// <summary>Lấy 1 chiến dịch theo mã.</summary>
        public static DataRow LayTheoMa(int ma)
        {
            const string sql = @"
SELECT
    cd.*,
    dm.TenDanhMuc,
    dm.MauSac AS MauDanhMuc
FROM dbo.ChienDich cd
INNER JOIN dbo.DanhMucChienDich dm ON cd.MaDanhMuc = dm.MaDanhMuc
WHERE cd.MaChienDich = @ma";
            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@ma", ma));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        /// <summary>Lấy danh sách tất cả danh mục chiến dịch.</summary>
        public static DataTable LayDanhMuc()
        {
            return KetNoiDB.GetDataTable(
                "SELECT MaDanhMuc, TenDanhMuc, MauSac FROM dbo.DanhMucChienDich ORDER BY ThuTuHienThi",
                CommandType.Text);
        }

        /// <summary>Lấy cập nhật tiến độ của một chiến dịch.</summary>
        public static DataTable LayTienDo(int maChienDich)
        {
            const string sql = @"
SELECT MaCapNhat, TieuDe, NoiDung, AnhMinhHoa, NgayDang
FROM dbo.CapNhatTienDo
WHERE MaChienDich = @ma
ORDER BY NgayDang DESC";
            return KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@ma", maChienDich));
        }

        /// <summary>Lấy top N chiến dịch nổi bật kèm % tiến độ (dùng cho TongQuan).</summary>
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
            return KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@n", soLuong));
        }

        // ── Thêm / Sửa / Xóa ─────────────────────────────────────────

        /// <summary>Thêm chiến dịch mới. Trả về mã mới tạo.</summary>
        public static int Them(
            string ten, string moTa, string noiDung,
            long mucTieu, DateTime ngayBD, DateTime ngayKT,
            string toChuc, string nganHang, string stk, string chuTK,
            string anhBia, int maDanhMuc, bool noiBat,
            int trangThai, int maNguoiTao)
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

        /// <summary>Sửa chiến dịch. Trả về true nếu thành công.</summary>
        public static bool Sua(
            int ma, string ten, string moTa, string noiDung,
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
WHERE MaChienDich = @ma";

                KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                    KetNoiDB.P("@ma", ma),
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

        /// <summary>Xóa chiến dịch. Trả về true nếu thành công.</summary>
        public static bool Xoa(int ma)
        {
            try
            {
                KetNoiDB.ExecuteNonQuery(
                    "DELETE FROM dbo.ChienDich WHERE MaChienDich = @ma",
                    CommandType.Text,
                    KetNoiDB.P("@ma", ma));
                return true;
            }
            catch { return false; } // FK constraint → có giao dịch liên quan
        }

        /// <summary>Thêm cập nhật tiến độ. Trả về true nếu thành công.</summary>
        public static bool ThemTienDo(int maChienDich, string tieuDe,
            string noiDung, DateTime ngayDang, int maNguoiDang)
        {
            try
            {
                const string sql = @"
INSERT INTO dbo.CapNhatTienDo
    (MaChienDich, TieuDe, NoiDung, MaNguoiDang, NgayDang)
VALUES
    (@maCD, @tieu, @noi, @nguoi, @ngay)";
                KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                    KetNoiDB.P("@maCD", maChienDich),
                    KetNoiDB.P("@tieu", tieuDe),
                    KetNoiDB.P("@noi", noiDung),
                    KetNoiDB.P("@nguoi", maNguoiDang),
                    KetNoiDB.P("@ngay", ngayDang));
                return true;
            }
            catch { return false; }
        }

        /// <summary>Đếm chiến dịch theo trạng thái.</summary>
        public static int DemTheoTrangThai(int trangThai)
        {
            object val = KetNoiDB.ExecuteScalar(
                "SELECT COUNT(*) FROM dbo.ChienDich WHERE TrangThai = @ts",
                CommandType.Text,
                KetNoiDB.P("@ts", trangThai));
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        /// <summary>
        /// Tạo DataRow rỗng với các cột cần thiết (dùng khi thêm mới,
        /// tránh null reference trong ASPX).
        /// </summary>
        public static DataRow TaoRowRong()
        {
            var dt = new DataTable();
            string[] cols =
            {
                "TenChienDich","MoTaNgan","NoiDungChiTiet","AnhBia",
                "MucTieu","NgayBatDau","NgayKetThuc","TrangThai","NoiBat",
                "TenNganHang","SoTaiKhoan","TenChuTaiKhoan","ToChucChuTri",
                "MaDanhMuc","NgayTao","NgayCapNhat"
            };
            foreach (var c in cols) dt.Columns.Add(c);
            return dt.NewRow(); // tất cả giá trị là DBNull
        }
    }
}