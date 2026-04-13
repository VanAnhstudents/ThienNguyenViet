<%@ Page Title="Quản lý Quyên góp" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyQuyenGop.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyQuyenGop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .qg-stat-grid { display: grid; grid-template-columns: repeat(5,1fr); gap: 14px; margin-bottom: 18px; }
    .qg-stat-card {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .qg-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }

    /* Stat card chỉ 2 thành phần: label + value */
    .qg-stat-card .stat-card-label {
        font-size: 10px; color: var(--txt-sub); text-transform: uppercase;
        letter-spacing: .04em; font-weight: 600; margin-bottom: 6px;
    }
    .qg-stat-card .stat-card-value {
        font-size: 22px; font-weight: 700;
    }

    /* Donor cell - BỎ avatar */
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
    .proof-wrap {
        margin-top: 6px; border: 1px solid var(--border); border-radius: var(--r);
        padding: 10px; min-height: 60px; display: flex; align-items: center;
        justify-content: center; background: var(--bg); font-size: 12px; color: var(--txt-sub);
    }
    .proof-wrap img { max-width: 100%; max-height: 260px; border-radius: var(--r); }
    .reject-textarea {
        width: 100%; padding: 8px 10px; border: 1px solid var(--border);
        border-radius: var(--r); font-family: var(--font); font-size: 13px;
        resize: vertical; min-height: 80px; outline: none;
    }
    .reject-textarea:focus { border-color: var(--accent); }

    @media (max-width: 1024px) { .qg-stat-grid { grid-template-columns: repeat(3,1fr); } }
    @media (max-width: 768px) { .qg-stat-grid { grid-template-columns: repeat(2,1fr); gap: 10px; } }
    @media (max-width: 425px) { .qg-stat-grid { grid-template-columns: 1fr 1fr; gap: 8px; } }
    @media (max-width: 375px) { .qg-stat-grid { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý quyên góp</h1>
    <p>Duyệt, từ chối và theo dõi giao dịch quyên góp</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Thống kê - chỉ 2 thành phần: label + value --%>
    <div class="qg-stat-grid" id="qgStats">
        <div class="qg-stat-card">
            <div class="stat-card-label">Tổng giao dịch</div>
            <div class="stat-card-value" id="sTong">--</div>
        </div>
        <div class="qg-stat-card">
            <div class="stat-card-label">Chờ duyệt</div>
            <div class="stat-card-value" id="sCho" style="color:var(--warn)">--</div>
        </div>
        <div class="qg-stat-card">
            <div class="stat-card-label">Đã duyệt</div>
            <div class="stat-card-value" id="sDuyet" style="color:var(--ok)">--</div>
        </div>
        <div class="qg-stat-card">
            <div class="stat-card-label">Từ chối</div>
            <div class="stat-card-value" id="sTuChoi" style="color:var(--err)">--</div>
        </div>
        <div class="qg-stat-card">
            <div class="stat-card-label">Tổng tiền</div>
            <div class="stat-card-value" id="sTien" style="color:var(--accent)">--</div>
        </div>
    </div>

    <%-- Thanh tìm kiếm --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <input type="text" class="input" id="txtSearch" placeholder="Tìm kiếm theo tên người góp, chiến dịch..." />
            <button type="button" class="btn btn-primary" onclick="doSearch()">Tìm kiếm</button>
        </div>
    </div>

    <%-- Bộ lọc trạng thái --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterTab">
            <button type="button" class="filter-btn active" data-val="">Tất cả</button>
            <button type="button" class="filter-btn" data-val="0">Chờ duyệt</button>
            <button type="button" class="filter-btn" data-val="1">Đã duyệt</button>
            <button type="button" class="filter-btn" data-val="2">Từ chối</button>
        </div>
    </div>

    <%-- Bảng dữ liệu --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Mã</th><th>Người góp</th><th>Chiến dịch</th>
                    <th>Số tiền</th><th>Lời nhắn</th><th>Ngày</th>
                    <th>Trạng thái</th><th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="qgBody">
                <tr><td colspan="8" class="empty-state">Đang tải...</td></tr>
            </tbody>
        </table>
    </div>
    <div class="paging" id="qgPaging"></div>

    <%-- Modal chi tiết --%>
    <div class="overlay" id="detailOverlay" onclick="if(event.target===this)closeQGDetail()">
        <div class="modal modal-wide">
            <div class="modal-hd">
                <h3>Chi tiết giao dịch</h3>
                <button type="button" class="modal-close" onclick="closeQGDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid" id="detailContent"></div>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeQGDetail()">Đóng</button>
            </div>
        </div>
    </div>

    <%-- Modal từ chối --%>
    <div class="overlay" id="rejectOverlay" onclick="if(event.target===this)closeReject()">
        <div class="modal" style="max-width:420px">
            <div class="modal-hd">
                <h3>Từ chối giao dịch</h3>
                <button type="button" class="modal-close" onclick="closeReject()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px;margin-bottom:10px">Nhập lý do từ chối giao dịch này:</p>
                <textarea class="reject-textarea" id="rejectReason" placeholder="Nhập lý do từ chối..."></textarea>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeReject()">Hủy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmReject">Từ chối</button>
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

        function loadData() {
            var tuKhoa = (document.getElementById('txtSearch').value || '').trim();
            var url = BASE + '?__ajax=true&action=list&page=' + currentPage + '&pageSize=' + pageSize;
            if (currentTab !== '') url += '&tab=' + currentTab;
            if (tuKhoa) url += '&q=' + encodeURIComponent(tuKhoa);

            fetch(url)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    renderTable(d.rows || []);
                    renderPaging(d.total || 0);
                })
                .catch(function () { showToast('Lỗi', 'Không tải được dữ liệu.', 'err'); });
        }

        function renderTable(rows) {
            var body = document.getElementById('qgBody');
            if (!rows.length) { body.innerHTML = '<tr><td colspan="8" class="empty-state">Không có giao dịch nào.</td></tr>'; return; }

            var html = '';
            rows.forEach(function (r) {
                var tsLabel = ['Chờ duyệt', 'Đã duyệt', 'Từ chối'][r.trangThai] || '';
                var tsCls = ['badge-warn', 'badge-ok', 'badge-err'][r.trangThai] || '';

                /* BỎ donor-av avatar, chỉ hiển thị tên thuần */
                html += '<tr>' +
                    '<td>#' + r.maQG + '</td>' +
                    '<td><div><div class="donor-name">' + esc(r.hoTen) + '</div><div class="donor-email">' + esc(r.email || '') + '</div></div></td>' +
                    '<td style="max-width:250px">' + esc(r.tenCD) + '</td>' +
                    '<td class="amount-cell">' + Number(r.soTien).toLocaleString('vi-VN') + ' đ</td>' +
                    '<td><div class="msg-cell">' + esc(r.loiNhan || '') + '</div>' +
                    (r.lyDo ? '<div class="reject-reason">' + esc(r.lyDo) + '</div>' : '') + '</td>' +
                    '<td style="white-space:nowrap;font-size:11px">' + r.ngayTao + '</td>' +
                    '<td><span class="badge ' + tsCls + '">' + tsLabel + '</span></td>' +
                    '<td><div style="display:flex;gap:4px">' +
                    '<button type="button" class="btn btn-xs btn-outline" onclick=\'viewDetail(' + JSON.stringify(r) + ')\'>Xem</button>';

                if (r.trangThai === 0) {
                    html += '<button type="button" class="btn btn-xs btn-success" onclick="approveQG(' + r.maQG + ')">Duyệt</button>' +
                        '<button type="button" class="btn btn-xs btn-danger" onclick="openReject(' + r.maQG + ')">Từ chối</button>';
                }
                html += '</div></td></tr>';
            });
            body.innerHTML = html;
        }

        function renderPaging(total) {
            var totalPages = Math.ceil(total / pageSize);
            var wrap = document.getElementById('qgPaging');
            if (totalPages <= 1) { wrap.innerHTML = ''; return; }
            var html = '<span class="paging-info">' + total + ' kết quả</span>';
            html += '<button class="page-btn" onclick="qgPage(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>Trước</button>';
            for (var p = 1; p <= totalPages; p++) {
                html += '<button class="page-btn' + (p === currentPage ? ' active' : '') + '" onclick="qgPage(' + p + ')">' + p + '</button>';
            }
            html += '<button class="page-btn" onclick="qgPage(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp</button>';
            wrap.innerHTML = html;
        }

        // FIX: Expose pagination to window scope
        window.qgPage = function (p) {
            if (p < 1) return;
            currentPage = p;
            loadData();
        };

        // Tìm kiếm
        window.doSearch = function () { currentPage = 1; loadData(); };
        document.getElementById('txtSearch').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') { e.preventDefault(); window.doSearch(); }
        });

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

        // Xem chi tiết - BỎ avatar
        window.viewDetail = function (r) {
            var tsNames = ['Chờ duyệt', 'Đã duyệt', 'Từ chối'];
            var html = '' +
                '<div class="detail-item"><label>Mã giao dịch</label><span class="detail-val">#' + r.maQG + '</span></div>' +
                '<div class="detail-item"><label>Ngày tạo</label><span class="detail-val">' + r.ngayTao + '</span></div>' +
                '<div class="detail-item"><label>Người góp</label><span class="detail-val">' + esc(r.hoTen) + '</span></div>' +
                '<div class="detail-item"><label>Email</label><span class="detail-val">' + esc(r.email || '(không có)') + '</span></div>' +
                '<div class="detail-item"><label>Chiến dịch</label><span class="detail-val">' + esc(r.tenCD) + '</span></div>' +
                '<div class="detail-item"><label>Số tiền</label><span class="detail-val" style="font-weight:700;color:var(--ok)">' + Number(r.soTien).toLocaleString('vi-VN') + ' đ</span></div>' +
                '<div class="detail-item"><label>Trạng thái</label><span class="detail-val">' + (tsNames[r.trangThai] || '') + '</span></div>' +
                '<div class="detail-item"><label>Ẩn danh</label><span class="detail-val">' + (r.anDanh ? 'Có' : 'Không') + '</span></div>' +
                '<div class="detail-item detail-full"><label>Lời nhắn</label><span class="detail-val" style="font-style:italic">' + esc(r.loiNhan || '(không có)') + '</span></div>' +
                '<div class="detail-item detail-full"><label>Ảnh xác nhận</label><div class="proof-wrap">' +
                (r.anhXN ? '<img src="' + r.anhXN + '" onerror="this.parentNode.innerHTML=\'Không tải được ảnh\'" />' : 'Chưa có ảnh xác nhận') +
                '</div></div>';
            document.getElementById('detailContent').innerHTML = html;
            document.getElementById('detailOverlay').classList.add('show');
        };
        window.closeQGDetail = function () { document.getElementById('detailOverlay').classList.remove('show'); };

        // Duyệt
        window.approveQG = function (id) {
            if (!confirm('Bạn có chắc muốn duyệt giao dịch #' + id + '?')) return;
            fetch(BASE + '?__ajax=true&action=approve&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) { showToast('Thành công', j.msg || 'Đã duyệt giao dịch.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };

        // Từ chối
        window.openReject = function (id) {
            pendingRejectId = id;
            document.getElementById('rejectReason').value = '';
            document.getElementById('rejectOverlay').classList.add('show');
        };
        window.closeReject = function () { document.getElementById('rejectOverlay').classList.remove('show'); };

        document.getElementById('btnConfirmReject').addEventListener('click', function () {
            if (!pendingRejectId) return;
            var lyDo = document.getElementById('rejectReason').value.trim();
            if (!lyDo) { showToast('Thiếu thông tin', 'Vui lòng nhập lý do từ chối.', 'warn'); return; }
            fetch(BASE + '?__ajax=true&action=reject&id=' + pendingRejectId + '&lydo=' + encodeURIComponent(lyDo))
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    closeReject();
                    if (j.ok) { showToast('Thành công', j.msg || 'Đã từ chối giao dịch.', 'ok'); loadStats(); loadData(); }
                    else showToast('Lỗi', j.msg || 'Lỗi.', 'err');
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        });

        loadStats();
        loadData();
    })();
</script>
</asp:Content>
