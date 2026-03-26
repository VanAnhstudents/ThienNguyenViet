<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DanhSachChienDich.aspx.cs" Inherits="ThienNguyenViet.DanhSachChienDich" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
/* ═══════════════════════════════════════════════════════
   PAGE HEADER / HERO
═══════════════════════════════════════════════════════ */
.page-hero {
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 55%, #3D9962 100%);
    padding: 52px 24px 48px;
    text-align: center;
    position: relative;
    overflow: hidden;
}
.page-hero::before {
    content: '';
    position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Ccircle cx='30' cy='30' r='4'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    pointer-events: none;
}
.page-hero h1 {
    color: #fff; font-family: 'Playfair Display', serif;
    font-size: 36px; font-weight: 700; margin: 0 0 10px;
    text-shadow: 0 2px 12px rgba(0,0,0,.2);
}
.page-hero p {
    color: rgba(255,255,255,.8); font-size: 15px; margin: 0 auto;
    max-width: 520px; line-height: 1.65;
}
.page-hero-stats {
    display: flex; justify-content: center; gap: 32px;
    margin-top: 28px; flex-wrap: wrap;
}
.hero-stat {
    background: rgba(255,255,255,.12);
    backdrop-filter: blur(8px);
    border: 1px solid rgba(255,255,255,.18);
    border-radius: 12px;
    padding: 12px 24px;
    text-align: center;
}
.hero-stat-number {
    font-size: 22px; font-weight: 700; color: #fff;
    font-family: 'Playfair Display', serif;
    display: block;
}
.hero-stat-label {
    font-size: 11px; color: rgba(255,255,255,.65);
    text-transform: uppercase; letter-spacing: .08em;
    font-weight: 600;
}

/* ═══════════════════════════════════════════════════════
   LAYOUT: SIDEBAR + MAIN
═══════════════════════════════════════════════════════ */
.campaigns-layout {
    max-width: 1200px; margin: 0 auto;
    padding: 36px 24px 60px;
    display: grid;
    grid-template-columns: 300px 1fr;
    gap: 28px;
    align-items: start;
}

/* ═══════════════════════════════════════════════════════
   SIDEBAR
═══════════════════════════════════════════════════════ */
.filter-sidebar {
    background: #fff;
    border: 1px solid var(--vien);
    border-radius: 16px;
    overflow: hidden;
    position: sticky;
    top: calc(var(--header-h, 68px) + 20px);
    box-shadow: 0 2px 16px rgba(0,0,0,.05);
}

.sidebar-header {
    padding: 18px 20px 14px;
    border-bottom: 1px solid var(--vien);
    display: flex; align-items: center; justify-content: space-between;
}
.sidebar-header h3 {
    font-size: 14px; font-weight: 700; color: var(--chu-chinh);
    text-transform: uppercase; letter-spacing: .07em; margin: 0;
}
.btn-reset-filter {
    font-size: 12px; color: var(--mau-cam); font-weight: 600;
    background: none; border: none; cursor: pointer;
    padding: 0; font-family: var(--font);
    transition: opacity .15s;
}
.btn-reset-filter:hover { opacity: .7; }

.filter-section {
    padding: 18px 20px;
    border-bottom: 1px solid var(--vien);
}
.filter-section:last-child { border-bottom: none; }

.filter-label {
    font-size: 12px; font-weight: 700; color: var(--chu-phu);
    text-transform: uppercase; letter-spacing: .09em;
    margin-bottom: 12px; display: block;
}

/* Checkbox groups */
.filter-checkbox-list { display: flex; flex-direction: column; gap: 8px; }
.filter-checkbox-item {
    display: flex; align-items: center; gap: 9px;
    cursor: pointer; user-select: none;
}
.filter-checkbox-item input[type="checkbox"] { display: none; }
.checkbox-box {
    width: 17px; height: 17px; border-radius: 4px;
    border: 1.5px solid #CBD5E0;
    background: #fff; flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    transition: all .15s;
    font-size: 10px; color: transparent;
}
.filter-checkbox-item input:checked + .checkbox-box {
    background: var(--mau-chinh);
    border-color: var(--mau-chinh);
    color: #fff;
}
.checkbox-label {
    font-size: 13.5px; color: var(--chu-than);
    display: flex; align-items: center; gap: 7px; flex: 1;
}
.checkbox-dot {
    width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0;
}
.checkbox-count {
    margin-left: auto; font-size: 11px;
    background: var(--nen-trang); border-radius: 999px;
    padding: 1px 7px; color: var(--chu-phu); font-weight: 600;
}

/* Radio status */
.filter-radio-list { display: flex; flex-direction: column; gap: 8px; }
.filter-radio-item {
    display: flex; align-items: center; gap: 9px;
    cursor: pointer; user-select: none;
}
.filter-radio-item input[type="radio"] { display: none; }
.radio-box {
    width: 17px; height: 17px; border-radius: 50%;
    border: 1.5px solid #CBD5E0; background: #fff;
    flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    transition: all .15s;
}
.radio-box::after {
    content: '';
    width: 7px; height: 7px; border-radius: 50%;
    background: transparent; transition: background .15s;
}
.filter-radio-item input:checked + .radio-box {
    border-color: var(--mau-chinh);
}
.filter-radio-item input:checked + .radio-box::after {
    background: var(--mau-chinh);
}
.radio-label { font-size: 13.5px; color: var(--chu-than); }

/* Range slider */
.range-slider-wrap { padding: 4px 0 8px; }
.range-labels {
    display: flex; justify-content: space-between;
    font-size: 12px; color: var(--chu-phu); margin-bottom: 8px;
}
.range-current {
    font-size: 13px; font-weight: 600; color: var(--mau-chinh);
    text-align: center; margin-bottom: 10px;
}
input[type="range"] {
    width: 100%; -webkit-appearance: none; appearance: none;
    height: 5px; border-radius: 999px;
    background: linear-gradient(to right, var(--mau-chinh) 0%, var(--mau-chinh) 60%, #CBD5E0 60%);
    outline: none; cursor: pointer;
}
input[type="range"]::-webkit-slider-thumb {
    -webkit-appearance: none; appearance: none;
    width: 18px; height: 18px; border-radius: 50%;
    background: #fff; border: 2px solid var(--mau-chinh);
    box-shadow: 0 2px 6px rgba(45,122,79,.3);
    cursor: grab;
}

/* Sort radio in sidebar */
.filter-sort-list { display: flex; flex-direction: column; gap: 8px; }

/* ═══════════════════════════════════════════════════════
   MAIN AREA
═══════════════════════════════════════════════════════ */
.campaigns-main { min-width: 0; }

/* Toolbar */
.campaigns-toolbar {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 20px; flex-wrap: wrap;
}
.search-wrap {
    flex: 1; min-width: 200px;
    position: relative;
}
.search-wrap input {
    width: 100%; height: 42px;
    padding: 0 16px 0 42px;
    border: 1.5px solid var(--vien);
    border-radius: 10px; font-size: 14px;
    font-family: var(--font); color: var(--chu-chinh);
    background: #fff; outline: none;
    transition: border-color .2s, box-shadow .2s;
}
.search-wrap input:focus {
    border-color: var(--mau-chinh);
    box-shadow: 0 0 0 3px rgba(45,122,79,.1);
}
.search-icon {
    position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
    font-size: 16px; pointer-events: none;
}
.toolbar-sort {
    height: 42px; padding: 0 14px;
    border: 1.5px solid var(--vien); border-radius: 10px;
    background: #fff; font-family: var(--font);
    font-size: 13.5px; color: var(--chu-than);
    cursor: pointer; outline: none;
    transition: border-color .18s;
    min-width: 190px;
}
.toolbar-sort:focus { border-color: var(--mau-chinh); }

.toolbar-result {
    font-size: 13px; color: var(--chu-phu);
    white-space: nowrap;
}
.toolbar-result strong { color: var(--mau-chinh); font-weight: 700; }

/* View toggle */
.view-toggle { display: flex; gap: 4px; }
.view-btn {
    width: 36px; height: 36px; border-radius: 8px;
    border: 1.5px solid var(--vien); background: #fff;
    display: flex; align-items: center; justify-content: center;
    font-size: 16px; cursor: pointer; transition: all .15s;
    color: var(--chu-phu);
}
.view-btn.active {
    background: var(--mau-chinh-nen);
    border-color: var(--mau-chinh); color: var(--mau-chinh);
}

/* ═══════════════════════════════════════════════════════
   CAMPAIGN CARDS GRID
═══════════════════════════════════════════════════════ */
.campaigns-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.campaign-card {
    background: #fff;
    border-radius: var(--r-md);
    border: 1px solid var(--vien);
    overflow: hidden;
    display: flex; flex-direction: column;
    transition: transform .22s, box-shadow .22s;
    box-shadow: 0 2px 8px rgba(0,0,0,.04);
}
.campaign-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 32px rgba(45,122,79,.13);
}

/* Card image */
.card-img-wrap {
    position: relative;
    aspect-ratio: 16/9;
    overflow: hidden;
    background: #EAF5EE;
}
.card-img-wrap img {
    width: 100%; height: 100%; object-fit: cover;
    transition: transform .4s ease;
}
.campaign-card:hover .card-img-wrap img { transform: scale(1.04); }

/* Fallback gradient images */
.card-img-placeholder {
    width: 100%; height: 100%;
    display: flex; align-items: center; justify-content: center;
    font-size: 40px;
}

.card-badges {
    position: absolute; top: 10px; left: 10px;
    display: flex; gap: 6px; flex-wrap: wrap;
}
.badge {
    font-size: 10.5px; font-weight: 700;
    padding: 3px 9px; border-radius: 999px;
    letter-spacing: .03em; white-space: nowrap;
}
.badge-thien-tai   { background: #FEE2E2; color: #C53030; }
.badge-giao-duc    { background: #DBEAFE; color: #1D4ED8; }
.badge-moi-truong  { background: #D1FAE5; color: #065F46; }
.badge-y-te        { background: #FEF3C7; color: #92400E; }

.badge-status-active   { background: #D1FAE5; color: #065F46; }
.badge-status-urgent   { background: #FEE2E2; color: #C53030; animation: urgentPulse 1.8s ease-in-out infinite; }
.badge-status-ending   { background: #FEF3C7; color: #92400E; }
.badge-status-done     { background: #E2E8F0; color: #4A5568; }

@keyframes urgentPulse {
    0%, 100% { opacity: 1; }
    50%       { opacity: .7; }
}

/* Card body */
.card-body {
    padding: 16px 16px 12px;
    display: flex; flex-direction: column; flex: 1;
}
.card-category-tag {
    font-size: 11px; font-weight: 600;
    text-transform: uppercase; letter-spacing: .07em;
    margin-bottom: 6px;
}

.card-title {
    font-size: 14.5px; font-weight: 700; color: var(--chu-chinh);
    line-height: 1.4; margin-bottom: 7px;
    display: -webkit-box;
    -webkit-line-clamp: 2; -webkit-box-orient: vertical;
    overflow: hidden;
}

.card-desc {
    font-size: 12.5px; color: var(--chu-phu); line-height: 1.65;
    display: -webkit-box;
    -webkit-line-clamp: 3; -webkit-box-orient: vertical;
    overflow: hidden;
    margin-bottom: 14px;
    flex: 1;
}

/* Progress */
.card-progress-wrap { margin-bottom: 10px; }
.card-progress-header {
    display: flex; justify-content: space-between;
    align-items: baseline; margin-bottom: 5px;
}
.card-progress-pct {
    font-size: 13px; font-weight: 700; color: var(--mau-chinh);
}
.card-progress-money {
    font-size: 11px; color: var(--chu-phu);
    text-align: right; line-height: 1.4;
}
.card-progress-money strong { color: var(--chu-chinh); font-weight: 600; }

.progress-nen { height: 7px; }

/* Card meta */
.card-meta {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 12px; flex-wrap: wrap;
}
.card-meta-item {
    display: flex; align-items: center; gap: 4px;
    font-size: 11.5px; color: var(--chu-phu);
}
.card-meta-item span:first-child { font-size: 13px; }
.card-meta-item.urgent { color: var(--mau-cam); font-weight: 600; }

/* Card actions */
.card-actions { display: flex; gap: 8px; margin-top: auto; }
.btn-card-detail {
    flex: 1; height: 34px; border-radius: 8px;
    border: 1.5px solid var(--mau-chinh); color: var(--mau-chinh);
    background: transparent; font-family: var(--font);
    font-size: 12.5px; font-weight: 600; cursor: pointer;
    text-decoration: none;
    display: inline-flex; align-items: center; justify-content: center;
    transition: all .18s;
}
.btn-card-detail:hover { background: var(--mau-chinh-nen); }

.btn-card-donate {
    flex: 1; height: 34px; border-radius: 8px;
    border: none;
    background: linear-gradient(135deg, #C0651A, #D97B2A);
    color: #fff; font-family: var(--font);
    font-size: 12.5px; font-weight: 700; cursor: pointer;
    text-decoration: none;
    display: inline-flex; align-items: center; justify-content: center; gap: 4px;
    box-shadow: 0 2px 6px rgba(192,101,26,.3);
    transition: all .18s;
}
.btn-card-donate:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(192,101,26,.4);
    color: #fff;
}

/* ═══════════════════════════════════════════════════════
   EMPTY STATE
═══════════════════════════════════════════════════════ */
.empty-state {
    grid-column: 1 / -1;
    text-align: center; padding: 60px 20px;
    color: var(--chu-phu);
}
.empty-state-icon { font-size: 52px; margin-bottom: 16px; }
.empty-state h3 { color: var(--chu-chinh); margin-bottom: 8px; }
.empty-state p { font-size: 14px; max-width: 320px; margin: 0 auto 20px; }

/* ═══════════════════════════════════════════════════════
   PAGINATION
═══════════════════════════════════════════════════════ */
.pagination-wrap {
    display: flex; align-items: center; justify-content: center;
    gap: 6px; margin-top: 36px; flex-wrap: wrap;
}
.page-btn {
    min-width: 36px; height: 36px; padding: 0 10px;
    border-radius: 9px;
    border: 1.5px solid var(--vien);
    background: #fff; color: var(--chu-than);
    font-family: var(--font); font-size: 13.5px; font-weight: 500;
    cursor: pointer; transition: all .15s;
    display: inline-flex; align-items: center; justify-content: center;
}
.page-btn:hover:not(:disabled) {
    border-color: var(--mau-chinh); color: var(--mau-chinh);
    background: var(--mau-chinh-nen);
}
.page-btn.active {
    background: var(--mau-chinh); border-color: var(--mau-chinh);
    color: #fff; font-weight: 700;
}
.page-btn:disabled { opacity: .4; cursor: not-allowed; }
.page-dots { color: var(--chu-phu); font-size: 14px; padding: 0 4px; }

/* ═══════════════════════════════════════════════════════
   ACTIVE FILTER TAGS
═══════════════════════════════════════════════════════ */
.active-filters {
    display: flex; align-items: center; gap: 8px;
    flex-wrap: wrap; margin-bottom: 14px;
}
.filter-tag {
    display: inline-flex; align-items: center; gap: 5px;
    background: var(--mau-chinh-nen);
    border: 1px solid var(--mau-chinh-nhat);
    border-radius: 999px;
    padding: 4px 10px; font-size: 12px; font-weight: 600;
    color: var(--mau-chinh);
}
.filter-tag-close {
    background: none; border: none; color: var(--mau-chinh);
    cursor: pointer; padding: 0; font-size: 14px; line-height: 1;
    opacity: .6; transition: opacity .15s;
}
.filter-tag-close:hover { opacity: 1; }
.active-filter-label { font-size: 12.5px; color: var(--chu-phu); font-weight: 500; }

/* Responsive */
@media (max-width: 900px) {
    .campaigns-layout {
        grid-template-columns: 1fr;
    }
    .filter-sidebar { position: static; }
    .campaigns-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 560px) {
    .campaigns-grid { grid-template-columns: 1fr; }
    .campaigns-toolbar { flex-direction: column; align-items: stretch; }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- ══ Hero ══ --%>
<div class="page-hero">
    <h1>Tất cả chiến dịch</h1>
    <p>Khám phá và tham gia các chiến dịch thiện nguyện đang cần sự chung tay của bạn trên khắp Việt Nam.</p>
    <div class="page-hero-stats">
        <div class="hero-stat">
            <span class="hero-stat-number">128</span>
            <span class="hero-stat-label">Chiến dịch</span>
        </div>
        <div class="hero-stat">
            <span class="hero-stat-number">47.200+</span>
            <span class="hero-stat-label">Lượt quyên góp</span>
        </div>
        <div class="hero-stat">
            <span class="hero-stat-number">32,4 tỷ</span>
            <span class="hero-stat-label">Đã huy động (VNĐ)</span>
        </div>
    </div>
</div>

<%-- ══ Main Layout ══ --%>
<div class="campaigns-layout">

    <%-- ════ SIDEBAR ════ --%>
    <aside class="filter-sidebar" id="filterSidebar">

        <div class="sidebar-header">
            <h3>🔍 Bộ lọc</h3>
            <button class="btn-reset-filter" onclick="resetFilters()">Xóa tất cả</button>
        </div>

        <%-- Danh mục --%>
        <div class="filter-section">
            <span class="filter-label">Danh mục</span>
            <div class="filter-checkbox-list">
                <label class="filter-checkbox-item">
                    <input type="checkbox" name="cat" value="thien-tai" onchange="applyFilters()" />
                    <span class="checkbox-box">✓</span>
                    <span class="checkbox-label">
                        <span class="checkbox-dot" style="background:#E53E3E"></span>
                        Thiên tai &amp; Khẩn cấp
                        <span class="checkbox-count">18</span>
                    </span>
                </label>
                <label class="filter-checkbox-item">
                    <input type="checkbox" name="cat" value="giao-duc" onchange="applyFilters()" />
                    <span class="checkbox-box">✓</span>
                    <span class="checkbox-label">
                        <span class="checkbox-dot" style="background:#3182CE"></span>
                        Giáo dục &amp; Học bổng
                        <span class="checkbox-count">34</span>
                    </span>
                </label>
                <label class="filter-checkbox-item">
                    <input type="checkbox" name="cat" value="moi-truong" onchange="applyFilters()" />
                    <span class="checkbox-box">✓</span>
                    <span class="checkbox-label">
                        <span class="checkbox-dot" style="background:#38A169"></span>
                        Môi trường &amp; Sinh thái
                        <span class="checkbox-count">27</span>
                    </span>
                </label>
                <label class="filter-checkbox-item">
                    <input type="checkbox" name="cat" value="y-te" onchange="applyFilters()" />
                    <span class="checkbox-box">✓</span>
                    <span class="checkbox-label">
                        <span class="checkbox-dot" style="background:#D69E2E"></span>
                        Y tế &amp; Sức khỏe
                        <span class="checkbox-count">49</span>
                    </span>
                </label>
            </div>
        </div>

        <%-- Trạng thái --%>
        <div class="filter-section">
            <span class="filter-label">Trạng thái</span>
            <div class="filter-radio-list">
                <label class="filter-radio-item">
                    <input type="radio" name="status" value="all" checked onchange="applyFilters()" />
                    <span class="radio-box"></span>
                    <span class="radio-label">Tất cả</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="status" value="active" onchange="applyFilters()" />
                    <span class="radio-box"></span>
                    <span class="radio-label">🟢 Đang diễn ra</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="status" value="urgent" onchange="applyFilters()" />
                    <span class="radio-box"></span>
                    <span class="radio-label">🔴 Khẩn cấp</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="status" value="ending" onchange="applyFilters()" />
                    <span class="radio-box"></span>
                    <span class="radio-label">🟡 Sắp kết thúc</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="status" value="done" onchange="applyFilters()" />
                    <span class="radio-box"></span>
                    <span class="radio-label">⚪ Đã hoàn thành</span>
                </label>
            </div>
        </div>

        <%-- Khoảng tiền mục tiêu --%>
        <div class="filter-section">
            <span class="filter-label">Mục tiêu quyên góp</span>
            <div class="range-slider-wrap">
                <div class="range-current" id="rangeDisplay">≤ 3.000.000.000 đ</div>
                <input type="range" id="goalRange" min="0" max="10" value="3"
                       step="1" oninput="updateRange(this.value)" onchange="applyFilters()" />
                <div class="range-labels">
                    <span>100 triệu</span>
                    <span>10 tỷ+</span>
                </div>
            </div>
        </div>

        <%-- Sắp xếp --%>
        <div class="filter-section">
            <span class="filter-label">Sắp xếp theo</span>
            <div class="filter-sort-list">
                <label class="filter-radio-item">
                    <input type="radio" name="sortSidebar" value="newest" checked onchange="syncSort('newest')" />
                    <span class="radio-box"></span>
                    <span class="radio-label">📅 Mới nhất</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="sortSidebar" value="ending-soon" onchange="syncSort('ending-soon')" />
                    <span class="radio-box"></span>
                    <span class="radio-label">⏰ Sắp hết hạn</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="sortSidebar" value="most-donors" onchange="syncSort('most-donors')" />
                    <span class="radio-box"></span>
                    <span class="radio-label">👥 Nhiều người góp nhất</span>
                </label>
                <label class="filter-radio-item">
                    <input type="radio" name="sortSidebar" value="most-funded" onchange="syncSort('most-funded')" />
                    <span class="radio-box"></span>
                    <span class="radio-label">💰 Gần đạt mục tiêu</span>
                </label>
            </div>
        </div>

    </aside>

    <%-- ════ MAIN CONTENT ════ --%>
    <div class="campaigns-main">

        <%-- Toolbar --%>
        <div class="campaigns-toolbar">
            <div class="search-wrap">
                <span class="search-icon">🔍</span>
                <input type="text" id="searchInput" placeholder="Tìm chiến dịch theo tên, địa điểm..."
                       oninput="applyFilters()" />
            </div>
            <select class="toolbar-sort" id="sortSelect" onchange="syncSortFromSelect()">
                <option value="newest">📅 Mới nhất</option>
                <option value="ending-soon">⏰ Sắp hết hạn</option>
                <option value="most-donors">👥 Nhiều người góp nhất</option>
                <option value="most-funded">💰 Gần đạt mục tiêu</option>
            </select>
            <span class="toolbar-result" id="resultCount">
                Tìm thấy <strong>9</strong> chiến dịch
            </span>
        </div>

        <%-- Active filter tags --%>
        <div class="active-filters" id="activeFilters" style="display:none">
            <span class="active-filter-label">Lọc đang áp dụng:</span>
        </div>

        <%-- Campaign Grid --%>
        <div class="campaigns-grid" id="campaignsGrid">
            <%-- Cards rendered by JS --%>
        </div>

        <%-- Pagination --%>
        <div class="pagination-wrap" id="paginationWrap"></div>

    </div>
</div>

<script>
// ═══════════════════════════════════════════════════
// DATA — 18 sample campaigns (2 pages of 9)
// ═══════════════════════════════════════════════════
var CAMPAIGNS = [
    {
        id: 1, cat: 'thien-tai',
        status: 'urgent',
        title: 'Cứu trợ khẩn cấp lũ lụt miền Trung 2026',
        desc: 'Hàng nghìn gia đình tại Quảng Bình, Hà Tĩnh đang chịu ảnh hưởng nặng nề bởi đợt lũ lịch sử. Chúng tôi cần lương thực, nước sạch và vật dụng thiết yếu để hỗ trợ bà con.',
        raised: 8400000000, goal: 10000000000, donors: 3821, daysLeft: 5,
        emoji: '🌊', gradFrom: '#1E40AF', gradTo: '#3B82F6',
        createdDaysAgo: 3, pct: 84
    },
    {
        id: 2, cat: 'giao-duc',
        status: 'active',
        title: 'Học bổng "Thắp sáng tương lai" cho trẻ em vùng cao',
        desc: 'Chương trình cấp học bổng toàn phần cho 200 em học sinh dân tộc thiểu số tại Hà Giang, Lai Châu có hoàn cảnh khó khăn nhưng học giỏi.',
        raised: 1250000000, goal: 2000000000, donors: 1247, daysLeft: 45,
        emoji: '📚', gradFrom: '#1D4ED8', gradTo: '#60A5FA',
        createdDaysAgo: 12, pct: 62
    },
    {
        id: 3, cat: 'moi-truong',
        status: 'active',
        title: 'Trồng 100.000 cây xanh tại rừng phòng hộ Cà Mau',
        desc: 'Rừng ngập mặn Cà Mau đang suy giảm nghiêm trọng. Dự án nhằm tái sinh hệ sinh thái ven biển, bảo vệ đường bờ biển và sinh kế ngư dân địa phương.',
        raised: 780000000, goal: 1500000000, donors: 2104, daysLeft: 60,
        emoji: '🌳', gradFrom: '#065F46', gradTo: '#34D399',
        createdDaysAgo: 8, pct: 52
    },
    {
        id: 4, cat: 'y-te',
        status: 'ending',
        title: 'Phẫu thuật tim cho 50 trẻ em nghèo mắc dị tật bẩm sinh',
        desc: 'Phối hợp với bệnh viện Nhi Đồng 1 và các chuyên gia tim mạch hàng đầu để thực hiện các ca phẫu thuật miễn phí cho trẻ em có bệnh tim bẩm sinh.',
        raised: 4200000000, goal: 5000000000, donors: 892, daysLeft: 8,
        emoji: '❤️‍🩹', gradFrom: '#92400E', gradTo: '#F59E0B',
        createdDaysAgo: 52, pct: 84
    },
    {
        id: 5, cat: 'giao-duc',
        status: 'active',
        title: 'Xây dựng thư viện số cho 30 trường tiểu học vùng sâu',
        desc: 'Trang bị thiết bị công nghệ, kết nối internet và xây dựng kho tài nguyên học liệu số để thu hẹp khoảng cách giáo dục giữa thành thị và nông thôn.',
        raised: 620000000, goal: 3000000000, donors: 543, daysLeft: 90,
        emoji: '💻', gradFrom: '#1E3A5F', gradTo: '#3B82F6',
        createdDaysAgo: 5, pct: 21
    },
    {
        id: 6, cat: 'thien-tai',
        status: 'done',
        title: 'Hỗ trợ tái thiết nhà ở sau bão số 9 tại Quảng Nam',
        desc: 'Chiến dịch đã hoàn thành, xây dựng lại 185 ngôi nhà kiên cố cho bà con bị mất nhà do bão số 9 năm 2025. Cảm ơn tấm lòng của hơn 5.000 nhà hảo tâm.',
        raised: 12000000000, goal: 12000000000, donors: 5342, daysLeft: 0,
        emoji: '🏠', gradFrom: '#374151', gradTo: '#9CA3AF',
        createdDaysAgo: 180, pct: 100
    },
    {
        id: 7, cat: 'moi-truong',
        status: 'active',
        title: 'Làm sạch bãi biển Đà Nẵng — Chiến dịch xanh 2026',
        desc: 'Tổ chức 12 đợt dọn dẹp bãi biển, thu gom rác thải nhựa, và nâng cao ý thức cộng đồng về bảo vệ môi trường biển Đà Nẵng.',
        raised: 340000000, goal: 800000000, donors: 1876, daysLeft: 30,
        emoji: '🏖️', gradFrom: '#0C4A6E', gradTo: '#22D3EE',
        createdDaysAgo: 10, pct: 43
    },
    {
        id: 8, cat: 'y-te',
        status: 'urgent',
        title: 'Mua máy thở khẩn cấp cho bệnh viện huyện Mường Tè',
        desc: 'Bệnh viện huyện Mường Tè đang thiếu trầm trọng trang thiết bị y tế. Mỗi ngày có nhiều bệnh nhân không được cứu chữa kịp thời vì thiếu máy thở.',
        raised: 1890000000, goal: 2500000000, donors: 4201, daysLeft: 4,
        emoji: '🏥', gradFrom: '#7C2D12', gradTo: '#FB923C',
        createdDaysAgo: 2, pct: 76
    },
    {
        id: 9, cat: 'giao-duc',
        status: 'active',
        title: 'Quỹ học bổng dành riêng cho trẻ em mồ côi tại TP.HCM',
        desc: 'Hỗ trợ chi phí học tập, sinh hoạt và hướng nghiệp cho 150 trẻ em mồ côi từ 6 đến 18 tuổi đang sống tại các mái ấm trên địa bàn TP. Hồ Chí Minh.',
        raised: 890000000, goal: 1800000000, donors: 723, daysLeft: 120,
        emoji: '👶', gradFrom: '#1E3A8A', gradTo: '#818CF8',
        createdDaysAgo: 20, pct: 49
    },
    {
        id: 10, cat: 'thien-tai',
        status: 'active',
        title: 'Hỗ trợ ngư dân Bình Thuận sau sự cố tràn dầu',
        desc: 'Sự cố tràn dầu đã ảnh hưởng nghiêm trọng đến ngư trường và sinh kế của hàng nghìn ngư dân ven biển Bình Thuận. Chúng tôi cần hỗ trợ khẩn cấp.',
        raised: 560000000, goal: 2000000000, donors: 389, daysLeft: 25,
        emoji: '⛵', gradFrom: '#0F4C75', gradTo: '#1B98E0',
        createdDaysAgo: 7, pct: 28
    },
    {
        id: 11, cat: 'moi-truong',
        status: 'ending',
        title: 'Bảo tồn rạn san hô Côn Đảo — Di sản đại dương Việt Nam',
        desc: 'Côn Đảo sở hữu một trong những hệ sinh thái san hô phong phú nhất Đông Nam Á. Dự án phục hồi 10 ha rạn san hô bị tẩy trắng do biến đổi khí hậu.',
        raised: 3100000000, goal: 4000000000, donors: 1543, daysLeft: 7,
        emoji: '🪸', gradFrom: '#0E7490', gradTo: '#06B6D4',
        createdDaysAgo: 88, pct: 78
    },
    {
        id: 12, cat: 'y-te',
        status: 'active',
        title: 'Chương trình khám chữa bệnh miễn phí vùng biên giới Tây Bắc',
        desc: 'Đưa đoàn y bác sĩ tình nguyện đến 20 xã vùng biên giới Điện Biên, Sơn La để khám bệnh, cấp thuốc và tuyên truyền kiến thức chăm sóc sức khỏe.',
        raised: 430000000, goal: 900000000, donors: 612, daysLeft: 55,
        emoji: '🩺', gradFrom: '#78350F', gradTo: '#FBBF24',
        createdDaysAgo: 15, pct: 48
    },
    {
        id: 13, cat: 'giao-duc',
        status: 'active',
        title: 'Xây trường học kiên cố tại Lai Châu — "Mái ấm tri thức"',
        desc: 'Sau nhiều năm học trong các lớp học tạm bợ, 400 học sinh tại xã Nậm Hàng sắp được học dưới mái trường kiên cố, an toàn trong mọi điều kiện thời tiết.',
        raised: 5600000000, goal: 8000000000, donors: 2891, daysLeft: 70,
        emoji: '🏫', gradFrom: '#1E40AF', gradTo: '#93C5FD',
        createdDaysAgo: 30, pct: 70
    },
    {
        id: 14, cat: 'moi-truong',
        status: 'done',
        title: 'Chiến dịch tái chế 1 triệu chai nhựa tại Hà Nội',
        desc: 'Đã hoàn thành! Thu gom và tái chế thành công 1.200.000 chai nhựa, tương đương 36 tấn rác thải nhựa được loại bỏ khỏi môi trường Hà Nội.',
        raised: 600000000, goal: 600000000, donors: 8724, daysLeft: 0,
        emoji: '♻️', gradFrom: '#14532D', gradTo: '#4ADE80',
        createdDaysAgo: 120, pct: 100
    },
    {
        id: 15, cat: 'y-te',
        status: 'active',
        title: 'Tầm soát ung thư vú miễn phí cho 10.000 phụ nữ nghèo',
        desc: 'Chương trình sàng lọc ung thư vú sớm bằng máy mammography di động, hướng đến 10.000 phụ nữ có hoàn cảnh khó khăn tại 5 tỉnh miền Nam.',
        raised: 2100000000, goal: 4500000000, donors: 1092, daysLeft: 80,
        emoji: '🩷', gradFrom: '#831843', gradTo: '#F472B6',
        createdDaysAgo: 18, pct: 47
    },
    {
        id: 16, cat: 'thien-tai',
        status: 'ending',
        title: 'Cứu trợ sạt lở đất Khánh Hòa — Hỗ trợ 80 gia đình mất nhà',
        desc: 'Trận sạt lở nghiêm trọng tháng 3/2026 tại Khánh Hòa đã khiến 80 hộ gia đình mất nhà và toàn bộ tài sản. Cần hỗ trợ khẩn để giúp bà con tái thiết cuộc sống.',
        raised: 1750000000, goal: 2400000000, donors: 2234, daysLeft: 9,
        emoji: '⛰️', gradFrom: '#44403C', gradTo: '#A8A29E',
        createdDaysAgo: 21, pct: 73
    },
    {
        id: 17, cat: 'giao-duc',
        status: 'active',
        title: 'Tiếng Anh cho trẻ em nông thôn — "English Bridge" 2026',
        desc: 'Mang lớp học tiếng Anh chuẩn quốc tế đến với 5.000 trẻ em ở 80 trường tiểu học nông thôn thông qua mô hình học trực tuyến kết hợp giáo viên tình nguyện.',
        raised: 480000000, goal: 1200000000, donors: 834, daysLeft: 95,
        emoji: '🗣️', gradFrom: '#1D4ED8', gradTo: '#6EE7B7',
        createdDaysAgo: 6, pct: 40
    },
    {
        id: 18, cat: 'y-te',
        status: 'done',
        title: 'Phẫu thuật mắt miễn phí cho 500 người cao tuổi vùng núi',
        desc: 'Chiến dịch đã hoàn thành xuất sắc! 512 người cao tuổi bị đục thủy tinh thể đã được phẫu thuật miễn phí và phục hồi thị lực, trở về với cuộc sống.',
        raised: 3800000000, goal: 3800000000, donors: 4102, daysLeft: 0,
        emoji: '👁️', gradFrom: '#1E3A5F', gradTo: '#67E8F9',
        createdDaysAgo: 200, pct: 100
    }
];

// ═══════════════════════════════════════════════════
// STATE
// ═══════════════════════════════════════════════════
var currentPage = 1;
var PAGE_SIZE = 9;
var filteredData = CAMPAIGNS.slice();

// ═══════════════════════════════════════════════════
// RANGE LABELS
// ═══════════════════════════════════════════════════
var RANGE_LABELS = [
    '100 triệu', '300 triệu', '500 triệu', '1 tỷ', '2 tỷ',
    '3 tỷ', '5 tỷ', '7 tỷ', '8 tỷ', '9 tỷ', '10 tỷ+'
];
var RANGE_VALUES = [
    1e8, 3e8, 5e8, 1e9, 2e9, 3e9, 5e9, 7e9, 8e9, 9e9, Infinity
];

function updateRange(v) {
    document.getElementById('rangeDisplay').textContent = '≤ ' + RANGE_LABELS[v];
    var pct = (v / 10) * 100;
    var el = document.getElementById('goalRange');
    el.style.background = 'linear-gradient(to right, #2D7A4F 0%, #2D7A4F ' + pct + '%, #CBD5E0 ' + pct + '%)';
}

// ═══════════════════════════════════════════════════
// FILTER + SORT
// ═══════════════════════════════════════════════════
function applyFilters() {
    var searchVal = document.getElementById('searchInput').value.toLowerCase().trim();
    var statusVal = document.querySelector('input[name="status"]:checked').value;
    var rangeVal = parseInt(document.getElementById('goalRange').value);
    var maxGoal = RANGE_VALUES[rangeVal];
    var checkedCats = Array.from(document.querySelectorAll('input[name="cat"]:checked')).map(function(c){ return c.value; });
    var sortVal = document.getElementById('sortSelect').value;

    filteredData = CAMPAIGNS.filter(function(c) {
        if (searchVal && !c.title.toLowerCase().includes(searchVal) && !c.desc.toLowerCase().includes(searchVal)) return false;
        if (statusVal !== 'all' && c.status !== statusVal) return false;
        if (c.goal > maxGoal) return false;
        if (checkedCats.length > 0 && !checkedCats.includes(c.cat)) return false;
        return true;
    });

    // Sort
    filteredData.sort(function(a, b) {
        if (sortVal === 'newest')      return a.createdDaysAgo - b.createdDaysAgo;
        if (sortVal === 'ending-soon') return (b.daysLeft === 0 ? 999 : b.daysLeft) < (a.daysLeft === 0 ? 999 : a.daysLeft) ? 1 : -1;
        if (sortVal === 'most-donors') return b.donors - a.donors;
        if (sortVal === 'most-funded') return b.pct - a.pct;
        return 0;
    });

    currentPage = 1;
    renderActiveFilterTags(checkedCats, statusVal, searchVal);
    renderGrid();
    renderPagination();
    updateResultCount();
}

function syncSort(val) {
    document.getElementById('sortSelect').value = val;
    applyFilters();
}
function syncSortFromSelect() {
    var val = document.getElementById('sortSelect').value;
    var radios = document.querySelectorAll('input[name="sortSidebar"]');
    radios.forEach(function(r){ if (r.value === val) r.checked = true; });
    applyFilters();
}

function resetFilters() {
    document.querySelectorAll('input[name="cat"]').forEach(function(c){ c.checked = false; });
    document.querySelector('input[name="status"][value="all"]').checked = true;
    document.getElementById('goalRange').value = 10;
    updateRange(10);
    document.getElementById('searchInput').value = '';
    document.getElementById('sortSelect').value = 'newest';
    document.querySelector('input[name="sortSidebar"][value="newest"]').checked = true;
    applyFilters();
}

// ═══════════════════════════════════════════════════
// ACTIVE FILTER TAGS
// ═══════════════════════════════════════════════════
var CAT_NAMES = {
    'thien-tai':'Thiên tai','giao-duc':'Giáo dục',
    'moi-truong':'Môi trường','y-te':'Y tế'
};
var STATUS_NAMES = {
    'active':'Đang diễn ra','urgent':'Khẩn cấp',
    'ending':'Sắp kết thúc','done':'Đã hoàn thành'
};

function renderActiveFilterTags(cats, status, search) {
    var wrap = document.getElementById('activeFilters');
    var tags = '';
    cats.forEach(function(c){
        tags += '<span class="filter-tag">' + CAT_NAMES[c] +
            '<button class="filter-tag-close" onclick="removeCatFilter(\'' + c + '\')">✕</button></span>';
    });
    if (status !== 'all') {
        tags += '<span class="filter-tag">' + STATUS_NAMES[status] +
            '<button class="filter-tag-close" onclick="removeStatusFilter()">✕</button></span>';
    }
    if (search) {
        tags += '<span class="filter-tag">Tìm: "' + search + '"' +
            '<button class="filter-tag-close" onclick="removeSearch()">✕</button></span>';
    }
    if (tags) {
        wrap.style.display = 'flex';
        wrap.innerHTML = '<span class="active-filter-label">Lọc đang áp dụng:</span>' + tags;
    } else {
        wrap.style.display = 'none';
    }
}
function removeCatFilter(val) {
    document.querySelector('input[name="cat"][value="' + val + '"]').checked = false;
    applyFilters();
}
function removeStatusFilter() {
    document.querySelector('input[name="status"][value="all"]').checked = true;
    applyFilters();
}
function removeSearch() {
    document.getElementById('searchInput').value = '';
    applyFilters();
}

// ═══════════════════════════════════════════════════
// RENDER CARDS
// ═══════════════════════════════════════════════════
var CAT_BADGE_CLASS = {
    'thien-tai':'badge-thien-tai','giao-duc':'badge-giao-duc',
    'moi-truong':'badge-moi-truong','y-te':'badge-y-te'
};
var STATUS_BADGE = {
    'active':  ['badge-status-active',  '🟢 Đang diễn ra'],
    'urgent':  ['badge-status-urgent',  '🔴 Khẩn cấp'],
    'ending':  ['badge-status-ending',  '🟡 Sắp kết thúc'],
    'done':    ['badge-status-done',    '✅ Đã hoàn thành']
};
var CAT_TAG_COLOR = {
    'thien-tai':'#C53030','giao-duc':'#1D4ED8',
    'moi-truong':'#065F46','y-te':'#92400E'
};

function formatMoney(n) {
    if (n >= 1e9) return (n/1e9).toFixed(n%1e9===0?0:1) + ' tỷ';
    if (n >= 1e6) return Math.round(n/1e6) + ' triệu';
    return n.toLocaleString('vi-VN');
}

function renderGrid() {
    var grid = document.getElementById('campaignsGrid');
    var start = (currentPage-1) * PAGE_SIZE;
    var pageData = filteredData.slice(start, start + PAGE_SIZE);

    if (pageData.length === 0) {
        grid.innerHTML = '<div class="empty-state">' +
            '<div class="empty-state-icon">🔍</div>' +
            '<h3>Không tìm thấy chiến dịch nào</h3>' +
            '<p>Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn.</p>' +
            '<button class="btn-chinh" onclick="resetFilters()" style="margin:0 auto;display:block">Xóa bộ lọc</button>' +
            '</div>';
        return;
    }

    grid.innerHTML = pageData.map(function(c) {
        var sBadge = STATUS_BADGE[c.status];
        var daysLabel = c.daysLeft > 0
            ? '<span class="card-meta-item' + (c.daysLeft<=7?' urgent':'') + '"><span>⏳</span><span>Còn ' + c.daysLeft + ' ngày</span></span>'
            : '<span class="card-meta-item"><span>✅</span><span>Đã kết thúc</span></span>';
        var donateDisabled = c.status === 'done';
        return '<div class="campaign-card" style="animation:cardIn .35s ease both;animation-delay:' + (pageData.indexOf(c)*0.05) + 's">' +
            '<div class="card-img-wrap">' +
                '<div class="card-img-placeholder" style="background:linear-gradient(135deg,' + c.gradFrom + ',' + c.gradTo + ')">' +
                    '<span style="filter:drop-shadow(0 2px 8px rgba(0,0,0,.3));font-size:48px">' + c.emoji + '</span>' +
                '</div>' +
                '<div class="card-badges">' +
                    '<span class="badge ' + CAT_BADGE_CLASS[c.cat] + '">' + CAT_NAMES[c.cat] + '</span>' +
                    '<span class="badge ' + sBadge[0] + '">' + sBadge[1] + '</span>' +
                '</div>' +
            '</div>' +
            '<div class="card-body">' +
                '<div class="card-title">' + c.title + '</div>' +
                '<div class="card-desc">' + c.desc + '</div>' +
                '<div class="card-progress-wrap">' +
                    '<div class="card-progress-header">' +
                        '<span class="card-progress-pct">' + c.pct + '%</span>' +
                        '<div class="card-progress-money">' +
                            '<strong>' + formatMoney(c.raised) + '</strong><br/>' +
                            '<span>/ ' + formatMoney(c.goal) + '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="progress-nen"><div class="progress-thanh" style="width:' + Math.min(c.pct,100) + '%"></div></div>' +
                '</div>' +
                '<div class="card-meta">' +
                    daysLabel +
                    '<span class="card-meta-item"><span>👥</span><span>' + c.donors.toLocaleString('vi-VN') + ' lượt góp</span></span>' +
                '</div>' +
                '<div class="card-actions">' +
                    '<a href="/ChiTietChienDich.aspx?id=' + c.id + '" class="btn-card-detail">Xem chi tiết</a>' +
                    (donateDisabled
                        ? '<button class="btn-card-donate" disabled style="opacity:.5;cursor:not-allowed">✓ Đã hoàn thành</button>'
                        : '<a href="/QuyenGop.aspx?id=' + c.id + '" class="btn-card-donate">❤ Góp ngay</a>') +
                '</div>' +
            '</div>' +
        '</div>';
    }).join('');
}

// ═══════════════════════════════════════════════════
// PAGINATION
// ═══════════════════════════════════════════════════
function renderPagination() {
    var wrap = document.getElementById('paginationWrap');
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (totalPages <= 1) { wrap.innerHTML = ''; return; }

    var html = '';
    html += '<button class="page-btn" onclick="goPage(' + (currentPage-1) + ')" ' + (currentPage===1?'disabled':'') + '>← Trước</button>';

    var pages = buildPageRange(currentPage, totalPages);
    pages.forEach(function(p) {
        if (p === '...') {
            html += '<span class="page-dots">…</span>';
        } else {
            html += '<button class="page-btn' + (p===currentPage?' active':'') + '" onclick="goPage(' + p + ')">' + p + '</button>';
        }
    });

    html += '<button class="page-btn" onclick="goPage(' + (currentPage+1) + ')" ' + (currentPage===totalPages?'disabled':'') + '>Sau →</button>';
    wrap.innerHTML = html;
}

function buildPageRange(cur, total) {
    var pages = [];
    if (total <= 7) {
        for (var i=1;i<=total;i++) pages.push(i);
        return pages;
    }
    pages.push(1);
    if (cur > 3) pages.push('...');
    for (var i=Math.max(2,cur-1); i<=Math.min(total-1,cur+1); i++) pages.push(i);
    if (cur < total-2) pages.push('...');
    pages.push(total);
    return pages;
}

function goPage(p) {
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (p < 1 || p > totalPages) return;
    currentPage = p;
    renderGrid();
    renderPagination();
    window.scrollTo({top: document.getElementById('campaignsGrid').offsetTop - 90, behavior: 'smooth'});
}

function updateResultCount() {
    document.getElementById('resultCount').innerHTML =
        'Tìm thấy <strong>' + filteredData.length + '</strong> chiến dịch';
}

// ═══════════════════════════════════════════════════
// CARD ANIMATION
// ═══════════════════════════════════════════════════
var styleEl = document.createElement('style');
styleEl.textContent = '@keyframes cardIn{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:none}}';
document.head.appendChild(styleEl);

// ═══════════════════════════════════════════════════
// INIT
// ═══════════════════════════════════════════════════
updateRange(3);
applyFilters();
</script>

</asp:Content>
