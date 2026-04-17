<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="ThienNguyenViet.DangKy" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Tạo tài khoản - Thiện Nguyện Việt</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* === Reset & Base === */
        *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
        html, body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-container {
            width: 100%; max-width: 460px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 36px 32px;
        }
        .form-title { font-size: 24px; font-weight: 700; text-align: center; color: #222; margin-bottom: 6px; }
        .form-subtitle { text-align: center; font-size: 14px; color: #666; margin-bottom: 24px; }
        .form-subtitle a { color: #2D7A4F; text-decoration: none; font-weight: 600; }
        .form-subtitle a:hover { text-decoration: underline; }

        /* Error box */
        .err-box {
            display: none; align-items: center; gap: 8px;
            background: #fff2f2; border: 1px solid #ffcccc; border-left: 4px solid #e74c3c;
            border-radius: 4px; padding: 10px 12px; margin-bottom: 18px;
            font-size: 13px; color: #c0392b;
        }
        .err-box.show { display: flex; }

        .field { margin-bottom: 16px; }
        .field-lbl {
            display: flex; justify-content: space-between;
            font-size: 13px; font-weight: 600; color: #333; margin-bottom: 5px;
        }
        .field-hint { font-size: 12px; color: #999; font-weight: 400; }
        .field-wrap { position: relative; }
        .field-ico {
            position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
            font-size: 15px; color: #999; pointer-events: none;
        }
        .field-inp {
            width: 100%; height: 44px;
            padding: 0 40px 0 40px;
            border: 1px solid #ccc; border-radius: 6px;
            background: #fafafa; color: #333; font-size: 14px;
            outline: none;
        }
        .field-inp:focus { border-color: #2D7A4F; }
        .toggle-eye {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            background: none; border: none; font-size: 18px; cursor: pointer; color: #888;
        }
        .field-error-msg {
            color: #e74c3c; font-size: 12px; margin-top: 4px; display: none;
        }
        .field-error-msg.show { display: block; }

        .terms-wrap {
            display: flex; align-items: flex-start; gap: 8px;
            border: 1px solid #ddd; border-radius: 6px; padding: 12px;
            margin: 8px 0 6px 0; background: #fafafa;
        }
        .terms-text { font-size: 13px; color: #555; line-height: 1.5; }
        .terms-text a { color: #2D7A4F; text-decoration: none; }
        .terms-error-msg {
            color: #e74c3c; font-size: 12px; margin-bottom: 14px; display: none;
        }
        .terms-error-msg.show { display: block; }

        .btn-reg {
            width: 100%; height: 46px;
            background: #2D7A4F; color: #fff;
            font-size: 15px; font-weight: 700;
            border: none; border-radius: 6px; cursor: pointer;
        }
        .btn-reg:hover { background: #24643f; }

        .form-bottom { text-align: center; font-size: 14px; color: #666; margin-top: 18px; }
        .form-bottom a { color: #2D7A4F; font-weight: 600; text-decoration: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <h1 class="form-title">Tạo tài khoản</h1>
            <p class="form-subtitle">
                Đã có tài khoản? <a href="DangNhap.aspx">Đăng nhập</a>
            </p>

            <!-- Error từ server -->
            <div class="err-box <%= lblError.Visible ? "show" : "" %>" id="errBox">
                <asp:Label ID="lblError" runat="server" Visible="false" />
            </div>

            <!-- Họ tên -->
            <div class="field">
                <div class="field-lbl">Họ và tên <span class="field-hint">*Bắt buộc</span></div>
                <div class="field-wrap">
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="field-inp" placeholder="Nguyễn Văn A" />
                </div>
                <div id="msgHoTen" class="field-error-msg">Vui lòng nhập họ và tên</div>
            </div>

            <!-- Email -->
            <div class="field">
                <div class="field-lbl">Email</div>
                <div class="field-wrap">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="email@example.com" />
                </div>
                <div id="msgEmail" class="field-error-msg">Email không hợp lệ</div>
            </div>

            <!-- SĐT -->
            <div class="field">
                <div class="field-lbl">Số điện thoại <span class="field-hint">10 chữ số</span></div>
                <div class="field-wrap">
                    <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="field-inp" placeholder="09xxxxxxxx" />
                </div>
                <div id="msgPhone" class="field-error-msg">Số điện thoại không hợp lệ</div>
            </div>

            <!-- Mật khẩu -->
            <div class="field">
                <div class="field-lbl">Mật khẩu</div>
                <div class="field-wrap">
                    <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="field-inp" placeholder="Tối thiểu 6 ký tự" />
                    <button type="button" class="toggle-eye" id="togglePass">👁️</button>
                </div>
                <div id="msgPass" class="field-error-msg">Mật khẩu phải có ít nhất 6 ký tự</div>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="field">
                <div class="field-lbl">Xác nhận mật khẩu</div>
                <div class="field-wrap">
                    <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="field-inp" placeholder="Nhập lại mật khẩu" />
                    <button type="button" class="toggle-eye" id="toggleConfirm">👁️</button>
                </div>
                <div id="msgConfirm" class="field-error-msg">Mật khẩu xác nhận không khớp</div>
            </div>

            <!-- Điều khoản -->
            <div class="terms-wrap">
                <asp:CheckBox ID="chkDongY" runat="server" />
                <span class="terms-text">
                    Tôi đã đọc và đồng ý với 
                    <a href="#">Điều khoản dịch vụ</a> và 
                    <a href="#">Chính sách bảo mật</a> của Thiện Nguyện Việt.
                </span>
            </div>
            <div id="msgTerms" class="terms-error-msg">Bạn phải đồng ý với Điều khoản dịch vụ và Chính sách bảo mật</div>

            <asp:Button ID="btnDangKy" runat="server" Text="Tạo tài khoản ngay" 
                        CssClass="btn-reg" OnClick="btnDangKy_Click"
                        OnClientClick="return validateRegister();" />

            <div class="form-bottom">
                Đã có tài khoản? <a href="DangNhap.aspx">Đăng nhập</a>
            </div>
        </div>
    </form>

    <script>
        // Toggle password visibility
        function togglePassword(btnId, inputId) {
            const btn = document.getElementById(btnId);
            const inp = document.getElementById(inputId);
            if (inp.type === "password") {
                inp.type = "text";
                btn.textContent = "🙈";
            } else {
                inp.type = "password";
                btn.textContent = "👁️";
            }
        }

        document.getElementById("togglePass").addEventListener("click", () => togglePassword("togglePass", "<%= txtMatKhau.ClientID %>"));
        document.getElementById("toggleConfirm").addEventListener("click", () => togglePassword("toggleConfirm", "<%= txtXacNhanMK.ClientID %>"));

        // Validate form
        function validateRegister() {
            const hoten = document.getElementById("<%= txtHoTen.ClientID %>").value.trim();
            const email = document.getElementById("<%= txtEmail.ClientID %>").value.trim();
            const phone = document.getElementById("<%= txtSoDienThoai.ClientID %>").value.trim();
            const pass  = document.getElementById("<%= txtMatKhau.ClientID %>").value;
            const confirm = document.getElementById("<%= txtXacNhanMK.ClientID %>").value;
            const agree = document.getElementById("<%= chkDongY.ClientID %>").checked;

            const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRx = /^(0[3-9])\d{8}$/;

            let isValid = true;

            // Reset errors
            document.querySelectorAll('.field-error-msg, .terms-error-msg').forEach(el => el.classList.remove('show'));

            if (hoten.length < 2) { document.getElementById('msgHoTen').classList.add('show'); isValid = false; }
            if (!emailRx.test(email)) { document.getElementById('msgEmail').classList.add('show'); isValid = false; }
            if (!phoneRx.test(phone)) { document.getElementById('msgPhone').classList.add('show'); isValid = false; }
            if (pass.length < 6) { document.getElementById('msgPass').classList.add('show'); isValid = false; }
            if (confirm !== pass || confirm === '') { document.getElementById('msgConfirm').classList.add('show'); isValid = false; }
            if (!agree) { document.getElementById('msgTerms').classList.add('show'); isValid = false; }

            return isValid;
        }
    </script>
</body>
</html>
