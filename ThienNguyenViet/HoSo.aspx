<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="HoSo.aspx.cs" Inherits="ThienNguyenViet.HoSo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    /* ==================== HỒ SƠ CÁ NHÂN - PHIÊN BẢN GỌN GÀNG ==================== */
    .profile-page-header {
        background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 100%);
        padding: 50px 0 70px;
        color: white;
    }
    .profile-header-inner {
        max-width: 1100px;
        margin: 0 auto;
        padding: 0 24px;
    }
    .profile-header-title {
        font-size: 28px;
        font-weight: 800;
        margin: 0 0 8px 0;
    }
    .profile-header-sub {
        font-size: 15px;
        opacity: 0.85;
    }

    .profile-page {
        max-width: 1100px;
        margin: -50px auto 80px;
        padding: 0 24px;
        display: grid;
        grid-template-columns: 280px 1fr;
        gap: 24px;
    }

    /* Sidebar */
    .profile-sidebar {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .avatar-card {
        background: #fff;
        border-radius: 16px;
        padding: 32px 24px;
        text-align: center;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        border: 1px solid #E8F0EB;
    }
    .avatar-wrap {
        position: relative;
        display: inline-block;
        margin-bottom: 16px;
    }
    .avatar-img {
        width: 100px; 
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(135deg, #2D7A4F, #3D9962);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 42px;
        color: white;
        font-weight: 700;
        border: 5px solid #fff;
        box-shadow: 0 6px 20px rgba(45,122,79,0.25);
        overflow: hidden;
    }
    .avatar-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .avatar-name {
        font-size: 20px;
        font-weight: 700;
        color: #1A3D28;
        margin-bottom: 6px;
    }
    .avatar-email {
        color: #666;
        font-size: 14px;
    }
    .avatar-role {
        margin-top: 12px;
        display: inline-block;
        background: #E6F4EC;
        color: #2D7A4F;
        padding: 6px 16px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
    }

    /* Main Content */
    .profile-main {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .panel {
        background: #fff;
        border-radius: 16px;
        border: 1px solid #E8F0EB;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        overflow: hidden;
    }
    .panel-header {
        padding: 22px 28px;
        border-bottom: 1px solid #F0F7F2;
        background: #F8FBF9;
    }
    .panel-header h3 {
        margin: 0;
        font-size: 18px;
        color: #1A3D28;
        font-weight: 700;
    }
    .panel-body {
        padding: 28px;
    }

    /* Form */
    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    .form-field.span2 { 
        grid-column: 1 / -1; 
    }

    .field-label {
        font-size: 14px;
        font-weight: 600;
        color: #333;
        margin-bottom: 6px;
        display: block;
    }
    .field-input, 
    .field-textarea {
        width: 100%;
        padding: 12px 14px;
        border: 1.5px solid #E2E8F0;
        border-radius: 10px;
        font-size: 15px;
        transition: all 0.2s;
    }
    .field-input:focus,
    .field-textarea:focus {
        border-color: #2D7A4F;
        box-shadow: 0 0 0 3px rgba(45,122,79,0.12);
        outline: none;
    }
    .field-textarea {
        min-height: 110px;
        resize: vertical;
    }

    .form-actions {
        margin-top: 24px;
        display: flex;
        gap: 12px;
    }
    .btn-save {
        padding: 12px 28px;
        background: #2D7A4F;
        color: white;
        border: none;
        border-radius: 10px;
        font-weight: 700;
        cursor: pointer;
        font-size: 15px;
    }
    .btn-save:hover {
        background: #23613E;
    }
    .btn-cancel {
        padding: 12px 24px;
        background: white;
        color: #555;
        border: 1.5px solid #E2E8F0;
        border-radius: 10px;
        font-weight: 600;
        cursor: pointer;
    }

    /* Bảng lịch sử quyên góp - Đã sửa không xuống dòng */
    .recent-donation-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }
    .recent-donation-table th,
    .recent-donation-table td {
        padding: 16px 20px;
        vertical-align: middle;
    }
    .recent-donation-table th {
        background: #F8FBF9;
        font-size: 13px;
        font-weight: 600;
        color: #555;
        text-transform: uppercase;
        white-space: nowrap;
    }
    .recent-donation-table td {
        border-bottom: 1px solid #F0F7F2;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .recent-donation-table td:first-child {
        width: 48%;
    }
    .recent-donation-table td:nth-child(2) {
        width: 18%;
        text-align: right;
        font-weight: 700;
        color: #2D7A4F;
    }
    .recent-donation-table td:nth-child(3) {
        width: 18%;
    }
    .recent-donation-table td:last-child {
        width: 16%;
    }

    .rdt-badge {
        padding: 6px 14px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        white-space: nowrap;
        display: inline-block;
    }
    .badge-confirmed {
        background: #E6F4EC;
        color: #2D7A4F;
    }
    .badge-pending {
        background: #FFF7E6;
        color: #D97706;
    }

    .btn-view-all {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: #F8FBF9;
        color: #2D7A4F;
        border: 1.5px solid #C6E4D4;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="profile-page-header">
    <div class="profile-header-inner">
        <h1 class="profile-header-title">Hồ sơ cá nhân</h1>
        <p class="profile-header-sub">Quản lý thông tin cá nhân và bảo mật tài khoản</p>
    </div>
</div>

<div class="profile-page">
    <!-- Sidebar -->
    <aside class="profile-sidebar">
        <div class="avatar-card">
            <div class="avatar-wrap">
                <div class="avatar-img" id="avatarPreview">N</div>
                <label for="avatarInput" style="position:absolute;bottom:4px;right:4px;background:#2D7A4F;color:white;width:28px;height:28px;border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:14px;">📷</label>
                <input type="file" id="avatarInput" style="display:none;" accept="image/*" />
            </div>
            <div class="avatar-name">Nguyễn Thị Lan Anh</div>
            <div class="avatar-email">lananh.nguyen@gmail.com</div>
            <div class="avatar-role">Tình nguyện viên</div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="profile-main">

        <!-- Thông tin cá nhân -->
        <div class="panel">
            <div class="panel-header">
                <h3>Thông tin cá nhân</h3>
            </div>
            <div class="panel-body">
                <div class="form-grid">
                    <div class="form-field">
                        <label class="field-label">Họ và tên đệm <span style="color:#e53e3e;">*</span></label>
                        <input type="text" class="field-input" value="Nguyễn Thị" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Tên <span style="color:#e53e3e;">*</span></label>
                        <input type="text" class="field-input" value="Lan Anh" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Email <span style="color:#e53e3e;">*</span></label>
                        <input type="email" class="field-input" value="lananh.nguyen@gmail.com" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Số điện thoại</label>
                        <input type="tel" class="field-input" value="0912 345 678" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Ngày sinh</label>
                        <input type="date" class="field-input" value="1995-08-14" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Giới tính</label>
                        <select class="field-input">
                            <option selected>Nữ</option>
                            <option>Nam</option>
                            <option>Khác</option>
                        </select>
                    </div>
                    <div class="form-field span2">
                        <label class="field-label">Giới thiệu bản thân</label>
                        <textarea class="field-textarea">Tôi yêu thích hoạt động thiện nguyện và muốn đóng góp cho cộng đồng. Đã tham gia Thiện Nguyện Việt từ năm 2024.</textarea>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn-save" onclick="saveInfo()">Lưu thay đổi</button>
                    <button class="btn-cancel" type="button">Hủy</button>
                </div>
            </div>
        </div>

        <!-- Đổi mật khẩu -->
        <div class="panel">
            <div class="panel-header">
                <h3>Đổi mật khẩu</h3>
            </div>
            <div class="panel-body">
                <div class="form-grid">
                    <div class="form-field span2">
                        <label class="field-label">Mật khẩu hiện tại <span style="color:#e53e3e;">*</span></label>
                        <input type="password" class="field-input" id="oldPwd" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Mật khẩu mới <span style="color:#e53e3e;">*</span></label>
                        <input type="password" class="field-input" id="newPwd" />
                    </div>
                    <div class="form-field">
                        <label class="field-label">Xác nhận mật khẩu mới <span style="color:#e53e3e;">*</span></label>
                        <input type="password" class="field-input" id="confirmPwd" />
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn-save" onclick="savePwd()">Cập nhật mật khẩu</button>
                    <button class="btn-cancel" type="button">Hủy</button>
                </div>
            </div>
        </div>

        <!-- Lịch sử quyên góp gần đây - ĐÃ SỬA KHÔNG XUỐNG DÒNG -->
        <div class="panel">
            <div class="panel-header">
                <h3>Lịch sử quyên góp gần đây</h3>
            </div>
            <div class="panel-body" style="padding:0;">
                <table class="recent-donation-table">
                    <thead>
                        <tr>
                            <th>Chiến dịch</th>
                            <th>Số tiền</th>
                            <th>Ngày</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Xây nhà cho đồng bào lũ lụt miền Trung</td>
                            <td class="rdt-amount">500.000 đ</td>
                            <td>20/03/2026</td>
                            <td><span class="rdt-badge badge-confirmed">Đã xác nhận</span></td>
                        </tr>
                        <tr>
                            <td>Học bổng cho trẻ em vùng cao Hà Giang</td>
                            <td class="rdt-amount">200.000 đ</td>
                            <td>12/03/2026</td>
                            <td><span class="rdt-badge badge-pending">Chờ xác nhận</span></td>
                        </tr>
                        <tr>
                            <td>Bữa cơm yêu thương — Hỗ trợ người vô gia cư</td>
                            <td class="rdt-amount">150.000 đ</td>
                            <td>05/03/2026</td>
                            <td><span class="rdt-badge badge-confirmed">Đã xác nhận</span></td>
                        </tr>
                    </tbody>
                </table>
                
                <div style="padding: 20px 28px; text-align: right; border-top: 1px solid #F0F7F2;">
                    <a href="/LichSuQuyenGop.aspx" class="btn-view-all">
                        Xem toàn bộ lịch sử →
                    </a>
                </div>
            </div>
        </div>

    </main>
</div>

<script>
    // Avatar preview
    document.getElementById('avatarInput').addEventListener('change', function (e) {
        if (e.target.files && e.target.files[0]) {
            const reader = new FileReader();
            reader.onload = function (ev) {
                document.getElementById('avatarPreview').innerHTML =
                    `<img src="${ev.target.result}" alt="Avatar"/>`;
            };
            reader.readAsDataURL(e.target.files[0]);
        }
    });

    function saveInfo() {
        alert("✅ Thông tin cá nhân đã được cập nhật thành công!");
    }

    function savePwd() {
        alert("✅ Mật khẩu đã được thay đổi thành công!");
    }
</script>

</asp:Content>