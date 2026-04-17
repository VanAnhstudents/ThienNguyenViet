<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ThienNguyenViet.DangNhap" %>
<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đăng nhập - Thiện Nguyện Việt</title>
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

        .login-container {
            width: 100%;
            max-width: 420px;
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
            margin-bottom: 32px;
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
            margin-bottom: 20px;
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
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            color: #ddd;
            margin-bottom: 6px;
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

        /* Options */
        .opts-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            font-size: 13.5px;
        }

        .check-wrap {
            display: flex;
            align-items: center;
            gap: 7px;
            color: #ccc;
            cursor: pointer;
        }

        .link-forgot {
            color: #4CAF7E;
            text-decoration: none;
            font-weight: 500;
        }

            .link-forgot:hover {
                text-decoration: underline;
            }

        /* Button */
        .btn-login {
            width: 100%;
            height: 50px;
            background: linear-gradient(135deg, #2D7A4F, #4CAF7E);
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(45, 122, 79, 0.3);
            transition: all 0.2s;
        }

            .btn-login:hover {
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h1 class="form-title">Đăng nhập</h1>
            <p class="form-subtitle">
                Chưa có tài khoản? 
                <a href="DangKy.aspx">Đăng ký ngay →</a>
            </p>

            <div class="err-box <%= lblError.Visible ? "show" : "" %>" id="errBox">
                <span></span>
                <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
            </div>

            <div class="field">
                <label class="field-lbl">Email / Tên đăng nhập</label>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="Admin hoặc user" />
                </div>
                <span id="errEmail" style="color: #ff7777; font-size: 13px;"></span>
            </div>

            <div class="field">
                <label class="field-lbl">Mật khẩu</label>
                <div class="field-wrap">
                    <span class="field-ico"></span>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="field-inp" placeholder="Nhập mật khẩu..." />
                    <button type="button" class="toggle-eye" id="toggleEye"></button>
                </div>
                <span id="errPass" style="color: #ff7777; font-size: 13px;"></span>
            </div>

            <div class="opts-row">
                <label class="check-wrap">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    Nhớ tôi
                </label>
                <asp:HyperLink ID="lnkQuenMK" runat="server" NavigateUrl="#" CssClass="link-forgot">
                    Quên mật khẩu?
                </asp:HyperLink>
            </div>

            <asp:Button ID="btnDangNhap" runat="server"
                Text="Đăng nhập"
                CssClass="btn-login"
                OnClick="btnDangNhap_Click"
                OnClientClick="return validateLogin();" />

            <div class="form-bottom">
                Chưa có tài khoản? 
                <a href="DangKy.aspx">Tạo tài khoản miễn phí</a>
            </div>
        </div>
    </form>

    <script>
        // Toggle password visibility
        document.getElementById('toggleEye').addEventListener('click', function () {
            var inp = document.getElementById('<%= txtPassword.ClientID %>');
            var show = inp.type === 'password';
            inp.type = show ? 'text' : 'password';
            this.textContent = show ? '🙈' : '👁️';
        });

        // Validation
        function validateLogin() {
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var pass = document.getElementById('<%= txtPassword.ClientID %>').value;
            var errEmail = document.getElementById('errEmail');
            var errPass = document.getElementById('errPass');

            errEmail.textContent = "";
            errPass.textContent = "";

            var isValid = true;

            if (!email) {
                errEmail.textContent = "Vui lòng không để trống Email / Tên đăng nhập";
                isValid = false;
            }
            if (!pass) {
                errPass.textContent = "Vui lòng không để trống Mật khẩu";
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>