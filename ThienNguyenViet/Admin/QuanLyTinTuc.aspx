<%@ Page Title="Quản lý Tin tức" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyTinTuc.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══ Toast ══════════════════════════════════════════════════════ */
#toastWrap {
    position: fixed; top: 64px; right: 18px;
    z-index: 9999; display: flex; flex-direction: column; gap: 8px;
    pointer-events: none;
}
.toast-item {
    display: flex; align-items: flex-start; gap: 10px;
    background: var(--admin-card); border: 1px solid var(--admin-vien);
    border-left: 4px solid #3182CE; border-radius: var(--r-card);
    padding: 10px 14px; min-width: 260px; max-width: 340px;
    pointer-events: all; box-shadow: 0 2px 10px rgba(0,0,0,.08);
    animation: toastIn .2s ease;
}
.toast-item.toast-ok  { border-left-color: var(--admin-thanh-cong); }
.toast-item.toast-err { border-left-color: var(--admin-loi); }
.toast-item .t-msg    { font-size: 13px; color: var(--admin-chu-chinh); flex: 1; }
.toast-item .t-close  { font-size: 16px; color: var(--admin-chu-phu); cursor: pointer; }
@keyframes toastIn { from { opacity:0; transform: translateX(12px); } to { opacity:1; transform: none; } }

/* ══ Stat cards — căn giữa, không icon ══════════════════════════ */
.tt-stats-row {
    display: grid; grid-template-columns: repeat(4,1fr);
    gap: 14px; margin-bottom: 20px;
}
.tt-stat-card {
    background: var(--admin-card); border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien); padding: 20px 18px;
    text-align: center; display: flex; flex-direction: column;
    align-items: center; justify-content: center;
}
.tt-stat-card strong {
    display: block; font-size: 24px; font-weight: 700;
    line-height: 1.1; margin-bottom: 6px;
}
.tt-stat-card span { font-size: 11px; color: var(--admin-chu-phu); text-align: center; }

/* ══ Topbar ══════════════════════════════════════════════════════ */
.page-topbar {
    display: flex; align-items: center;
    justify-content: space-between; margin-bottom: 16px;
}
.page-topbar-title { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); }
.btn-add-link {
    height: 36px; padding: 0 16px; background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500;
    text-decoration: none; display: inline-flex; align-items: center; gap: 4px;
    cursor: pointer; transition: background .15s;
}
.btn-add-link:hover { background: #2B6CB0; color: #fff; }

/* ══ Tab bar ══════════════════════════════════════════════════════ */
.tab-bar {
    display: flex; align-items: center; gap: 4px; margin-bottom: 16px;
    background: var(--admin-card); border: 0.5px solid var(--admin-vien);
    border-radius: var(--r-card); padding: 6px;
}
.tab-btn {
    height: 32px; padding: 0 16px; border-radius: 6px; border: none;
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
    background: transparent; color: var(--admin-chu-phu);
    display: flex; align-items: center; gap: 6px; transition: all .15s;
}
.tab-btn:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }
.tab-btn.active { background: #3182CE; color: #fff; }
.tab-count {
    font-size: 10px; font-weight: 700; min-width: 18px; height: 18px;
    border-radius: 99px; display: inline-flex; align-items: center; justify-content: center; padding: 0 5px;
}
.tab-btn.active .tab-count     { background: rgba(255,255,255,.25); color: #fff; }
.tab-btn:not(.active) .tab-count { background: var(--admin-vien); color: var(--admin-chu-phu); }

/* ══ Filter ══════════════════════════════════════════════════════ */
.filter-bar { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
.input-search {
    height: 34px; padding: 0 10px; border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut); font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); width: 240px; outline: none; transition: border-color .15s;
}
.input-search:focus { border-color: #3182CE; }

/* Button group danh mục ══════════════════════════════════════════ */
.btn-group { display: flex; gap: 4px; flex-wrap: wrap; }
.btn-grp-item {
    height: 34px; padding: 0 13px;
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    background: var(--admin-nen); font-family: var(--font);
    font-size: 12px; font-weight: 500; color: var(--admin-chu-phu);
    cursor: pointer; white-space: nowrap; transition: all .15s;
}
.btn-grp-item:hover { background: #e2e8f0; color: var(--admin-chu-chinh); }
.btn-grp-item.active { background: #3182CE; color: #fff; border-color: #3182CE; font-weight: 600; }

.btn-primary-sm {
    height: 34px; padding: 0 14px; background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
}
.btn-primary-sm:hover { background: #2B6CB0; }
.btn-outline-sm {
    height: 34px; padding: 0 12px; background: transparent;
    color: var(--admin-chu-phu); border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut); font-size: 13px; font-family: var(--font); cursor: pointer;
}
.btn-outline-sm:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }

/* ══ Section header ══════════════════════════════════════════════ */
.section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px; }
.section-title  { font-size: 14px; font-weight: 600; }
.section-count  { font-size: 12px; color: var(--admin-chu-phu); }

/* ══ News cell ════════════════════════════════════════════════════ */
.news-cell { display: flex; align-items: center; gap: 12px; }
.news-thumb {
    width: 64px; height: 44px; border-radius: 6px; flex-shrink: 0;
    background: var(--admin-nen); border: 1px solid var(--admin-vien);
    overflow: hidden;
}
.news-thumb img { width: 100%; height: 100%; object-fit: cover; }
.news-thumb-empty { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; font-size: 10px; color: var(--admin-chu-phu); }
.news-title {
    font-size: 13px; font-weight: 500; color: var(--admin-chu-chinh);
    max-width: 240px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
.news-summary {
    font-size: 11px; color: var(--admin-chu-phu);
    max-width: 240px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-top: 2px;
}
.cat-badge {
    font-size: 10px; font-weight: 600; padding: 2px 8px; border-radius: 4px;
    display: inline-block; white-space: nowrap;
}
.view-count { font-size: 12px; color: var(--admin-chu-phu); }
.date-col   { font-size: 12px; color: var(--admin-chu-phu); }

/* ══ Action buttons ══════════════════════════════════════════════ */
.btn-sua {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #EBF8FF; color: #2B6CB0; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s; text-decoration: none;
    display: inline-block;
}
.btn-sua:hover { background: #BEE3F8; }
.btn-toggle {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #FEEBC8; color: #C05621; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s;
}
.btn-toggle:hover { background: #FBD38D; }
.btn-toggle.published { background: #C6F6D5; color: #276749; }
.btn-toggle.published:hover { background: #9AE6B4; }
.btn-xoa {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #FED7D7; color: #C53030; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s;
}
.btn-xoa:hover { background: #FEB2B2; }

/* ══ Pagination — căn giữa ═══════════════════════════════════════ */
.pagination-wrap {
    display: flex; align-items: center; justify-content: center;
    flex-direction: column; gap: 8px;
    padding-top: 14px; border-top: 1px solid var(--admin-vien); margin-top: 4px;
}
.paging-info { font-size: 12px; color: var(--admin-chu-phu); }
.paging-btns { display: flex; align-items: center; gap: 6px; }
.paging-btn {
    font-size: 12px; padding: 4px 12px; border-radius: var(--r-nut);
    background: #fff; border: 1px solid var(--admin-vien);
    color: var(--admin-chu-chinh); cursor: pointer; font-family: var(--font);
    transition: background .12s; min-width: 34px; text-align: center;
}
.paging-btn:hover    { background: var(--admin-nen); }
.paging-btn.active   { background: #3182CE; color: #fff; border-color: #3182CE; }
.paging-btn:disabled { opacity: .4; cursor: default; }

/* ══ Empty / Loading ══════════════════════════════════════════════ */
.empty-state { text-align: center; padding: 48px 0; color: var(--admin-chu-phu); }
.empty-state p { font-size: 13px; }
.tbl-loading { text-align: center; padding: 40px; font-size: 13px; color: var(--admin-chu-phu); }

/* ══ Confirm modal ════════════════════════════════════════════════ */
.modal-overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.45); z-index: 999;
    align-items: center; justify-content: center;
}
.modal-overlay.show { display: flex; }
.modal-box {
    background: var(--admin-card); border-radius: 12px; width: 400px; max-width: 94vw;
    box-shadow: 0 20px 60px rgba(0,0,0,.22); overflow: hidden; animation: modalIn .18s ease;
}
@keyframes modalIn { from { opacity:0; transform:translateY(-14px) scale(.97); } to { opacity:1; transform:none; } }
.modal-header {
    padding: 16px 20px 14px; border-bottom: 1px solid var(--admin-vien);
    display: flex; align-items: center; justify-content: space-between;
}
.modal-header h3 { font-size: 15px; font-weight: 600; }
.modal-close {
    width: 28px; height: 28px; border-radius: 6px; border: none;
    background: var(--admin-nen); font-size: 15px; cursor: pointer;
    display: flex; align-items: center; justify-content: center; color: var(--admin-chu-phu);
}
.modal-close:hover { background: #FED7D7; color: #C53030; }
.modal-body  { padding: 20px; }
.modal-footer { padding: 14px 20px; border-top: 1px solid var(--admin-vien); display: flex; gap: 8px; justify-content: flex-end; }
.confirm-msg { font-size: 14px; color: var(--admin-chu-chinh); margin-bottom: 6px; }
.confirm-sub { font-size: 12px; color: var(--admin-chu-phu); }
.btn-confirm-danger {
    height: 34px; padding: 0 18px; background: #E53E3E; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
}
.btn-confirm-danger:hover { opacity: .88; }
.btn-cancel {
    height: 34px; padding: 0 14px; background: var(--admin-nen); color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); cursor: pointer;
}
.btn-cancel:hover { background: #EDF2F7; }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Tin tức</h1>
    <p>Danh sách bài viết và thông báo trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="toastWrap"></div>

<%-- Stat cards --%>
<div class="tt-stats-row" id="statsRow">
    <div class="tt-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="tt-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="tt-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
    <div class="tt-stat-card"><strong class="skeleton" style="width:60px;height:28px;display:inline-block">&nbsp;</strong><span>Đang tải...</span></div>
</div>

<%-- Topbar --%>
<div class="page-topbar">
    <span class="page-topbar-title">Danh sách bài viết</span>
    <a href="/Admin/FormTinTuc.aspx" class="btn-add-link">Viết bài mới</a>
</div>

<%-- Tab lọc trạng thái --%>
<div class="tab-bar">
    <button class="tab-btn active" onclick="switchTab(this,'')"  data-tab="">Tất cả <span class="tab-count" id="cnt-all">0</span></button>
    <button class="tab-btn"        onclick="switchTab(this,'1')" data-tab="1">Đã đăng <span class="tab-count" id="cnt-1">0</span></button>
    <button class="tab-btn"        onclick="switchTab(this,'0')" data-tab="0">Nháp <span class="tab-count" id="cnt-0">0</span></button>
</div>

<%-- Filter — danh mục là button group --%>
<div class="admin-card" style="margin-bottom:16px;padding:14px 20px;">
    <div class="filter-bar">
        <input type="text" id="inputSearch" class="input-search" placeholder="Tìm theo tiêu đề bài viết..." />

        <span style="font-size:12px;font-weight:600;color:var(--admin-chu-phu);white-space:nowrap">Danh mục:</span>
        <div class="btn-group" id="dmBtnGroup">
            <button type="button" class="btn-grp-item active" data-val="" onclick="setDanhMuc(this,'')">Tất cả</button>
            <button type="button" class="btn-grp-item" data-val="1" onclick="setDanhMuc(this,'1')">Hoạt động thiện nguyện</button>
            <button type="button" class="btn-grp-item" data-val="2" onclick="setDanhMuc(this,'2')">Cảm hứng</button>
            <button type="button" class="btn-grp-item" data-val="3" onclick="setDanhMuc(this,'3')">Thông báo</button>
        </div>

        <button class="btn-outline-sm" onclick="resetFilter()">Đặt lại</button>
    </div>
</div>

<%-- Table --%>
<div class="admin-card">
    <div class="section-header">
        <span class="section-title">Danh sách tin tức</span>
        <span class="section-count" id="countLabel"></span>
    </div>

    <table class="admin-table">
        <thead>
            <tr>
                <th style="width:38%">Bài viết</th>
                <th>Danh mục</th>
                <th>Lượt xem</th>
                <th>Người đăng</th>
                <th>Ngày đăng</th>
                <th>Trạng thái</th>
                <th style="text-align:center">Thao tác</th>
            </tr>
        </thead>
        <tbody id="tableBody">
            <tr><td colspan="7" class="tbl-loading">Đang tải dữ liệu...</td></tr>
        </tbody>
    </table>

    <div id="emptyMsg" class="empty-state" style="display:none">
        <p>Không tìm thấy bài viết nào.</p>
    </div>

    <div class="pagination-wrap" id="pagingWrap" style="display:none">
        <div class="paging-btns" id="pagingBtns"></div>
        <span class="paging-info" id="pagingInfo"></span>
    </div>
</div>

<%-- Modal xóa --%>
<div class="modal-overlay" id="modalXoa" onclick="closeModalOutside(event)">
    <div class="modal-box">
        <div class="modal-header">
            <h3>Xóa bài viết</h3>
            <button class="modal-close" onclick="closeModal()">✕</button>
        </div>
        <div class="modal-body">
            <div class="confirm-msg">Xóa bài viết "<strong id="xoa-title"></strong>"?</div>
            <div class="confirm-sub">Hành động này không thể hoàn tác.</div>
        </div>
        <div class="modal-footer">
            <button class="btn-confirm-danger" onclick="confirmXoa()">Xóa bài viết</button>
            <button class="btn-cancel" onclick="closeModal()">Hủy</button>
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
        var activeTab = '';
        var filterDanhMuc = '';
        var searchTimeout = null;
        var pendingDeleteId = null;

        var DANHMUC_MAP = {
            1: { ten: 'Hoạt động thiện nguyện', bg: '#EBF8FF', color: '#2B6CB0' },
            2: { ten: 'Câu chuyện truyền cảm hứng', bg: '#C6F6D5', color: '#276749' },
            3: { ten: 'Thông báo', bg: '#FEEBC8', color: '#C05621' }
        };

        /* ── Toast ──────────────────────────────────────────────────── */
        function showToast(msg, type) {
            var wrap = document.getElementById('toastWrap');
            var t = document.createElement('div');
            t.className = 'toast-item toast-' + (type || 'ok');
            t.innerHTML = '<span class="t-msg">' + msg + '</span><span class="t-close" onclick="this.parentElement.remove()">×</span>';
            wrap.appendChild(t);
            setTimeout(function () { t.style.transition = 'opacity .3s'; t.style.opacity = '0'; setTimeout(function () { t.remove(); }, 350); }, 4000);
        }

        /* ── Load Stats ──────────────────────────────────────────────── */
        function loadStats() {
            fetch(location.pathname + '?__ajax=true&action=stats')
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var d = j.data;
                    var statColors = [
                        'var(--stat-xanh-vien)', 'var(--admin-thanh-cong)',
                        'var(--stat-cam-vien)', 'var(--stat-tim-vien)'
                    ];
                    var cards = [
                        { label: 'Tổng bài viết', value: d.tong, color: statColors[0] },
                        { label: 'Đã đăng', value: d.daDang, color: statColors[1] },
                        { label: 'Nháp', value: d.nhap, color: statColors[2] },
                        { label: 'Tổng lượt xem', value: d.tongView + ' lượt', color: statColors[3] }
                    ];
                    var html = '';
                    cards.forEach(function (c) {
                        html += '<div class="tt-stat-card">'
                            + '<strong style="color:' + c.color + '">' + c.value + '</strong>'
                            + '<span>' + c.label + '</span>'
                            + '</div>';
                    });
                    document.getElementById('statsRow').innerHTML = html;
                    document.getElementById('cnt-all').textContent = d.tong;
                    document.getElementById('cnt-1').textContent = d.daDang;
                    document.getElementById('cnt-0').textContent = d.nhap;
                })
                .catch(function () { });
        }

        /* ── Tab / Filter ────────────────────────────────────────────── */
        window.switchTab = function (btn, tab) {
            document.querySelectorAll('.tab-btn').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            activeTab = tab; currentPage = 1; loadData();
        };

        window.setDanhMuc = function (btn, val) {
            document.querySelectorAll('#dmBtnGroup .btn-grp-item').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            filterDanhMuc = val; currentPage = 1; loadData();
        };

        window.resetFilter = function () {
            document.getElementById('inputSearch').value = '';
            filterDanhMuc = ''; currentPage = 1;
            document.querySelectorAll('#dmBtnGroup .btn-grp-item').forEach(function (b) { b.classList.remove('active'); if (b.dataset.val === '') b.classList.add('active'); });
            loadData();
        };

        /* ── Load Data ───────────────────────────────────────────────── */
        function loadData() {
            var q = document.getElementById('inputSearch').value.trim();
            var params = new URLSearchParams({
                __ajax: 'true', action: 'list',
                tuKhoa: q, trangThai: activeTab, maDanhMuc: filterDanhMuc,
                trang: currentPage, soDong: PAGE_SIZE
            });
            fetch(location.pathname + '?' + params)
                .then(function (r) { return r.json(); })
                .then(function (j) { if (j.ok) renderTable(j.data, j.total); })
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
                document.getElementById('countLabel').textContent = '0 bài viết';
                return;
            }
            emptyMsg.style.display = 'none';
            pagingWrap.style.display = 'flex';

            var from = (currentPage - 1) * PAGE_SIZE + 1;
            var to = Math.min(currentPage * PAGE_SIZE, total);
            document.getElementById('countLabel').textContent = 'Hiển thị ' + from + '–' + to + ' / ' + total + ' bài viết';

            var html = '';
            data.forEach(function (t) {
                var dm = DANHMUC_MAP[t.MaDanhMuc] || { ten: '—', bg: '#EDF2F7', color: '#718096' };
                var toggleLabel = t.TrangThai === 1 ? 'Ẩn bài' : 'Đăng';
                var toggleClass = t.TrangThai === 1 ? 'btn-toggle published' : 'btn-toggle';
                var statusBadge = t.TrangThai === 1
                    ? '<span class="badge-admin badge-thanh-cong">Đã đăng</span>'
                    : '<span class="badge-admin badge-nhap">Nháp</span>';
                var views = t.LuotXem >= 1000 ? (t.LuotXem / 1000).toFixed(1) + 'K' : t.LuotXem;

                var thumbHtml = t.AnhBia
                    ? '<img src="' + t.AnhBia + '" alt="" />'
                    : '<div class="news-thumb-empty">No img</div>';

                html += '<tr id="tt-row-' + t.MaTinTuc + '">'
                    + '<td><div class="news-cell">'
                    + '<div class="news-thumb">' + thumbHtml + '</div>'
                    + '<div>'
                    + '<div class="news-title" title="' + t.TieuDe + '">' + t.TieuDe + '</div>'
                    + '<div class="news-summary">' + (t.TomTat || '') + '</div>'
                    + '</div></div></td>'
                    + '<td><span class="cat-badge" style="background:' + dm.bg + ';color:' + dm.color + '">' + dm.ten + '</span></td>'
                    + '<td class="view-count">' + views + '</td>'
                    + '<td style="font-size:12px">' + (t.NguoiDang || 'Admin') + '</td>'
                    + '<td class="date-col">' + t.NgayDang + '</td>'
                    + '<td>' + statusBadge + '</td>'
                    + '<td style="text-align:center;white-space:nowrap">'
                    + '<a href="/Admin/FormTinTuc.aspx?id=' + t.MaTinTuc + '" class="btn-sua" style="margin-right:3px">Sửa</a>'
                    + '<button class="' + toggleClass + '" onclick="toggleTrangThai(' + t.MaTinTuc + ')" style="margin-right:3px">' + toggleLabel + '</button>'
                    + '<button class="btn-xoa" onclick="openXoa(' + t.MaTinTuc + ',' + JSON.stringify(t.TieuDe) + ')">Xóa</button>'
                    + '</td>'
                    + '</tr>';
            });
            tbody.innerHTML = html;
            renderPaging(Math.ceil(total / PAGE_SIZE));
        }

        /* ── Pagination ──────────────────────────────────────────────── */
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

        /* ── Toggle trạng thái ───────────────────────────────────────── */
        window.toggleTrangThai = function (id) {
            fetch(location.pathname + '?__ajax=true&action=toggle&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) {
                        showToast('Đã cập nhật trạng thái bài viết.', 'ok');
                        loadStats();
                        loadData();
                    } else {
                        showToast(j.msg || 'Lỗi khi cập nhật.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };

        /* ── Xóa ─────────────────────────────────────────────────────── */
        window.openXoa = function (id, title) {
            pendingDeleteId = id;
            document.getElementById('xoa-title').textContent = title.substring(0, 50) + (title.length > 50 ? '...' : '');
            document.getElementById('modalXoa').classList.add('show');
            document.body.style.overflow = 'hidden';
        };
        window.confirmXoa = function () {
            if (!pendingDeleteId) return;
            fetch(location.pathname + '?__ajax=true&action=delete&id=' + pendingDeleteId)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    closeModal();
                    if (j.ok) {
                        showToast('Đã xóa bài viết thành công.', 'ok');
                        loadStats(); loadData();
                    } else {
                        showToast(j.msg || 'Lỗi khi xóa.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };
        window.closeModal = function () {
            document.getElementById('modalXoa').classList.remove('show');
            document.body.style.overflow = '';
            pendingDeleteId = null;
        };
        window.closeModalOutside = function (e) {
            if (e.target === document.getElementById('modalXoa')) closeModal();
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
