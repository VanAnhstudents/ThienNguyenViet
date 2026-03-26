<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuyenGop.aspx.cs" Inherits="ThienNguyenViet.QuyenGop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Ghi đè và bổ sung style riêng cho trang Quyên Góp */
        .qg-page { background-color: #fcfdfc; padding-bottom: 80px; }
        
        .breadcrumb-bar { background: #F6FBF7; border-bottom: 1px solid var(--vien); padding: 12px 0; }
        .breadcrumb-inner { max-width: 1100px; margin: 0 auto; padding: 0 24px; display: flex; align-items: center; gap: 6px; font-size: 13px; color: var(--chu-phu); }
        .breadcrumb-inner a { color: var(--chu-phu); text-decoration: none; }
        .breadcrumb-inner strong { color: var(--mau-chinh); }

        .qg-container { 
            max-width: 1100px; margin: 40px auto; padding: 0 24px; 
            display: grid; grid-template-columns: 1fr 380px; gap: 32px; 
            font-family: 'Be Vietnam Pro', sans-serif; 
        }

        /* Khối bên trái: Các bước thực hiện */
        .qg-main { display: flex; flex-direction: column; gap: 24px; }
        .qg-card { 
            background: #fff; border: 1px solid var(--vien); border-radius: 16px; 
            padding: 32px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); 
        }
        .step-header { display: flex; align-items: center; margin-bottom: 24px; gap: 15px; }
        .step-number { 
            width: 32px; height: 32px; background: var(--mau-chinh); color: #fff; 
            border-radius: 50%; display: flex; align-items: center; justify-content: center; 
            font-weight: 700; flex-shrink: 0; 
        }
        .step-title { font-size: 20px; font-weight: 700; color: var(--chu-chinh); margin: 0; }

        /* Form controls */
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--chu-chinh); }
        .input-wrapper { position: relative; }
        .currency-suffix { position: absolute; right: 16px; top: 50%; transform: translateY(-50%); font-weight: 600; color: var(--chu-phu); }
        .form-control { 
            width: 100%; padding: 14px 16px; border: 1px solid var(--vien); 
            border-radius: 10px; font-family: inherit; font-size: 16px; transition: all 0.2s; 
        }
        .form-control:focus { outline: none; border-color: var(--mau-chinh); box-shadow: 0 0 0 3px var(--mau-chinh-nen); }
        
        /* Gợi ý số tiền */
        .amount-suggestions { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-top: 12px; }
        .btn-suggest { 
            background: var(--mau-chinh-nen); border: 1px solid var(--mau-chinh-nhat); 
            color: var(--mau-chinh); padding: 10px; border-radius: 8px; cursor: pointer; 
            font-weight: 600; transition: all 0.2s; text-align: center;
        }
        .btn-suggest:hover { background: var(--mau-chinh); color: #fff; }

        /* QR Section */
        .qr-wrapper { 
            display: grid; grid-template-columns: 200px 1fr; gap: 24px; 
            background: var(--nen-trang); padding: 20px; border-radius: 12px; border: 1px dashed var(--mau-chinh-nhat);
        }
        .qr-image { width: 100%; border-radius: 8px; border: 1px solid var(--vien); background: #fff; padding: 5px; }
        .bank-info { display: flex; flex-direction: column; gap: 8px; }
        .bank-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid var(--vien); font-size: 14px; }
        .bank-row strong { color: var(--chu-chinh); }

        /* Sidebar: Tóm tắt chiến dịch */
        .qg-sidebar { position: sticky; top: 90px; }
        .campaign-summary { 
            background: #fff; border: 1px solid var(--vien); border-radius: 16px; 
            overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.03); 
        }
        .summary-img { width: 100%; aspect-ratio: 16/9; object-fit: cover; }
        .summary-content { padding: 20px; }
        .summary-title { font-family: 'Playfair Display', serif; font-size: 18px; font-weight: 700; margin-bottom: 12px; line-height: 1.4; }
        
        .progress-bar-wrap { background: #edf2f7; height: 8px; border-radius: 99px; margin: 15px 0 8px; overflow: hidden; }
        .progress-bar-fill { background: linear-gradient(90deg, var(--mau-chinh), var(--mau-chinh-hover)); height: 100%; border-radius: 99px; }
        .summary-stats { display: flex; justify-content: space-between; font-size: 13px; color: var(--chu-phu); }
        .summary-stats strong { color: var(--mau-chinh); }

        /* Upload area */
        .upload-area { 
            border: 2px dashed var(--vien); padding: 20px; border-radius: 10px; 
            text-align: center; cursor: pointer; transition: background 0.2s; 
        }
        .upload-area:hover { background: var(--mau-chinh-nen); border-color: var(--mau-chinh-nhat); }

        .btn-submit { 
            width: 100%; padding: 16px; background: var(--mau-cam); color: #fff; 
            border: none; border-radius: 10px; font-size: 16px; font-weight: 700; 
            cursor: pointer; transition: all 0.2s; margin-top: 10px;
        }
        .btn-submit:hover { background: var(--mau-cam-hover); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(192,101,26,0.3); }

        @media (max-width: 992px) {
            .qg-container { grid-template-columns: 1fr; }
            .qg-sidebar { order: -1; position: static; }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="qg-page">
        <div class="breadcrumb-bar">
            <div class="breadcrumb-inner">
                <a href="Default.aspx">Trang chủ</a>
                <span>/</span>
                <a href="DanhSachChienDich.aspx">Chiến dịch</a>
                <span>/</span>
                <strong>Quyên góp ủng hộ</strong>
            </div>
        </div>

        <div class="qg-container">
            <div class="qg-main">
                <h1 class="qg-header-title" style="font-family:'Playfair Display'; font-size: 32px; color: var(--chu-chinh);">Ủng hộ chiến dịch</h1>
                <p style="color: var(--chu-phu); margin-top: -15px; margin-bottom: 10px;">Sự đóng góp của bạn là nguồn động lực to lớn cho cộng đồng.</p>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">1</div>
                        <h3 class="step-title">Thông tin quyên góp</h3>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Số tiền ủng hộ</label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Nhập số tiền..." onkeypress="return isNumberKey(event)"></asp:TextBox>
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
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Gửi lời chúc đến chiến dịch..."></asp:TextBox>
                    </div>

                    <div class="form-group" style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                        <asp:CheckBox ID="chkAnonymous" runat="server" />
                        <label for="<%= chkAnonymous.ClientID %>" style="font-size: 14px; color: var(--chu-than); cursor: pointer;">Quyên góp ẩn danh</label>
                    </div>
                </div>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">2</div>
                        <h3 class="step-title">Chuyển khoản ủng hộ</h3>
                    </div>
                    <p style="font-size: 14px; color: var(--chu-than); margin-bottom: 20px;">Vui lòng quét mã QR hoặc chuyển khoản vào thông tin dưới đây:</p>
                    
                    <div class="qr-wrapper">
                        <img id="qrCode" src="https://api.vietqr.io/image/970422-0348236109-compact2.jpg?amount=0&addInfo=QG%20CD01" alt="QR Code Bank" class="qr-image" />
                        <div class="bank-info">
                            <div class="bank-row"><span>Ngân hàng:</span> <strong>MB Bank (Quân Đội)</strong></div>
                            <div class="bank-row"><span>Số tài khoản:</span> <strong>0348 236 109</strong></div>
                            <div class="bank-row"><span>Chủ tài khoản:</span> <strong>QUY THIEN NGUYEN VIET</strong></div>
                            <div class="bank-row"><span>Nội dung CK:</span> <strong id="ckContent" style="color: var(--mau-cam);">QG CD01 [SĐT]</strong></div>
                            <p style="font-size: 12px; color: var(--chu-phu); font-style: italic; margin-top: 5px;">* Thay [SĐT] bằng số điện thoại của bạn để chúng tôi dễ dàng xác minh.</p>
                        </div>
                    </div>
                </div>

                <div class="qg-card">
                    <div class="step-header">
                        <div class="step-number">3</div>
                        <h3 class="step-title">Gửi minh chứng</h3>
                    </div>
                    <p style="font-size: 14px; color: var(--chu-than); margin-bottom: 15px;">Tải lên ảnh chụp màn hình giao dịch chuyển khoản thành công:</p>
                    
                    <div class="form-group">
                        <div class="upload-area">
                            <asp:FileUpload ID="fileBill" runat="server" />
                            <p style="font-size: 12px; color: var(--chu-phu); margin-top: 8px;">Định dạng: JPG, PNG, tối đa 5MB</p>
                        </div>
                    </div>

                    <asp:Button ID="btnConfirm" runat="server" Text="Tôi đã chuyển khoản" CssClass="btn-submit" OnClick="btnConfirm_Click" />
                    <p style="text-align: center; font-size: 13px; color: var(--chu-phu); margin-top: 15px;">
                        <i class="fas fa-shield-alt"></i> Thông tin quyên góp được bảo mật và công khai minh bạch.
                    </p>
                </div>
            </div>

            <div class="qg-sidebar">
                <div class="campaign-summary">
                    <img src="https://picsum.photos/400/250" alt="Campaign" class="summary-img" />
                    <div class="summary-content">
                        <span class="hero-cat-badge" style="background: var(--mau-chinh-nen); color: var(--mau-chinh); padding: 4px 10px; border-radius: 99px; font-size: 11px; font-weight: 700;">TRẺ EM</span>
                        <h2 class="summary-title">Xây dựng trường học cho trẻ em vùng cao Hà Giang</h2>
                        
                        <div class="summary-stats">
                            <span>Đã đạt được:</span>
                            <strong id="lblRaised">450.000.000đ</strong>
                        </div>
                        <div class="progress-bar-wrap">
                            <div class="progress-bar-fill" style="width: 75%;"></div>
                        </div>
                        <div class="summary-stats" style="color: var(--chu-phu);">
                            <span>75% mục tiêu</span>
                            <span>Mục tiêu: <strong>600.000.000đ</strong></span>
                        </div>

                        <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--vien); font-size: 14px; color: var(--chu-than);">
                            <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 10px;">
                                <span style="color: var(--mau-chinh);">●</span> <strong>1,240</strong> lượt quyên góp
                            </div>
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <span style="color: var(--mau-cam);">●</span> Còn <strong>12</strong> ngày
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
            // Cập nhật lại QR Code nếu cần (giả lập)
            updateQRCode(val);
        }

        function updateQRCode(amount) {
            const qrImg = document.getElementById('qrCode');
            const baseUrl = "https://api.vietqr.io/image/970422-0348236109-compact2.jpg";
            const addInfo = encodeURIComponent("QG CD01");
            qrImg.src = `${baseUrl}?amount=${amount}&addInfo=${addInfo}`;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>
