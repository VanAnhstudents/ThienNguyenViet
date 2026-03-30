using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ThienNguyenViet.DAO
{
    /// <summary>
    /// Lớp tiện ích kết nối SQL Server.
    /// Tất cả DAO đều dùng lớp này để lấy connection string và tạo SqlConnection.
    /// </summary>
    public static class KetNoiDB
    {
        // Lấy connection string từ Web.config
        private static readonly string _connStr =
            ConfigurationManager.ConnectionStrings["db_vanhdev_ThienNguyenViet"].ConnectionString;

        /// <summary>Tạo và mở một SqlConnection mới.</summary>
        public static SqlConnection MoKetNoi()
        {
            var conn = new SqlConnection(_connStr);
            conn.Open();
            return conn;
        }

        // ──────────────────────────────────────────────
        //  Helpers: ExecuteNonQuery, ExecuteScalar, Fill
        // ──────────────────────────────────────────────

        /// <summary>Thực thi lệnh không trả về dữ liệu (INSERT/UPDATE/DELETE).</summary>
        public static int ExecuteNonQuery(string sql,
            CommandType cmdType = CommandType.Text,
            params SqlParameter[] prms)
        {
            using (var conn = MoKetNoi())
            using (var cmd = new SqlCommand(sql, conn) { CommandType = cmdType })
            {
                if (prms != null) cmd.Parameters.AddRange(prms);
                return cmd.ExecuteNonQuery();
            }
        }

        /// <summary>Thực thi lệnh trả về giá trị đầu tiên (COUNT, SUM, SCOPE_IDENTITY…).</summary>
        public static object ExecuteScalar(string sql,
            CommandType cmdType = CommandType.Text,
            params SqlParameter[] prms)
        {
            using (var conn = MoKetNoi())
            using (var cmd = new SqlCommand(sql, conn) { CommandType = cmdType })
            {
                if (prms != null) cmd.Parameters.AddRange(prms);
                return cmd.ExecuteScalar();
            }
        }

        /// <summary>Fill DataTable từ một câu truy vấn SELECT hoặc Stored Procedure.</summary>
        public static DataTable GetDataTable(string sql,
            CommandType cmdType = CommandType.Text,
            params SqlParameter[] prms)
        {
            var dt = new DataTable();
            using (var conn = MoKetNoi())
            using (var cmd = new SqlCommand(sql, conn) { CommandType = cmdType })
            {
                if (prms != null) cmd.Parameters.AddRange(prms);
                using (var da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }
            return dt;
        }

        /// <summary>Fill DataSet (nhiều result-set) – dùng cho SP trả nhiều bảng.</summary>
        public static DataSet GetDataSet(string sql,
            CommandType cmdType = CommandType.Text,
            params SqlParameter[] prms)
        {
            var ds = new DataSet();
            using (var conn = MoKetNoi())
            using (var cmd = new SqlCommand(sql, conn) { CommandType = cmdType })
            {
                if (prms != null) cmd.Parameters.AddRange(prms);
                using (var da = new SqlDataAdapter(cmd))
                    da.Fill(ds);
            }
            return ds;
        }

        /// <summary>Tạo SqlParameter an toàn, tự xử lý null.</summary>
        public static SqlParameter P(string name, object value)
            => new SqlParameter(name, value ?? DBNull.Value);
    }
}