<%@ Page Title="Quản lý Chiến dịch" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .page-topbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 14px; flex-wrap: wrap; gap: 8px;
    }
    .page-topbar h3 { font-size: 14px; font-weight: 600; }
    .cd-name { font-size: 13px; font-weight: 600; }
    .cd-sub { font-size: 11px; color: var(--txt-sub); margin-top: 2px; }
    .cd-dm {
        display: inline-block; font-size: 10px; padding: 2px 7px;
        border-radius: 4px; font-weight: 500;
    }
    .cd-amount { font-weight: 600; font-size: 12px; }
    .cd-date { font-size: 11px; color: var(--txt-sub); white-space: nowrap; }
    .action-group { display: flex; gap: 4px; }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý chiến dịch</h1>
    <p>Danh sách các chiến dịch quyên góp</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-topbar">
        <h3>Tất cả chiến dịch</h3>
        <a href="<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>" class="btn btn-primary">Thêm chiến dịch</a>
    </div>

    <%-- Thanh tìm kiếm --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <input type="text" class="input" id="txtSearch" placeholder="Tìm kiếm chiến dịch theo tên..." />
            <button type="button" class="btn btn-primary" onclick="doSearch()">Tìm kiếm</button>
        </div>
    </div>

    <%-- Bộ lọc --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterStatus">
            <button type="button" class="filter-btn active" data-val="">Tất cả</button>
            <button type="button" class="filter-btn" data-val="0">Nháp</button>
            <button type="button" class="filter-btn" data-val="1">Đang chạy</button>
            <button type="button" class="filter-btn" data-val="2">Kết thúc</button>
        </div>
        <select class="select" id="filterDanhMuc" style="min-width:140px">
            <option value="">Tất cả danh mục</option>
        </select>
    </div>

    <%-- Bảng dữ liệu --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Tên chiến dịch</th>
                    <th>Danh mục</th>
                    <th>Mục tiêu</th>
                    <th>Đã quyên</th>
                    <th>Tiến độ</th>
                    <th>Kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="tblBody">
                <tr><td colspan="8" class="empty-state">Đang tải...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="pagingWrap"></div>

    <%-- Modal xóa --%>
    <div class="overlay" id="deleteOverlay" onclick="if(event.target===this)closeDeleteModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xóa chiến dịch</h3>
                <button type="button" class="modal-close" onclick="closeDeleteModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Bạn có chắc chắn muốn xóa chiến dịch "<strong id="delName"></strong>"?</p>
                <p style="font-size:11px;color:var(--txt-sub);margin-top:6px">Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeDeleteModal()">Hủy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmDelete">Xóa</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = '<%= ResolveUrl("~/Admin/QuanLyChienDich.aspx") %>';
        var currentPage = 1, pageSize = 8, currentStatus = '', currentDM = '';
        var pendingDeleteId = 0;

        // Load danh mục vào select
        function loadDanhMuc() {
            fetch('<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>?__ajax=true&action=danhMuc')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    var sel = document.getElementById('filterDanhMuc');
                    d.data.forEach(function (dm) {
                        var opt = document.createElement('option');
                        opt.value = dm.ma;
                        opt.textContent = dm.ten;
                        sel.appendChild(opt);
                    });
                });
        }

        // Load dữ liệu bảng
        function loadData() {
            var tuKhoa = (document.getElementById('txtSearch').value || '').trim();
            var params = '__ajax=true&action=list&TrangHienTai=' + currentPage + '&SoDoiMoiTrang=' + pageSize;
            if (currentStatus !== '') params += '&TrangThai=' + currentStatus;
            if (currentDM !== '') params += '&MaDanhMuc=' + currentDM;
            if (tuKhoa) params += '&TuKhoa=' + encodeURIComponent(tuKhoa);

            fetch(BASE + '?' + params)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) { showToast('Lỗi', d.msg || 'Lỗi tải dữ liệu', 'err'); return; }
                    renderTable(d.data || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Lỗi', 'Không thể kết nối server.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('tblBody');
            if (!rows.length) {
                body.innerHTML = '<tr><td colspan="8" class="empty-state">Không có chiến dịch nào.</td></tr>';
                return;
            }
            var html = '';
            rows.forEach(function (r) {
                var pct = r.MucTieu > 0 ? Math.min(100, Math.round(r.SoTienDaQuyen * 100 / r.MucTieu)) : 0;
                var tsLabel = ['Nháp', 'Đang chạy', 'Kết thúc'][r.TrangThai] || '';
                var tsClass = ['badge-warn', 'badge-ok', 'badge-info'][r.TrangThai] || '';
                html += '<tr>' +
                    '<td><div class="cd-name">' + esc(r.TenChienDich) + '</div>' +
                    '<div class="cd-sub">' + esc(r.MoTaNgan || '') + '</div></td>' +
                    '<td><span class="cd-dm" style="background:' + (r.MauDanhMuc || '#EDF2F7') + '20;color:' + (r.MauDanhMuc || '#4A5568') + '">' + esc(r.TenDanhMuc) + '</span></td>' +
                    '<td class="cd-amount">' + Number(r.MucTieu).toLocaleString('vi-VN') + '</td>' +
                    '<td class="cd-amount" style="color:var(--ok)">' + Number(r.SoTienDaQuyen).toLocaleString('vi-VN') + '</td>' +
                    '<td style="min-width:100px"><div class="prog-wrap"><div class="prog-fill" style="width:' + pct + '%"></div></div><div style="font-size:10px;color:var(--txt-sub);margin-top:3px">' + pct + '%</div></td>' +
                    '<td class="cd-date">' + r.NgayKetThuc + (r.SoNgayCon > 0 ? ' (' + r.SoNgayCon + ' ngày)' : '') + '</td>' +
                    '<td><span class="badge ' + tsClass + '">' + tsLabel + '</span>' +
                    (r.NoiBat ? '<span class="badge badge-info" style="margin-left:3px">Nổi bật</span>' : '') + '</td>' +
                    '<td><div class="action-group">' +
                    '<a href="' + BASE.replace('QuanLyChienDich.aspx', 'FormChienDich.aspx') + '?id=' + r.MaChienDich + '" class="btn btn-outline btn-xs">Sửa</a>' +
                    '<button type="button" class="btn btn-xs" style="background:var(--err-bg);color:var(--err-txt)" onclick="openDelete(' + r.MaChienDich + ',\'' + esc(r.TenChienDich).replace(/'/g, "\\'") + '\')">Xóa</button>' +
                    '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('pagingWrap');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }

            var html = '<span class="paging-info">' + total + ' kết quả</span>';
            html += '<button class="page-btn" onclick="goPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Trước</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="goPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="goPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp</button>';
            wrap.innerHTML = html;
        }

        // FIX: Expose goPage to window scope cho pagination hoạt động
        window.goPage = function (p) {
            if (p < 1) return;
            currentPage = p;
            loadData();
        };

        // Filter trạng thái
        document.getElementById('filterStatus').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                currentStatus = e.target.getAttribute('data-val');
                currentPage = 1;
                loadData();
            }
        });

        // Filter danh mục
        document.getElementById('filterDanhMuc').addEventListener('change', function () {
            currentDM = this.value;
            currentPage = 1;
            loadData();
        });

        // Tìm kiếm
        window.doSearch = function () {
            currentPage = 1;
            loadData();
        };
        document.getElementById('txtSearch').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') { e.preventDefault(); window.doSearch(); }
        });

        // Xóa chiến dịch
        window.openDelete = function (id, name) {
            pendingDeleteId = id;
            document.getElementById('delName').textContent = name;
            document.getElementById('deleteOverlay').classList.add('show');
        };
        window.closeDeleteModal = function () {
            document.getElementById('deleteOverlay').classList.remove('show');
        };
        document.getElementById('btnConfirmDelete').addEventListener('click', function () {
            if (!pendingDeleteId) return;
            fetch(BASE + '?__ajax=true&action=delete&id=' + pendingDeleteId)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    closeDeleteModal();
                    if (j.ok) { showToast('Thành công', 'Đã xóa chiến dịch.', 'ok'); loadData(); }
                    else showToast('Lỗi', j.msg || 'Không thể xóa.', 'err');
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        });

        loadDanhMuc();
        loadData();
    })();
</script>
</asp:Content>
