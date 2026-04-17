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
        .progress-bar-wrap { background: #edf2f7; height: 8px; border-radius: 99px; margin: 15px 0 8px; overflow: hidden; }
        .progress-bar-fill { background: linear-gradient(90deg, var(--mau-chinh), var(--mau-chinh-hover)); height: 100%; border-radius: 99px; }
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
                <a href="TrangChu.aspx">Trang chủ</a>
                <span>/</span>
                <a href="DanhSachChienDich.aspx">Chiến dịch</a>
                <span>/</span>
                <strong>Quyên góp ủng hộ</strong>
            </div>
        </div>

        <div class="qg-container">

            <div class="qg-main">
                <h1 style="font-family:'Playfair Display'; font-size:32px; color:var(--chu-chinh); margin:0;">
                    Ủng hộ chiến dịch
                </h1>
                <p style="color:var(--chu-phu); margin-top:-10px; margin-bottom:10px;">
                    Sự đóng góp của bạn là nguồn động lực to lớn cho cộng đồng.
                </p>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">1</div>
                        <h3 class="step-title">Thông tin quyên góp</h3>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Số tiền ủng hộ</label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control"
                                placeholder="Nhập số tiền muốn ủng hộ..."
                                onkeypress="return isNumberKey(event)"></asp:TextBox>
                            <span class="currency-suffix">VNĐ</span>
                        </div>
                        <div class="amount-suggestions">
                            <button type="button" class="btn-suggest" onclick="setAmount(50000)">50.000đ</button>
                            <button type="button" class="btn-suggest" onclick="setAmount(100000)">100.000đ</button>
                            <button type="button" class="btn-suggest" onclick="setAmount(200000)">200.000đ</button>
                            <button type="button" class="btn-suggest" onclick="setAmount(500000)">500.000đ</button>
                            <button type="button" class="btn-suggest" onclick="setAmount(1000000)">1.000.000đ</button>
                            <button type="button" class="btn-suggest" onclick="setAmount(2000000)">2.000.000đ</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Lời nhắn (Tùy chọn)</label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="3"
                            CssClass="form-control"
                            placeholder="Gửi lời chúc tốt đẹp đến chiến dịch..."></asp:TextBox>
                    </div>

                    <div class="form-group" style="display:flex; align-items:center; gap:10px; cursor:pointer;">
                        <asp:CheckBox ID="chkAnonymous" runat="server" />
                        <label for="<%= chkAnonymous.ClientID %>"
                               style="font-size:14px; color:var(--chu-than); cursor:pointer;">
                            Quyên góp ẩn danh
                        </label>
                    </div>
                </div>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">2</div>
                        <h3 class="step-title">Chuyển khoản ủng hộ</h3>
                    </div>
                    <p style="font-size:14px; color:var(--chu-than); margin-bottom:20px;">
                        Vui lòng chuyển khoản vào thông tin tài khoản dưới đây:
                    </p>

                    <div class="bank-info-table">
                        <div class="bank-row">
                            <span>Ngân hàng</span>
                            <strong>MB Bank (Quân Đội)</strong>
                        </div>
                        <div class="bank-row">
                            <span>Số tài khoản</span>
                            <strong>0348 236 109</strong>
                        </div>
                        <div class="bank-row">
                            <span>Chủ tài khoản</span>
                            <strong>QUY THIEN NGUYEN VIET</strong>
                        </div>
                        <div class="bank-row highlight">
                            <span>Nội dung chuyển khoản</span>
                            <strong id="ckContent">QG CD01 [SĐT]</strong>
                        </div>
                    </div>
                    <p style="font-size:12px; color:var(--chu-phu); font-style:italic; margin-top:10px;">
                        * Thay [SĐT] bằng số điện thoại của bạn để chúng tôi dễ dàng xác minh.
                    </p>
                </div>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">3</div>
                        <h3 class="step-title">Gửi minh chứng</h3>
                    </div>
                    <p style="font-size:14px; color:var(--chu-than); margin-bottom:15px;">
                        Tải lên ảnh chụp màn hình giao dịch chuyển khoản thành công:
                    </p>

                    <div class="form-group">
                        <div class="upload-area">
                            <asp:FileUpload ID="fileBill" runat="server" />
                            <p style="font-size:12px; color:var(--chu-phu); margin-top:8px;">
                                Định dạng: JPG, PNG, tối đa 5MB
                            </p>
                        </div>
                    </div>

                    <asp:Button ID="btnConfirm" runat="server" Text="Tôi đã chuyển khoản"
                        CssClass="btn-submit" OnClick="btnConfirm_Click" />
                    <p class="note-text">
                        Thông tin quyên góp được bảo mật và công khai minh bạch.
                    </p>
                </div>
            </div>

            <div class="qg-sidebar">
                <div class="campaign-summary">
                    <img src="https://picsum.photos/400/250" alt="Ảnh chiến dịch" class="summary-img" />
                    <div class="summary-content">
                        <span style="background:var(--mau-chinh-nen); color:var(--mau-chinh);
                                     padding:4px 10px; border-radius:99px; font-size:11px;
                                     font-weight:700; text-transform:uppercase;">
                            TRẺ EM
                        </span>
                        <h2 class="summary-title">Xây dựng trường học cho trẻ em vùng cao Hà Giang</h2>

                        <div class="summary-stats">
                            <span>Đã đạt được:</span>
                            <strong id="lblRaised">450.000.000đ</strong>
                        </div>
                        <div class="progress-bar-wrap">
                            <div class="progress-bar-fill" style="width:75%;"></div>
                        </div>
                        <div class="summary-stats" style="color:var(--chu-phu);">
                            <span>75% mục tiêu</span>
                            <span>Mục tiêu: <strong>600.000.000đ</strong></span>
                        </div>

                        <div style="margin-top:20px; padding-top:20px; border-top:1px solid var(--vien);">
                            <div class="stat-row">
                                <span class="stat-dot" style="background:var(--mau-chinh);"></span>
                                <strong>1.240</strong>&nbsp;lượt quyên góp
                            </div>
                            <div class="stat-row">
                                <span class="stat-dot" style="background:var(--mau-cam);"></span>
                                Còn <strong>12</strong>&nbsp;ngày
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        function setAmount(val) {
            document.getElementById('<%= txtAmount.ClientID %>').value = val;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
            return true;
        }
    </script>
</asp:Content>
