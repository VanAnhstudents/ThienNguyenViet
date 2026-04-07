<%@ Page Title="Quản lý Người dùng" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyNguoiDung.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ── QuanLyNguoiDung — Đồng bộ đẹp như QuanLyQuyenGop ── */
.user-stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 20px; }
.user-stat-card { background: var(--card); border: 1px solid var(--border); border-radius: var(--r-card); padding: 20px 18px; text-align: center; }
.user-stat-card strong { display: block; font-size: 24px; font-weight: 700; line-height: 1.1; }
.user-stat-card span { font-size: 11px; color: var(--txt-sub); text-transform: uppercase; }

.admin-card { background: var(--card); border: 1px solid var(--border); border-radius: var(--r-card); padding: 18px 20px; margin-bottom: 18px; }
.filter-bar { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
.input-search { height: 36px; padding: 0 12px; border: 1px solid var(--border); border-radius: var(--r); font-size: 13px; background: #fff; }
.btn-grp-item { height: 36px; padding: 0 13px; border: 1px solid var(--border); border-radius: var(--r); background: var(--bg); font-size: 12px; font-weight: 500; color: var(--txt-sub); cursor: pointer; }
.btn-grp-item.active { background: var(--accent); color: #fff; border-color: var(--accent); font-weight: 600; }

.admin-table { width: 100%; border-collapse: collapse; font-size: 13px; }
.admin-table thead th { background: var(--thead); padding: 10px 12px; font-size: 11px; font-weight: 600; color: var(--txt-sub); text-transform: uppercase; }
.admin-table tbody td { padding: 10px 12px; border-bottom: 1px solid var(--border); vertical-align: middle; }
.admin-table tbody tr:hover { background: var(--accent-light); }

.user-cell { display: flex; align-items: center; gap: 10px; }
.user-av { width: 34px; height: 34px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: 700; flex-shrink: 0; }
.user-fullname { font-size: 13px; font-weight: 500; }
.user-role-badge { font-size: 10px; padding: 2px 8px; border-radius: 4px; }

.btn-view, .btn-lock, .btn-unlock { font-size: 12px; padding: 5px 12px; border-radius: var(--r); border: none; cursor: pointer; font-family: var(--font); }
.btn-view { background: var(--accent-light); color: var(--accent); }
.btn-lock { background: var(--err-bg); color: var(--err-txt); }
.btn-unlock { background: var(--ok-bg); color: var(--ok-txt); }

#toastWrap .toast-item { background: var(--card); border: 1px solid var(--border); border-left: 4px solid var(--accent); border-radius: var(--r-card); }
.modal-box { background: var(--card); border: 1px solid var(--border); border-radius: var(--r-card); box-shadow: 0 8px 32px rgba(0,0,0,.15); }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Người dùng</h1>
    <p>Danh sách tài khoản đã đăng ký trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="toastWrap"></div>

<%-- Stat Cards --%>
<div class="user-stats-row" id="statsRow">
    <div class="user-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="user-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="user-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="user-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
</div>

<%-- Filter Bar --%>
<div class="admin-card" style="margin-bottom:16px;padding:14px 20px;">
    <div class="filter-bar">
        <input type="text" id="inputSearch" class="input-search" placeholder="Tìm theo tên hoặc email..." />

        <span style="font-size:12px;font-weight:600;color:var(--admin-chu-phu);white-space:nowrap">Trạng thái:</span>
        <div class="btn-group" id="ttBtnGroup">
            <button type="button" class="btn-grp-item active" data-val="" onclick="setFilter('tt',this,'')">Tất cả</button>
            <button type="button" class="btn-grp-item" data-val="1" onclick="setFilter('tt',this,'1')">Hoạt động</button>
            <button type="button" class="btn-grp-item" data-val="0" onclick="setFilter('tt',this,'0')">Bị khóa</button>
        </div>

        <span style="font-size:12px;font-weight:600;color:var(--admin-chu-phu);white-space:nowrap">Vai trò:</span>
        <div class="btn-group" id="vtBtnGroup">
            <button type="button" class="btn-grp-item active" data-val="" onclick="setFilter('vt',this,'')">Tất cả</button>
            <button type="button" class="btn-grp-item" data-val="1" onclick="setFilter('vt',this,'1')">Admin</button>
            <button type="button" class="btn-grp-item" data-val="0" onclick="setFilter('vt',this,'0')">Người dùng</button>
        </div>

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
        <tbody id="tableBody">
            <tr><td colspan="7" class="tbl-loading">Đang tải dữ liệu...</td></tr>
        </tbody>
    </table>

    <div id="emptyMsg" class="empty-state" style="display:none">
        <p>Không tìm thấy người dùng nào phù hợp.</p>
    </div>

    <div class="pagination-wrap" id="pagingWrap" style="display:none">
        <div class="paging-btns" id="pagingBtns"></div>
        <span class="paging-info" id="pagingInfo"></span>
    </div>
</div>

<%-- Modal xem chi tiết --%>
<div class="modal-overlay" id="modalOverlay" onclick="closeModalOutside(event)">
    <div class="modal-box" id="modalBox">
        <div class="modal-header">
            <h3>Chi tiết người dùng</h3>
            <button class="modal-close" onclick="closeModal()">✕</button>
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
                <div class="info-item"><label>Mã người dùng</label><span class="info-val" id="modalMa"></span></div>
                <div class="info-item"><label>Số điện thoại</label><span class="info-val" id="modalPhone"></span></div>
                <div class="info-item"><label>Ngày đăng ký</label><span class="info-val" id="modalNgay"></span></div>
                <div class="info-item"><label>Trạng thái</label><span class="info-val" id="modalStatus"></span></div>
                <div class="info-item"><label>Tổng quyên góp</label><span class="info-val" id="modalTongGop" style="color:var(--admin-thanh-cong)"></span></div>
                <div class="info-item"><label>Số lần góp</label><span class="info-val" id="modalSoLan"></span></div>
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
    (function () {
        'use strict';

        /* ── State ──────────────────────────────────────────────────── */
        var currentPage = 1;
        var PAGE_SIZE = 10;
        var filterTT = '';   // trạng thái
        var filterVT = '';   // vai trò
        var searchTimeout = null;
        var currentModalId = null;

        /* ── Màu avatar ─────────────────────────────────────────────── */
        var AV_COLORS = [
            { bg: '#EBF8FF', color: '#2B6CB0' }, { bg: '#E9D8FD', color: '#6B46C1' },
            { bg: '#C6F6D5', color: '#276749' }, { bg: '#FEEBC8', color: '#C05621' },
            { bg: '#FED7D7', color: '#C53030' }, { bg: '#E6FFFA', color: '#285E61' },
            { bg: '#FEFCBF', color: '#744210' }, { bg: '#FEE2E2', color: '#991B1B' }
        ];
        function avColor(id) { return AV_COLORS[((id || 1) - 1) % AV_COLORS.length]; }
        function getInitials(name) {
            var p = name.trim().split(' ');
            if (p.length === 1) return p[0][0].toUpperCase();
            return (p[p.length - 2][0] + p[p.length - 1][0]).toUpperCase();
        }

        /* ── Helpers ────────────────────────────────────────────────── */
        function fmtMoney(n) {
            if (!n || n === 0) return '—';
            if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ';
            if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ';
            return parseInt(n).toLocaleString('vi-VN') + ' đ';
        }
        function statusBadge(ts) {
            return ts == 1
                ? '<span class="badge-admin badge-thanh-cong">Hoạt động</span>'
                : '<span class="badge-admin badge-tu-choi">Bị khóa</span>';
        }
        function donationStatusBadge(ts) {
            var map = { 0: 'badge-cho-duyet', 1: 'badge-thanh-cong', 2: 'badge-tu-choi' };
            var label = { 0: 'Chờ duyệt', 1: 'Đã duyệt', 2: 'Từ chối' };
            return '<span class="badge-admin ' + (map[ts] || '') + '">' + (label[ts] || '') + '</span>';
        }

        /* ── Toast ──────────────────────────────────────────────────── */
        function showToast(msg, type) {
            var wrap = document.getElementById('toastWrap');
            var t = document.createElement('div');
            t.className = 'toast-item toast-' + (type || 'ok');
            t.innerHTML = '<span class="t-msg">' + msg + '</span><span class="t-close" onclick="this.parentElement.remove()">×</span>';
            wrap.appendChild(t);
            setTimeout(function () { t.style.transition = 'opacity .3s'; t.style.opacity = '0'; setTimeout(function () { t.remove(); }, 350); }, 4000);
        }

        /* ── Filter button toggle ────────────────────────────────────── */
        window.setFilter = function (type, btn, val) {
            var groupId = type === 'tt' ? 'ttBtnGroup' : 'vtBtnGroup';
            document.querySelectorAll('#' + groupId + ' .btn-grp-item').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            if (type === 'tt') filterTT = val;
            else filterVT = val;
            currentPage = 1;
            loadData();
        };

        window.resetFilter = function () {
            document.getElementById('inputSearch').value = '';
            filterTT = ''; filterVT = '';
            document.querySelectorAll('#ttBtnGroup .btn-grp-item').forEach(function (b) { b.classList.remove('active'); if (b.dataset.val === '') b.classList.add('active'); });
            document.querySelectorAll('#vtBtnGroup .btn-grp-item').forEach(function (b) { b.classList.remove('active'); if (b.dataset.val === '') b.classList.add('active'); });
            currentPage = 1;
            loadData();
        };

        /* ── Load Stats ──────────────────────────────────────────────── */
        function loadStats() {
            fetch(location.pathname + '?__ajax=true&action=stats')
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var d = j.data;
                    var statColors = [
                        { color: 'var(--stat-xanh-vien)' },
                        { color: 'var(--admin-thanh-cong)' },
                        { color: 'var(--admin-loi)' },
                        { color: 'var(--stat-cam-vien)' }
                    ];
                    var cards = [
                        { label: 'Tổng tài khoản', value: d.tongTaiKhoan, color: statColors[0].color },
                        { label: 'Người dùng hoạt động', value: d.nguoiDungHoatDong, color: statColors[1].color },
                        { label: 'Tài khoản bị khóa', value: d.taiKhoanKhoa, color: statColors[2].color },
                        { label: 'Tổng đã quyên góp', value: fmtMoney(d.tongQuyenGop), color: statColors[3].color }
                    ];
                    var html = '';
                    cards.forEach(function (c) {
                        html += '<div class="user-stat-card">'
                            + '<strong style="color:' + c.color + '">' + c.value + '</strong>'
                            + '<span>' + c.label + '</span>'
                            + '</div>';
                    });
                    document.getElementById('statsRow').innerHTML = html;
                })
                .catch(function () { });
        }

        /* ── Load Data ───────────────────────────────────────────────── */
        function loadData() {
            var q = document.getElementById('inputSearch').value.trim();
            var params = new URLSearchParams({
                __ajax: 'true', action: 'list',
                tuKhoa: q, trangThai: filterTT, vaiTro: filterVT,
                trang: currentPage, soDong: PAGE_SIZE
            });

            fetch(location.pathname + '?' + params)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) renderTable(j.data, j.total);
                })
                .catch(function (e) { console.error(e); });
        }

        /* ── Render Table ────────────────────────────────────────────── */
        function renderTable(data, total) {
            var tbody = document.getElementById('tableBody');
            var emptyMsg = document.getElementById('emptyMsg');
            var pagingWrap = document.getElementById('pagingWrap');

            if (!data || !data.length) {
                tbody.innerHTML = '';
                emptyMsg.style.display = 'block';
                pagingWrap.style.display = 'none';
                document.getElementById('countLabel').textContent = '0 người dùng';
                return;
            }
            emptyMsg.style.display = 'none';
            pagingWrap.style.display = 'flex';

            var from = (currentPage - 1) * PAGE_SIZE + 1;
            var to = Math.min(currentPage * PAGE_SIZE, total);
            document.getElementById('countLabel').textContent =
                'Hiển thị ' + from + '–' + to + ' / ' + total + ' người dùng';

            var html = '';
            data.forEach(function (u) {
                var av = avColor(u.MaNguoiDung);
                var initials = getInitials(u.HoTen);
                var roleLbl = u.VaiTro === 1
                    ? '<span class="user-role-badge role-admin">Admin</span>'
                    : '<span class="user-role-badge role-user">Thành viên</span>';
                var lockBtn = u.VaiTro === 1
                    ? '<span style="font-size:11px;color:var(--admin-chu-phu)">—</span>'
                    : (u.TrangThai === 1
                        ? '<button class="btn-lock"   onclick="doLockUnlock(' + u.MaNguoiDung + ',0)">Khóa</button>'
                        : '<button class="btn-unlock" onclick="doLockUnlock(' + u.MaNguoiDung + ',1)">Mở khóa</button>');

                html += '<tr id="row-' + u.MaNguoiDung + '">'
                    + '<td><div class="user-cell">'
                    + '<div class="user-av" style="background:' + av.bg + ';color:' + av.color + '">' + initials + '</div>'
                    + '<div><div class="user-fullname">' + u.HoTen + '</div>' + roleLbl + '</div>'
                    + '</div></td>'
                    + '<td style="font-size:12px">' + u.Email + '</td>'
                    + '<td class="phone-col">' + (u.SoDienThoai || '—') + '</td>'
                    + '<td class="date-col">' + u.NgayTao + '</td>'
                    + '<td class="money-col">' + fmtMoney(u.TongGop) + '</td>'
                    + '<td>' + statusBadge(u.TrangThai) + '</td>'
                    + '<td style="text-align:center;white-space:nowrap">'
                    + '<button class="btn-view" onclick="openModal(' + u.MaNguoiDung + ')" style="margin-right:4px">Xem</button>'
                    + lockBtn
                    + '</td>'
                    + '</tr>';
            });
            tbody.innerHTML = html;
            renderPaging(Math.ceil(total / PAGE_SIZE));
        }

        /* ── Render Pagination ───────────────────────────────────────── */
        function renderPaging(totalPages) {
            var info = document.getElementById('pagingInfo');
            var btns = document.getElementById('pagingBtns');
            info.textContent = 'Trang ' + currentPage + ' / ' + totalPages;
            btns.innerHTML = '';

            var prev = document.createElement('button');
            prev.className = 'paging-btn'; prev.textContent = 'Trước';
            prev.disabled = currentPage <= 1;
            prev.onclick = function () { goToPage(currentPage - 1); };
            btns.appendChild(prev);

            var start = Math.max(1, currentPage - 2);
            var end = Math.min(totalPages, start + 4);
            start = Math.max(1, end - 4);
            for (var p = start; p <= end; p++) {
                (function (pg) {
                    var b = document.createElement('button');
                    b.className = 'paging-btn' + (pg === currentPage ? ' active' : '');
                    b.textContent = pg;
                    b.onclick = function () { goToPage(pg); };
                    btns.appendChild(b);
                })(p);
            }

            var next = document.createElement('button');
            next.className = 'paging-btn'; next.textContent = 'Tiếp';
            next.disabled = currentPage >= totalPages;
            next.onclick = function () { goToPage(currentPage + 1); };
            btns.appendChild(next);
        }

        function goToPage(p) { currentPage = p; loadData(); }

        /* ── Lock / Unlock ───────────────────────────────────────────── */
        window.doLockUnlock = function (userId, newStatus) {
            var action = newStatus === 0 ? 'lock' : 'unlock';
            var label = newStatus === 0 ? 'khóa' : 'mở khóa';
            fetch(location.pathname + '?__ajax=true&action=' + action + '&id=' + userId)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) {
                        showToast('Đã ' + label + ' tài khoản thành công.', 'ok');
                        loadData();
                        loadStats();
                        if (currentModalId === userId) openModal(userId);
                    } else {
                        showToast(j.msg || 'Lỗi khi ' + label + ' tài khoản.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };

        /* ── Modal chi tiết ─────────────────────────────────────────── */
        window.openModal = function (userId) {
            currentModalId = userId;
            fetch(location.pathname + '?__ajax=true&action=get&id=' + userId)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) { showToast('Không tìm thấy người dùng.', 'err'); return; }
                    var u = j.data;
                    var av = avColor(u.MaNguoiDung);
                    var ini = getInitials(u.HoTen);

                    var avEl = document.getElementById('modalAv');
                    avEl.textContent = ini;
                    avEl.style.background = av.bg;
                    avEl.style.color = av.color;

                    document.getElementById('modalName').textContent = u.HoTen;
                    document.getElementById('modalEmail').textContent = u.Email;
                    document.getElementById('modalRoleBadge').innerHTML = u.VaiTro === 1
                        ? '<span class="user-role-badge role-admin" style="font-size:11px">Admin</span>'
                        : '<span class="user-role-badge role-user"  style="font-size:11px">Thành viên</span>';
                    document.getElementById('modalMa').textContent = '#' + u.MaNguoiDung;
                    document.getElementById('modalPhone').textContent = u.SoDienThoai || '—';
                    document.getElementById('modalNgay').textContent = u.NgayTao;
                    document.getElementById('modalStatus').innerHTML = statusBadge(u.TrangThai);
                    document.getElementById('modalTongGop').textContent = fmtMoney(u.TongGop);
                    document.getElementById('modalSoLan').textContent = (u.SoLanGop || 0) + ' lần';

                    var donEl = document.getElementById('modalDonations');
                    if (!u.Donations || !u.Donations.length) {
                        donEl.innerHTML = '<div class="no-donations">Chưa có giao dịch nào.</div>';
                    } else {
                        var dHtml = '<div class="donation-mini-list">';
                        u.Donations.forEach(function (d) {
                            dHtml += '<div class="donation-mini-item">'
                                + '<span class="dm-name">' + d.TenChienDich + '</span>'
                                + donationStatusBadge(d.TrangThai)
                                + '<span class="dm-amount" style="margin-left:8px">' + fmtMoney(d.SoTien) + '</span>'
                                + '<span class="dm-date">' + d.NgayTao + '</span>'
                                + '</div>';
                        });
                        donEl.innerHTML = dHtml + '</div>';
                    }

                    var footerBtn = document.getElementById('modalActionBtn');
                    if (u.VaiTro === 1) {
                        footerBtn.innerHTML = '';
                    } else if (u.TrangThai === 1) {
                        footerBtn.innerHTML = '<button class="btn-modal-lock" onclick="doLockUnlock(' + u.MaNguoiDung + ',0)">Khóa tài khoản</button>';
                    } else {
                        footerBtn.innerHTML = '<button class="btn-modal-unlock" onclick="doLockUnlock(' + u.MaNguoiDung + ',1)">Mở khóa tài khoản</button>';
                    }

                    document.getElementById('modalOverlay').classList.add('show');
                    document.body.style.overflow = 'hidden';
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };

        window.closeModal = function () {
            document.getElementById('modalOverlay').classList.remove('show');
            document.body.style.overflow = '';
        };
        window.closeModalOutside = function (e) {
            if (e.target === document.getElementById('modalOverlay')) closeModal();
        };
        document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeModal(); });

        /* ── Real-time search ────────────────────────────────────────── */
        document.getElementById('inputSearch').addEventListener('input', function () {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(function () { currentPage = 1; loadData(); }, 350);
        });
        document.getElementById('inputSearch').addEventListener('keypress', function (e) {
            if (e.key === 'Enter') { clearTimeout(searchTimeout); currentPage = 1; loadData(); }
        });

        /* ── Init ────────────────────────────────────────────────────── */
        loadStats();
        loadData();

    })();
</script>
</asp:Content>
