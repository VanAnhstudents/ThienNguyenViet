<%@ Page Title="Quan ly Nguoi dung" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyNguoiDung.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .nd-stats { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; }
    .nd-stat {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px; text-align: center;
        transition: box-shadow .2s;
    }
    .nd-stat:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .nd-stat strong { display: block; font-size: 22px; font-weight: 700; margin-bottom: 4px; }
    .nd-stat span { font-size: 10px; color: var(--txt-sub); text-transform: uppercase; font-weight: 600; }

    /* User cell */
    .user-cell { display: flex; align-items: center; gap: 10px; }
    .user-av {
        width: 32px; height: 32px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 11px; font-weight: 700; flex-shrink: 0;
        background: var(--accent-light); color: var(--accent);
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
    @media (max-width: 480px) { .nd-stats { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quan ly nguoi dung</h1>
    <p>Danh sach tai khoan nguoi dung</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Stats --%>
    <div class="nd-stats">
        <div class="nd-stat"><strong id="ndTong">--</strong><span>Tong tai khoan</span></div>
        <div class="nd-stat"><strong id="ndHoatDong" style="color:var(--ok)">--</strong><span>Hoat dong</span></div>
        <div class="nd-stat"><strong id="ndKhoa" style="color:var(--err)">--</strong><span>Da khoa</span></div>
        <div class="nd-stat"><strong id="ndQuyenGop" style="color:var(--accent)">--</strong><span>Tong quyen gop</span></div>
    </div>

    <%-- Filter --%>
    <div class="filter-bar">
        <div class="filter-group" id="ndFilterTT">
            <button type="button" class="filter-btn active" data-val="">Tat ca</button>
            <button type="button" class="filter-btn" data-val="1">Hoat dong</button>
            <button type="button" class="filter-btn" data-val="0">Da khoa</button>
        </div>
        <div class="filter-group" id="ndFilterVT">
            <button type="button" class="filter-btn active" data-val="">Tat ca vai tro</button>
            <button type="button" class="filter-btn" data-val="0">Nguoi dung</button>
            <button type="button" class="filter-btn" data-val="1">Admin</button>
        </div>
    </div>

    <%-- Table --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Nguoi dung</th>
                    <th>Email</th>
                    <th>SDT</th>
                    <th>Vai tro</th>
                    <th>Trang thai</th>
                    <th>Ngay tao</th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="ndBody">
                <tr><td colspan="7" class="empty-state">Dang tai...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="ndPaging"></div>

    <%-- Modal chi tiet --%>
    <div class="overlay" id="ndDetailOverlay" onclick="if(event.target===this)closeNdDetail()">
        <div class="modal">
            <div class="modal-hd">
                <h3>Chi tiet tai khoan</h3>
                <button type="button" class="modal-close" onclick="closeNdDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid" id="ndDetailContent"></div>
            </div>
            <div class="modal-ft" id="ndDetailFt">
                <button type="button" class="btn btn-outline" onclick="closeNdDetail()">Dong</button>
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

        // Load stats
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

        // Load data
        function loadData() {
            var url = BASE + '?__ajax=true&action=list&trang=' + currentPage + '&soDong=' + pageSize;
            if (filterTT !== '') url += '&trangThai=' + filterTT;
            if (filterVT !== '') url += '&vaiTro=' + filterVT;

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
            var body = document.getElementById('ndBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="7" class="empty-state">Khong co nguoi dung nao.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var ini = r.HoTen ? r.HoTen.trim().split(' ').pop().charAt(0).toUpperCase() : '?';
                var roleCls = r.VaiTro === 1 ? 'role-admin' : 'role-user';
                var roleLabel = r.VaiTro === 1 ? 'Admin' : 'Nguoi dung';
                var ttLabel = r.TrangThai === 1 ? 'Hoat dong' : 'Da khoa';
                var ttCls = r.TrangThai === 1 ? 'badge-ok' : 'badge-err';

                html += '<tr>' +
                    '<td><div class="user-cell"><div class="user-av">' + ini + '</div><div><div class="user-fullname">' + esc(r.HoTen) + '</div></div></div></td>' +
                    '<td style="font-size:12px">' + esc(r.Email || '') + '</td>' +
                    '<td style="font-size:12px">' + esc(r.SoDienThoai || '') + '</td>' +
                    '<td><span class="user-role ' + roleCls + '">' + roleLabel + '</span></td>' +
                    '<td><span class="badge ' + ttCls + '">' + ttLabel + '</span></td>' +
                    '<td style="font-size:11px;white-space:nowrap">' + (r.NgayTao || '') + '</td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick=\'viewNdDetail(' + JSON.stringify(r) + ')\'>Xem</button>';

                if (r.TrangThai === 1) {
                    html += '<button type="button" class="btn btn-xs" style="background:var(--err-bg);color:var(--err-txt)" onclick="lockUser(' + r.MaNguoiDung + ')">Khoa</button>';
                } else {
                    html += '<button type="button" class="btn btn-xs btn-success" onclick="unlockUser(' + r.MaNguoiDung + ')">Mo khoa</button>';
                }
                html += '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('ndPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' tai khoan</span>';
            html += '<button class="page-btn" onclick="ndPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Truoc</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="ndPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="ndPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiep</button>';
            wrap.innerHTML = html;
        }

        window.ndPage = function (p) { currentPage = p; loadData(); };

        // Filter: trang thai
        document.getElementById('ndFilterTT').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                filterTT = e.target.getAttribute('data-val');
                currentPage = 1; loadData();
            }
        });
        // Filter: vai tro
        document.getElementById('ndFilterVT').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                filterVT = e.target.getAttribute('data-val');
                currentPage = 1; loadData();
            }
        });

        // View detail
        window.viewNdDetail = function (r) {
            var roleLabel = r.VaiTro === 1 ? 'Admin' : 'Nguoi dung';
            var ttLabel = r.TrangThai === 1 ? 'Hoat dong' : 'Da khoa';
            var html = '' +
                '<div class="detail-item"><label>Ma nguoi dung</label><span class="detail-val">#' + r.MaNguoiDung + '</span></div>' +
                '<div class="detail-item"><label>Ho ten</label><span class="detail-val">' + esc(r.HoTen) + '</span></div>' +
                '<div class="detail-item"><label>Email</label><span class="detail-val">' + esc(r.Email || '') + '</span></div>' +
                '<div class="detail-item"><label>SDT</label><span class="detail-val">' + esc(r.SoDienThoai || '') + '</span></div>' +
                '<div class="detail-item"><label>Vai tro</label><span class="detail-val">' + roleLabel + '</span></div>' +
                '<div class="detail-item"><label>Trang thai</label><span class="detail-val">' + ttLabel + '</span></div>' +
                '<div class="detail-item"><label>Ngay tao</label><span class="detail-val">' + (r.NgayTao || '') + '</span></div>' +
                '<div class="detail-item"><label>Tong quyen gop</label><span class="detail-val" style="font-weight:700;color:var(--ok)">' + Number(r.TongQuyenGop || 0).toLocaleString('vi-VN') + ' d</span></div>';
            document.getElementById('ndDetailContent').innerHTML = html;

            // Nut khoa/mo khoa trong modal
            var ft = document.getElementById('ndDetailFt');
            var extraBtn = '';
            if (r.TrangThai === 1) {
                extraBtn = '<button type="button" class="btn btn-danger" onclick="lockUser(' + r.MaNguoiDung + ');closeNdDetail()">Khoa tai khoan</button>';
            } else {
                extraBtn = '<button type="button" class="btn btn-success" onclick="unlockUser(' + r.MaNguoiDung + ');closeNdDetail()">Mo khoa</button>';
            }
            ft.innerHTML = '<button type="button" class="btn btn-outline" onclick="closeNdDetail()">Dong</button>' + extraBtn;

            document.getElementById('ndDetailOverlay').classList.add('show');
        };
        window.closeNdDetail = function () { document.getElementById('ndDetailOverlay').classList.remove('show'); };

        // Lock / Unlock
        window.lockUser = function (id) {
            showConfirm({
                title: 'Khoa tai khoan',
                msg: 'Ban co chac chan muon khoa tai khoan #' + id + '?',
                okLabel: 'Khoa',
                okClass: 'btn-danger',
                onOk: function () {
                    fetch(BASE + '?__ajax=true&action=lock&id=' + id)
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d.ok) { showToast('Thanh cong', 'Da khoa tai khoan.', 'ok'); loadStats(); loadData(); }
                            else showToast('Loi', d.msg, 'err');
                        });
                }
            });
        };
        window.unlockUser = function (id) {
            fetch(BASE + '?__ajax=true&action=unlock&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (d.ok) { showToast('Thanh cong', 'Da mo khoa tai khoan.', 'ok'); loadStats(); loadData(); }
                    else showToast('Loi', d.msg, 'err');
                });
        };

        function esc(s) { var d = document.createElement('div'); d.textContent = s; return d.innerHTML; }

        loadStats();
        loadData();
    })();
</script>
</asp:Content>
