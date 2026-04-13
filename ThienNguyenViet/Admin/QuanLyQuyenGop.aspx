<%@ Page Title="Quan ly Quyen gop" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyQuyenGop.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyQuyenGop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    /* QuanLyQuyenGop */
    .qg-stat-grid { display: grid; grid-template-columns: repeat(5,1fr); gap: 14px; margin-bottom: 18px; }
    .qg-stat-card {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px; text-align: center;
        transition: box-shadow .2s;
    }
    .qg-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .qg-stat-card strong { display: block; font-size: 22px; font-weight: 700; margin-bottom: 4px; }
    .qg-stat-card span {
        font-size: 10px; color: var(--txt-sub); text-transform: uppercase;
        letter-spacing: .04em; font-weight: 600;
    }

    /* Donor cell */
    .donor-cell { display: flex; align-items: center; gap: 8px; }
    .donor-av {
        width: 28px; height: 28px; border-radius: 50%;
        background: var(--accent-light); color: var(--accent);
        display: flex; align-items: center; justify-content: center;
        font-size: 10px; font-weight: 700; flex-shrink: 0;
    }
    .donor-name { font-size: 12px; font-weight: 500; }
    .donor-email { font-size: 10px; color: var(--txt-sub); }
    .amount-cell { color: var(--ok); font-weight: 600; white-space: nowrap; }
    .msg-cell {
        max-width: 160px; font-size: 11px; color: var(--txt-sub);
        white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-style: italic;
    }
    .reject-reason {
        font-size: 10px; color: var(--err-txt); background: var(--err-bg);
        border-radius: 4px; padding: 2px 6px; margin-top: 3px;
        max-width: 160px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    }

    /* Proof */
    .proof-wrap {
        margin-top: 6px; border: 1px solid var(--border); border-radius: var(--r);
        padding: 10px; min-height: 60px; display: flex; align-items: center;
        justify-content: center; background: var(--bg); font-size: 12px; color: var(--txt-sub);
    }
    .proof-wrap img { max-width: 100%; max-height: 260px; border-radius: var(--r); }

    /* Reject textarea */
    .reject-textarea {
        width: 100%; padding: 8px 10px; border: 1px solid var(--border);
        border-radius: var(--r); font-family: var(--font); font-size: 13px;
        resize: vertical; min-height: 80px; outline: none;
    }
    .reject-textarea:focus { border-color: var(--accent); }

    @media (max-width: 1024px) { .qg-stat-grid { grid-template-columns: repeat(3,1fr); } }
    @media (max-width: 768px) { .qg-stat-grid { grid-template-columns: repeat(2,1fr); gap: 10px; } }
    @media (max-width: 480px) { .qg-stat-grid { grid-template-columns: 1fr 1fr; gap: 8px; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quan ly quyen gop</h1>
    <p>Duyet, tu choi va theo doi giao dich quyen gop</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Stat cards --%>
    <div class="qg-stat-grid" id="qgStats">
        <div class="qg-stat-card"><strong id="sTong">--</strong><span>Tong giao dich</span></div>
        <div class="qg-stat-card"><strong id="sCho" style="color:var(--warn)">--</strong><span>Cho duyet</span></div>
        <div class="qg-stat-card"><strong id="sDuyet" style="color:var(--ok)">--</strong><span>Da duyet</span></div>
        <div class="qg-stat-card"><strong id="sTuChoi" style="color:var(--err)">--</strong><span>Tu choi</span></div>
        <div class="qg-stat-card"><strong id="sTien" style="color:var(--accent)">--</strong><span>Tong tien</span></div>
    </div>

    <%-- Filter tabs --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterTab">
            <button type="button" class="filter-btn active" data-val="">Tat ca</button>
            <button type="button" class="filter-btn" data-val="0">Cho duyet</button>
            <button type="button" class="filter-btn" data-val="1">Da duyet</button>
            <button type="button" class="filter-btn" data-val="2">Tu choi</button>
        </div>
    </div>

    <%-- Table --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Ma</th><th>Nguoi gop</th><th>Chien dich</th>
                    <th>So tien</th><th>Loi nhan</th><th>Ngay</th>
                    <th>Trang thai</th><th></th>
                </tr>
            </thead>
            <tbody id="qgBody">
                <tr><td colspan="8" class="empty-state">Dang tai...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="qgPaging"></div>

    <%-- Modal chi tiet --%>
    <div class="overlay" id="detailOverlay" onclick="if(event.target===this)closeQGDetail()">
        <div class="modal modal-wide">
            <div class="modal-hd">
                <h3>Chi tiet giao dich</h3>
                <button type="button" class="modal-close" onclick="closeQGDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid" id="detailContent"></div>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeQGDetail()">Dong</button>
            </div>
        </div>
    </div>

    <%-- Modal tu choi --%>
    <div class="overlay" id="rejectOverlay" onclick="if(event.target===this)closeReject()">
        <div class="modal" style="max-width:420px">
            <div class="modal-hd">
                <h3>Tu choi giao dich</h3>
                <button type="button" class="modal-close" onclick="closeReject()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px;margin-bottom:10px">Nhap ly do tu choi giao dich nay:</p>
                <textarea class="reject-textarea" id="rejectReason" placeholder="Ly do tu choi..."></textarea>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeReject()">Huy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmReject">Tu choi</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = '<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>';
        var currentTab = '', currentPage = 1, pageSize = 10;
        var pendingRejectId = 0;

        // Load stats
        function loadStats() {
            fetch(BASE + '?__ajax=true&action=stats')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    document.getElementById('sTong').textContent = d.total || 0;
                    document.getElementById('sCho').textContent = d.cho || 0;
                    document.getElementById('sDuyet').textContent = d.duyet || 0;
                    document.getElementById('sTuChoi').textContent = d.tuchoi || 0;
                    document.getElementById('sTien').textContent = formatShort(d.tongTien || 0);
                });
        }

        // Load data
        function loadData() {
            var url = BASE + '?__ajax=true&action=list&page=' + currentPage + '&pageSize=' + pageSize;
            if (currentTab !== '') url += '&tab=' + currentTab;

            fetch(url)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    renderTable(d.rows || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Loi', 'Khong tai duoc du lieu.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('qgBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="8" class="empty-state">Khong co giao dich nao.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var tsLabel = ['Cho duyet', 'Da duyet', 'Tu choi'][r.trangThai] || '';
                var tsCls = ['badge-warn', 'badge-ok', 'badge-err'][r.trangThai] || '';
                var initial = r.hoTen ? r.hoTen.trim().split(' ').pop().charAt(0).toUpperCase() : '?';

                html += '<tr>' +
                    '<td>#' + r.maQG + '</td>' +
                    '<td><div class="donor-cell"><div class="donor-av">' + initial + '</div><div><div class="donor-name">' + esc(r.hoTen) + '</div><div class="donor-email">' + esc(r.email || '') + '</div></div></div></td>' +
                    '<td style="max-width:250px">' + esc(r.tenCD) + '</td>' +
                    '<td class="amount-cell">' + Number(r.soTien).toLocaleString('vi-VN') + ' d</td>' +
                    '<td><div class="msg-cell">' + esc(r.loiNhan || '') + '</div>' +
                    (r.lyDo ? '<div class="reject-reason">' + esc(r.lyDo) + '</div>' : '') + '</td>' +
                    '<td style="white-space:nowrap;font-size:11px">' + r.ngayTao + '</td>' +
                    '<td><span class="badge ' + tsCls + '">' + tsLabel + '</span></td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick=\'viewDetail(' + JSON.stringify(r) + ')\'>Xem</button>';

                if (r.trangThai === 0) {
                    html += '<button type="button" class="btn btn-xs btn-success" onclick="approveQG(' + r.maQG + ')">Duyet</button>' +
                        '<button type="button" class="btn btn-xs btn-danger" onclick="openReject(' + r.maQG + ')">Tu choi</button>';
                }
                html += '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('qgPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' ket qua</span>';
            html += '<button class="page-btn" onclick="qgPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Truoc</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="qgPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="qgPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiep</button>';
            wrap.innerHTML = html;
        }

        window.qgPage = function (p) { currentPage = p; loadData(); };

        // Filter tabs
        document.getElementById('filterTab').addEventListener('click', function (e) {
            if (e.target.classList.contains('filter-btn')) {
                this.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
                e.target.classList.add('active');
                currentTab = e.target.getAttribute('data-val');
                currentPage = 1;
                loadData();
            }
        });

        // View detail modal
        window.viewDetail = function (r) {
            var tsNames = ['Cho duyet', 'Da duyet', 'Tu choi'];
            var html = '' +
                '<div class="detail-item"><label>Ma giao dich</label><span class="detail-val">#' + r.maQG + '</span></div>' +
                '<div class="detail-item"><label>Ngay tao</label><span class="detail-val">' + r.ngayTao + '</span></div>' +
                '<div class="detail-item"><label>Nguoi gop</label><span class="detail-val">' + esc(r.hoTen) + '</span></div>' +
                '<div class="detail-item"><label>Email</label><span class="detail-val">' + esc(r.email || '(khong co)') + '</span></div>' +
                '<div class="detail-item"><label>Chien dich</label><span class="detail-val">' + esc(r.tenCD) + '</span></div>' +
                '<div class="detail-item"><label>So tien</label><span class="detail-val" style="font-weight:700;color:var(--ok)">' + Number(r.soTien).toLocaleString('vi-VN') + ' d</span></div>' +
                '<div class="detail-item"><label>Trang thai</label><span class="detail-val">' + (tsNames[r.trangThai] || '') + '</span></div>' +
                '<div class="detail-item"><label>An danh</label><span class="detail-val">' + (r.anDanh ? 'Co' : 'Khong') + '</span></div>' +
                '<div class="detail-item detail-full"><label>Loi nhan</label><span class="detail-val" style="font-style:italic">' + esc(r.loiNhan || '(khong co)') + '</span></div>' +
                '<div class="detail-item detail-full"><label>Anh xac nhan</label><div class="proof-wrap">' +
                (r.anhXN ? '<img src="' + r.anhXN + '" />' : 'Chua co anh') + '</div></div>';
            if (r.lyDo) {
                html += '<div class="detail-item detail-full"><label>Ly do tu choi</label><span class="detail-val" style="color:var(--err)">' + esc(r.lyDo) + '</span></div>';
            }
            document.getElementById('detailContent').innerHTML = html;
            document.getElementById('detailOverlay').classList.add('show');
        };
        window.closeQGDetail = function () { document.getElementById('detailOverlay').classList.remove('show'); };

        // Duyet
        window.approveQG = function (id) {
            showConfirm({
                title: 'Duyet giao dich',
                msg: 'Ban co chac chan muon duyet giao dich #' + id + '?',
                onOk: function () {
                    fetch(BASE + '?__ajax=true&action=approve&id=' + id)
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d.ok) { showToast('Thanh cong', d.msg, 'ok'); loadStats(); loadData(); }
                            else showToast('Loi', d.msg, 'err');
                        })
                        .catch(function () { showToast('Loi', 'Loi ket noi.', 'err'); });
                }
            });
        };

        // Tu choi
        window.openReject = function (id) {
            pendingRejectId = id;
            document.getElementById('rejectReason').value = '';
            document.getElementById('rejectOverlay').classList.add('show');
        };
        window.closeReject = function () { document.getElementById('rejectOverlay').classList.remove('show'); };
        document.getElementById('btnConfirmReject').onclick = function () {
            var lydo = document.getElementById('rejectReason').value.trim();
            if (!lydo) { showToast('Thieu thong tin', 'Vui long nhap ly do tu choi.', 'warn'); return; }
            fetch(BASE + '?__ajax=true&action=reject&id=' + pendingRejectId + '&lydo=' + encodeURIComponent(lydo))
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    closeReject();
                    if (d.ok) { showToast('Thanh cong', d.msg, 'ok'); loadStats(); loadData(); }
                    else showToast('Loi', d.msg, 'err');
                })
                .catch(function () { showToast('Loi', 'Loi ket noi.', 'err'); });
        };

        function esc(s) { var d = document.createElement('div'); d.textContent = s; return d.innerHTML; }

        loadStats();
        loadData();
    })();
</script>
</asp:Content>
