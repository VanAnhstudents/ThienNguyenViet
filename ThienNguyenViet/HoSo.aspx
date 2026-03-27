<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HoSo.aspx.cs" Inherits="ThienNguyenViet.HoSo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   HỒ SƠ CÁ NHÂN — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Page Header ────────────────────────────────────────────── */
.profile-page-header {
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 55%, #3D9962 100%);
    padding: 48px 0 80px;
    position: relative; overflow: hidden;
}
.profile-page-header::before {
    content: '';
    position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Ccircle cx='30' cy='30' r='1' fill='rgba(255,255,255,.07)'/%3E%3C/svg%3E");
}
.profile-header-inner {
    max-width: 1100px; margin: 0 auto; padding: 0 24px;
    position: relative; z-index: 1;
    display: flex; align-items: center; gap: 28px;
}
.profile-header-badge {
    display: inline-flex; align-items: center; gap: 7px;
    background: rgba(255,255,255,.12); backdrop-filter: blur(8px);
    color: rgba(255,255,255,.9); font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: .1em;
    padding: 5px 16px; border-radius: 99px;
    border: 1px solid rgba(255,255,255,.18);
    margin-bottom: 10px;
}
.profile-header-title {
    font-family: 'Playfair Display', serif;
    font-size: 28px; font-weight: 800; color: #fff; margin-bottom: 4px;
}
.profile-header-sub { font-size: 13px; color: rgba(255,255,255,.65); }

/* ── Page Layout ─────────────────────────────────────────────── */
.profile-page {
    max-width: 1100px; margin: -48px auto 80px;
    padding: 0 24px;
    position: relative; z-index: 2;
    display: grid;
    grid-template-columns: 280px 1fr;
    gap: 24px;
    align-items: start;
}

/* ── LEFT SIDEBAR ────────────────────────────────────────────── */
.profile-sidebar {
    display: flex; flex-direction: column; gap: 20px;
}

/* Avatar Card */
.avatar-card {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.09);
    padding: 32px 24px;
    text-align: center;
}
.avatar-wrap {
    position: relative; display: inline-block; margin-bottom: 16px;
}
.avatar-img {
    width: 96px; height: 96px; border-radius: 50%;
    background: linear-gradient(135deg, #2D7A4F, #3D9962);
    display: flex; align-items: center; justify-content: center;
    font-size: 38px; color: #fff; font-weight: 800;
    border: 4px solid #EAF5EE;
    box-shadow: 0 4px 18px rgba(45,122,79,.22);
    overflow: hidden; position: relative;
}
.avatar-img img {
    width: 100%; height: 100%; object-fit: cover;
    position: absolute; inset: 0;
}
.avatar-upload-btn {
    position: absolute; bottom: 2px; right: 2px;
    width: 28px; height: 28px; border-radius: 50%;
    background: var(--mau-cam);
    border: 2px solid #fff;
    display: flex; align-items: center; justify-content: center;
    font-size: 12px; cursor: pointer;
    box-shadow: 0 2px 8px rgba(0,0,0,.2);
    transition: all .18s;
}
.avatar-upload-btn:hover { background: var(--mau-cam-hover); transform: scale(1.1); }
.avatar-upload-input { display: none; }

.avatar-name {
    font-family: 'Playfair Display', serif;
    font-size: 19px; font-weight: 700; color: #1A3D28; margin-bottom: 4px;
}
.avatar-email { font-size: 13px; color: var(--chu-phu); margin-bottom: 14px; }
.avatar-role-badge {
    display: inline-flex; align-items: center; gap: 5px;
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 12px; font-weight: 700; padding: 5px 14px; border-radius: 99px;
    border: 1.5px solid var(--mau-chinh-nhat);
    margin-bottom: 18px;
}
.avatar-since { font-size: 11px; color: var(--chu-phu); }

/* Stats Card */
.stats-card {
    background: linear-gradient(135deg, #1A3D28, #2D7A4F);
    border-radius: 20px;
    padding: 24px;
    box-shadow: 0 4px 24px rgba(45,122,79,.22);
}
.stats-card-title {
    font-size: 11px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .1em; color: rgba(255,255,255,.55); margin-bottom: 18px;
}
.stat-item {
    display: flex; align-items: center; gap: 14px;
    padding: 13px 0;
    border-bottom: 1px solid rgba(255,255,255,.09);
}
.stat-item:last-child { border-bottom: none; padding-bottom: 0; }
.stat-icon {
    width: 38px; height: 38px; border-radius: 10px;
    background: rgba(255,255,255,.1);
    display: flex; align-items: center; justify-content: center;
    font-size: 17px; flex-shrink: 0;
}
.stat-text { flex: 1; }
.stat-label { font-size: 11px; color: rgba(255,255,255,.55); line-height: 1; margin-bottom: 4px; }
.stat-val { font-size: 20px; font-weight: 800; color: #fff; line-height: 1; }
.stat-val span { font-size: 12px; font-weight: 500; color: rgba(255,255,255,.6); margin-left: 2px; }

/* Badges Card */
.badges-card {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.07);
    padding: 22px;
}
.badges-card-title {
    font-size: 12px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .1em; color: var(--chu-phu); margin-bottom: 16px;
}
.badges-grid {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px;
}
.badge-item {
    text-align: center; padding: 12px 6px;
    border-radius: 12px; background: #F6FBF7;
    border: 1.5px solid #EAF5EE; position: relative;
    transition: all .2s;
}
.badge-item.locked {
    background: #F8F9FA; border-color: #E2E8F0; opacity: .5;
    filter: grayscale(1);
}
.badge-item:not(.locked):hover {
    border-color: var(--mau-chinh-nhat);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(45,122,79,.12);
}
.badge-icon { font-size: 26px; display: block; margin-bottom: 5px; }
.badge-name { font-size: 10px; font-weight: 700; color: #1A3D28; line-height: 1.3; }
.badge-lock-overlay {
    position: absolute; top: 5px; right: 5px;
    font-size: 9px; opacity: .5;
}

/* Nav menu */
.profile-nav {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.07);
    overflow: hidden;
}
.profile-nav-item {
    display: flex; align-items: center; gap: 10px;
    padding: 13px 18px; font-size: 13.5px; font-weight: 500;
    color: var(--chu-than); text-decoration: none;
    border-bottom: 1px solid #F0F7F2;
    cursor: pointer; transition: all .15s;
}
.profile-nav-item:last-child { border-bottom: none; }
.profile-nav-item:hover { background: #F6FBF7; color: var(--mau-chinh); }
.profile-nav-item.active { background: var(--mau-chinh-nen); color: var(--mau-chinh); font-weight: 700; }
.profile-nav-item .nav-icon { font-size: 16px; }
.profile-nav-item .nav-arrow { margin-left: auto; font-size: 11px; color: var(--chu-phu); }

/* ── RIGHT MAIN AREA ─────────────────────────────────────────── */
.profile-main { display: flex; flex-direction: column; gap: 20px; }

/* Panel base */
.panel {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.07);
    overflow: hidden;
}
.panel-header {
    padding: 20px 28px 18px;
    border-bottom: 1px solid #F0F7F2;
    display: flex; align-items: center; gap: 12px;
}
.panel-header-icon {
    width: 38px; height: 38px; border-radius: 10px;
    background: var(--mau-chinh-nen);
    display: flex; align-items: center; justify-content: center;
    font-size: 18px;
}
.panel-header-text h3 { font-size: 16px; font-weight: 700; color: #1A3D28; margin-bottom: 2px; }
.panel-header-text p { font-size: 12px; color: var(--chu-phu); }
.panel-body { padding: 28px; }

/* ── Form Fields ─────────────────────────────────────────────── */
.form-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 18px;
}
.form-grid.full { grid-template-columns: 1fr; }

.form-field { display: flex; flex-direction: column; gap: 6px; }
.form-field.span2 { grid-column: 1 / -1; }

.field-label {
    font-size: 13px; font-weight: 600; color: var(--chu-chinh);
    display: flex; align-items: center; gap: 5px;
}
.field-required { color: #E53E3E; font-size: 12px; }
.field-hint { font-size: 11px; color: var(--chu-phu); font-weight: 400; }

.field-input {
    height: 44px; padding: 0 14px;
    border: 1.5px solid var(--vien);
    border-radius: 10px;
    font-size: 14px; font-family: var(--font);
    color: var(--chu-chinh); background: #FAFAFA;
    outline: none; transition: all .2s;
}
.field-input:focus {
    border-color: var(--mau-chinh);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(45,122,79,.10);
}
.field-input::placeholder { color: #A0AEC0; }
.field-input:disabled { background: #F1F5F2; color: var(--chu-phu); cursor: not-allowed; }

.field-input-wrap { position: relative; }
.field-prefix {
    position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
    font-size: 13px; color: var(--chu-phu);
    pointer-events: none;
}
.field-input-wrap .field-input { padding-left: 36px; }

/* Password toggle */
.field-input-wrap .pwd-toggle {
    position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
    background: none; border: none; cursor: pointer; font-size: 16px;
    color: var(--chu-phu); transition: color .15s; padding: 0;
}
.field-input-wrap .pwd-toggle:hover { color: var(--mau-chinh); }

/* Textarea */
.field-textarea {
    padding: 12px 14px; min-height: 90px; resize: vertical;
    border: 1.5px solid var(--vien); border-radius: 10px;
    font-size: 14px; font-family: var(--font); color: var(--chu-chinh);
    background: #FAFAFA; outline: none; transition: all .2s; line-height: 1.6;
}
.field-textarea:focus {
    border-color: var(--mau-chinh); background: #fff;
    box-shadow: 0 0 0 3px rgba(45,122,79,.10);
}

/* Password strength */
.pwd-strength { margin-top: 6px; }
.pwd-strength-bar {
    height: 4px; background: var(--vien); border-radius: 99px; overflow: hidden;
    margin-bottom: 5px;
}
.pwd-strength-fill {
    height: 100%; border-radius: 99px;
    transition: width .3s, background .3s;
    width: 0%;
}
.pwd-strength-text { font-size: 11px; color: var(--chu-phu); }

/* Form actions */
.form-actions {
    display: flex; align-items: center; gap: 12px;
    padding-top: 8px; margin-top: 4px;
    flex-wrap: wrap;
}
.btn-save {
    height: 44px; padding: 0 28px; border-radius: 10px;
    background: var(--mau-chinh); color: #fff;
    font-size: 14px; font-weight: 700; font-family: var(--font);
    border: none; cursor: pointer;
    display: inline-flex; align-items: center; gap: 7px;
    transition: all .2s; box-shadow: 0 3px 10px rgba(45,122,79,.25);
}
.btn-save:hover {
    background: var(--mau-chinh-hover);
    transform: translateY(-1px);
    box-shadow: 0 6px 18px rgba(45,122,79,.35);
}
.btn-save:active { transform: translateY(0); }
.btn-cancel {
    height: 44px; padding: 0 22px; border-radius: 10px;
    background: #fff; color: var(--chu-than);
    font-size: 14px; font-weight: 600; font-family: var(--font);
    border: 1.5px solid var(--vien); cursor: pointer;
    transition: all .18s;
}
.btn-cancel:hover { border-color: var(--mau-chinh-nhat); color: var(--mau-chinh); }

/* Divider in form */
.form-divider {
    height: 1px; background: #F0F7F2;
    margin: 24px 0;
}

/* Danger zone */
.danger-zone {
    border: 1.5px dashed #FEB2B2;
    border-radius: 12px; padding: 18px 20px;
    background: #FFF5F5; margin-top: 8px;
    display: flex; align-items: center; gap: 14px;
    flex-wrap: wrap;
}
.danger-zone-text h4 { font-size: 14px; font-weight: 700; color: #C53030; margin-bottom: 3px; }
.danger-zone-text p  { font-size: 12px; color: #E53E3E; }
.btn-danger {
    height: 38px; padding: 0 18px; border-radius: 8px;
    background: #FFF5F5; color: #C53030;
    border: 1.5px solid #FC8181; font-size: 13px; font-weight: 700;
    font-family: var(--font); cursor: pointer; flex-shrink: 0;
    transition: all .18s; margin-left: auto;
}
.btn-danger:hover { background: #FED7D7; }

/* Success / error alert */
.alert-success {
    display: none;
    background: #F0FFF4; border: 1.5px solid #9AE6B4;
    border-radius: 10px; padding: 12px 16px;
    font-size: 13px; color: #276749; font-weight: 600;
    align-items: center; gap: 8px; margin-bottom: 20px;
}
.alert-success.show { display: flex; }

/* ── Toggle switch last fix ────────────────────────────────── */
.toggle-switch input:checked + .toggle-slider { background: var(--mau-chinh); }
.toggle-switch input:checked + .toggle-slider::before { transform: translateX(20px); }

/* ── Recent Donation Table ────────────────────────────────── */
.recent-donation-table {
    width: 100%; border-collapse: collapse;
}
.recent-donation-table thead tr {
    background: #F6FBF7;
}
.recent-donation-table th {
    padding: 11px 20px; font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: .07em;
    color: var(--chu-phu); text-align: left;
    border-bottom: 1px solid #EAF5EE;
}
.recent-donation-table td {
    padding: 14px 20px; font-size: 13.5px;
    border-bottom: 1px solid #F0F7F2;
    vertical-align: middle;
}
.recent-donation-table tbody tr:last-child td { border-bottom: none; }
.recent-donation-table tbody tr:hover td { background: #FAFFF9; }

.rdt-campaign { display: flex; align-items: center; gap: 9px; color: var(--chu-chinh); }
.rdt-campaign-icon {
    width: 32px; height: 32px; border-radius: 8px;
    background: var(--mau-chinh-nen);
    display: inline-flex; align-items: center; justify-content: center;
    font-size: 15px; flex-shrink: 0;
}
.rdt-amount { font-weight: 700; color: var(--mau-chinh); white-space: nowrap; }
.rdt-date   { color: var(--chu-phu); font-size: 12.5px; white-space: nowrap; }

.rdt-badge {
    display: inline-flex; align-items: center; gap: 4px;
    padding: 4px 12px; border-radius: 99px;
    font-size: 11.5px; font-weight: 700; white-space: nowrap;
}
.badge-confirmed {
    background: #F0FFF4; color: #276749;
    border: 1.5px solid #9AE6B4;
}
.badge-pending {
    background: #FFFBEB; color: #92400E;
    border: 1.5px solid #FCD34D;
}
.badge-rejected {
    background: #FFF5F5; color: #C53030;
    border: 1.5px solid #FC8181;
}

.btn-view-all {
    display: inline-flex; align-items: center; gap: 7px;
    height: 40px; padding: 0 22px; border-radius: 10px;
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 13.5px; font-weight: 700; text-decoration: none;
    border: 1.5px solid var(--mau-chinh-nhat);
    transition: all .18s;
}
.btn-view-all:hover {
    background: var(--mau-chinh); color: #fff;
    transform: translateX(2px);
}
.toggle-row {
    display: flex; align-items: center; justify-content: space-between;
    padding: 14px 0; border-bottom: 1px solid #F0F7F2;
}
.toggle-row:last-child { border-bottom: none; padding-bottom: 0; }
.toggle-label { font-size: 14px; color: var(--chu-chinh); }
.toggle-sub   { font-size: 12px; color: var(--chu-phu); margin-top: 2px; }
.toggle-switch {
    position: relative; width: 44px; height: 24px; flex-shrink: 0;
}
.toggle-switch input { opacity: 0; width: 0; height: 0; }
.toggle-slider {
    position: absolute; inset: 0; cursor: pointer;
    background: #CBD5E0; border-radius: 99px; transition: .25s;
}
.toggle-slider::before {
    content: ''; position: absolute;
    width: 18px; height: 18px; border-radius: 50%;
    background: #fff; left: 3px; top: 3px;
    transition: .25s; box-shadow: 0 1px 4px rgba(0,0,0,.2);
}
.toggle-switch input:checked + .toggle-slider { background: var(--mau-chinh); }
.toggle-switch input:checked + .toggle-slider::before { transform: translateX(20px); }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- ═══════════════════════════════════════════════════════════
     PAGE HEADER
═══════════════════════════════════════════════════════════════ -->
<div class="profile-page-header">
    <div class="profile-header-inner">
        <div>
            <div class="profile-header-badge">👤 Tài khoản của tôi</div>
            <h1 class="profile-header-title">Hồ sơ cá nhân</h1>
            <p class="profile-header-sub">Quản lý thông tin cá nhân, bảo mật và hoạt động thiện nguyện của bạn.</p>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     PAGE LAYOUT
═══════════════════════════════════════════════════════════════ -->
<div class="profile-page">

    <!-- ─── LEFT SIDEBAR ─────────────────────────────────── -->
    <aside class="profile-sidebar">

        <!-- Avatar Card -->
        <div class="avatar-card">
            <div class="avatar-wrap">
                <div class="avatar-img" id="avatarPreview">
                    N
                </div>
                <label for="avatarInput" class="avatar-upload-btn" title="Thay ảnh đại diện">📷</label>
                <input type="file" id="avatarInput" class="avatar-upload-input" accept="image/*" />
            </div>
            <div class="avatar-name">Nguyễn Thị Lan Anh</div>
            <div class="avatar-email">lananh.nguyen@gmail.com</div>
            <div class="avatar-role-badge">🌿 Tình nguyện viên</div>
            <div class="avatar-since">Thành viên từ tháng 3/2024</div>
        </div>

        <!-- Stats Card -->
        <div class="stats-card">
            <div class="stats-card-title">📊 Thống kê cá nhân</div>
            <div class="stat-item">
                <div class="stat-icon">💰</div>
                <div class="stat-text">
                    <div class="stat-label">Tổng đã quyên góp</div>
                    <div class="stat-val">4.750.000 <span>đ</span></div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">🎯</div>
                <div class="stat-text">
                    <div class="stat-label">Chiến dịch đã tham gia</div>
                    <div class="stat-val">12 <span>chiến dịch</span></div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">✅</div>
                <div class="stat-text">
                    <div class="stat-label">Lượt góp được xác nhận</div>
                    <div class="stat-val">9 <span>/ 12</span></div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">🏆</div>
                <div class="stat-text">
                    <div class="stat-label">Xếp hạng đóng góp</div>
                    <div class="stat-val">#28 <span>toàn quốc</span></div>
                </div>
            </div>
        </div>

        <!-- Badges Card -->
        <div class="badges-card">
            <div class="badges-card-title">🎖️ Huy hiệu của bạn</div>
            <div class="badges-grid">
                <div class="badge-item" title="Người mới bắt đầu">
                    <span class="badge-icon">🌱</span>
                    <div class="badge-name">Người mới</div>
                </div>
                <div class="badge-item" title="Đã tham gia 5+ chiến dịch">
                    <span class="badge-icon">🤝</span>
                    <div class="badge-name">Đồng hành</div>
                </div>
                <div class="badge-item" title="Đã quyên góp 1 triệu+">
                    <span class="badge-icon">💎</span>
                    <div class="badge-name">Nhà hảo tâm</div>
                </div>
                <div class="badge-item locked" title="Tham gia 20 chiến dịch để mở khóa">
                    <span class="badge-icon">🌟</span>
                    <div class="badge-name">Sao sáng</div>
                    <span class="badge-lock-overlay">🔒</span>
                </div>
                <div class="badge-item locked" title="Quyên góp 10 triệu+ để mở khóa">
                    <span class="badge-icon">🏆</span>
                    <div class="badge-name">Huyền thoại</div>
                    <span class="badge-lock-overlay">🔒</span>
                </div>
                <div class="badge-item locked" title="Tham gia 1 năm liên tiếp để mở khóa">
                    <span class="badge-icon">🔥</span>
                    <div class="badge-name">Kiên định</div>
                    <span class="badge-lock-overlay">🔒</span>
                </div>
            </div>
        </div>

        <!-- Profile Nav -->
        <nav class="profile-nav">
            <a href="#info" class="profile-nav-item active" onclick="scrollToSection('info',this)">
                <span class="nav-icon">👤</span> Thông tin cá nhân
                <span class="nav-arrow">›</span>
            </a>
            <a href="#password" class="profile-nav-item" onclick="scrollToSection('password',this)">
                <span class="nav-icon">🔒</span> Đổi mật khẩu
                <span class="nav-arrow">›</span>
            </a>
            <a href="#notifications" class="profile-nav-item" onclick="scrollToSection('notifications',this)">
                <span class="nav-icon">🔔</span> Thông báo
                <span class="nav-arrow">›</span>
            </a>
            <a href="/LichSuQuyenGop.aspx" class="profile-nav-item">
                <span class="nav-icon">📋</span> Lịch sử quyên góp
                <span class="nav-arrow">›</span>
            </a>
        </nav>

    </aside>

    <!-- ─── MAIN CONTENT ──────────────────────────────────── -->
    <main class="profile-main">

        <!-- ══ PANEL 1: THÔNG TIN CÁ NHÂN ═══════════════════ -->
        <div class="panel" id="info">
            <div class="panel-header">
                <div class="panel-header-icon">👤</div>
                <div class="panel-header-text">
                    <h3>Thông tin cá nhân</h3>
                    <p>Cập nhật họ tên, email, số điện thoại và địa chỉ của bạn</p>
                </div>
            </div>
            <div class="panel-body">
                <div class="alert-success" id="infoAlert">
                    ✅ Cập nhật thông tin thành công!
                </div>

                <div class="form-grid">
                    <!-- Họ -->
                    <div class="form-field">
                        <label class="field-label">
                            Họ và tên đệm <span class="field-required">*</span>
                        </label>
                        <input type="text" class="field-input" value="Nguyễn Thị" placeholder="Nhập họ và tên đệm..." />
                    </div>
                    <!-- Tên -->
                    <div class="form-field">
                        <label class="field-label">
                            Tên <span class="field-required">*</span>
                        </label>
                        <input type="text" class="field-input" value="Lan Anh" placeholder="Nhập tên..." />
                    </div>
                    <!-- Email -->
                    <div class="form-field">
                        <label class="field-label">
                            📧 Email <span class="field-required">*</span>
                            <span class="field-hint">(dùng để đăng nhập)</span>
                        </label>
                        <input type="email" class="field-input" value="lananh.nguyen@gmail.com" placeholder="your@email.com" />
                    </div>
                    <!-- SĐT -->
                    <div class="form-field">
                        <label class="field-label">📞 Số điện thoại</label>
                        <div class="field-input-wrap">
                            <span class="field-prefix">🇻🇳</span>
                            <input type="tel" class="field-input" value="0912 345 678" placeholder="09xx xxx xxx" />
                        </div>
                    </div>
                    <!-- Ngày sinh -->
                    <div class="form-field">
                        <label class="field-label">🎂 Ngày sinh</label>
                        <input type="date" class="field-input" value="1995-08-14" />
                    </div>
                    <!-- Giới tính -->
                    <div class="form-field">
                        <label class="field-label">Giới tính</label>
                        <select class="field-input" style="cursor:pointer">
                            <option value="">-- Chọn giới tính --</option>
                            <option value="nu" selected>Nữ</option>
                            <option value="nam">Nam</option>
                            <option value="khac">Khác</option>
                        </select>
                    </div>
                    <!-- Tỉnh/thành -->
                    <div class="form-field">
                        <label class="field-label">📍 Tỉnh / Thành phố</label>
                        <select class="field-input" style="cursor:pointer">
                            <option>-- Chọn tỉnh/thành --</option>
                            <option selected>TP. Hồ Chí Minh</option>
                            <option>Hà Nội</option>
                            <option>Đà Nẵng</option>
                            <option>Cần Thơ</option>
                            <option>Khác</option>
                        </select>
                    </div>
                    <!-- Nghề nghiệp -->
                    <div class="form-field">
                        <label class="field-label">💼 Nghề nghiệp</label>
                        <input type="text" class="field-input" value="Kỹ sư phần mềm" placeholder="Nghề nghiệp của bạn..." />
                    </div>
                    <!-- Giới thiệu -->
                    <div class="form-field span2">
                        <label class="field-label">📝 Giới thiệu bản thân
                            <span class="field-hint">(không bắt buộc)</span>
                        </label>
                        <textarea class="field-textarea" placeholder="Chia sẻ đôi điều về bản thân và lý do bạn tham gia hoạt động thiện nguyện...">Tôi yêu thích hoạt động thiện nguyện và muốn đóng góp cho cộng đồng. Đã tham gia Thiện Nguyện Việt từ năm 2024 và rất vui khi được cùng mọi người lan tỏa yêu thương.</textarea>
                    </div>
                </div>

                <div class="form-divider"></div>
                <div class="form-actions">
                    <button class="btn-save" onclick="saveInfo()">💾 Lưu thay đổi</button>
                    <button class="btn-cancel">Hủy</button>
                </div>
            </div>
        </div>

        <!-- ══ PANEL 2: ĐỔI MẬT KHẨU ════════════════════════ -->
        <div class="panel" id="password">
            <div class="panel-header">
                <div class="panel-header-icon">🔒</div>
                <div class="panel-header-text">
                    <h3>Đổi mật khẩu</h3>
                    <p>Sử dụng mật khẩu mạnh, ít nhất 8 ký tự gồm chữ và số</p>
                </div>
            </div>
            <div class="panel-body">
                <div class="alert-success" id="pwdAlert">
                    ✅ Đổi mật khẩu thành công!
                </div>

                <div class="form-grid">
                    <!-- Mật khẩu cũ -->
                    <div class="form-field span2">
                        <label class="field-label">🔑 Mật khẩu hiện tại <span class="field-required">*</span></label>
                        <div class="field-input-wrap">
                            <input type="password" class="field-input" id="oldPwd" placeholder="Nhập mật khẩu hiện tại..." />
                            <button class="pwd-toggle" onclick="togglePwd('oldPwd',this)">👁️</button>
                        </div>
                    </div>
                    <!-- Mật khẩu mới -->
                    <div class="form-field">
                        <label class="field-label">🔒 Mật khẩu mới <span class="field-required">*</span></label>
                        <div class="field-input-wrap">
                            <input type="password" class="field-input" id="newPwd" placeholder="Nhập mật khẩu mới..." oninput="checkStrength(this.value)" />
                            <button class="pwd-toggle" onclick="togglePwd('newPwd',this)">👁️</button>
                        </div>
                        <!-- Strength meter -->
                        <div class="pwd-strength">
                            <div class="pwd-strength-bar">
                                <div class="pwd-strength-fill" id="strengthFill"></div>
                            </div>
                            <div class="pwd-strength-text" id="strengthText">Nhập mật khẩu để kiểm tra độ mạnh</div>
                        </div>
                    </div>
                    <!-- Xác nhận mật khẩu -->
                    <div class="form-field">
                        <label class="field-label">🔁 Xác nhận mật khẩu mới <span class="field-required">*</span></label>
                        <div class="field-input-wrap">
                            <input type="password" class="field-input" id="confirmPwd" placeholder="Nhập lại mật khẩu mới..." />
                            <button class="pwd-toggle" onclick="togglePwd('confirmPwd',this)">👁️</button>
                        </div>
                    </div>
                </div>

                <div class="form-divider"></div>
                <div class="form-actions">
                    <button class="btn-save" onclick="savePwd()">🔐 Cập nhật mật khẩu</button>
                    <button class="btn-cancel">Hủy</button>
                </div>

                <div class="form-divider"></div>
                <!-- Danger zone -->
                <div class="danger-zone">
                    <div class="danger-zone-text">
                        <h4>⚠️ Xóa tài khoản</h4>
                        <p>Hành động này không thể hoàn tác. Tất cả dữ liệu sẽ bị xóa vĩnh viễn.</p>
                    </div>
                    <button class="btn-danger" onclick="confirmDelete()">🗑️ Xóa tài khoản</button>
                </div>
            </div>
        </div>

        <!-- ══ PANEL: LỊCH SỬ QUYÊN GÓP GẦN ĐÂY ═══════════ -->
        <div class="panel" id="recent-donations">
            <div class="panel-header">
                <div class="panel-header-icon">📋</div>
                <div class="panel-header-text">
                    <h3>Lịch sử quyên góp gần đây</h3>
                    <p>3 giao dịch quyên góp mới nhất của bạn</p>
                </div>
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
                            <td class="rdt-campaign">
                                <span class="rdt-campaign-icon">🏠</span>
                                <span>Xây nhà cho đồng bào lũ lụt miền Trung</span>
                            </td>
                            <td class="rdt-amount">500.000 đ</td>
                            <td class="rdt-date">20/03/2026</td>
                            <td><span class="rdt-badge badge-confirmed">✅ Đã xác nhận</span></td>
                        </tr>
                        <tr>
                            <td class="rdt-campaign">
                                <span class="rdt-campaign-icon">📚</span>
                                <span>Học bổng cho trẻ em vùng cao Hà Giang</span>
                            </td>
                            <td class="rdt-amount">200.000 đ</td>
                            <td class="rdt-date">12/03/2026</td>
                            <td><span class="rdt-badge badge-pending">⏳ Chờ xác nhận</span></td>
                        </tr>
                        <tr>
                            <td class="rdt-campaign">
                                <span class="rdt-campaign-icon">🍚</span>
                                <span>Bữa cơm yêu thương — Hỗ trợ người vô gia cư</span>
                            </td>
                            <td class="rdt-amount">150.000 đ</td>
                            <td class="rdt-date">05/03/2026</td>
                            <td><span class="rdt-badge badge-confirmed">✅ Đã xác nhận</span></td>
                        </tr>
                    </tbody>
                </table>
                <div style="padding:18px 28px;text-align:right;border-top:1px solid #F0F7F2;">
                    <a href="<%= ResolveUrl("~/LichSuQuyenGop.aspx") %>" class="btn-view-all">
                        📋 Xem toàn bộ lịch sử →
                    </a>
                </div>
            </div>
        </div>

        <!-- ══ PANEL 3: THÔNG BÁO ════════════════════════════ -->
        <div class="panel" id="notifications">
            <div class="panel-header">
                <div class="panel-header-icon">🔔</div>
                <div class="panel-header-text">
                    <h3>Tùy chọn thông báo</h3>
                    <p>Chọn loại thông báo bạn muốn nhận qua email hoặc trong hệ thống</p>
                </div>
            </div>
            <div class="panel-body">
                <div class="toggle-row">
                    <div>
                        <div class="toggle-label">📧 Xác nhận quyên góp qua email</div>
                        <div class="toggle-sub">Nhận email khi admin duyệt hoặc từ chối quyên góp của bạn</div>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" checked />
                        <span class="toggle-slider"></span>
                    </label>
                </div>
                <div class="toggle-row">
                    <div>
                        <div class="toggle-label">📰 Tin tức & Hoạt động mới</div>
                        <div class="toggle-sub">Nhận thông báo khi có bài viết hoặc chiến dịch mới</div>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" checked />
                        <span class="toggle-slider"></span>
                    </label>
                </div>
                <div class="toggle-row">
                    <div>
                        <div class="toggle-label">⏰ Nhắc nhở chiến dịch sắp kết thúc</div>
                        <div class="toggle-sub">Thông báo khi chiến dịch bạn quan tâm còn dưới 3 ngày</div>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" />
                        <span class="toggle-slider"></span>
                    </label>
                </div>
                <div class="toggle-row">
                    <div>
                        <div class="toggle-label">🏆 Cập nhật huy hiệu & xếp hạng</div>
                        <div class="toggle-sub">Thông báo khi bạn đạt huy hiệu mới hoặc thay đổi thứ hạng</div>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" checked />
                        <span class="toggle-slider"></span>
                    </label>
                </div>
                <div class="toggle-row">
                    <div>
                        <div class="toggle-label">📊 Báo cáo hoạt động hàng tháng</div>
                        <div class="toggle-sub">Nhận tổng kết các hoạt động và thống kê mỗi cuối tháng</div>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" />
                        <span class="toggle-slider"></span>
                    </label>
                </div>

                <div class="form-divider"></div>
                <div class="form-actions">
                    <button class="btn-save" onclick="saveNotif()">💾 Lưu tùy chọn</button>
                </div>
            </div>
        </div>

    </main>
</div>

<!-- ─────────────────────────────────────────────────────────── -->
<script>
    /* Avatar preview */
    document.getElementById('avatarInput').addEventListener('change', function () {
        var file = this.files[0];
        if (!file) return;
        var reader = new FileReader();
        reader.onload = function (e) {
            var wrap = document.getElementById('avatarPreview');
            wrap.innerHTML = '<img src="' + e.target.result + '" alt="avatar"/>';
        };
        reader.readAsDataURL(file);
    });

    /* Scroll to section */
    function scrollToSection(id, navEl) {
        event.preventDefault();
        var el = document.getElementById(id);
        if (el) window.scrollTo({ top: el.getBoundingClientRect().top + window.scrollY - 90, behavior: 'smooth' });
        document.querySelectorAll('.profile-nav-item').forEach(function (a) { a.classList.remove('active'); });
        navEl.classList.add('active');
    }

    /* Password toggle */
    function togglePwd(id, btn) {
        var input = document.getElementById(id);
        if (input.type === 'password') { input.type = 'text'; btn.textContent = '🙈'; }
        else { input.type = 'password'; btn.textContent = '👁️'; }
    }

    /* Password strength */
    function checkStrength(val) {
        var fill = document.getElementById('strengthFill');
        var text = document.getElementById('strengthText');
        var score = 0;
        if (val.length >= 8) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        var levels = [
            { w: '0%', c: '#E53E3E', t: 'Chưa nhập' },
            { w: '25%', c: '#E53E3E', t: '🔴 Rất yếu' },
            { w: '50%', c: '#D69E2E', t: '🟡 Trung bình' },
            { w: '75%', c: '#3182CE', t: '🔵 Khá mạnh' },
            { w: '100%', c: '#38A169', t: '🟢 Rất mạnh' }
        ];
        var lv = val.length === 0 ? 0 : score;
        fill.style.width = levels[lv].w;
        fill.style.background = levels[lv].c;
        text.textContent = levels[lv].t;
    }

    /* Save info mock */
    function saveInfo() {
        var al = document.getElementById('infoAlert');
        al.classList.add('show');
        setTimeout(function () { al.classList.remove('show'); }, 3500);
    }
    /* Save password mock */
    function savePwd() {
        var al = document.getElementById('pwdAlert');
        al.classList.add('show');
        setTimeout(function () { al.classList.remove('show'); }, 3500);
    }
    /* Save notifications mock */
    function saveNotif() { saveInfo(); }

    /* Confirm delete */
    function confirmDelete() {
        if (confirm('Bạn có chắc chắn muốn xóa tài khoản? Hành động này KHÔNG THỂ hoàn tác!')) {
            alert('Tài khoản của bạn đã được gửi yêu cầu xóa.');
        }
    }
</script>
</asp:Content>
