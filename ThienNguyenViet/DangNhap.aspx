<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ThienNguyenViet.DangNhap" %>
<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đăng nhập - Thiện Nguyện Việt</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* (giữ nguyên style như file cũ - đã rút gọn cho ngắn gọn) */
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        html,body{font-family:'Be Vietnam Pro',sans-serif;background:#f0f2f5;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px;}
        .login-container{width:100%;max-width:420px;background:#fff;border:1px solid #ddd;border-radius:8px;padding:36px 32px;}
        .btn-home{display:inline-block;font-size:14px;font-weight:500;color:#2D7A4F;text-decoration:none;margin-bottom:20px;}
        .form-title{font-size:24px;font-weight:700;text-align:center;color:#222;margin-bottom:6px;}
        .form-subtitle{text-align:center;font-size:14px;color:#666;margin-bottom:24px;}
        .form-subtitle a{color:#2D7A4F;text-decoration:none;font-weight:600;}
        .msg-box{display:none;align-items:center;gap:8px;border-radius:4px;padding:10px 12px;margin-bottom:18px;font-size:13px;}
        .msg-box.show{display:flex;}
        .msg-box.error{background:#fff2f2;border:1px solid #ffcccc;border-left:4px solid #e74c3c;color:#c0392b;}
        .msg-box.success{background:#f0faf4;border:1px solid #b2dfdb;border-left:4px solid #2D7A4F;color:#2D7A4F;}
        .field{margin-bottom:16px;}
        .field-lbl{display:block;font-size:13px;font-weight:600;color:#333;margin-bottom:5px;}
        .field-wrap{position:relative;}
        .field-inp{width:100%;height:44px;padding:0 40px 0 40px;border:1px solid #ccc;border-radius:6px;background:#fafafa;color:#333;font-size:14px;outline:none;}
        .field-inp:focus{border-color:#2D7A4F;}
        .toggle-eye{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;font-size:18px;cursor:pointer;color:#888;}
        .field-error-msg{color:#e74c3c;font-size:12px;margin-top:4px;}
        .opts-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;font-size:13px;}
        .btn-login{width:100%;height:46px;background:#2D7A4F;color:#fff;font-size:15px;font-weight:700;border:none;border-radius:6px;cursor:pointer;}
        .btn-login:hover{background:#24643f;}
        .form-bottom{text-align:center;font-size:14px;color:#666;margin-top:18px;}
        .form-bottom a{color:#2D7A4F;font-weight:600;text-decoration:none;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <a href="TrangChu.aspx" class="btn-home">← Trang chủ</a>
            <h1 class="form-title">Đăng nhập</h1>
            <p class="form-subtitle">Chưa có tài khoản? <a href="DangKy.aspx">Tạo tài khoản miễn phí</a></p>

            <asp:Panel ID="pnlMsg" runat="server" Visible="false">
                <div class="msg-box show" id="msgBox" runat="server">
                    <asp:Label ID="lblError" runat="server" />
                </div>
            </asp:Panel>

            <div class="field">
                <label class="field-lbl">Email</label>
                <div class="field-wrap">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="email@example.com" />
                </div>
                <div id="errEmail" class="field-error-msg"></div>
            </div>

            <div class="field">
                <label class="field-lbl">Mật khẩu</label>
                <div class="field-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="field-inp" placeholder="Nhập mật khẩu" />
                    <button type="button" class="toggle-eye" id="toggleEye">👁️</button>
                </div>
                <div id="errPass" class="field-error-msg"></div>
            </div>

            <div class="opts-row">
                <label class="check-wrap">
                    <asp:CheckBox ID="chkRemember" runat="server" /> Nhớ tôi
                </label>
                <asp:HyperLink ID="lnkQuenMK" runat="server" NavigateUrl="#" CssClass="link-forgot">Quên mật khẩu?</asp:HyperLink>
            </div>

            <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" 
                        CssClass="btn-login" OnClick="btnDangNhap_Click"
                        OnClientClick="return validateLogin();" />

            <div class="form-bottom">
                Chưa có tài khoản? <a href="DangKy.aspx">Tạo tài khoản miễn phí</a>
            </div>
        </div>
    </form>

    <script>
        // Toggle password
        document.getElementById("toggleEye").addEventListener("click", function () {
            const inp = document.getElementById("<%= txtPassword.ClientID %>");
            if (inp.type === "password") {
                inp.type = "text";
                this.textContent = "🙈";
            } else {
                inp.type = "password";
                this.textContent = "👁️";
            }
        });

        function validateLogin() {
            const email = document.getElementById("<%= txtEmail.ClientID %>").value.trim();
            const pass  = document.getElementById("<%= txtPassword.ClientID %>").value;
            const errEmail = document.getElementById("errEmail");
            const errPass = document.getElementById("errPass");

            errEmail.textContent = ''; errPass.textContent = '';
            let valid = true;

            if (!email) { errEmail.textContent = 'Vui lòng nhập Email'; valid = false; }
            if (!pass) { errPass.textContent = 'Vui lòng nhập Mật khẩu'; valid = false; }

            return valid;
        }
    </script>
</body>
</html>
