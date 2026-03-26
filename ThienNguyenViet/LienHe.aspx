<%@ Page Title="Liên hệ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="ThienNguyenViet.LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    .container {
        width: 1200px;
        margin: auto;
    }

    .row {
        display: flex;
        gap: 30px;
    }

    .col-left {
        flex: 2;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
    }

    .col-right {
        flex: 1;
        background: #f9f9f9;
        padding: 20px;
        border-radius: 10px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        font-weight: bold;
    }

    .form-control {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 6px;
    }

    .btn-submit {
        background: #e53935;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }

    iframe {
        width: 100%;
        height: 200px;
        border: 0;
        margin-top: 10px;
    }
</style>

<div class="container">
    <h2>Liên hệ với chúng tôi</h2>

    <div class="row">

        <!-- LEFT: FORM -->
        <div class="col-left">

            <div class="form-group">
                <label>Họ tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtHoTen" ErrorMessage="* Bắt buộc" ForeColor="Red" runat="server" />
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtEmail" ErrorMessage="* Bắt buộc" ForeColor="Red" runat="server" />
                <asp:RegularExpressionValidator 
                    ControlToValidate="txtEmail"
                    ValidationExpression="\w+@\w+\.\w+"
                    ErrorMessage="Email không hợp lệ"
                    ForeColor="Red"
                    runat="server" />
            </div>

            <div class="form-group">
                <label>Chủ đề</label>
                <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Chọn chủ đề --" Value=""></asp:ListItem>
                    <asp:ListItem Text="Hỗ trợ quyên góp" />
                    <asp:ListItem Text="Hợp tác" />
                    <asp:ListItem Text="Phản hồi" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Nội dung</label>
                <asp:TextBox ID="txtNoiDung" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtNoiDung" ErrorMessage="* Bắt buộc" ForeColor="Red" runat="server" />
            </div>

            <asp:Button ID="btnGui" runat="server" Text="Gửi liên hệ" CssClass="btn-submit" OnClick="btnGui_Click" />

            <br /><br />
            <asp:Label ID="lblThongBao" runat="server" ForeColor="Green"></asp:Label>

        </div>

        <!-- RIGHT: INFO -->
        <div class="col-right">

            <h3>Thông tin liên hệ</h3>

            <p><b>Địa chỉ:</b> Hà Nội, Việt Nam</p>
            <p><b>Hotline:</b> 0123 456 789</p>
            <p><b>Email:</b> contact@thiennguyenviet.vn</p>

            <h4>Bản đồ</h4>
            <iframe src="https://maps.google.com/maps?q=ha%20noi&t=&z=13&ie=UTF8&iwloc=&output=embed"></iframe>

            <h4>Giờ làm việc</h4>
            <p>Thứ 2 - Thứ 6: 8h - 17h</p>
            <p>Thứ 7: 8h - 12h</p>

        </div>

    </div>
</div>

</asp:Content>