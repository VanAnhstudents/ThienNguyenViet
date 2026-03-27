<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="ThienNguyenViet.LienHe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .section {
            padding: 60px 0;
        }

        .container {
            width: 1100px;
            margin: 0 auto;
        }

        .lienhe-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 40px;
        }

        .form-box {
            background: #fff;
            padding: 24px;
            border-radius: var(--r-md);
            border: 1px solid var(--vien);
        }

        .info-box {
            background: var(--mau-chinh-nen);
            padding: 24px;
            border-radius: var(--r-md);
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: var(--r-sm);
            border: 1px solid var(--vien);
        }

        textarea {
            height: 120px;
            resize: none;
        }

        .error {
            color: var(--mau-loi);
            font-size: 13px;
        }

        iframe {
            width: 100%;
            border-radius: var(--r-sm);
            margin-top: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section">
        <div class="container">
            <h1>Liên hệ với chúng tôi</h1>
            <p>Hãy gửi thông tin, chúng tôi sẽ phản hồi sớm nhất</p>
        </div>
    </section>

    <!-- ===== MAIN ===== -->
    <section class="section">
    <div class="container">

        <div class="lienhe-grid">

            <!-- ===== LEFT: FORM ===== -->
            <div class="form-box">
                <h2>Gửi liên hệ</h2>

                <!-- Validation Summary -->
                <asp:ValidationSummary 
                    runat="server" 
                    CssClass="error" 
                    HeaderText="Vui lòng kiểm tra lại thông tin:" />

                <!-- Họ tên -->
                <div class="form-group">
                    <label for="txtHoTen">Họ tên</label>
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="input" />

                    <asp:RequiredFieldValidator 
                        ControlToValidate="txtHoTen"
                        ErrorMessage="* Nhập họ tên"
                        CssClass="error"
                        Display="Dynamic"
                        runat="server" />
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input" />

                    <asp:RequiredFieldValidator 
                        ControlToValidate="txtEmail"
                        ErrorMessage="* Nhập email"
                        CssClass="error"
                        Display="Dynamic"
                        runat="server" />

                    <asp:RegularExpressionValidator
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="* Email không hợp lệ"
                        CssClass="error"
                        Display="Dynamic"
                        runat="server" />
                </div>

                <!-- Chủ đề -->
                <div class="form-group">
                    <label for="ddlChuDe">Chủ đề</label>
                    <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="input">
                        <asp:ListItem Text="-- Chọn chủ đề --" Value="" />
                        <asp:ListItem Text="Hỗ trợ" Value="HoTro" />
                        <asp:ListItem Text="Hợp tác" Value="HopTac" />
                        <asp:ListItem Text="Góp ý" Value="GopY" />
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ControlToValidate="ddlChuDe"
                        InitialValue=""
                        ErrorMessage="* Chọn chủ đề"
                        CssClass="error"
                        Display="Dynamic"
                        runat="server" />
                </div>

                <!-- Nội dung -->
                <div class="form-group">
                    <label for="txtNoiDung">Nội dung</label>
                    <asp:TextBox ID="txtNoiDung" runat="server" 
                                 TextMode="MultiLine" CssClass="input" Rows="4" />

                    <asp:RequiredFieldValidator 
                        ControlToValidate="txtNoiDung"
                        ErrorMessage="* Nhập nội dung"
                        CssClass="error"
                        Display="Dynamic"
                        runat="server" />
                </div>

                <!-- Button -->
                <asp:Button 
                    ID="btnGui" 
                    runat="server" 
                    Text="Gửi liên hệ" 
                    CssClass="btn-chinh"
                    OnClick="BtnGui_Click" />

            </div>

            <!-- ===== RIGHT: INFO ===== -->
            <div class="info-box">
                <h2>Thông tin liên hệ</h2>

                <p><strong>📍 Địa chỉ:</strong> Hà Nội, Việt Nam</p>
                <p><strong>📞 Hotline:</strong> 0123 456 789</p>
                <p><strong>📧 Email:</strong> support@thiennguyenviet.vn</p>
                <p><strong>🕘 Giờ làm việc:</strong> 08:00 - 17:30 (T2 - T6)</p>

                <iframe 
                    src="https://www.google.com/maps?q=Hà Nội&output=embed"
                    height="220"
                    loading="lazy">
                </iframe>
            </div>

        </div>

    </div>
</section>

</asp:Content>
