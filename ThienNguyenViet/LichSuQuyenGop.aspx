<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LichSuQuyenGop.aspx.cs" Inherits="ThienNguyenViet.LichSuQuyenGop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   LỊCH SỬ QUYÊN GÓP — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Page Header ────────────────────────────────────────────── */
.history-page-header {
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 55%, #3D9962 100%);
    padding: 48px 0 80px;
    position: relative; overflow: hidden;
}
.history-page-header::before {
    content: '';
    position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Ccircle cx='30' cy='30' r='1' fill='rgba(255,255,255,.07)'/%3E%3C/svg%3E");
}
.history-header-inner {
    max-width: 1100px; margin: 0 auto; padding: 0 24px;
    position: relative; z-index: 1;
    display: flex; align-items: flex-end; justify-content: space-between;
    flex-wrap: wrap; gap: 16px;
}
.history-header-badge {
    display: inline-flex; align-items: center; gap: 7px;
    background: rgba(255,255,255,.12); backdrop-filter: blur(8px);
    color: rgba(255,255,255,.9); font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: .1em;
    padding: 5px 16px; border-radius: 99px;
    border: 1px solid rgba(255,255,255,.18);
    margin-bottom: 10px;
}
.history-header-title {
    font-family: 'Playfair Display', serif;
    font-size: 28px; font-weight: 800; color: #fff; margin-bottom: 4px;
}
.history-header-sub { font-size: 13px; color: rgba(255,255,255,.65); }

/* Quick stats in header */
.header-quick-stats {
    display: flex; gap: 16px; flex-wrap: wrap;
}
.header-stat-chip {
    background: rgba(255,255,255,.12); backdrop-filter: blur(8px);
    border: 1px solid rgba(255,255,255,.18); border-radius: 12px;
    padding: 12px 18px; text-align: center;
}
.header-stat-chip .chip-val {
    font-family: 'Playfair Display', serif;
    font-size: 22px; font-weight: 800; color: #fff; line-height: 1;
    margin-bottom: 3px;
}
.header-stat-chip .chip-lbl {
    font-size: 11px; color: rgba(255,255,255,.65); font-weight: 500;
}

/* ── Page Wrapper ────────────────────────────────────────────── */
.history-page {
    max-width: 1100px; margin: -48px auto 80px;
    padding: 0 24px;
    position: relative; z-index: 2;
    display: flex; flex-direction: column; gap: 20px;
}

/* ── Filter Panel ────────────────────────────────────────────── */
.filter-panel {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.09);
    padding: 20px 24px;
}
.filter-panel-inner {
    display: flex; align-items: center; gap: 14px; flex-wrap: wrap;
}
.filter-label {
    font-size: 13px; font-weight: 700; color: var(--chu-chinh);
    flex-shrink: 0;
}
.filter-divider {
    width: 1px; height: 28px; background: var(--vien); flex-shrink: 0;
}

/* Status pills */
.status-pills { display: flex; gap: 8px; flex-wrap: wrap; }
.status-pill {
    height: 34px; padding: 0 15px; border-radius: 99px;
    font-size: 12.5px; font-weight: 600; font-family: var(--font);
    cursor: pointer; border: 1.5px solid var(--vien);
    background: #fff; color: var(--chu-than);
    transition: all .18s;
    display: inline-flex; align-items: center; gap: 5px;
}
.status-pill:hover { border-color: var(--mau-chinh-nhat); color: var(--mau-chinh); background: var(--mau-chinh-nen); }
.status-pill.active { box-shadow: 0 2px 8px rgba(45,122,79,.2); }

.status-pill.pill-all.active    { background: var(--mau-chinh); border-color: var(--mau-chinh); color: #fff; }
.status-pill.pill-pending.active{ background: #ED8936; border-color: #ED8936; color: #fff; }
.status-pill.pill-approved.active{ background: #38A169; border-color: #38A169; color: #fff; }
.status-pill.pill-rejected.active{ background: #E53E3E; border-color: #E53E3E; color: #fff; }

/* Date range */
.date-range {
    display: flex; align-items: center; gap: 8px; flex-wrap: wrap;
}
.date-input {
    height: 36px; padding: 0 12px;
    border: 1.5px solid var(--vien); border-radius: 9px;
    font-size: 13px; font-family: var(--font); color: var(--chu-chinh);
    background: #FAFAFA; outline: none; transition: border-color .2s;
    cursor: pointer;
}
.date-input:focus { border-color: var(--mau-chinh); }
.date-sep { font-size: 12px; color: var(--chu-phu); }

/* Search in filter */
.filter-search {
    position: relative; flex: 1; min-width: 180px;
}
.filter-search-icon {
    position: absolute; left: 11px; top: 50%; transform: translateY(-50%);
    font-size: 13px; pointer-events: none; color: var(--chu-phu);
}
.filter-search input {
    width: 100%; height: 36px; padding: 0 12px 0 34px;
    border: 1.5px solid var(--vien); border-radius: 9px;
    font-size: 13px; font-family: var(--font); color: var(--chu-chinh);
    background: #FAFAFA; outline: none; transition: all .2s;
}
.filter-search input:focus {
    border-color: var(--mau-chinh); background: #fff;
    box-shadow: 0 0 0 3px rgba(45,122,79,.10);
}
.filter-search input::placeholder { color: #A0AEC0; }

.btn-filter-reset {
    height: 36px; padding: 0 16px; border-radius: 9px;
    border: 1.5px solid var(--vien); background: #fff;
    font-size: 12.5px; font-weight: 600; color: var(--chu-phu);
    font-family: var(--font); cursor: pointer; transition: all .18s;
    white-space: nowrap;
}
.btn-filter-reset:hover { border-color: #FEB2B2; color: #E53E3E; }

/* ── Main Card ───────────────────────────────────────────────── */
.history-card {
    background: #fff; border-radius: 20px;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.07);
    overflow: hidden;
}
.history-card-header {
    padding: 18px 24px;
    border-bottom: 1px solid #F0F7F2;
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 10px;
}
.history-card-title {
    font-size: 15px; font-weight: 700; color: #1A3D28;
    display: flex; align-items: center; gap: 8px;
}
.results-info {
    font-size: 13px; color: var(--chu-phu);
}
.results-info strong { color: var(--chu-chinh); }

.btn-export {
    height: 34px; padding: 0 16px; border-radius: 8px;
    border: 1.5px solid var(--mau-chinh-nhat);
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 12.5px; font-weight: 700; font-family: var(--font);
    cursor: pointer; transition: all .18s;
    display: flex; align-items: center; gap: 5px;
}
.btn-export:hover { background: var(--mau-chinh); color: #fff; }

/* ── Table ───────────────────────────────────────────────────── */
.table-wrap { overflow-x: auto; }

table.history-table {
    width: 100%; border-collapse: collapse;
}
.history-table thead th {
    padding: 12px 18px; text-align: left;
    font-size: 11px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .07em; color: var(--chu-phu);
    background: #F8FBF9;
    border-bottom: 1px solid #EBF4EE;
    white-space: nowrap;
}
.history-table thead th:first-child { border-radius: 0; }

.history-table tbody tr {
    border-bottom: 1px solid #F0F7F2;
    transition: background .15s;
}
.history-table tbody tr:last-child { border-bottom: none; }
.history-table tbody tr:hover { background: #FAFDF8; }

.history-table tbody td {
    padding: 14px 18px; font-size: 14px; color: var(--chu-than);
    vertical-align: middle;
}

/* STT */
.td-stt {
    font-size: 13px; font-weight: 600; color: var(--chu-phu);
    text-align: center;
}

/* Campaign cell */
.campaign-cell { display: flex; align-items: center; gap: 12px; }
.campaign-thumb-sm {
    width: 40px; height: 40px; border-radius: 10px;
    background: linear-gradient(135deg, #EAF5EE, #B7DEC6);
    display: flex; align-items: center; justify-content: center;
    font-size: 18px; flex-shrink: 0; overflow: hidden;
}
.campaign-thumb-sm img { width: 100%; height: 100%; object-fit: cover; }
.campaign-name-text {
    font-size: 13.5px; font-weight: 600; color: #1A3D28;
    line-height: 1.35; max-width: 240px;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.campaign-cat-tiny {
    font-size: 10px; color: var(--mau-chinh); font-weight: 600; margin-top: 2px;
}

/* Amount */
.td-amount {
    font-size: 15px; font-weight: 800;
    color: var(--mau-chinh); white-space: nowrap;
}

/* Date */
.td-date { font-size: 13px; color: var(--chu-phu); white-space: nowrap; }
.td-date .date-main { font-weight: 600; color: var(--chu-than); }

/* Status badges */
.status-badge {
    display: inline-flex; align-items: center; gap: 5px;
    font-size: 11.5px; font-weight: 700; padding: 5px 12px;
    border-radius: 99px; white-space: nowrap;
}
.badge-pending  { background: #FFF3E0; color: #C05621; border: 1.5px solid #F6AD55; }
.badge-approved { background: #F0FFF4; color: #276749; border: 1.5px solid #9AE6B4; }
.badge-rejected { background: #FFF5F5; color: #C53030; border: 1.5px solid #FC8181; }

/* Actions */
.td-actions { text-align: center; }
.btn-view-detail {
    height: 32px; padding: 0 14px; border-radius: 8px;
    border: 1.5px solid var(--vien); background: #fff;
    font-size: 12px; font-weight: 600; color: var(--chu-than);
    font-family: var(--font); cursor: pointer;
    transition: all .18s; white-space: nowrap;
}
.btn-view-detail:hover {
    border-color: var(--mau-chinh); color: var(--mau-chinh);
    background: var(--mau-chinh-nen);
}

/* Empty row */
.empty-row td {
    text-align: center; padding: 60px 20px !important;
    color: var(--chu-phu); font-size: 14px;
}
.empty-row-icon { font-size: 48px; margin-bottom: 10px; }

/* ── Summary Row ─────────────────────────────────────────────── */
.summary-bar {
    padding: 18px 24px;
    border-top: 2px solid #EBF4EE;
    background: linear-gradient(to right, #F6FBF7, #fff);
    display: flex; align-items: center; gap: 0;
    flex-wrap: wrap;
}
.summary-item {
    flex: 1; min-width: 140px;
    padding: 10px 20px;
    border-right: 1px solid #EBF4EE;
    text-align: center;
}
.summary-item:last-child { border-right: none; }
.summary-item-label {
    font-size: 11px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .06em; color: var(--chu-phu); margin-bottom: 5px;
}
.summary-item-val {
    font-family: 'Playfair Display', serif;
    font-size: 20px; font-weight: 800; color: #1A3D28;
}
.summary-item-val.green { color: var(--mau-chinh); }
.summary-item-val.orange { color: var(--mau-cam); }
.summary-item-val.red  { color: #E53E3E; }

/* ── Pagination ──────────────────────────────────────────────── */
.table-pagination {
    padding: 16px 24px;
    border-top: 1px solid #F0F7F2;
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 10px;
}
.page-info { font-size: 13px; color: var(--chu-phu); }
.page-btns { display: flex; gap: 6px; }
.pg-btn {
    min-width: 36px; height: 36px; padding: 0 8px;
    border-radius: 9px; border: 1.5px solid var(--vien);
    background: #fff; color: var(--chu-than);
    font-size: 13px; font-weight: 600; font-family: var(--font);
    cursor: pointer; transition: all .15s;
    display: flex; align-items: center; justify-content: center;
}
.pg-btn:hover { border-color: var(--mau-chinh-nhat); color: var(--mau-chinh); background: var(--mau-chinh-nen); }
.pg-btn.active { background: var(--mau-chinh); border-color: var(--mau-chinh); color: #fff; box-shadow: 0 2px 8px rgba(45,122,79,.22); }
.pg-btn:disabled { opacity: .4; cursor: not-allowed; }

/* ── Detail Modal ────────────────────────────────────────────── */
.modal-overlay {
    display: none; position: fixed; inset: 0; z-index: 1000;
    background: rgba(0,0,0,.5); backdrop-filter: blur(4px);
    align-items: center; justify-content: center;
    padding: 20px;
}
.modal-overlay.open { display: flex; }

.modal-box {
    background: #fff; border-radius: 20px;
    width: 100%; max-width: 520px;
    box-shadow: 0 24px 64px rgba(0,0,0,.18);
    overflow: hidden;
    animation: modalIn .28s cubic-bezier(.175,.885,.32,1.1) both;
}
@keyframes modalIn {
    from { opacity:0; transform: scale(.92) translateY(16px); }
    to   { opacity:1; transform: scale(1) translateY(0); }
}
.modal-header {
    padding: 20px 24px 18px;
    border-bottom: 1px solid #F0F7F2;
    display: flex; align-items: center; justify-content: space-between;
}
.modal-title { font-family: 'Playfair Display', serif; font-size: 18px; font-weight: 800; color: #1A3D28; }
.modal-close {
    width: 32px; height: 32px; border-radius: 50%;
    background: #F0F7F2; border: none; cursor: pointer;
    font-size: 16px; display: flex; align-items: center; justify-content: center;
    transition: background .15s;
}
.modal-close:hover { background: #E2F0E8; }

.modal-body { padding: 24px; }
.modal-row {
    display: flex; align-items: flex-start; justify-content: space-between;
    gap: 16px; padding: 11px 0; border-bottom: 1px solid #F0F7F2;
}
.modal-row:last-child { border-bottom: none; padding-bottom: 0; }
.modal-row-label { font-size: 13px; color: var(--chu-phu); flex-shrink: 0; }
.modal-row-val   { font-size: 13.5px; font-weight: 600; color: var(--chu-chinh); text-align: right; }

.modal-proof-img {
    width: 100%; border-radius: 12px; overflow: hidden;
    background: #F6FBF7; margin-top: 14px;
    border: 1px solid #EBF4EE;
    display: flex; align-items: center; justify-content: center;
    height: 160px; font-size: 48px;
}
.modal-proof-img img { width: 100%; height: 100%; object-fit: cover; }

.modal-footer {
    padding: 16px 24px;
    border-top: 1px solid #F0F7F2; background: #FAFDF8;
    display: flex; justify-content: flex-end; gap: 10px;
}
.btn-modal-close {
    height: 38px; padding: 0 22px; border-radius: 9px;
    border: 1.5px solid var(--vien); background: #fff;
    font-size: 13px; font-weight: 600; color: var(--chu-than);
    font-family: var(--font); cursor: pointer; transition: all .18s;
}
.btn-modal-close:hover { border-color: var(--mau-chinh); color: var(--mau-chinh); }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- ═══════════════════════════════════════════════════════════
     PAGE HEADER
═══════════════════════════════════════════════════════════════ -->
<div class="history-page-header">
    <div class="history-header-inner">
        <div>
            <div class="history-header-badge">📋 Tài khoản</div>
            <h1 class="history-header-title">Lịch sử quyên góp</h1>
            <p class="history-header-sub">Toàn bộ lịch sử đóng góp của bạn cho các chiến dịch thiện nguyện.</p>
        </div>
        <div class="header-quick-stats">
            <div class="header-stat-chip">
                <div class="chip-val">4.750.000đ</div>
                <div class="chip-lbl">Tổng đã quyên góp</div>
            </div>
            <div class="header-stat-chip">
                <div class="chip-val">12</div>
                <div class="chip-lbl">Lần tham gia</div>
            </div>
            <div class="header-stat-chip">
                <div class="chip-val">9</div>
                <div class="chip-lbl">Đã xác nhận</div>
            </div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     PAGE CONTENT
═══════════════════════════════════════════════════════════════ -->
<div class="history-page">

    <!-- Back link -->
    <div>
        <a href="/HoSo.aspx" style="display:inline-flex;align-items:center;gap:6px;font-size:13px;font-weight:600;color:var(--mau-chinh);text-decoration:none;background:#fff;border:1.5px solid var(--vien);padding:8px 16px;border-radius:9px;transition:all .18s"
           onmouseover="this.style.borderColor='var(--mau-chinh)'" onmouseout="this.style.borderColor='var(--vien)'">
            ← Quay lại hồ sơ
        </a>
    </div>

    <!-- ── Filter Panel ──────────────────────────────────── -->
    <div class="filter-panel">
        <div class="filter-panel-inner">
            <span class="filter-label">🔽 Lọc:</span>

            <!-- Status -->
            <div class="status-pills">
                <button class="status-pill pill-all active"     data-status="all">📋 Tất cả <span id="countAll">(12)</span></button>
                <button class="status-pill pill-pending"        data-status="pending">⏳ Chờ xác nhận <span id="countPending">(2)</span></button>
                <button class="status-pill pill-approved"       data-status="approved">✅ Đã xác nhận <span id="countApproved">(9)</span></button>
                <button class="status-pill pill-rejected"       data-status="rejected">❌ Từ chối <span id="countRejected">(1)</span></button>
            </div>

            <div class="filter-divider"></div>

            <!-- Date range -->
            <div class="date-range">
                <input type="date" class="date-input" id="dateFrom" value="2024-01-01" title="Từ ngày" />
                <span class="date-sep">→</span>
                <input type="date" class="date-input" id="dateTo" value="2026-03-27" title="Đến ngày" />
            </div>

            <div class="filter-divider"></div>

            <!-- Search -->
            <div class="filter-search">
                <span class="filter-search-icon">🔍</span>
                <input type="text" id="searchInput" placeholder="Tìm chiến dịch..." />
            </div>

            <button class="btn-filter-reset" onclick="resetFilters()">↺ Đặt lại</button>
        </div>
    </div>

    <!-- ── History Table ─────────────────────────────────── -->
    <div class="history-card">
        <div class="history-card-header">
            <div class="history-card-title">📋 Danh sách giao dịch</div>
            <div style="display:flex;align-items:center;gap:12px;flex-wrap:wrap">
                <span class="results-info" id="resultsInfo">Hiển thị <strong>12</strong> giao dịch</span>
                <button class="btn-export" onclick="alert('Xuất Excel thành công!')">📥 Xuất Excel</button>
            </div>
        </div>

        <div class="table-wrap">
            <table class="history-table" id="historyTable">
                <thead>
                    <tr>
                        <th style="text-align:center;width:50px">#</th>
                        <th>Chiến dịch</th>
                        <th style="text-align:right">Số tiền</th>
                        <th>Ngày gửi</th>
                        <th>Ngày duyệt</th>
                        <th style="text-align:center">Trạng thái</th>
                        <th style="text-align:center">Chi tiết</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <!-- Rendered by JS -->
                </tbody>
            </table>
        </div>

        <!-- Summary -->
        <div class="summary-bar" id="summaryBar">
            <div class="summary-item">
                <div class="summary-item-label">Tổng số giao dịch</div>
                <div class="summary-item-val" id="sumTotal">12</div>
            </div>
            <div class="summary-item">
                <div class="summary-item-label">Tổng tiền đã góp</div>
                <div class="summary-item-val green" id="sumApproved">4.750.000đ</div>
            </div>
            <div class="summary-item">
                <div class="summary-item-label">Đang chờ xác nhận</div>
                <div class="summary-item-val orange" id="sumPending">450.000đ</div>
            </div>
            <div class="summary-item">
                <div class="summary-item-label">Bị từ chối</div>
                <div class="summary-item-val red" id="sumRejected">200.000đ</div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="table-pagination" id="paginationBar">
            <span class="page-info" id="pageInfo">Trang 1 / 2</span>
            <div class="page-btns" id="pageBtns"></div>
        </div>
    </div>

</div>

<!-- ══ DETAIL MODAL ══════════════════════════════════════════ -->
<div class="modal-overlay" id="detailModal">
    <div class="modal-box">
        <div class="modal-header">
            <div class="modal-title" id="modalTitle">Chi tiết quyên góp</div>
            <button class="modal-close" onclick="closeModal()">✕</button>
        </div>
        <div class="modal-body" id="modalBody">
            <!-- filled by JS -->
        </div>
        <div class="modal-footer">
            <button class="btn-modal-close" onclick="closeModal()">Đóng</button>
        </div>
    </div>
</div>

<!-- ─────────────────────────────────────────────────────────── -->
<script>
    /* ── Mock data ──────────────────────────────────────────────── */
    var DATA = [
        { id: 1, campaign: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', cat: 'Cứu trợ thiên tai', icon: '🌊', amount: 500000, dateFrom: '2026-03-05', dateDuyet: '2026-03-06', status: 'approved', loiNhan: 'Mong bà con sớm ổn định cuộc sống!', anDanh: false, proof: true },
        { id: 2, campaign: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', cat: 'Y tế cộng đồng', icon: '❤️', amount: 300000, dateFrom: '2026-02-18', dateDuyet: '2026-02-19', status: 'approved', loiNhan: 'Cầu chúc các bé mau khỏe!', anDanh: false, proof: true },
        { id: 3, campaign: 'Học bổng Thắp sáng ước mơ 2026', cat: 'Học bổng', icon: '📚', amount: 200000, dateFrom: '2026-02-10', dateDuyet: '2026-02-11', status: 'approved', loiNhan: '', anDanh: true, proof: false },
        { id: 4, campaign: 'Trồng 10.000 cây xanh Ngày Môi trường', cat: 'Môi trường', icon: '🌱', amount: 150000, dateFrom: '2026-01-22', dateDuyet: '2026-01-23', status: 'approved', loiNhan: 'Vì một Việt Nam xanh hơn.', anDanh: false, proof: true },
        { id: 5, campaign: 'Khám bệnh miễn phí vùng cao Điện Biên', cat: 'Y tế cộng đồng', icon: '🏥', amount: 500000, dateFrom: '2026-01-15', dateDuyet: '2026-01-16', status: 'approved', loiNhan: '', anDanh: false, proof: true },
        { id: 6, campaign: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', cat: 'Cứu trợ thiên tai', icon: '🌊', amount: 1000000, dateFrom: '2025-12-20', dateDuyet: '2025-12-21', status: 'approved', loiNhan: 'Chúc bà con vượt qua khó khăn.', anDanh: false, proof: true },
        { id: 7, campaign: 'Nhà tình thương cho hộ nghèo Bến Tre', cat: 'Nhà ở', icon: '🏠', amount: 500000, dateFrom: '2025-11-10', dateDuyet: '2025-11-12', status: 'approved', loiNhan: '', anDanh: true, proof: false },
        { id: 8, campaign: 'Học bổng Thắp sáng ước mơ 2025', cat: 'Học bổng', icon: '📚', amount: 300000, dateFrom: '2025-09-05', dateDuyet: '2025-09-06', status: 'approved', loiNhan: 'Chúc các em học giỏi!', anDanh: false, proof: true },
        { id: 9, campaign: 'Phẫu thuật mắt miễn phí cho người già', cat: 'Y tế cộng đồng', icon: '👁️', amount: 200000, dateFrom: '2025-08-20', dateDuyet: '2025-08-21', status: 'approved', loiNhan: '', anDanh: false, proof: false },
        { id: 10, campaign: 'Cứu trợ hạn mặn đồng bằng sông Cửu Long', cat: 'Cứu trợ thiên tai', icon: '💧', amount: 300000, dateFrom: '2024-12-01', dateDuyet: null, status: 'rejected', loiNhan: '', lyDo: 'Ảnh xác nhận không rõ ràng.', anDanh: false, proof: true },
        { id: 11, campaign: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', cat: 'Cứu trợ thiên tai', icon: '🌊', amount: 300000, dateFrom: '2026-03-20', dateDuyet: null, status: 'pending', loiNhan: 'Mong được duyệt sớm ạ.', anDanh: false, proof: true },
        { id: 12, campaign: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', cat: 'Y tế cộng đồng', icon: '❤️', amount: 150000, dateFrom: '2026-03-25', dateDuyet: null, status: 'pending', loiNhan: '', anDanh: true, proof: false },
    ];

    var filtered = DATA.slice();
    var currentPage = 1;
    var PER_PAGE = 8;
    var currentFilter = 'all';
    var searchVal = '';

    /* ── Render ─────────────────────────────────────────────────── */
    function fmt(n) {
        return n.toLocaleString('vi-VN') + 'đ';
    }
    function fmtDate(d) {
        if (!d) return '—';
        var parts = d.split('-');
        return parts[2] + '/' + parts[1] + '/' + parts[0];
    }
    function statusHTML(s, lyDo) {
        if (s === 'approved') return '<span class="status-badge badge-approved">✅ Đã xác nhận</span>';
        if (s === 'pending') return '<span class="status-badge badge-pending">⏳ Chờ xác nhận</span>';
        return '<span class="status-badge badge-rejected" title="' + (lyDo || '') + '">❌ Từ chối</span>';
    }

    function renderTable() {
        var tbody = document.getElementById('tableBody');
        var start = (currentPage - 1) * PER_PAGE;
        var page = filtered.slice(start, start + PER_PAGE);
        var html = '';

        if (page.length === 0) {
            html = '<tr class="empty-row"><td colspan="7"><div class="empty-row-icon">🔍</div><div>Không tìm thấy giao dịch nào phù hợp.</div></td></tr>';
        } else {
            page.forEach(function (d, i) {
                var anDanhText = d.anDanh ? ' <span style="font-size:10px;color:var(--chu-phu)">(ẩn danh)</span>' : '';
                html += '<tr>'
                    + '<td class="td-stt">' + (start + i + 1) + '</td>'
                    + '<td><div class="campaign-cell">'
                    + '<div class="campaign-thumb-sm">' + d.icon + '</div>'
                    + '<div><div class="campaign-name-text">' + d.campaign + anDanhText + '</div>'
                    + '<div class="campaign-cat-tiny">' + d.cat + '</div></div>'
                    + '</div></td>'
                    + '<td style="text-align:right" class="td-amount">' + fmt(d.amount) + '</td>'
                    + '<td class="td-date"><div class="date-main">' + fmtDate(d.dateFrom) + '</div></td>'
                    + '<td class="td-date"><div class="date-main">' + fmtDate(d.dateDuyet) + '</div></td>'
                    + '<td class="td-actions">' + statusHTML(d.status, d.lyDo) + '</td>'
                    + '<td class="td-actions"><button class="btn-view-detail" onclick="openModal(' + d.id + ')">🔍 Xem</button></td>'
                    + '</tr>';
            });
        }
        tbody.innerHTML = html;

        // Summary
        var sumApproved = 0, sumPending = 0, sumRejected = 0;
        filtered.forEach(function (d) {
            if (d.status === 'approved') sumApproved += d.amount;
            if (d.status === 'pending') sumPending += d.amount;
            if (d.status === 'rejected') sumRejected += d.amount;
        });
        document.getElementById('sumTotal').textContent = filtered.length;
        document.getElementById('sumApproved').textContent = fmt(sumApproved);
        document.getElementById('sumPending').textContent = fmt(sumPending);
        document.getElementById('sumRejected').textContent = fmt(sumRejected);

        // Results info
        document.getElementById('resultsInfo').innerHTML = 'Hiển thị <strong>' + filtered.length + '</strong> giao dịch';

        renderPagination();
    }

    function renderPagination() {
        var totalPages = Math.max(1, Math.ceil(filtered.length / PER_PAGE));
        document.getElementById('pageInfo').textContent = 'Trang ' + currentPage + ' / ' + totalPages;
        var btns = document.getElementById('pageBtns');
        btns.innerHTML = '';

        // Prev
        var prev = document.createElement('button');
        prev.className = 'pg-btn'; prev.textContent = '‹';
        prev.disabled = currentPage === 1;
        prev.onclick = function () { currentPage--; renderTable(); };
        btns.appendChild(prev);

        for (var i = 1; i <= totalPages; i++) {
            (function (p) {
                var btn = document.createElement('button');
                btn.className = 'pg-btn' + (p === currentPage ? ' active' : '');
                btn.textContent = p;
                btn.onclick = function () { currentPage = p; renderTable(); };
                btns.appendChild(btn);
            })(i);
        }

        // Next
        var next = document.createElement('button');
        next.className = 'pg-btn'; next.textContent = '›';
        next.disabled = currentPage === totalPages;
        next.onclick = function () { currentPage++; renderTable(); };
        btns.appendChild(next);
    }

    /* ── Filters ────────────────────────────────────────────────── */
    function applyFilters() {
        var dateFrom = document.getElementById('dateFrom').value;
        var dateTo = document.getElementById('dateTo').value;
        searchVal = document.getElementById('searchInput').value.toLowerCase().trim();

        filtered = DATA.filter(function (d) {
            var matchStatus = currentFilter === 'all' || d.status === currentFilter;
            var matchSearch = searchVal === '' || d.campaign.toLowerCase().includes(searchVal);
            var matchFrom = !dateFrom || d.dateFrom >= dateFrom;
            var matchTo = !dateTo || d.dateFrom <= dateTo;
            return matchStatus && matchSearch && matchFrom && matchTo;
        });

        currentPage = 1;
        updateCounts();
        renderTable();
    }

    function updateCounts() {
        var counts = { all: DATA.length, pending: 0, approved: 0, rejected: 0 };
        DATA.forEach(function (d) { counts[d.status]++; });
        document.getElementById('countAll').textContent = '(' + counts.all + ')';
        document.getElementById('countPending').textContent = '(' + counts.pending + ')';
        document.getElementById('countApproved').textContent = '(' + counts.approved + ')';
        document.getElementById('countRejected').textContent = '(' + counts.rejected + ')';
    }

    function resetFilters() {
        currentFilter = 'all';
        document.querySelectorAll('.status-pill').forEach(function (p) { p.classList.remove('active'); });
        document.querySelector('.pill-all').classList.add('active');
        document.getElementById('searchInput').value = '';
        document.getElementById('dateFrom').value = '2024-01-01';
        document.getElementById('dateTo').value = '2026-03-27';
        applyFilters();
    }

    /* Status pill clicks */
    document.querySelectorAll('.status-pill').forEach(function (pill) {
        pill.addEventListener('click', function () {
            document.querySelectorAll('.status-pill').forEach(function (p) { p.classList.remove('active'); });
            this.classList.add('active');
            currentFilter = this.dataset.status;
            applyFilters();
        });
    });

    document.getElementById('searchInput').addEventListener('input', applyFilters);
    document.getElementById('dateFrom').addEventListener('change', applyFilters);
    document.getElementById('dateTo').addEventListener('change', applyFilters);

    /* ── Modal ──────────────────────────────────────────────────── */
    function openModal(id) {
        var d = DATA.find(function (x) { return x.id === id; });
        if (!d) return;

        var statusStr = d.status === 'approved' ? '✅ Đã xác nhận'
            : d.status === 'pending' ? '⏳ Chờ xác nhận'
                : '❌ Từ chối';

        var proofHTML = d.proof
            ? '<div class="modal-proof-img">🖼️ &nbsp; <span style="font-size:14px;color:var(--chu-phu)">Ảnh xác nhận chuyển khoản</span></div>'
            : '<div class="modal-proof-img" style="background:#F8F9FA"><span style="font-size:14px;color:#A0AEC0">Không có ảnh xác nhận</span></div>';

        var lyDoHTML = d.lyDo
            ? '<div class="modal-row"><div class="modal-row-label">Lý do từ chối</div><div class="modal-row-val" style="color:#E53E3E">' + d.lyDo + '</div></div>'
            : '';

        document.getElementById('modalTitle').textContent = 'Chi tiết #QG-' + String(id).padStart(4, '0');
        document.getElementById('modalBody').innerHTML =
            '<div class="modal-row"><div class="modal-row-label">Mã giao dịch</div><div class="modal-row-val" style="font-family:monospace;color:var(--mau-chinh)">#QG-' + String(id).padStart(4, '0') + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Chiến dịch</div><div class="modal-row-val" style="max-width:280px;text-align:right">' + d.campaign + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Số tiền quyên góp</div><div class="modal-row-val" style="color:var(--mau-chinh);font-size:18px">' + fmt(d.amount) + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Ngày gửi</div><div class="modal-row-val">' + fmtDate(d.dateFrom) + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Ngày duyệt</div><div class="modal-row-val">' + fmtDate(d.dateDuyet) + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Trạng thái</div><div class="modal-row-val">' + statusHTML(d.status) + '</div></div>'
            + '<div class="modal-row"><div class="modal-row-label">Ẩn danh</div><div class="modal-row-val">' + (d.anDanh ? '✅ Có' : '❌ Không') + '</div></div>'
            + (d.loiNhan ? '<div class="modal-row"><div class="modal-row-label">Lời nhắn</div><div class="modal-row-val" style="font-style:italic;max-width:260px;text-align:right">"' + d.loiNhan + '"</div></div>' : '')
            + lyDoHTML
            + proofHTML;

        document.getElementById('detailModal').classList.add('open');
    }

    function closeModal() {
        document.getElementById('detailModal').classList.remove('open');
    }

    document.getElementById('detailModal').addEventListener('click', function (e) {
        if (e.target === this) closeModal();
    });

    /* Init */
    updateCounts();
    applyFilters();
</script>
</asp:Content>
