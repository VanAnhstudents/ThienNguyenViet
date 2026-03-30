using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace ThienNguyenViet.DAO
{
    /// <summary>
    /// Quản lý phiên đăng nhập (Session + Cookie) và phân quyền Admin.
    /// </summary>
    public static class PhanQuyenHelper
    {
        // ── Khóa Session ──────────────────────────────────────────────
        public const string SESSION_MA = "ND_Ma";
        public const string SESSION_HOTEN = "ND_HoTen";
        public const string SESSION_EMAIL = "ND_Email";
        public const string SESSION_VAITRO = "ND_VaiTro";   // 0=user, 1=admin
        public const string COOKIE_REMEMBER = "TNV_Remember";

        // ── Lưu thông tin đăng nhập vào Session ───────────────────────
        public static void LuuSession(HttpSessionStateBase session,
            int ma, string hoTen, string email, int vaiTro)
        {
            session[SESSION_MA] = ma;
            session[SESSION_HOTEN] = hoTen;
            session[SESSION_EMAIL] = email;
            session[SESSION_VAITRO] = vaiTro;
        }

        public static void LuuSession(System.Web.SessionState.HttpSessionState session,
            int ma, string hoTen, string email, int vaiTro)
        {
            session[SESSION_MA] = ma;
            session[SESSION_HOTEN] = hoTen;
            session[SESSION_EMAIL] = email;
            session[SESSION_VAITRO] = vaiTro;
        }

        // ── Kiểm tra đã đăng nhập ─────────────────────────────────────
        public static bool DaDangNhap(System.Web.SessionState.HttpSessionState session)
            => session[SESSION_MA] != null;

        // ── Kiểm tra quyền Admin ──────────────────────────────────────
        public static bool LaAdmin(System.Web.SessionState.HttpSessionState session)
            => DaDangNhap(session) && Convert.ToInt32(session[SESSION_VAITRO]) == 1;

        // ── Lấy mã người dùng hiện tại ───────────────────────────────
        public static int LayMa(System.Web.SessionState.HttpSessionState session)
            => session[SESSION_MA] == null ? 0 : Convert.ToInt32(session[SESSION_MA]);

        public static string LayHoTen(System.Web.SessionState.HttpSessionState session)
            => session[SESSION_HOTEN]?.ToString() ?? string.Empty;

        // ── Yêu cầu đăng nhập Admin – redirect nếu chưa ──────────────
        /// <summary>
        /// Gọi ở đầu Page_Load của mọi trang Admin.
        /// Nếu chưa đăng nhập hoặc không phải admin → redirect về trang đăng nhập.
        /// </summary>
        public static void YeuCauAdmin(Page page)
        {
            if (!LaAdmin(page.Session))
                page.Response.Redirect("~/DangNhap.aspx", true);
        }

        // ── Đăng xuất ─────────────────────────────────────────────────
        public static void DangXuat(HttpResponse response,
            System.Web.SessionState.HttpSessionState session,
            HttpRequest request)
        {
            session.Abandon();
            // Xóa cookie "remember me" nếu có
            if (request.Cookies[COOKIE_REMEMBER] != null)
            {
                var c = new HttpCookie(COOKIE_REMEMBER) { Expires = DateTime.Now.AddDays(-1) };
                response.Cookies.Add(c);
            }
        }
    }
}