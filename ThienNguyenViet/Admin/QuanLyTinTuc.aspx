<%@ Page Title="Quản lý Tin tức" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyTinTuc.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .tt-stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; }
    .tt-stat-card {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .tt-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }

    /* Stat card chỉ 2 thành phần: label + value */
    .tt-stat-card .stat-card-label {
        font-size: 10px; text-transform: uppercase;
        letter-spacing: .04em; font-weight: 600; margin-bottom: 6px;
    }
    .tt-stat-card .stat-card-value {
        font-size: 22px; font-weight: 700;
    }

    .page-topbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 14px; flex-wrap: wrap; gap: 8px;
    }
    .tt-title-cell { font-size: 13px; font-weight: 500; max-width: 300px; }
    .tt-thumb {
        width: 48px; height: 36px; border-radius: 4px;
        object-fit: cover; background: var(--bg); border: 1px solid var(--border);
    }
    .tt-views { font-size: 12px; }

    @media (max-width: 768px) { .tt-stats-row { grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 425px) { .tt-stats-row { grid-template-columns: 1fr 1fr; gap: 8px; } }
    @media (max-width: 375px) { .tt-stats-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý tin tức</h1>
    <p>Quản lý bài viết, tin tức trên hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Thống kê - chỉ 2 thành phần: label + value --%>
    <div class="tt-stats-row" id="ttStats">
        <div class="tt-stat-card">
            <div class="stat-card-label">Tổng bài viết</div>
            <div class="stat-card-value" id="ttTong">--</div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Xuất bản</div>
            <div class="stat-card-value" id="ttXuatBan">--</div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Bản nháp</div>
            <div class="stat-card-value" id="ttNhap">--</div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Tổng lượt xem</div>
            <div class="stat-card-value" id="ttLuotXem">--</div>
        </div>
    </div>

    <div class="page-topbar">
        <h3>Danh sách bài viết</h3>
        <a href="<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>" class="btn btn-primary">Thêm bài viết</a>
    </div>

    <%-- Thanh tìm kiếm --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <input type="text" class="input" id="txtSearch" placeholder="Tìm kiếm bài viết theo tiêu đề..." />
            <button type="button" class="btn btn-primary" onclick="doSearch()">Tìm kiếm</button>
        </div>
    </div>

    <%-- Bộ lọc --%>
    <div class="filter-bar">
        <div class="filter-group" id="ttFilterStatus">
            <button type="button" class="filter-btn active" data-val="">Tất cả</button>
            <button type="button" class="filter-btn" data-val="1">Xuất bản</button>
            <button type="button" class="filter-btn" data-val="0">Bản nháp</button>
        </div>
        <select class="select" id="ttFilterDM" style="min-width:140px">
            <option value="">Tất cả danh mục</option>
        </select>
    </div>

    <%-- Bảng dữ liệu --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Ảnh</th><th>Tiêu đề</th><th>Người đăng</th>
                    <th>Ngày đăng</th><th>Lượt xem</th><th>Trạng thái</th><th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="ttBody">
                <tr><td colspan="7" class="empty-state">Đang tải...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="ttPaging"></div>

    <%-- Modal xóa --%>
    <div class="overlay" id="modalXoa" onclick="if(event.target===this)closeModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xóa bài viết</h3>
                <button type="button" class="modal-close" onclick="closeModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Bạn có chắc chắn muốn xóa bài viết "<strong id="xoa-title"></strong>"?</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeModal()">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="confirmXoa()">Xóa</button>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = '<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>';
        var FORM_URL = '<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>';
        var currentPage = 1, filterTT = '', filterDM = '';
        var pendingDeleteId = 0;

        function loadStats() {
            fetch(BASE + '?__ajax=true&action=stats')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    document.getElementById('ttTong').textContent = d.tong || 0;
                    document.getElementById('ttXuatBan').textContent = d.xuatBan || 0;
                    document.getElementById('ttNhap').textContent = d.nhap || 0;
                    document.getElementById('ttLuotXem').textContent = formatShort(d.luotXem || 0);
                });
        }

        function loadDanhMuc() {
            fetch(BASE + '?__ajax=true&action=danhMuc')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok || !d.data) return;
                    var sel = document.getElementById('ttFilterDM');
                    d.data.forEach(function (dm) {
                        var opt = document.createElement('option');
                        opt.value = dm.MaDanhMuc;
                        opt.textContent = dm.TenDanhMuc;
                        sel.appendChild(opt);
                    });
                });
        }

        function loadData() {
            var tuKhoa = (document.getElementById('txtSearch').value || '').trim();
            var url = BASE + '?__ajax=true&action=list&trang=' + currentPage + '&soDong=10';
            if (filterTT !== '') url += '&trangThai=' + filterTT;
            if (filterDM !== '') url += '&maDanhMuc=' + filterDM;
            if (tuKhoa) url += '&tuKhoa=' + encodeURIComponent(tuKhoa);

            fetch(url)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    renderTable(d.data || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Lỗi', 'Không tải được dữ liệu.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('ttBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="7" class="empty-state">Không có bài viết nào.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var tsLabel = r.TrangThai === 1 ? 'Xuất bản' : 'Bản nháp';
                var tsCls = r.TrangThai === 1 ? 'badge-ok' : 'badge-warn';
                var thumb = r.AnhBia ? '<img class="tt-thumb" src="' + r.AnhBia + '" onerror="this.style.display=\'none\'" />' : '<div class="tt-thumb" style="display:flex;align-items:center;justify-content:center;font-size:9px;">N/A</div>';

                html += '<tr>' +
                    '<td>' + thumb + '</td>' +
                    '<td><div class="tt-title-cell">' + esc(r.TieuDe) + '</div></td>' +
                    '<td style="font-size:12px">' + esc(r.NguoiDang || '') + '</td>' +
                    '<td style="font-size:11px;white-space:nowrap">' + r.NgayDang + '</td>' +
                    '<td class="tt-views">' + Number(r.LuotXem || 0).toLocaleString('vi-VN') + '</td>' +
                    '<td><span class="badge ' + tsCls + '">' + tsLabel + '</span></td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<a href="' + FORM_URL + '?id=' + r.MaTinTuc + '" class="btn btn-xs btn-outline">Sửa</a>' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick="toggleTrangThai(' + r.MaTinTuc + ')">' + (r.TrangThai === 1 ? 'Ẩn' : 'Hiện') + '</button>' +
                    '<button type="button" class="btn btn-xs" style="background:var(--err-bg)" onclick="openXoa(' + r.MaTinTuc + ',\'' + esc(r.TieuDe).replace(/'/g, "\\'") + '\')">Xóa</button>' +
                    '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / 10);
            var wrap = document.getElementById('ttPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' bài viết</span>';
            html += '<button class="page-btn" onclick="ttPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Trước</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="ttPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="ttPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp</button>';
            wrap.innerHTML = html;
        }

        window.ttPage = function (p) {
            if (p < 1) return;
            currentPage = p;
            loadData();
        };

        // Tìm kiếm
        window.doSearch = function () { currentPage = 1; loadData(); };
        document.getElementById('txtSearch').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') { e.preventDefault(); window.doSearch(); }
        });

        // Filters
        document.getElementById('ttFilterStatus').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                filterTT = e.target.getAttribute('data-val');
                currentPage = 1; loadData();
            }
        });
        document.getElementById('ttFilterDM').addEventListener('change', function () {
            filterDM = this.value; currentPage = 1; loadData();
        });

        // Toggle trạng thái
        window.toggleTrangThai = function (id) {
            fetch(BASE + '?__ajax=true&action=toggle&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) { showToast('Thành công', 'Đã cập nhật trạng thái.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };

        // Xóa
        window.openXoa = function (id, title) {
            pendingDeleteId = id;
            document.getElementById('xoa-title').textContent = title.length > 50 ? title.substring(0, 50) + '...' : title;
            document.getElementById('modalXoa').classList.add('show');
        };
        window.confirmXoa = function () {
            if (!pendingDeleteId) return;
            fetch(BASE + '?__ajax=true&action=delete&id=' + pendingDeleteId)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    closeModal();
                    if (j.ok) { showToast('Thành công', 'Đã xóa bài viết.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };
        window.closeModal = function () {
            document.getElementById('modalXoa').classList.remove('show');
        };

        loadStats();
        loadDanhMuc();
        loadData();
    })();
</script>
</asp:Content>
