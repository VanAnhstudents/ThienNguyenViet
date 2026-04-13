<%@ Page Title="Quan ly Chien dich" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    /* ── QuanLyChienDich ── */
    .page-topbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 14px; flex-wrap: wrap; gap: 8px;
    }
    .page-topbar h3 { font-size: 14px; font-weight: 600; }

    /* Table cells */
    .cd-name { font-size: 13px; font-weight: 600; }
    .cd-sub { font-size: 11px; color: var(--txt-sub); margin-top: 2px; }
    .cd-dm {
        display: inline-block; font-size: 10px; padding: 2px 7px;
        border-radius: 4px; font-weight: 500;
    }
    .cd-amount { font-weight: 600; font-size: 12px; }
    .cd-date { font-size: 11px; color: var(--txt-sub); white-space: nowrap; }

    /* Actions */
    .action-group { display: flex; gap: 4px; }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quan ly chien dich</h1>
    <p>Danh sach cac chien dich quyen gop</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-topbar">
        <h3>Tat ca chien dich</h3>
        <a href="<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>" class="btn btn-primary">Them chien dich</a>
    </div>

    <%-- Filter bar --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterStatus">
            <button type="button" class="filter-btn active" data-val="">Tat ca</button>
            <button type="button" class="filter-btn" data-val="1">Dang chay</button>
            <button type="button" class="filter-btn" data-val="0">Nhap</button>
            <button type="button" class="filter-btn" data-val="2">Ket thuc</button>
        </div>
        <select class="select" id="filterDanhMuc" style="min-width:140px">
            <option value="">Tat ca danh muc</option>
        </select>
    </div>

    <%-- Table --%>
    <div class="card" style="padding:0">
        <table class="tbl" id="tblChienDich">
            <thead>
                <tr>
                    <th>Chien dich</th>
                    <th>Danh muc</th>
                    <th>Muc tieu</th>
                    <th>Da quyen</th>
                    <th>Tien do</th>
                    <th>Han</th>
                    <th>Trang thai</th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tblBody">
                <tr><td colspan="8" class="empty-state">Dang tai...</td></tr>
            </tbody>
        </table>
    </div>

    <%-- Paging --%>
    <div class="paging" id="pagingWrap"></div>

    <%-- Modal xac nhan xoa --%>
    <div class="overlay" id="deleteOverlay" onclick="if(event.target===this)closeDeleteModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xoa chien dich</h3>
                <button type="button" class="modal-close" onclick="closeDeleteModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Ban co chac chan muon xoa chien dich "<strong id="deleteName"></strong>"?</p>
                <p style="font-size:12px;color:var(--txt-sub);margin-top:6px">Hanh dong nay khong the hoan tac.</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeDeleteModal()">Huy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmDelete">Xoa</button>
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

    // Load danh muc vao select
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

        // Load du lieu bang
        function loadData() {
            var params = '__ajax=true&action=list&TrangHienTai=' + currentPage + '&SoDoiMoiTrang=' + pageSize;
            if (currentStatus !== '') params += '&TrangThai=' + currentStatus;
            if (currentDM !== '') params += '&MaDanhMuc=' + currentDM;

            fetch(BASE + '?' + params)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) { showToast('Loi', d.msg || 'Loi tai du lieu', 'err'); return; }
                    renderTable(d.data || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Loi', 'Khong the ket noi server.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('tblBody');
            if (!rows.length) {
                body.innerHTML = '<tr><td colspan="8" class="empty-state">Khong co chien dich nao.</td></tr>';
                return;
            }
            var html = '';
            rows.forEach(function (r) {
                var pct = r.MucTieu > 0 ? Math.min(100, Math.round(r.SoTienDaQuyen * 100 / r.MucTieu)) : 0;
                var tsLabel = ['Nhap', 'Dang chay', 'Ket thuc'][r.TrangThai] || '';
                var tsClass = ['badge-warn', 'badge-ok', 'badge-info'][r.TrangThai] || '';
                html += '<tr>' +
                    '<td><div class="cd-name">' + esc(r.TenChienDich) + '</div>' +
                    '<div class="cd-sub">' + esc(r.MoTaNgan || '') + '</div></td>' +
                    '<td><span class="cd-dm" style="background:' + (r.MauDanhMuc || '#EDF2F7') + '20;color:' + (r.MauDanhMuc || '#4A5568') + '">' + esc(r.TenDanhMuc) + '</span></td>' +
                    '<td class="cd-amount">' + Number(r.MucTieu).toLocaleString('vi-VN') + '</td>' +
                    '<td class="cd-amount" style="color:var(--ok)">' + Number(r.SoTienDaQuyen).toLocaleString('vi-VN') + '</td>' +
                    '<td style="min-width:100px"><div class="prog-wrap"><div class="prog-fill" style="width:' + pct + '%"></div></div><div style="font-size:10px;color:var(--txt-sub);margin-top:3px">' + pct + '%</div></td>' +
                    '<td class="cd-date">' + r.NgayKetThuc + (r.SoNgayCon > 0 ? ' (' + r.SoNgayCon + ' ngay)' : '') + '</td>' +
                    '<td><span class="badge ' + tsClass + '">' + tsLabel + '</span>' +
                    (r.NoiBat ? '<span class="badge badge-info" style="margin-left:3px">Noi bat</span>' : '') + '</td>' +
                    '<td><div class="action-group">' +
                    '<a href="' + BASE.replace('QuanLyChienDich.aspx', 'FormChienDich.aspx') + '?id=' + r.MaChienDich + '" class="btn btn-outline btn-xs">Sua</a>' +
                    '<button type="button" class="btn btn-xs" style="background:var(--err-bg);color:var(--err-txt)" onclick="openDelete(' + r.MaChienDich + ',\'' + esc(r.TenChienDich).replace(/'/g, "\\'") + '\')">Xoa</button>' +
                    '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('pagingWrap');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }

            var html = '<span class="paging-info">' + total + ' ket qua</span>';
            html += '<button class="page-btn" onclick="goPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Truoc</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="goPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="goPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiep</button>';
            wrap.innerHTML = html;
        }

        window.goPage = function (p) { currentPage = p; loadData(); };

        // Filter: status buttons
        document.getElementById('filterStatus').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                currentStatus = e.target.getAttribute('data-val');
                currentPage = 1;
                loadData();
            }
        });

        // Filter: danh muc select
        document.getElementById('filterDanhMuc').addEventListener('change', function () {
            currentDM = this.value;
            currentPage = 1;
            loadData();
        });

        // Xoa chien dich
        window.openDelete = function (id, name) {
            pendingDeleteId = id;
            document.getElementById('deleteName').textContent = name;
            document.getElementById('deleteOverlay').classList.add('show');
        };
        window.closeDeleteModal = function () {
            document.getElementById('deleteOverlay').classList.remove('show');
        };
        document.getElementById('btnConfirmDelete').onclick = function () {
            if (!pendingDeleteId) return;
            fetch(BASE + '?__ajax=true&action=delete&id=' + pendingDeleteId)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    closeDeleteModal();
                    if (d.ok) {
                        showToast('Thanh cong', d.msg, 'ok');
                        loadData();
                    } else {
                        showToast('Loi', d.msg || 'Khong the xoa.', 'err');
                    }
                })
                .catch(function () { showToast('Loi', 'Loi ket noi server.', 'err'); });
        };

        function esc(s) {
            var d = document.createElement('div');
            d.textContent = s;
            return d.innerHTML;
        }

        // Init
        loadDanhMuc();
        loadData();
    })();
</script>
</asp:Content>
