<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="ThienNguyenViet.DangKy" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thiện Nguyện Việt - Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background: linear-gradient(135deg, #f8fff8, #e8f5e9); font-family: 'Segoe UI', sans-serif; }
        .register-card { max-width: 500px; margin: 60px auto; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .card-header { background: #4CAF50; color: white; padding: 25px; text-align: center; border-radius: 16px 16px 0 0; }
        .logo { font-size: 28px; font-weight: 700; }
        .btn-success { background: #4CAF50; border: none; padding: 12px; font-weight: 600; }
        .form-control:focus { border-color: #4CAF50; box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25); }
        .error-text { color: #d32f2f; font-size: 14px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="card register-card">
                <div class="card-header">
                    <div class="logo">🌱 Thiện Nguyện Việt</div>
                    <p class="mb-0">Tạo tài khoản mới</p>
                </div>

                <div class="card-body p-4">
                    <asp:Label ID="lblError" runat="server" CssClass="error-text d-block mb-3 text-center" Visible="false"></asp:Label>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" placeholder="" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="form-control" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu</label>
                        <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="form-control" />
                    </div>

                    <div class="mb-4 form-check">
                        <asp:CheckBox ID="chkDongY" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Tôi đồng ý với <a href="#" class="green-text">Điều khoản & Chính sách bảo mật</a></label>
                    </div>

                    <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" 
                        CssClass="btn btn-success w-100" OnClick="btnDangKy_Click" 
                        OnClientClick="return validateRegister();" />

                    <div class="text-center mt-3">
                        Đã có tài khoản? 
                        <a href="DangNhap.aspx" class="green-text text-decoration-none">Đăng nhập ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function validateRegister() {
            const hoten = document.getElementById('<%= txtHoTen.ClientID %>').value.trim();
            const email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            const phone = document.getElementById('<%= txtSoDienThoai.ClientID %>').value.trim();
            const pass = document.getElementById('<%= txtMatKhau.ClientID %>').value;
            const confirm = document.getElementById('<%= txtXacNhanMK.ClientID %>').value;
            const agree = document.getElementById('<%= chkDongY.ClientID %>').checked;
            const error = document.getElementById('<%= lblError.ClientID %>');

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (hoten === "") { error.textContent = "Vui lòng nhập họ tên!"; error.style.display = "block"; return false; }
            if (email === "" || !emailRegex.test(email)) { error.textContent = "Email không hợp lệ!"; error.style.display = "block"; return false; }
            if (phone === "" || phone.length < 10) { error.textContent = "Số điện thoại không hợp lệ!"; error.style.display = "block"; return false; }
            if (pass.length < 6) { error.textContent = "Mật khẩu phải có ít nhất 6 ký tự!"; error.style.display = "block"; return false; }
            if (pass !== confirm) { error.textContent = "Xác nhận mật khẩu không khớp!"; error.style.display = "block"; return false; }
            if (!agree) { error.textContent = "Bạn phải đồng ý với điều khoản!"; error.style.display = "block"; return false; }

            error.style.display = "none";
            return true;
        }
    </script>
</body>
</html>
