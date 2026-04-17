<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ThienNguyenViet.DangNhap" %>
<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đăng nhập - Thiện Nguyện Việt</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* === Reset === */
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        /* === Trang === */
        html, body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* === Form chính === */
        .login-container {
            width: 100%;
            max-width: 420px;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 36px 32px;
        }

        /* === Nút quay về trang chủ === */
        .btn-home {
            display: inline-block;
            font-size: 14px;
            font-weight: 500;
            color: #2D7A4F;
            text-decoration: none;
            margin-bottom: 20px;
        }

        .btn-home:hover {
            text-decoration: underline;
        }

        /* === Tiêu đề === */
        .form-title {
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            color: #222;
            margin-bottom: 6px;
        }

        .form-subtitle {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 24px;
        }

        .form-subtitle a {
            color: #2D7A4F;
            text-decoration: none;
            font-weight: 600;
        }

        .form-subtitle a:hover {
            text-decoration: underline;
        }

        /* === Ô thông báo (lỗi / thành công) === */
        .msg-box {
            display: none;
            align-items: center;
            gap: 8px;
            border-radius: 4px;
            padding: 10px 12px;
            margin-bottom: 18px;
            font-size: 13px;
        }

        .msg-box.show {
            display: flex;
        }

        /* Kiểu lỗi (đỏ) */
        .msg-box.error {
            background: #fff2f2;
            border: 1px solid #ffcccc;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        /* Kiểu thành công (xanh) */
        .msg-box.success {
            background: #f0faf4;
            border: 1px solid #b2dfdb;
            border-left: 4px solid #2D7A4F;
            color: #2D7A4F;
        }

        /* === Mỗi trường nhập liệu === */
        .field {
            margin-bottom: 16px;
        }

        .field-lbl {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .field-wrap {
            position: relative;
        }

        .field-ico {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 15px;
            color: #999;
            pointer-events: none;
        }

        .field-inp {
            width: 100%;
            height: 44px;
            padding: 0 40px 0 40px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background: #fafafa;
            color: #333;
            font-size: 14px;
            outline: none;
        }

        .field-inp:focus {
            border-color: #2D7A4F;
        }

        .field-inp::placeholder {
            color: #aaa;
        }

        /* Nút mắt xem mật khẩu */
        .toggle-eye {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #888;
            font-size: 17px;
            cursor: pointer;
            padding: 2px;
        }

        /* Thông báo lỗi dưới ô input */
        .field-error-msg {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 4px;
        }

        /* === Hàng tùy chọn: Nhớ tôi / Quên mật khẩu === */
        .opts-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 13px;
        }

        .check-wrap {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #555;
            cursor: pointer;
        }

        .link-forgot {
            color: #2D7A4F;
            text-decoration: none;
            font-weight: 500;
        }

        .link-forgot:hover {
            text-decoration: underline;
        }

        /* === Nút đăng nhập === */
        .btn-login {
            width: 100%;
            height: 46px;
            background: #2D7A4F;
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-login:hover {
            background: #24643f;
        }

        /* === Dòng cuối form === */
        .form-bottom {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-top: 18px;
        }

        .form-bottom a {
            color: #2D7A4F;
            font-weight: 600;
            text-decoration: none;
        }

        .form-bottom a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">

            <!-- Nút quay về trang chủ -->
            <a href="TrangChu.aspx" class="btn-home">Trang chủ</a>

            <!-- Tiêu đề -->
            <h1 class="form-title">Đăng nhập</h1>
            <p class="form-subtitle">
                Chưa có tài khoản?
                <a href="DangKy.aspx">Tạo tài khoản miễn phí</a>
            </p>

            <!-- Thông báo lỗi hoặc thành công từ server -->
            <asp:Panel ID="pnlMsg" runat="server" Visible="false">
                <div class="msg-box show" id="msgBox" runat="server">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <!-- Email -->
            <div class="field">
                <label class="field-lbl">Email</label>
                <div class="field-wrap">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp"
                        placeholder="email@example.com" />
                </div>
                <div id="errEmail" class="field-error-msg"></div>
            </div>

            <!-- Mật khẩu -->
            <div class="field">
                <label class="field-lbl">Mật khẩu</label>
                <div class="field-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        CssClass="field-inp" placeholder="Nhập mật khẩu" />
                    <button type="button" class="toggle-eye" id="toggleEye"></button>
                </div>
                <div id="errPass" class="field-error-msg"></div>
            </div>

            <!-- Nhớ tôi / Quên mật khẩu -->
            <div class="opts-row">
                <label class="check-wrap">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    Nhớ tôi
                </label>
                <asp:HyperLink ID="lnkQuenMK" runat="server" NavigateUrl="#"
                    CssClass="link-forgot">
                    Quên mật khẩu?
                </asp:HyperLink>
            </div>

            <!-- Nút đăng nhập -->
            <asp:Button ID="btnDangNhap" runat="server"
                Text="Đăng nhập"
                CssClass="btn-login"
                OnClick="btnDangNhap_Click"
                OnClientClick="return validateLogin();" />

            <!-- Dòng cuối -->
            <div class="form-bottom">
                Chưa có tài khoản?
                <a href="DangKy.aspx">Tạo tài khoản miễn phí</a>
            </div>
        </div>
    </form>

    <script>
        // === Validate trước khi gửi form ===
        function validateLogin() {
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var pass  = document.getElementById('<%= txtPassword.ClientID %>').value;

            var errEmail = document.getElementById('errEmail');
            var errPass  = document.getElementById('errPass');

            // Xóa lỗi cũ
            errEmail.textContent = '';
            errPass.textContent  = '';

            var isValid = true;

            if (!email) {
                errEmail.textContent = 'Vui lòng nhập Email';
                isValid = false;
            }
            if (!pass) {
                errPass.textContent = 'Vui lòng nhập Mật khẩu';
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>
