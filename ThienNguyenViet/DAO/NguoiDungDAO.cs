using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ThienNguyenViet.DAO
{
    /// <summary>DAO thao tác bảng NguoiDung + đăng nhập / đăng ký.</summary>
    public class NguoiDungDAO
    {
        // ─── Đăng nhập ────────────────────────────────────────────────
        /// <summary>
        /// Kiểm tra email + mật khẩu. Trả về DataRow người dùng nếu hợp lệ,
        /// null nếu sai hoặc bị khóa.
        /// </summary>
        public static DataRow DangNhap(string email, string matKhauRaw)
        {
            string hash = MaHoaMD5(matKhauRaw);
            DataTable dt = KetNoiDB.GetDataTable("SP_DangNhap",
                CommandType.StoredProcedure,
                KetNoiDB.P("@Email", email),
                KetNoiDB.P("@MatKhau", hash));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        // ─── Đăng ký ──────────────────────────────────────────────────
        public static int DangKy(string hoTen, string email,
            string matKhauRaw, string sdt = null)
        {
            string hash = MaHoaMD5(matKhauRaw);
            var prm = new System.Data.SqlClient.SqlParameter("@MaNguoiDungMoi",
                SqlDbType.Int)
            { Direction = ParameterDirection.Output };

            using (var conn = KetNoiDB.MoKetNoi())
            using (var cmd = new System.Data.SqlClient.SqlCommand(
                "SP_DangKy", conn)
            { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddRange(new[]
                {
                    KetNoiDB.P("@HoTen",       hoTen),
                    KetNoiDB.P("@Email",        email),
                    KetNoiDB.P("@MatKhau",      hash),
                    KetNoiDB.P("@SoDienThoai",  sdt),
                    prm
                });
                cmd.ExecuteNonQuery();
            }
            return Convert.ToInt32(prm.Value);
        }

        // ─── Đếm người dùng ───────────────────────────────────────────
        public static int DemNguoiDung()
        {
            object val = KetNoiDB.ExecuteScalar(
                "SELECT COUNT(*) FROM dbo.NguoiDung WHERE VaiTro = 0",
                CommandType.Text);
            return val == DBNull.Value ? 0 : Convert.ToInt32(val);
        }

        // ─── Hash MD5 ─────────────────────────────────────────────────
        public static string MaHoaMD5(string input)
        {
            using (var md5 = MD5.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = md5.ComputeHash(bytes);
                var sb = new StringBuilder();
                foreach (byte b in hash) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
        // ─────────────────────────────────────────────────────────────
        //  HỒ SƠ CÁ NHÂN – HoSo.aspx
        // ─────────────────────────────────────────────────────────────

        /// <summary>Lấy thông tin hồ sơ người dùng theo mã.</summary>
        public static DataRow LayThongTinHoSo(int maNguoiDung)
        {
            const string sql = "SELECT * FROM dbo.NguoiDung WHERE MaNguoiDung = @ma";
            DataTable dt = KetNoiDB.GetDataTable(sql, CommandType.Text,
                KetNoiDB.P("@ma", maNguoiDung));
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        /// <summary>Cập nhật thông tin cá nhân + avatar.</summary>
        public static bool CapNhatHoSo(int maNguoiDung, string hoTen, string soDienThoai, string anhDaiDien = null)
        {
            try
            {
                const string sql = @"
UPDATE dbo.NguoiDung 
SET HoTen = @hoTen, 
    SoDienThoai = @soDienThoai,
    AnhDaiDien = @anhDaiDien,
    NgayCapNhat = GETDATE()
WHERE MaNguoiDung = @ma";

                KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                    KetNoiDB.P("@ma", maNguoiDung),
                    KetNoiDB.P("@hoTen", hoTen),
                    KetNoiDB.P("@soDienThoai", string.IsNullOrWhiteSpace(soDienThoai) ? (object)DBNull.Value : soDienThoai),
                    KetNoiDB.P("@anhDaiDien", string.IsNullOrWhiteSpace(anhDaiDien) ? (object)DBNull.Value : anhDaiDien));
                return true;
            }
            catch { return false; }
        }

        /// <summary>Đổi mật khẩu (kiểm tra mật khẩu cũ trước).</summary>
        public static bool DoiMatKhau(int maNguoiDung, string oldPassRaw, string newPassRaw)
        {
            string oldHash = MaHoaMD5(oldPassRaw);
            string newHash = MaHoaMD5(newPassRaw);

            // Kiểm tra mật khẩu cũ
            const string checkSql = "SELECT COUNT(*) FROM dbo.NguoiDung WHERE MaNguoiDung = @ma AND MatKhau = @oldHash";
            object count = KetNoiDB.ExecuteScalar(checkSql, CommandType.Text,
                KetNoiDB.P("@ma", maNguoiDung),
                KetNoiDB.P("@oldHash", oldHash));

            if (Convert.ToInt32(count) == 0) return false;

            // Cập nhật mật khẩu mới
            const string sql = "UPDATE dbo.NguoiDung SET MatKhau = @newHash, NgayCapNhat = GETDATE() WHERE MaNguoiDung = @ma";
            KetNoiDB.ExecuteNonQuery(sql, CommandType.Text,
                KetNoiDB.P("@ma", maNguoiDung),
                KetNoiDB.P("@newHash", newHash));
            return true;
        }
    }
}