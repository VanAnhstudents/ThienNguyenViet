<%@ Page Title="Quản lý Người dùng" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyNguoiDung.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   QUẢN LÝ NGƯỜI DÙNG — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Topbar / Filter ──────────────────────────────────────── */
.page-topbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
}
.page-topbar-title {
    font-size: 20px;
    font-weight: 700;
    color: var(--admin-chu-chinh);
}

.filter-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.input-search {
    height: 34px;
    padding: 0 10px;
    border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut);
    font-size: 13px;
    font-family: var(--font);
    color: var(--admin-chu-chinh);
    width: 240px;
    outline: none;
    transition: border-color .15s;
}
.input-search:focus { border-color: #3182CE; }

.select-filter {
    height: 34px;
    padding: 0 8px;
    border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut);
    font-size: 13px;
    font-family: var(--font);
    color: var(--admin-chu-chinh);
    background: #fff;
    cursor: pointer;
    outline: none;
}

.btn-primary-sm {
    height: 34px;
    padding: 0 14px;
    background: #3182CE;
    color: #fff;
    border: none;
    border-radius: var(--r-nut);
    font-size: 13px;
    font-family: var(--font);
    font-weight: 500;
    cursor: pointer;
    transition: background .15s;
}
.btn-primary-sm:hover { background: #2B6CB0; }

.btn-outline-sm {
    height: 34px;
    padding: 0 12px;
    background: transparent;
    color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut);
    font-size: 13px;
    font-family: var(--font);
    cursor: pointer;
    transition: background .15s;
}
.btn-outline-sm:hover {
    background: var(--admin-nen);
    color: var(--admin-chu-chinh);
}

/* ── Stats tóm tắt ─────────────────────────────────────────── */
.user-stats-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px;
    margin-bottom: 20px;
}

.user-stat-card {
    background: var(--admin-card);
    border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien);
    padding: 16px 18px;
    display: flex;
    align-items: center;
    gap: 14px;
}

.user-stat-icon {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    flex-shrink: 0;
}

.user-stat-info strong {
    display: block;
    font-size: 20px;
    font-weight: 700;
    color: var(--admin-chu-chinh);
    line-height: 1.1;
}
.user-stat-info span {
    font-size: 11px;
    color: var(--admin-chu-phu);
}

/* ── Section header ─────────────────────────────────────────── */
.section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 14px;
}
.section-title  { font-size: 14px; font-weight: 600; color: var(--admin-chu-chinh); }
.section-count  { font-size: 12px; color: var(--admin-chu-phu); }

/* ── Avatar cell ────────────────────────────────────────────── */
.user-cell {
    display: flex;
    align-items: center;
    gap: 10px;
}
.user-av {
    width: 34px;
    height: 34px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: 700;
    flex-shrink: 0;
    border: 2px solid rgba(255,255,255,.8);
    box-shadow: 0 1px 4px rgba(0,0,0,.12);
}
.user-fullname {
    font-size: 13px;
    font-weight: 500;
    color: var(--admin-chu-chinh);
    line-height: 1.3;
}
.user-role-badge {
    font-size: 10px;
    font-weight: 600;
    padding: 1px 6px;
    border-radius: 4px;
    display: inline-block;
    margin-top: 2px;
}
.role-admin { background: #EBF8FF; color: #2B6CB0; }
.role-user  { background: #F0FFF4; color: #276749; }

/* ── Table tweaks ───────────────────────────────────────────── */
.admin-table td { vertical-align: middle; }

.money-col  {
    font-size: 13px;
    font-weight: 600;
    color: var(--admin-thanh-cong);
    white-space: nowrap;
}
.date-col   { font-size: 12px; color: var(--admin-chu-phu); }
.phone-col  { font-size: 12px; color: var(--admin-chu-chinh); font-family: monospace; letter-spacing: .02em; }

/* Action buttons */
.btn-view   {
    font-size: 12px;
    padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #EBF8FF;
    color: #2B6CB0;
    border: none;
    cursor: pointer;
    font-family: var(--font);
    transition: background .12s;
}
.btn-view:hover { background: #BEE3F8; }

.btn-lock {
    font-size: 12px;
    padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #FED7D7;
    color: #C53030;
    border: none;
    cursor: pointer;
    font-family: var(--font);
    transition: background .12s;
}
.btn-lock:hover { background: #FEB2B2; }

.btn-unlock {
    font-size: 12px;
    padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #C6F6D5;
    color: #276749;
    border: none;
    cursor: pointer;
    font-family: var(--font);
    transition: background .12s;
}
.btn-unlock:hover { background: #9AE6B4; }

/* ── Pagination ─────────────────────────────────────────────── */
.pagination-wrap {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-top: 14px;
    border-top: 1px solid var(--admin-vien);
    margin-top: 4px;
}
.paging-info { font-size: 12px; color: var(--admin-chu-phu); }
.paging-btns { display: flex; align-items: center; gap: 6px; }
.paging-btn {
    font-size: 12px;
    padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #fff;
    border: 1px solid var(--admin-vien);
    color: var(--admin-chu-chinh);
    cursor: pointer;
    font-family: var(--font);
    transition: background .12s;
}
.paging-btn:hover    { background: var(--admin-nen); }
.paging-btn.active   { background: #3182CE; color: #fff; border-color: #3182CE; }
.paging-btn:disabled { opacity: .4; cursor: default; }

/* ── Empty state ────────────────────────────────────────────── */
.empty-state {
    text-align: center;
    padding: 56px 0;
    color: var(--admin-chu-phu);
}
.empty-state .empty-icon { font-size: 40px; margin-bottom: 10px; }
.empty-state p { font-size: 13px; }

/* ── Alert ──────────────────────────────────────────────────── */
.alert-success {
    padding: 10px 14px;
    background: #C6F6D5;
    color: #276749;
    border-radius: var(--r-nut);
    font-size: 13px;
    margin-bottom: 16px;
    display: none;
}
.alert-info {
    padding: 10px 14px;
    background: #EBF8FF;
    color: #2B6CB0;
    border-radius: var(--r-nut);
    font-size: 13px;
    margin-bottom: 16px;
    display: none;
}

/* ══════════════════════════════════════════════════════════════
   MODAL XEM CHI TIẾT
══════════════════════════════════════════════════════════════ */
.modal-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,.45);
    z-index: 999;
    align-items: center;
    justify-content: center;
}
.modal-overlay.show { display: flex; }

.modal-box {
    background: var(--admin-card);
    border-radius: 12px;
    width: 480px;
    max-width: 94vw;
    box-shadow: 0 20px 60px rgba(0,0,0,.2);
    overflow: hidden;
    animation: modalIn .18s ease;
}
@keyframes modalIn {
    from { opacity:0; transform:translateY(-16px) scale(.97); }
    to   { opacity:1; transform:translateY(0) scale(1); }
}

.modal-header {
    padding: 18px 20px 14px;
    border-bottom: 1px solid var(--admin-vien);
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.modal-header h3 { font-size: 15px; font-weight: 600; }

.modal-close {
    width: 28px; height: 28px;
    border-radius: 6px;
    border: none;
    background: var(--admin-nen);
    font-size: 16px;
    cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    color: var(--admin-chu-phu);
    transition: background .12s;
}
.modal-close:hover { background: #FED7D7; color: #C53030; }

.modal-body { padding: 20px; }

/* Profile card bên trong modal */
.profile-header {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 20px;
    padding-bottom: 16px;
    border-bottom: 1px solid var(--admin-vien);
}
.profile-av {
    width: 56px; height: 56px;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; font-weight: 700;
    flex-shrink: 0;
    box-shadow: 0 2px 8px rgba(0,0,0,.12);
}
.profile-name  { font-size: 16px; font-weight: 700; color: var(--admin-chu-chinh); }
.profile-email { font-size: 12px; color: var(--admin-chu-phu); margin-top: 2px; }

.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-bottom: 16px;
}
.info-item label {
    display: block;
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .06em;
    color: var(--admin-chu-phu);
    margin-bottom: 3px;
}
.info-item .info-val {
    font-size: 13px;
    font-weight: 500;
    color: var(--admin-chu-chinh);
}

/* Donation history inside modal */
.modal-section-title {
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .06em;
    color: var(--admin-chu-phu);
    margin-bottom: 10px;
}
.donation-mini-list { display: flex; flex-direction: column; gap: 8px; }
.donation-mini-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 12px;
    padding: 8px 10px;
    background: var(--admin-nen);
    border-radius: var(--r-nut);
}
.dm-name { color: var(--admin-chu-chinh); font-weight: 500; flex: 1; margin-right: 8px; }
.dm-amount { color: var(--admin-thanh-cong); font-weight: 600; white-space: nowrap; }
.dm-date { color: var(--admin-chu-phu); margin-left: 8px; white-space: nowrap; }

.modal-footer {
    padding: 14px 20px;
    border-top: 1px solid var(--admin-vien);
    display: flex;
    gap: 8px;
    justify-content: flex-end;
}
.btn-modal-lock {
    height: 32px; padding: 0 14px;
    border-radius: var(--r-nut);
    background: #FED7D7; color: #C53030;
    border: none; font-size: 12px;
    font-family: var(--font); font-weight: 500; cursor: pointer;
}
.btn-modal-lock:hover { background: #FEB2B2; }
.btn-modal-unlock {
    height: 32px; padding: 0 14px;
    border-radius: var(--r-nut);
    background: #C6F6D5; color: #276749;
    border: none; font-size: 12px;
    font-family: var(--font); font-weight: 500; cursor: pointer;
}
.btn-modal-unlock:hover { background: #9AE6B4; }
.btn-modal-close {
    height: 32px; padding: 0 14px;
    border-radius: var(--r-nut);
    background: var(--admin-nen); color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien);
    font-size: 12px; font-family: var(--font); cursor: pointer;
}
.btn-modal-close:hover { background: #EDF2F7; color: var(--admin-chu-chinh); }

/* no donations placeholder */
.no-donations {
    text-align: center;
    padding: 16px 0;
    font-size: 12px;
    color: var(--admin-chu-phu);
}
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Người dùng</h1>
    <p>Danh sách tài khoản đã đăng ký trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Alerts --%>
    <div id="alertSuccess" class="alert-success"></div>
    <div id="alertInfo"    class="alert-info"></div>

    <%-- Stat Cards --%>
    <div class="user-stats-row" id="statsRow"></div>

    <%-- Filter Bar --%>
    <div class="admin-card" style="margin-bottom:16px;padding:14px 20px;">
        <div class="filter-bar">
            <input type="text" id="inputSearch" class="input-search"
                   placeholder="Tìm theo tên hoặc email..." />
            <select id="selTrangThai" class="select-filter">
                <option value="">Tất cả trạng thái</option>
                <option value="1">Hoạt động</option>
                <option value="0">Bị khóa</option>
            </select>
            <select id="selVaiTro" class="select-filter">
                <option value="">Tất cả vai trò</option>
                <option value="1">Admin</option>
                <option value="0">Người dùng</option>
            </select>
            <button class="btn-primary-sm" onclick="applyFilter()">Tìm kiếm</button>
            <button class="btn-outline-sm" onclick="resetFilter()">Đặt lại</button>
        </div>
    </div>

    <%-- Table --%>
    <div class="admin-card">
        <div class="section-header">
            <span class="section-title">Danh sách người dùng</span>
            <span class="section-count" id="countLabel"></span>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width:28%">Người dùng</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Ngày đăng ký</th>
                    <th>Tổng góp</th>
                    <th>Trạng thái</th>
                    <th style="text-align:center">Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" class="empty-state" style="display:none">
            <div class="empty-icon">🔍</div>
            <p>Không tìm thấy người dùng nào phù hợp.</p>
        </div>

        <div class="pagination-wrap" id="pagingWrap">
            <span class="paging-info" id="pagingInfo"></span>
            <div class="paging-btns" id="pagingBtns"></div>
        </div>
    </div>

    <%-- Modal xem chi tiết --%>
    <div class="modal-overlay" id="modalOverlay" onclick="closeModalOutside(event)">
        <div class="modal-box" id="modalBox">

            <div class="modal-header">
                <h3>Chi tiết người dùng</h3>
                <button class="modal-close" onclick="closeModal()" title="Đóng">✕</button>
            </div>

            <div class="modal-body">

                <div class="profile-header">
                    <div class="profile-av" id="modalAv"></div>
                    <div>
                        <div class="profile-name"  id="modalName"></div>
                        <div class="profile-email" id="modalEmail"></div>
                        <div style="margin-top:4px" id="modalRoleBadge"></div>
                    </div>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <label>Mã người dùng</label>
                        <span class="info-val" id="modalMa"></span>
                    </div>
                    <div class="info-item">
                        <label>Số điện thoại</label>
                        <span class="info-val" id="modalPhone"></span>
                    </div>
                    <div class="info-item">
                        <label>Ngày đăng ký</label>
                        <span class="info-val" id="modalNgay"></span>
                    </div>
                    <div class="info-item">
                        <label>Trạng thái</label>
                        <span class="info-val" id="modalStatus"></span>
                    </div>
                    <div class="info-item">
                        <label>Tổng quyên góp</label>
                        <span class="info-val" id="modalTongGop" style="color:var(--admin-thanh-cong)"></span>
                    </div>
                    <div class="info-item">
                        <label>Số lần góp</label>
                        <span class="info-val" id="modalSoLan"></span>
                    </div>
                </div>

                <div class="modal-section-title">Lịch sử quyên góp gần đây</div>
                <div id="modalDonations"></div>

            </div>

            <div class="modal-footer">
                <div id="modalActionBtn"></div>
                <button class="btn-modal-close" onclick="closeModal()">Đóng</button>
            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ══════════════════════════════════════════════════════════════
   MOCK DATA — khớp với SampleData.sql
══════════════════════════════════════════════════════════════ */
var MOCK_USERS = [
    {
        id: 1,
        hoTen:      'Admin',
        email:      'admin@thiennguyen.vn',
        sdt:        '0901000001',
        vaiTro:     1,         // 1 = Admin
        trangThai:  1,         // 1 = Hoạt động
        ngayTao:    '17/03/2026',
        anhDaiDien: null,
        tongGop:    0,
        soLanGop:   0,
        donationHistory: []
    },
    {
        id: 2,
        hoTen:     'User',
        email:     'user@thiennguyen.vn',
        sdt:       '0901000002',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '17/03/2026',
        anhDaiDien: null,
        tongGop:   1300000,
        soLanGop:  3,
        donationHistory: [
            { chiendich: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', soTien: 500000, ngay: '02/03/2026', trangThai: 1 },
            { chiendich: 'Học bổng "Thắp sáng ước mơ"',             soTien: 500000, ngay: '05/02/2026', trangThai: 1 },
            { chiendich: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', soTien: 300000, ngay: '24/01/2026', trangThai: 2 }
        ]
    },
    {
        id: 3,
        hoTen:     'Trần Thị Bình',
        email:     'binh.tran@gmail.com',
        sdt:       '0901000003',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '10/01/2026',
        anhDaiDien: null,
        tongGop:   1200000,
        soLanGop:  2,
        donationHistory: [
            { chiendich: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', soTien: 200000,  ngay: '03/03/2026', trangThai: 1 },
            { chiendich: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', soTien: 1000000, ngay: '20/01/2026', trangThai: 1 }
        ]
    },
    {
        id: 4,
        hoTen:     'Lê Hoàng Minh',
        email:     'minh.le@gmail.com',
        sdt:       '0901000004',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '15/01/2026',
        anhDaiDien: null,
        tongGop:   5500000,
        soLanGop:  2,
        donationHistory: [
            { chiendich: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', soTien: 5000000, ngay: '05/03/2026', trangThai: 1 },
            { chiendich: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', soTien: 500000,  ngay: '22/01/2026', trangThai: 1 }
        ]
    },
    {
        id: 5,
        hoTen:     'Phạm Thị Thu Hương',
        email:     'huong.pham@gmail.com',
        sdt:       '0901000005',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '20/01/2026',
        anhDaiDien: null,
        tongGop:   800000,
        soLanGop:  2,
        donationHistory: [
            { chiendich: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', soTien: 300000, ngay: '06/03/2026', trangThai: 1 },
            { chiendich: 'Khám chữa bệnh miễn phí cho người cao tuổi', soTien: 500000, ngay: '16/03/2026', trangThai: 1 }
        ]
    },
    {
        id: 6,
        hoTen:     'Vũ Đức Thắng',
        email:     'thang.vu@gmail.com',
        sdt:       '0901000006',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '01/02/2026',
        anhDaiDien: null,
        tongGop:   200000,
        soLanGop:  1,
        donationHistory: [
            { chiendich: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', soTien: 200000, ngay: '16/03/2026', trangThai: 0 }
        ]
    },
    {
        id: 7,
        hoTen:     'Đỗ Thị Lan',
        email:     'lan.do@gmail.com',
        sdt:       '0901000007',
        vaiTro:    0,
        trangThai: 1,
        ngayTao:   '10/02/2026',
        anhDaiDien: null,
        tongGop:   2200000,
        soLanGop:  2,
        donationHistory: [
            { chiendich: 'Học bổng "Thắp sáng ước mơ"',              soTien: 2000000, ngay: '10/02/2026', trangThai: 1 },
            { chiendich: 'Khám chữa bệnh miễn phí cho người cao tuổi', soTien: 200000,  ngay: '17/03/2026', trangThai: 0 }
        ]
    },
    {
        id: 8,
        hoTen:     'Hoàng Văn Tú',
        email:     'tu.hoang@gmail.com',
        sdt:       '0901000008',
        vaiTro:    0,
        trangThai: 0,          // bị khóa
        ngayTao:   '15/02/2026',
        anhDaiDien: null,
        tongGop:   0,
        soLanGop:  0,
        donationHistory: []
    }
];

/* ── Màu avatar tự động ───────────────────────────────────── */
var AV_COLORS = [
    { bg:'#EBF8FF', color:'#2B6CB0' },
    { bg:'#E9D8FD', color:'#6B46C1' },
    { bg:'#C6F6D5', color:'#276749' },
    { bg:'#FEEBC8', color:'#C05621' },
    { bg:'#FED7D7', color:'#C53030' },
    { bg:'#E6FFFA', color:'#285E61' },
    { bg:'#FEFCBF', color:'#744210' },
    { bg:'#FEE2E2', color:'#991B1B' }
];

function avColor(id) { return AV_COLORS[(id - 1) % AV_COLORS.length]; }

function getInitials(name) {
    var parts = name.trim().split(' ');
    if (parts.length === 1) return parts[0][0].toUpperCase();
    return (parts[parts.length - 2][0] + parts[parts.length - 1][0]).toUpperCase();
}

/* ── Helpers ────────────────────────────────────────────────── */
function fmtMoney(n) {
    if (!n) return '—';
    if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ';
    if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ';
    return n.toLocaleString('vi-VN') + ' đ';
}

function statusBadge(ts) {
    return ts === 1
        ? '<span class="badge-admin badge-thanh-cong">Hoạt động</span>'
        : '<span class="badge-admin badge-tu-choi">Bị khóa</span>';
}

function donationStatusBadge(ts) {
    var map = { 0:'badge-cho-duyet', 1:'badge-thanh-cong', 2:'badge-tu-choi' };
    var label = { 0:'Chờ duyệt', 1:'Đã duyệt', 2:'Từ chối' };
    return '<span class="badge-admin ' + (map[ts]||'') + '">' + (label[ts]||'') + '</span>';
}

/* ══════════════════════════════════════════════════════════════
   STATS SUMMARY
══════════════════════════════════════════════════════════════ */
(function renderStats() {
    var total    = MOCK_USERS.length;
    var active   = MOCK_USERS.filter(function(u){ return u.trangThai === 1 && u.vaiTro === 0; }).length;
    var locked   = MOCK_USERS.filter(function(u){ return u.trangThai === 0; }).length;
    var admins   = MOCK_USERS.filter(function(u){ return u.vaiTro === 1; }).length;
    var tongGop  = MOCK_USERS.reduce(function(s,u){ return s + u.tongGop; }, 0);

    var stats = [
        { icon:'👥', label:'Tổng tài khoản',    value: total,          bg:'var(--stat-xanh-nen)', color:'var(--stat-xanh-vien)' },
        { icon:'✅', label:'Người dùng hoạt động', value: active,       bg:'#C6F6D5',              color:'var(--admin-thanh-cong)' },
        { icon:'🔒', label:'Tài khoản bị khóa', value: locked,         bg:'#FED7D7',              color:'var(--admin-loi)' },
        { icon:'💰', label:'Tổng đã quyên góp', value: fmtMoney(tongGop), bg:'var(--stat-cam-nen)', color:'var(--stat-cam-vien)' }
    ];

    var html = '';
    stats.forEach(function(s) {
        html +=
            '<div class="user-stat-card">' +
            '<div class="user-stat-icon" style="background:' + s.bg + ';color:' + s.color + '">' + s.icon + '</div>' +
            '<div class="user-stat-info">' +
            '<strong style="color:' + s.color + '">' + s.value + '</strong>' +
            '<span>' + s.label + '</span>' +
            '</div>' +
            '</div>';
    });
    document.getElementById('statsRow').innerHTML = html;
})();

/* ══════════════════════════════════════════════════════════════
   TABLE RENDER + FILTER + PAGINATION
══════════════════════════════════════════════════════════════ */
var PAGE_SIZE    = 7;
var currentPage  = 1;
var filteredData = MOCK_USERS.slice();

function renderTable() {
    var tbody      = document.getElementById('tableBody');
    var emptyMsg   = document.getElementById('emptyMsg');
    var pagingWrap = document.getElementById('pagingWrap');

    if (filteredData.length === 0) {
        tbody.innerHTML          = '';
        emptyMsg.style.display   = 'block';
        pagingWrap.style.display = 'none';
        document.getElementById('countLabel').textContent = '0 người dùng';
        return;
    }

    emptyMsg.style.display   = 'none';
    pagingWrap.style.display = 'flex';

    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (currentPage > totalPages) currentPage = totalPages;

    var from = (currentPage - 1) * PAGE_SIZE;
    var to   = Math.min(from + PAGE_SIZE, filteredData.length);
    var page = filteredData.slice(from, to);

    document.getElementById('countLabel').textContent =
        'Hiển thị ' + (from + 1) + '–' + to + ' / ' + filteredData.length + ' người dùng';
    document.getElementById('pagingInfo').textContent =
        'Trang ' + currentPage + ' / ' + totalPages;

    var html = '';
    page.forEach(function(u) {
        var av      = avColor(u.id);
        var initials = getInitials(u.hoTen);
        var roleLbl = u.vaiTro === 1
            ? '<span class="user-role-badge role-admin">⚙ Admin</span>'
            : '<span class="user-role-badge role-user">👤 Thành viên</span>';

        var lockBtn = u.trangThai === 1
            ? '<button class="btn-lock"   onclick="doLockUnlock(' + u.id + ',0)">🔒 Khóa</button>'
            : '<button class="btn-unlock" onclick="doLockUnlock(' + u.id + ',1)">🔓 Mở khóa</button>';

        // Disable lock/unlock for admin #1
        if (u.vaiTro === 1) lockBtn = '<span style="font-size:11px;color:var(--admin-chu-phu)">—</span>';

        html +=
            '<tr id="row-' + u.id + '">' +
            '<td>' +
                '<div class="user-cell">' +
                    '<div class="user-av" style="background:' + av.bg + ';color:' + av.color + '">' + initials + '</div>' +
                    '<div>' +
                        '<div class="user-fullname">' + u.hoTen + '</div>' +
                        roleLbl +
                    '</div>' +
                '</div>' +
            '</td>' +
            '<td style="font-size:12px;">' + u.email + '</td>' +
            '<td class="phone-col">' + (u.sdt || '—') + '</td>' +
            '<td class="date-col">' + u.ngayTao + '</td>' +
            '<td class="money-col">' + fmtMoney(u.tongGop) + '</td>' +
            '<td>' + statusBadge(u.trangThai) + '</td>' +
            '<td style="text-align:center;white-space:nowrap">' +
                '<button class="btn-view" onclick="openModal(' + u.id + ')" style="margin-right:4px">👁 Xem</button>' +
                lockBtn +
            '</td>' +
            '</tr>';
    });

    tbody.innerHTML = html;
    renderPaging(totalPages);
}

function renderPaging(totalPages) {
    var btns  = document.getElementById('pagingBtns');
    var start = Math.max(1, currentPage - 2);
    var end   = Math.min(totalPages, start + 4);
    start     = Math.max(1, end - 4);

    var html = '<button class="paging-btn" onclick="changePage(' + (currentPage - 1) + ')"' +
               (currentPage <= 1 ? ' disabled' : '') + '>← Trước</button>';
    for (var p = start; p <= end; p++) {
        html += '<button class="paging-btn' + (p === currentPage ? ' active' : '') +
                '" onclick="changePage(' + p + ')">' + p + '</button>';
    }
    html += '<button class="paging-btn" onclick="changePage(' + (currentPage + 1) + ')"' +
            (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp →</button>';
    btns.innerHTML = html;
}

function changePage(p) {
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (p < 1 || p > totalPages) return;
    currentPage = p;
    renderTable();
}

/* ── Filter ─────────────────────────────────────────────────── */
function applyFilter() {
    var q  = document.getElementById('inputSearch').value.trim().toLowerCase();
    var tt = document.getElementById('selTrangThai').value;
    var vt = document.getElementById('selVaiTro').value;

    filteredData = MOCK_USERS.filter(function(u) {
        var matchQ  = !q  || u.hoTen.toLowerCase().includes(q) || u.email.toLowerCase().includes(q);
        var matchTT = tt === '' || String(u.trangThai) === tt;
        var matchVT = vt === '' || String(u.vaiTro)    === vt;
        return matchQ && matchTT && matchVT;
    });

    currentPage = 1;
    renderTable();
}

function resetFilter() {
    document.getElementById('inputSearch').value   = '';
    document.getElementById('selTrangThai').value  = '';
    document.getElementById('selVaiTro').value     = '';
    filteredData = MOCK_USERS.slice();
    currentPage  = 1;
    renderTable();
}

document.getElementById('inputSearch').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') applyFilter();
});

/* ══════════════════════════════════════════════════════════════
   LOCK / UNLOCK
══════════════════════════════════════════════════════════════ */
function doLockUnlock(userId, newStatus) {
    var user = MOCK_USERS.find(function(u){ return u.id === userId; });
    if (!user) return;

    var action = newStatus === 0 ? 'khóa' : 'mở khóa';
    if (!confirm('Bạn có chắc muốn ' + action + ' tài khoản của "' + user.hoTen + '"?')) return;

    user.trangThai = newStatus;
    renderTable();

    showAlert('alertSuccess',
        (newStatus === 0 ? '🔒' : '🔓') +
        ' Đã ' + action + ' tài khoản "' + user.hoTen + '" thành công.');

    // Nếu modal đang mở cho user này → cập nhật
    if (currentModalId === userId) openModal(userId);
}

/* ══════════════════════════════════════════════════════════════
   MODAL CHI TIẾT
══════════════════════════════════════════════════════════════ */
var currentModalId = null;

function openModal(userId) {
    var u = MOCK_USERS.find(function(x){ return x.id === userId; });
    if (!u) return;
    currentModalId = userId;

    var av = avColor(u.id);
    var initials = getInitials(u.hoTen);

    // Avatar
    var avEl = document.getElementById('modalAv');
    avEl.textContent         = initials;
    avEl.style.background    = av.bg;
    avEl.style.color         = av.color;

    document.getElementById('modalName').textContent  = u.hoTen;
    document.getElementById('modalEmail').textContent = u.email;

    document.getElementById('modalRoleBadge').innerHTML = u.vaiTro === 1
        ? '<span class="user-role-badge role-admin" style="font-size:11px">⚙ Admin</span>'
        : '<span class="user-role-badge role-user"  style="font-size:11px">👤 Thành viên</span>';

    document.getElementById('modalMa').textContent     = '#' + u.id;
    document.getElementById('modalPhone').textContent  = u.sdt || '—';
    document.getElementById('modalNgay').textContent   = u.ngayTao;
    document.getElementById('modalStatus').innerHTML   = statusBadge(u.trangThai);
    document.getElementById('modalTongGop').textContent = fmtMoney(u.tongGop);
    document.getElementById('modalSoLan').textContent  = u.soLanGop + ' lần';

    // Donation history
    var donEl = document.getElementById('modalDonations');
    if (!u.donationHistory || u.donationHistory.length === 0) {
        donEl.innerHTML = '<div class="no-donations">📭 Chưa có giao dịch nào.</div>';
    } else {
        var html = '<div class="donation-mini-list">';
        u.donationHistory.slice(0, 5).forEach(function(d) {
            html +=
                '<div class="donation-mini-item">' +
                '<span class="dm-name">' + d.chiendich + '</span>' +
                donationStatusBadge(d.trangThai) +
                '<span class="dm-amount" style="margin-left:8px">' + fmtMoney(d.soTien) + '</span>' +
                '<span class="dm-date">' + d.ngay + '</span>' +
                '</div>';
        });
        html += '</div>';
        donEl.innerHTML = html;
    }

    // Footer action button
    var footerBtn = document.getElementById('modalActionBtn');
    if (u.vaiTro === 1) {
        footerBtn.innerHTML = '';
    } else if (u.trangThai === 1) {
        footerBtn.innerHTML =
            '<button class="btn-modal-lock" onclick="doLockUnlock(' + u.id + ',0)">🔒 Khóa tài khoản</button>';
    } else {
        footerBtn.innerHTML =
            '<button class="btn-modal-unlock" onclick="doLockUnlock(' + u.id + ',1)">🔓 Mở khóa tài khoản</button>';
    }

    document.getElementById('modalOverlay').classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('modalOverlay').classList.remove('show');
    document.body.style.overflow = '';
    currentModalId = null;
}

function closeModalOutside(e) {
    if (e.target === document.getElementById('modalOverlay')) closeModal();
}

// ESC key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeModal();
});

/* ── Alerts ─────────────────────────────────────────────────── */
function showAlert(id, msg) {
    var el = document.getElementById(id);
    el.textContent   = msg;
    el.style.display = 'block';
    setTimeout(function() { el.style.display = 'none'; }, 3500);
}

/* ── Init ────────────────────────────────────────────────────── */
renderTable();
</script>
</asp:Content>
