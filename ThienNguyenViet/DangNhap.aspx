<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ThienNguyenViet.DangNhap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thiện Nguyện Việt - Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #f8fff8, #e8f5e9);
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            max-width: 420px;
            margin: 80px auto;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .card-header {
            background: #4CAF50;
            color: white;
            text-align: center;
            padding: 25px;
            border-radius: 16px 16px 0 0;
        }
        .logo {
            font-size: 28px;
            font-weight: 700;
        }
        .btn-success {
            background: #4CAF50;
            border: none;
            padding: 12px;
            font-weight: 600;
        }
        .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
        }
        .error-text { color: #d32f2f; font-size: 14px; }
        .green-text { color: #4CAF50; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="card login-card">
                <!-- Header -->
                <div class="card-header">
                    <div class="logo">🌱 Thiện Nguyện Việt</div>
                    <p class="mb-0">Cùng nhau lan tỏa yêu thương</p>
                </div>

                <div class="card-body p-4">
                    <asp:Label ID="lblError" runat="server" CssClass="error-text d-block mb-3 text-center" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="@gmail.com" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                    </div>

                    <div class="mb-3 form-check">
                        <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Nhớ tôi</label>
                    </div>

                    <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" 
                        CssClass="btn btn-success w-100" OnClick="btnDangNhap_Click" 
                        OnClientClick="return validateLogin();" />

                    <div class="text-center mt-4">
                        <asp:HyperLink ID="lnkQuenMK" runat="server" NavigateUrl="#" CssClass="green-text text-decoration-none">Quên mật khẩu?</asp:HyperLink>
                        <span class="mx-2">•</span>
                        <asp:HyperLink ID="lnkDangKy" runat="server" NavigateUrl="DangKy.aspx" CssClass="green-text text-decoration-none">Đăng ký tài khoản</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function validateLogin() {
            const email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            const pass = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            const error = document.getElementById('<%= lblError.ClientID %>');

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (email === "") {
                error.textContent = "Vui lòng nhập email!";
                error.style.display = "block";
                return false;
            }
            if (!emailRegex.test(email)) {
                error.textContent = "Email không hợp lệ!";
                error.style.display = "block";
                return false;
            }
            if (pass === "") {
                error.textContent = "Vui lòng nhập mật khẩu!";
                error.style.display = "block";
                return false;
            }
            error.style.display = "none";
            return true;
        }
    </script>
</body>
</html>
