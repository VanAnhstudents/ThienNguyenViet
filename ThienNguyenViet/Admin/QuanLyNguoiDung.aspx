<%@ Page Title="Quản lý Người dùng" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyNguoiDung.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .nd-stats { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; }
    .nd-stat {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .nd-stat:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }

    /* Stat card chỉ 2 thành phần: label + value */
    .nd-stat .stat-card-label {
        font-size: 10px; color: var(--txt-sub); text-transform: uppercase;
        font-weight: 600; letter-spacing: .03em; margin-bottom: 6px;
    }
    .nd-stat .stat-card-value {
        font-size: 22px; font-weight: 700;
    }

    .user-fullname { font-size: 13px; font-weight: 500; }
    .user-email { font-size: 10px; color: var(--txt-sub); }
    .user-role {
        display: inline-block; font-size: 10px; padding: 2px 8px;
        border-radius: 4px; font-weight: 500;
    }
    .role-admin { background: #E9D8FD; color: #6B46C1; }
    .role-user { background: var(--info-bg); color: var(--info-txt); }

    @media (max-width: 768px) { .nd-stats { grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 425px) { .nd-stats { grid-template-columns: 1fr 1fr; gap: 8px; } }
    @media (max-width: 375px) { .nd-stats { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý người dùng</h1>
    <p>Danh sách tài khoản người dùng hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Thống kê - chỉ 2 thành phần: label + value --%>
    <div class="nd-stats">
        <div class="nd-stat">
            <div class="stat-card-label">Tổng tài khoản</div>
            <div class="stat-card-value" id="ndTong">--</div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Đang hoạt động</div>
            <div class="stat-card-value" id="ndHoatDong" style="color:var(--ok)">--</div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Tài khoản bị khóa</div>
            <div class="stat-card-value" id="ndKhoa" style="color:var(--err)">--</div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Tổng quyên góp</div>
            <div class="stat-card-value" id="ndQuyenGop" style="color:var(--accent)">--</div>
        </div>
    </div>

    <%-- Thanh tìm kiếm --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <input type="text" class="input" id="txtSearch" placeholder="Tìm kiếm theo tên, email, số điện thoại..." />
            <button type="button" class="btn btn-primary" onclick="doSearch()">Tìm kiếm</button>
        </div>
    </div>

    <%-- Bộ lọc --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterTT">
            <button type="button" class="filter-btn active" data-val="">Tất cả</button>
            <button type="button" class="filter-btn" data-val="1">Hoạt động</button>
            <button type="button" class="filter-btn" data-val="0">Đã khóa</button>
        </div>
        <div class="filter-group" id="filterVT">
            <button type="button" class="filter-btn active" data-val="">Tất cả vai trò</button>
            <button type="button" class="filter-btn" data-val="1">Quản trị viên</button>
            <button type="button" class="filter-btn" data-val="0">Người dùng</button>
        </div>
    </div>

    <%-- Bảng dữ liệu --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Họ tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="ndBody">
                <tr><td colspan="7" class="empty-state">Đang tải...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="ndPaging"></div>

    <%-- Modal chi tiết --%>
    <div class="overlay" id="ndDetailOverlay" onclick="if(event.target===this)closeNdDetail()">
        <div class="modal modal-wide">
            <div class="modal-hd">
                <h3>Chi tiết người dùng</h3>
                <button type="button" class="modal-close" onclick="closeNdDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid" id="ndDetailContent"></div>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeNdDetail()">Đóng</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = '<%= ResolveUrl("~/Admin/QuanLyNguoiDung.aspx") %>';
        var currentPage = 1, pageSize = 10;
        var filterTT = '', filterVT = '';

        function loadStats() {
            fetch(BASE + '?__ajax=true&action=stats')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    var s = d.data;
                    document.getElementById('ndTong').textContent = s.tongTaiKhoan;
                    document.getElementById('ndHoatDong').textContent = s.nguoiDungHoatDong;
                    document.getElementById('ndKhoa').textContent = s.taiKhoanKhoa;
                    document.getElementById('ndQuyenGop').textContent = formatShort(s.tongQuyenGop);
                });
        }

        function loadData() {
            var tuKhoa = (document.getElementById('txtSearch').value || '').trim();
            var url = BASE + '?__ajax=true&action=list&trang=' + currentPage + '&soDong=' + pageSize;
            if (filterTT !== '') url += '&trangThai=' + filterTT;
            if (filterVT !== '') url += '&vaiTro=' + filterVT;
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
            var body = document.getElementById('ndBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="7" class="empty-state">Không có người dùng nào.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var roleCls = r.VaiTro === 1 ? 'role-admin' : 'role-user';
                var roleLabel = r.VaiTro === 1 ? 'Quản trị viên' : 'Người dùng';
                var ttLabel = r.TrangThai === 1 ? 'Hoạt động' : 'Đã khóa';
                var ttCls = r.TrangThai === 1 ? 'badge-ok' : 'badge-err';

                /* BỎ user-av, chỉ hiển thị tên thuần */
                html += '<tr>' +
                    '<td><div class="user-fullname">' + esc(r.HoTen) + '</div></td>' +
                    '<td style="font-size:12px">' + esc(r.Email || '') + '</td>' +
                    '<td style="font-size:12px">' + esc(r.SoDienThoai || '') + '</td>' +
                    '<td><span class="user-role ' + roleCls + '">' + roleLabel + '</span></td>' +
                    '<td><span class="badge ' + ttCls + '">' + ttLabel + '</span></td>' +
                    '<td style="font-size:11px;white-space:nowrap">' + (r.NgayTao || '') + '</td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick=\'viewNdDetail(' + JSON.stringify(r) + ')\'>Xem</button>';

                if (r.TrangThai === 1) {
                    html += '<button type="button" class="btn btn-xs" style="background:var(--err-bg);color:var(--err-txt)" onclick="lockUser(' + r.MaNguoiDung + ')">Khóa</button>';
                } else {
                    html += '<button type="button" class="btn btn-xs btn-success" onclick="unlockUser(' + r.MaNguoiDung + ')">Mở khóa</button>';
                }
                html += '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('ndPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' tài khoản</span>';
            html += '<button class="page-btn" onclick="ndPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Trước</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="ndPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="ndPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp</button>';
            wrap.innerHTML = html;
        }

        window.ndPage = function (p) {
            if (p < 1) return;
            currentPage = p;
            loadData();
        };

        // Tìm kiếm
        window.doSearch = function () { currentPage = 1; loadData(); };
        document.getElementById('txtSearch').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') { e.preventDefault(); window.doSearch(); }
        });

        // Filter trạng thái
        document.getElementById('filterTT').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                filterTT = e.target.getAttribute('data-val');
                currentPage = 1; loadData();
            }
        });

        // Filter vai trò
        document.getElementById('filterVT').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                filterVT = e.target.getAttribute('data-val');
                currentPage = 1; loadData();
            }
        });

        // Xem chi tiết - BỎ avatar
        window.viewNdDetail = function (r) {
            var roleLabel = r.VaiTro === 1 ? 'Quản trị viên' : 'Người dùng';
            var ttLabel = r.TrangThai === 1 ? 'Hoạt động' : 'Đã khóa';
            var html =
                '<div class="detail-item"><label>Mã người dùng</label><span class="detail-val">#' + r.MaNguoiDung + '</span></div>' +
                '<div class="detail-item"><label>Họ tên</label><span class="detail-val">' + esc(r.HoTen) + '</span></div>' +
                '<div class="detail-item"><label>Email</label><span class="detail-val">' + esc(r.Email || '(không có)') + '</span></div>' +
                '<div class="detail-item"><label>Số điện thoại</label><span class="detail-val">' + esc(r.SoDienThoai || '(không có)') + '</span></div>' +
                '<div class="detail-item"><label>Vai trò</label><span class="detail-val">' + roleLabel + '</span></div>' +
                '<div class="detail-item"><label>Trạng thái</label><span class="detail-val">' + ttLabel + '</span></div>' +
                '<div class="detail-item"><label>Ngày tạo</label><span class="detail-val">' + (r.NgayTao || '') + '</span></div>';
            document.getElementById('ndDetailContent').innerHTML = html;
            document.getElementById('ndDetailOverlay').classList.add('show');
        };
        window.closeNdDetail = function () {
            document.getElementById('ndDetailOverlay').classList.remove('show');
        };

        // Khóa / Mở khóa
        window.lockUser = function (id) {
            if (!confirm('Bạn có chắc muốn khóa tài khoản này?')) return;
            fetch(BASE + '?__ajax=true&action=lock&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) { showToast('Thành công', 'Đã khóa tài khoản.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                });
        };
        window.unlockUser = function (id) {
            fetch(BASE + '?__ajax=true&action=unlock&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) { showToast('Thành công', 'Đã mở khóa tài khoản.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                });
        };

        loadStats();
        loadData();
    })();
</script>
</asp:Content>
