<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="ThienNguyenViet.DangKy" %>
<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Tạo tài khoản - Thiện Nguyện Việt</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            font-family: 'Be Vietnam Pro', system-ui, sans-serif;
            background: #0F2D1A;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-container {
            width: 100%;
            max-width: 460px;
            background: #1a1a1a;
            border-radius: 16px;
            padding: 40px 36px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            color: #fff;
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 8px;
        }

        .form-subtitle {
            text-align: center;
            font-size: 14px;
            color: #aaa;
            margin-bottom: 30px;
        }

            .form-subtitle a {
                color: #4CAF7E;
                text-decoration: none;
                font-weight: 600;
            }

                .form-subtitle a:hover {
                    text-decoration: underline;
                }

        /* Error box */
        .err-box {
            display: none;
            align-items: center;
            gap: 10px;
            background: #440000;
            border: 1px solid #ff4444;
            border-left: 4px solid #ff4444;
            border-radius: 8px;
            padding: 12px 14px;
            margin-bottom: 22px;
            font-size: 13.5px;
            color: #ffaaaa;
        }

            .err-box.show {
                display: flex;
            }

        /* Field */
        .field {
            margin-bottom: 18px;
        }

        .field-lbl {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 13.5px;
            font-weight: 600;
            color: #ddd;
            margin-bottom: 6px;
        }

        .field-hint {
            font-size: 12px;
            color: #888;
            font-weight: 400;
        }

        .field-wrap {
            position: relative;
        }

        .field-ico {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            opacity: 0.6;
            pointer-events: none;
        }

        .field-inp {
            width: 100%;
            height: 48px;
            padding: 0 14px 0 46px;
            border: 1.5px solid #333;
            border-radius: 8px;
            background: #252525;
            color: #fff;
            font-size: 15px;
            outline: none;
            transition: all 0.2s;
        }

            .field-inp:focus {
                border-color: #4CAF7E;
                box-shadow: 0 0 0 3px rgba(76, 175, 126, 0.15);
            }

            .field-inp::placeholder {
                color: #777;
            }

        .toggle-eye {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #aaa;
            font-size: 18px;
            cursor: pointer;
        }

        /* Terms */
        .terms-wrap {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: #1f2a24;
            border: 1px solid #2e3f34;
            border-radius: 8px;
            padding: 14px;
            margin: 10px 0 22px 0;
        }

        .terms-text {
            font-size: 13.5px;
            color: #ccc;
            line-height: 1.5;
        }

            .terms-text a {
                color: #4CAF7E;
                text-decoration: none;
            }

                .terms-text a:hover {
                    text-decoration: underline;
                }

        /* Button */
        .btn-reg {
            width: 100%;
            height: 50px;
            background: linear-gradient(135deg, #2D7A4F, #4CAF7E);
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(45, 122, 79, 0.3);
            transition: all 0.2s;
        }

            .btn-reg:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(45, 122, 79, 0.4);
            }

        .form-bottom {
            text-align: center;
            font-size: 14px;
            color: #888;
            margin-top: 20px;
        }

            .form-bottom a {
                color: #4CAF7E;
                font-weight: 600;
                text-decoration: none;
            }

                .form-bottom a:hover {
                    text-decoration: underline;
                }

        .field-error-msg {
            color: #ff7777;
            font-size: 12.5px;
            margin-top: 4px;
            display: none;
        }

            .field-error-msg.show {
                display: block;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <h1 class="form-title">Tạo tài khoản</h1>
            <p class="form-subtitle">
                Đã có tài khoản? 
                <a href="DangNhap.aspx">Đăng nhập tại đây →</a>
            </p>

            <div class="err-box <%= lblError.Visible ? "show" : "" %>" id="errBox">
                <span>⚠️</span>
                <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
            </div>

            <!-- Họ và tên -->
            <div class="field">
                <div class="field-lbl">
                    Họ và tên <span class="field-hint">*Bắt buộc</span>
                </div>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="field-inp" placeholder="Nguyen Van A" />
                </div>
                <span id="msgHoTen" class="field-error-msg">Vui lòng nhập họ và tên</span>
            </div>

            <!-- Email -->
            <div class="field">
                <div class="field-lbl">Email</div>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="@example.com" />
                </div>
                <span id="msgEmail" class="field-error-msg">Email không hợp lệ</span>
            </div>

            <!-- Số điện thoại -->
            <div class="field">
                <div class="field-lbl">
                    Số điện thoại <span class="field-hint">10 chữ số</span>
                </div>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="field-inp" placeholder="09xxxxxxxx" />
                </div>
                <span id="msgPhone" class="field-error-msg">Số điện thoại không hợp lệ</span>
            </div>

            <!-- Mật khẩu -->
            <div class="field">
                <div class="field-lbl">Mật khẩu</div>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="field-inp"
                        placeholder="Tối thiểu 6 ký tự" />
                    <button type="button" class="toggle-eye" id="togglePass"></button>
                </div>
                <span id="msgPass" class="field-error-msg">Mật khẩu phải có ít nhất 6 ký tự!</span>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="field">
                <div class="field-lbl">Xác nhận mật khẩu</div>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="field-inp"
                        placeholder="Nhập lại mật khẩu" />
                    <button type="button" class="toggle-eye" id="toggleConfirm"></button>
                </div>
                <span id="msgConfirm" class="field-error-msg">Mật khẩu xác nhận không khớp!</span>
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

            <asp:Button ID="btnDangKy" runat="server"
                Text="Tạo tài khoản ngay"
                CssClass="btn-reg"
                OnClick="btnDangKy_Click"
                OnClientClick="return validateRegister();" />

            <div class="form-bottom">
                Đã có tài khoản? 
                <a href="DangNhap.aspx">Đăng nhập</a>
            </div>
        </div>
    </form>

    <script>
        // Toggle password visibility
        document.getElementById('togglePass').addEventListener('click', function () {
            var inp = document.getElementById('<%= txtMatKhau.ClientID %>');
            var show = inp.type === 'password';
            inp.type = show ? 'text' : 'password';
            this.textContent = show ? '🙈' : '👁️';
        });

        document.getElementById('toggleConfirm').addEventListener('click', function () {
            var inp = document.getElementById('<%= txtXacNhanMK.ClientID %>');
            var show = inp.type === 'password';
            inp.type = show ? 'text' : 'password';
            this.textContent = show ? '🙈' : '👁️';
        });

        // Validation
        function validateRegister() {
            var hoten = document.getElementById('<%= txtHoTen.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var phone = document.getElementById('<%= txtSoDienThoai.ClientID %>').value.trim();
            var pass = document.getElementById('<%= txtMatKhau.ClientID %>').value;
            var confirm = document.getElementById('<%= txtXacNhanMK.ClientID %>').value;
            var agree = document.getElementById('<%= chkDongY.ClientID %>').checked;

            var emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            var phoneRx = /^(0[3-9])\d{8}$/;

            var isValid = true;

            // Reset lỗi
            document.querySelectorAll('.field-error-msg').forEach(el => el.classList.remove('show'));

            if (hoten.length < 2) {
                document.getElementById('msgHoTen').classList.add('show');
                isValid = false;
            }
            if (!emailRx.test(email)) {
                document.getElementById('msgEmail').classList.add('show');
                isValid = false;
            }
            if (!phoneRx.test(phone)) {
                document.getElementById('msgPhone').classList.add('show');
                isValid = false;
            }
            if (pass.length < 6) {
                document.getElementById('msgPass').classList.add('show');
                isValid = false;
            }
            if (confirm !== pass || confirm === '') {
                document.getElementById('msgConfirm').classList.add('show');
                isValid = false;
            }
            if (!agree) {
                alert("Bạn phải đồng ý với điều khoản dịch vụ và chính sách bảo mật!");
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>