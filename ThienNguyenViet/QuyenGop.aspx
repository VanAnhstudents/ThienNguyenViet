<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuyenGop.aspx.cs" Inherits="ThienNguyenViet.QuyenGop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
        /* Giữ nguyên phần CSS của bạn */
        .qg-page { background-color: #fcfdfc; padding-bottom: 80px; }
        .breadcrumb-bar { background: #F6FBF7; border-bottom: 1px solid var(--vien); padding: 12px 0; }
        .breadcrumb-inner { max-width: 1100px; margin: 0 auto; padding: 0 24px; display: flex; align-items: center; gap: 6px; font-size: 13px; color: var(--chu-phu); }
        .breadcrumb-inner a { color: var(--chu-phu); text-decoration: none; }
        .breadcrumb-inner strong { color: var(--mau-chinh); }
        .qg-container { max-width: 1100px; margin: 40px auto; padding: 0 24px; display: grid; grid-template-columns: 1fr 380px; gap: 32px; font-family: 'Be Vietnam Pro', sans-serif; }
        .qg-main { display: flex; flex-direction: column; gap: 24px; }
        .qg-card { background: #fff; border: 1px solid var(--vien); border-radius: 16px; padding: 32px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); }
        .step-header { display: flex; align-items: center; margin-bottom: 24px; gap: 15px; }
        .step-number { width: 32px; height: 32px; background: var(--mau-chinh); color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; flex-shrink: 0; }
        .step-title { font-size: 20px; font-weight: 700; color: var(--chu-chinh); margin: 0; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--chu-chinh); }
        .input-wrapper { position: relative; }
        .currency-suffix { position: absolute; right: 16px; top: 50%; transform: translateY(-50%); font-weight: 600; color: var(--chu-phu); }
        .form-control { width: 100%; padding: 14px 16px; border: 1px solid var(--vien); border-radius: 10px; font-family: inherit; font-size: 16px; transition: all 0.2s; }
        .form-control:focus { outline: none; border-color: var(--mau-chinh); box-shadow: 0 0 0 3px var(--mau-chinh-nen); }
        .amount-suggestions { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-top: 12px; }
        .btn-suggest { background: var(--mau-chinh-nen); border: 1px solid var(--mau-chinh-nhat); color: var(--mau-chinh); padding: 10px; border-radius: 8px; cursor: pointer; font-weight: 600; transition: all 0.2s; text-align: center; }
        .btn-suggest:hover { background: var(--mau-chinh); color: #fff; }
        .bank-info-table { background: var(--mau-chinh-nen); border: 1px solid var(--mau-chinh-nhat); border-radius: 12px; padding: 20px; }
        .bank-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--vien); font-size: 14px; }
        .bank-row:last-child { border-bottom: none; padding-bottom: 0; }
        .bank-row span { color: var(--chu-phu); }
        .bank-row strong { color: var(--chu-chinh); }
        .bank-row.highlight strong { color: var(--mau-cam); font-size: 15px; }
        .qg-sidebar { position: sticky; top: 90px; }
        .campaign-summary { background: #fff; border: 1px solid var(--vien); border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.03); }
        .summary-img { width: 100%; aspect-ratio: 16/9; object-fit: cover; }
        .summary-content { padding: 20px; }
        .summary-title { font-family: 'Playfair Display', serif; font-size: 18px; font-weight: 700; margin-bottom: 12px; line-height: 1.4; }
        .progress-bar-wrap { background: #fff; height: 10px; border-radius: 6px; margin: 15px 0 8px; overflow: hidden; border: 1px solid #000; }
        .progress-bar-fill { background: #2D7A4F; height: 100%; border-radius: 5px; }
        .summary-stats { display: flex; justify-content: space-between; font-size: 13px; color: var(--chu-phu); }
        .summary-stats strong { color: var(--mau-chinh); }
        .stat-row { display: flex; align-items: center; gap: 8px; margin-bottom: 10px; font-size: 14px; color: var(--chu-than); }
        .stat-dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }
        .upload-area { border: 2px dashed var(--vien); padding: 20px; border-radius: 10px; text-align: center; cursor: pointer; transition: background 0.2s; }
        .upload-area:hover { background: var(--mau-chinh-nen); border-color: var(--mau-chinh-nhat); }
        .btn-submit { width: 100%; padding: 16px; background: var(--mau-cam); color: #fff; border: none; border-radius: 10px; font-size: 16px; font-weight: 700; cursor: pointer; transition: all 0.2s; margin-top: 10px; }
        .btn-submit:hover { background: #a05418; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(192,101,26,0.3); }
        .note-text { text-align: center; font-size: 13px; color: var(--chu-phu); margin-top: 15px; }
        @media (max-width: 992px) { .qg-container { grid-template-columns: 1fr; } .qg-sidebar { order: -1; position: static; } .amount-suggestions { grid-template-columns: repeat(2, 1fr); } }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="qg-page">
        <div class="breadcrumb-bar">
            <div class="breadcrumb-inner">
                <a href="Default.aspx">Trang chủ</a> <span>/</span> 
                <a href="#">Chiến dịch</a> <span>/</span> 
                <strong>Quyên góp</strong>
            </div>
        </div>

        <div class="qg-container">
            <div class="qg-main">
                <div class="card-custom">
                    <h1 style="font-family:'Playfair Display'; font-size:32px; color:var(--chu-chinh); margin:0;">
                        Ủng hộ chiến dịch: <asp:Literal ID="litTenCDMain" runat="server" />
                    </h1>
                    <p style="color:var(--chu-phu); margin-top:8px;">Vui lòng thực hiện chuyển khoản theo thông tin bên dưới</p>

                    <div class="bank-info-table">
                        <div class="bank-row"><span>Ngân hàng</span> <strong><asp:Literal ID="litBank" runat="server" /></strong></div>
                        <div class="bank-row"><span>Số tài khoản</span> <strong style="color:var(--mau-chinh); font-size:18px;"><asp:Literal ID="litSTK" runat="server" /></strong></div>
                        <div class="bank-row"><span>Chủ tài khoản</span> <strong><asp:Literal ID="litAccHolder" runat="server" /></strong></div>
                        <div class="bank-row"><span>Nội dung CK</span> <strong style="color:var(--mau-cam);"><asp:Literal ID="litNoiDung" runat="server" /></strong></div>
                    </div>
                </div>

                <div class="card-custom">
                    <h3 style="margin-bottom:20px;">Gửi thông tin xác nhận</h3>
                    <div style="margin-bottom:15px;">
                        <label style="display:block; margin-bottom:8px;">Số tiền muốn ủng hộ (VNĐ)</label>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" placeholder="Ví dụ: 100,000" style="width:100%; padding:12px; border:1px solid var(--vien); border-radius:6px;"></asp:TextBox>
                        <div style="display:flex; gap:10px; margin-top:10px;">
                            <button type="button" onclick="setAmount('50000')" class="btn" style="border:1px solid var(--vien); font-size:12px; padding:5px 10px;">50.000đ</button>
                            <button type="button" onclick="setAmount('100000')" class="btn" style="border:1px solid var(--vien); font-size:12px; padding:5px 10px;">100.000đ</button>
                            <button type="button" onclick="setAmount('500000')" class="btn" style="border:1px solid var(--vien); font-size:12px; padding:5px 10px;">500.000đ</button>
                        </div>
                    </div>
                    <div style="margin-bottom:15px;">
                        <label style="display:block; margin-bottom:8px;">Lời nhắn nhủ (nếu có)</label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="3" style="width:100%; border:1px solid var(--vien); border-radius:6px; padding:10px;"></asp:TextBox>
                    </div>
                    <div style="margin-bottom:20px;">
                        <asp:CheckBox ID="chkAnDanh" runat="server" Text=" &nbsp;Quyên góp ẩn danh" />
                    </div>
                    <asp:Button ID="btnConfirm" runat="server" Text="Xác nhận đã chuyển khoản" CssClass="btn-confirm" OnClick="btnConfirm_Click" />
                </div>
            </div>

            <div class="qg-sidebar">
                <div class="card-custom">
                    <asp:Image ID="imgCD" runat="server" CssClass="summary-img" />
                    <div class="summary-content">
                        <h4 style="margin:0 0 10px 0; font-size:18px; line-height:1.4;"><asp:Literal ID="litTenCDSidebar" runat="server" /></h4>
                        <div class="progress-bar-wrap">
                            <div id="divProgress" runat="server" class="progress-bar-fill"></div>
                        </div>
                        <div style="display:flex; justify-content:space-between; font-size:14px; color:var(--chu-phu);">
                            <span><asp:Literal ID="litPercent" runat="server" />% mục tiêu</span>
                            <span>Mục tiêu: <strong><asp:Literal ID="litGoal" runat="server" />đ</strong></span>
                        </div>

                        <div style="margin-top:20px; padding-top:20px; border-top:1px solid var(--vien);">
                            <div class="stat-row">
                                <span class="stat-dot" style="background:var(--mau-chinh);"></span>
                                <strong><asp:Literal ID="litCount" runat="server" /></strong>&nbsp;lượt quyên góp
                            </div>
                            <div class="stat-row">
                                <span class="stat-dot" style="background:var(--mau-cam);"></span>
                                Còn <strong><asp:Literal ID="litDays" runat="server" /></strong>&nbsp;ngày
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setAmount(val) { document.getElementById('<%= txtAmount.ClientID %>').value = val; }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
            return true;
        }
    </script>
</asp:Content>
