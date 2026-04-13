<%@ Page Title="Quan ly Tin tuc" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyTinTuc.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .tt-stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; }
    .tt-stat-card {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px; text-align: center;
        transition: box-shadow .2s;
    }
    .tt-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .tt-stat-card strong { display: block; font-size: 22px; font-weight: 700; margin-bottom: 4px; }
    .tt-stat-card span {
        font-size: 10px; color: var(--txt-sub); text-transform: uppercase;
        letter-spacing: .04em; font-weight: 600;
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
    .tt-views { font-size: 12px; color: var(--txt-sub); }

    @media (max-width: 768px) { .tt-stats-row { grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 480px) { .tt-stats-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quan ly tin tuc</h1>
    <p>Quan ly bai viet, tin tuc tren he thong</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Stats --%>
    <div class="tt-stats-row" id="ttStats">
        <div class="tt-stat-card"><strong id="ttTong">--</strong><span>Tong bai viet</span></div>
        <div class="tt-stat-card"><strong id="ttXuatBan" style="color:var(--ok)">--</strong><span>Xuat ban</span></div>
        <div class="tt-stat-card"><strong id="ttNhap" style="color:var(--warn)">--</strong><span>Nhap</span></div>
        <div class="tt-stat-card"><strong id="ttLuotXem" style="color:var(--accent)">--</strong><span>Tong luot xem</span></div>
    </div>

    <div class="page-topbar">
        <h3>Danh sach bai viet</h3>
        <a href="<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>" class="btn btn-primary">Them bai viet</a>
    </div>

    <%-- Filter --%>
    <div class="filter-bar">
        <div class="filter-group" id="ttFilterStatus">
            <button type="button" class="filter-btn active" data-val="">Tat ca</button>
            <button type="button" class="filter-btn" data-val="1">Xuat ban</button>
            <button type="button" class="filter-btn" data-val="0">Nhap</button>
        </div>
        <select class="select" id="ttFilterDM" style="min-width:140px">
            <option value="">Tat ca danh muc</option>
        </select>
    </div>

    <%-- Table --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th></th><th>Tieu de</th><th>Nguoi dang</th>
                    <th>Ngay dang</th><th>Luot xem</th><th>Trang thai</th><th></th>
                </tr>
            </thead>
            <tbody id="ttBody">
                <tr><td colspan="7" class="empty-state">Dang tai...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="ttPaging"></div>

    <%-- Modal xoa --%>
    <div class="overlay" id="modalXoa" onclick="if(event.target===this)closeModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xoa bai viet</h3>
                <button type="button" class="modal-close" onclick="closeModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Ban co chac chan muon xoa bai viet "<strong id="xoa-title"></strong>"?</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeModal()">Huy</button>
                <button type="button" class="btn btn-danger" onclick="confirmXoa()">Xoa</button>
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

        // Load stats
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

        // Load danh muc
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

        // Load data
        function loadData() {
            var url = BASE + '?__ajax=true&action=list&trang=' + currentPage + '&soDong=10';
            if (filterTT !== '') url += '&trangThai=' + filterTT;
            if (filterDM !== '') url += '&maDanhMuc=' + filterDM;

            fetch(url)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    renderTable(d.data || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Loi', 'Khong tai duoc du lieu.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('ttBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="7" class="empty-state">Khong co bai viet nao.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var tsLabel = r.TrangThai === 1 ? 'Xuat ban' : 'Nhap';
                var tsCls = r.TrangThai === 1 ? 'badge-ok' : 'badge-warn';
                var thumb = r.AnhBia ? '<img class="tt-thumb" src="' + r.AnhBia + '" onerror="this.style.display=\'none\'" />' : '<div class="tt-thumb" style="display:flex;align-items:center;justify-content:center;font-size:9px;color:var(--txt-sub)">N/A</div>';

                html += '<tr>' +
                    '<td>' + thumb + '</td>' +
                    '<td><div class="tt-title-cell">' + esc(r.TieuDe) + '</div></td>' +
                    '<td style="font-size:12px">' + esc(r.NguoiDang || '') + '</td>' +
                    '<td style="font-size:11px;white-space:nowrap">' + r.NgayDang + '</td>' +
                    '<td class="tt-views">' + Number(r.LuotXem || 0).toLocaleString('vi-VN') + '</td>' +
                    '<td><span class="badge ' + tsCls + '">' + tsLabel + '</span></td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<a href="' + FORM_URL + '?id=' + r.MaTinTuc + '" class="btn btn-xs btn-outline">Sua</a>' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick="toggleTrangThai(' + r.MaTinTuc + ')">' + (r.TrangThai === 1 ? 'An' : 'Hien') + '</button>' +
                    '<button type="button" class="btn btn-xs" style="background:var(--err-bg);color:var(--err-txt)" onclick="openXoa(' + r.MaTinTuc + ',\'' + esc(r.TieuDe).replace(/'/g, "\\'") + '\')">Xoa</button>' +
                    '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / 10);
            var wrap = document.getElementById('ttPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' bai viet</span>';
            html += '<button class="page-btn" onclick="ttPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Truoc</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="ttPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="ttPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiep</button>';
            wrap.innerHTML = html;
        }

        window.ttPage = function (p) { currentPage = p; loadData(); };

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

        // Toggle trang thai
        window.toggleTrangThai = function (id) {
            fetch(BASE + '?__ajax=true&action=toggle&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) { showToast('Thanh cong', 'Da cap nhat trang thai.', 'ok'); loadStats(); loadData(); }
                    else showToast('Loi', j.msg || 'Loi.', 'err');
                })
                .catch(function () { showToast('Loi', 'Loi ket noi server.', 'err'); });
        };

        // Xoa
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
                    if (j.ok) { showToast('Thanh cong', 'Da xoa bai viet.', 'ok'); loadStats(); loadData(); }
                    else showToast('Loi', j.msg || 'Loi.', 'err');
                })
                .catch(function () { showToast('Loi', 'Loi ket noi server.', 'err'); });
        };
        window.closeModal = function () {
            document.getElementById('modalXoa').classList.remove('show');
        };

        function esc(s) { var d = document.createElement('div'); d.textContent = s; return d.innerHTML; }

        loadStats();
        loadDanhMuc();
        loadData();
    })();
</script>
</asp:Content>
