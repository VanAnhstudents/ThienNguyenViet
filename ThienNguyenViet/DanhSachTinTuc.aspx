<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
         CodeBehind="DanhSachTinTuc.aspx.cs" Inherits="ThienNguyenViet.DanhSachTinTuc" %>
<%@ Import Namespace="ThienNguyenViet.DAO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   DANH SÁCH TIN TỨC — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Page Hero ─────────────────────────────────────────────── */
.news-page-hero {
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 60%, #3D9962 100%);
    padding: 60px 0 52px;
    position: relative;
    overflow: hidden;
}
.news-page-hero::before {
    content: '';
    position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='80' height='80'%3E%3Ccircle cx='40' cy='40' r='1' fill='rgba(255,255,255,.06)'/%3E%3C/svg%3E");
}
.news-page-hero::after {
    content: '';
    position: absolute;
    bottom: -2px; left: 0; right: 0;
    height: 60px;
    background: var(--nen-trang);
    clip-path: ellipse(55% 100% at 50% 100%);
}
.news-hero-content {
    position: relative; z-index: 1;
    text-align: center;
}
.news-hero-badge {
    display: inline-flex; align-items: center; gap: 7px;
    background: rgba(255,255,255,.12); backdrop-filter: blur(8px);
    color: rgba(255,255,255,.9); font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: .12em;
    padding: 6px 18px; border-radius: 99px;
    border: 1px solid rgba(255,255,255,.18);
    margin-bottom: 18px;
}
.news-hero-title {
    font-family: 'Playfair Display', serif;
    font-size: clamp(32px, 4vw, 48px);
    font-weight: 800; color: #fff;
    line-height: 1.15; margin-bottom: 14px;
}
.news-hero-title em { font-style: italic; color: #7EE090; }
.news-hero-sub {
    font-size: 15px; color: rgba(255,255,255,.72);
    max-width: 480px; margin: 0 auto;
    line-height: 1.7;
}

/* ── Filter & Search Bar ────────────────────────────────────── */
.filter-bar-wrapper {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
    margin-top: 40px; margin-bottom: 48px;
}
.filter-bar {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 32px rgba(45,122,79,.10);
    border: 1px solid #E2F0E8;
    padding: 20px 24px;
    display: flex;
    align-items: center;
    gap: 16px;
    flex-wrap: wrap;
}

/* Search input */
.search-box {
    position: relative;
    flex: 1; min-width: 220px;
}
.search-box-icon {
    position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
    font-size: 15px; pointer-events: none;
    color: var(--chu-phu);
}
.search-input {
    width: 100%;
    height: 42px; padding: 0 16px 0 42px;
    border: 1.5px solid var(--vien);
    border-radius: 10px;
    font-size: 14px; font-family: var(--font);
    color: var(--chu-chinh);
    background: #F8F9FA;
    outline: none;
    transition: border-color .2s, background .2s, box-shadow .2s;
}
.search-input:focus {
    border-color: var(--mau-chinh);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(45,122,79,.12);
}
.search-input::placeholder { color: #A0AEC0; }

/* Category pills */
.filter-divider {
    width: 1px; height: 28px;
    background: var(--vien);
    flex-shrink: 0;
}
.category-pills {
    display: flex; gap: 8px; flex-wrap: wrap;
}
.cat-pill {
    height: 36px; padding: 0 16px;
    border-radius: 99px;
    font-size: 13px; font-weight: 600;
    font-family: var(--font);
    cursor: pointer;
    border: 1.5px solid var(--vien);
    background: #fff; color: var(--chu-than);
    transition: all .18s;
    display: inline-flex; align-items: center; gap: 6px;
}
.cat-pill:hover {
    border-color: var(--mau-chinh-nhat);
    color: var(--mau-chinh);
    background: var(--mau-chinh-nen);
}
.cat-pill.active {
    background: var(--mau-chinh);
    border-color: var(--mau-chinh);
    color: #fff;
    box-shadow: 0 3px 10px rgba(45,122,79,.25);
}

/* Sort select */
.sort-select {
    height: 42px; padding: 0 36px 0 14px;
    border: 1.5px solid var(--vien);
    border-radius: 10px;
    font-size: 13px; font-family: var(--font);
    color: var(--chu-than);
    background: #F8F9FA;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23718096' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    outline: none; cursor: pointer;
    transition: border-color .2s;
    flex-shrink: 0;
    min-width: 160px;
}
.sort-select:focus { border-color: var(--mau-chinh); }

/* ── Results Summary ────────────────────────────────────────── */
.results-summary {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 28px;
    flex-wrap: wrap; gap: 10px;
}
.results-count {
    font-size: 14px; color: var(--chu-phu);
}
.results-count strong { color: var(--chu-chinh); font-weight: 700; }

/* ── News Grid ──────────────────────────────────────────────── */
.news-list-section {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
}

/* Featured card (full width) */
.news-featured-card {
    display: grid;
    grid-template-columns: 1.15fr 1fr;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
    border: 1px solid #E8F0EB;
    box-shadow: 0 4px 24px rgba(45,122,79,.08);
    margin-bottom: 36px;
    transition: all .3s;
}
.news-featured-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 16px 48px rgba(45,122,79,.14);
    border-color: var(--mau-chinh-nhat);
}
.featured-thumb {
    height: 320px; overflow: hidden;
    background: linear-gradient(135deg, #143D20, #2D7A4F);
    display: flex; align-items: center; justify-content: center;
    font-size: 80px;
    position: relative;
}
.featured-thumb img {
    width: 100%; height: 100%; object-fit: cover;
    transition: transform .6s ease;
}
.news-featured-card:hover .featured-thumb img { transform: scale(1.04); }
.featured-tag {
    position: absolute; top: 18px; left: 18px;
    font-size: 10px; font-weight: 700;
    padding: 5px 12px; border-radius: 99px;
    text-transform: uppercase; letter-spacing: .06em;
    backdrop-filter: blur(8px);
}
.tag-hoatdong  { background: rgba(229,62,62,.85);   color: #fff; }
.tag-cauchuy   { background: rgba(56,161,105,.85);  color: #fff; }
.tag-thongbao  { background: rgba(49,130,206,.85);  color: #fff; }
.tag-all       { background: rgba(113,128,150,.85); color: #fff; }

.featured-pin-badge {
    position: absolute; top: 18px; right: 18px;
    background: rgba(192,101,26,.9); color: #fff;
    font-size: 10px; font-weight: 700;
    padding: 5px 12px; border-radius: 99px;
    display: flex; align-items: center; gap: 4px;
}
.featured-body {
    padding: 36px 36px 36px 32px;
    display: flex; flex-direction: column; justify-content: center;
}
.featured-meta {
    display: flex; align-items: center; gap: 16px;
    margin-bottom: 14px;
    font-size: 12px; color: var(--chu-phu);
}
.featured-meta span { display: flex; align-items: center; gap: 5px; }
.featured-title {
    font-family: 'Playfair Display', serif;
    font-size: 22px; font-weight: 800; color: #1A3D28;
    line-height: 1.35; margin-bottom: 14px;
    display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
}
.featured-summary {
    font-size: 14px; color: var(--chu-phu); line-height: 1.75;
    margin-bottom: 24px;
    display: -webkit-box; -webkit-line-clamp: 4; -webkit-box-orient: vertical; overflow: hidden;
}
.btn-read-more {
    align-self: flex-start;
    height: 42px; padding: 0 22px;
    background: var(--mau-chinh);
    color: #fff; border-radius: 10px;
    font-size: 13px; font-weight: 700;
    font-family: var(--font); border: none;
    cursor: pointer; text-decoration: none;
    display: inline-flex; align-items: center; gap: 7px;
    transition: all .2s;
    box-shadow: 0 3px 10px rgba(45,122,79,.25);
}
.btn-read-more:hover {
    background: var(--mau-chinh-hover);
    transform: translateY(-1px);
    box-shadow: 0 6px 18px rgba(45,122,79,.35);
    color: #fff;
}

/* Regular grid */
.news-cards-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 26px;
}

.news-card-item {
    background: #fff;
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid #E8F0EB;
    transition: all .3s cubic-bezier(.175,.885,.32,1.1);
    display: flex; flex-direction: column;
    position: relative;
}
.news-card-item:hover {
    transform: translateY(-6px);
    box-shadow: 0 16px 40px rgba(45,122,79,.14);
    border-color: var(--mau-chinh-nhat);
}

.card-thumb {
    height: 196px; overflow: hidden;
    position: relative;
    background: linear-gradient(135deg, #EAF5EE, #B7DEC6);
    display: flex; align-items: center; justify-content: center;
    font-size: 56px;
}
.card-thumb img {
    width: 100%; height: 100%; object-fit: cover;
    transition: transform .5s ease;
}
.news-card-item:hover .card-thumb img { transform: scale(1.05); }

.card-cat-badge {
    position: absolute; bottom: 12px; left: 12px;
    font-size: 9px; font-weight: 700;
    padding: 4px 10px; border-radius: 99px;
    text-transform: uppercase; letter-spacing: .06em;
    backdrop-filter: blur(8px);
}

.card-body {
    padding: 18px 20px 20px;
    flex: 1; display: flex; flex-direction: column;
}
.card-meta {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 10px;
    font-size: 11px; color: var(--chu-phu);
}
.card-meta span { display: flex; align-items: center; gap: 4px; }
.card-title {
    font-family: 'Playfair Display', serif;
    font-size: 16px; font-weight: 700; color: #1A3D28;
    line-height: 1.4; margin-bottom: 10px;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.card-summary {
    font-size: 13px; color: var(--chu-phu); line-height: 1.65;
    flex: 1;
    display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
    margin-bottom: 16px;
}
.card-footer {
    display: flex; align-items: center; justify-content: space-between;
    padding-top: 14px;
    border-top: 1px solid #F0F7F2;
}
.card-read-link {
    font-size: 13px; font-weight: 600; color: var(--mau-chinh);
    text-decoration: none;
    display: flex; align-items: center; gap: 4px;
    transition: gap .18s;
}
.card-read-link:hover { gap: 8px; color: var(--mau-chinh-hover); }
.card-views {
    font-size: 11px; color: var(--chu-phu);
    display: flex; align-items: center; gap: 4px;
}

/* ── Pagination ─────────────────────────────────────────────── */
.pagination-wrapper {
    display: flex; align-items: center; justify-content: center;
    gap: 6px; margin: 52px 0 0;
}
.page-btn {
    min-width: 40px; height: 40px; padding: 0 10px;
    border-radius: 10px;
    border: 1.5px solid var(--vien);
    background: #fff; color: var(--chu-than);
    font-size: 13px; font-weight: 600;
    font-family: var(--font);
    cursor: pointer; transition: all .18s;
    display: flex; align-items: center; justify-content: center;
}
.page-btn:hover {
    border-color: var(--mau-chinh-nhat);
    color: var(--mau-chinh);
    background: var(--mau-chinh-nen);
}
.page-btn.active {
    background: var(--mau-chinh);
    border-color: var(--mau-chinh);
    color: #fff;
    box-shadow: 0 3px 10px rgba(45,122,79,.25);
}
.page-btn:disabled {
    opacity: .4; cursor: not-allowed;
}
.page-dots {
    color: var(--chu-phu); font-size: 13px;
    padding: 0 4px; letter-spacing: .1em;
}

/* ── Empty State ────────────────────────────────────────────── */
.empty-state {
    text-align: center; padding: 80px 20px;
}
.empty-state-icon { font-size: 64px; margin-bottom: 16px; }
.empty-state h3 { font-size: 20px; color: var(--chu-chinh); margin-bottom: 8px; }
.empty-state p { font-size: 14px; color: var(--chu-phu); }

/* ── Reveal animation ───────────────────────────────────────── */
.reveal {
    opacity: 0; transform: translateY(24px);
    transition: opacity .5s ease, transform .5s ease;
}
.reveal.visible { opacity: 1; transform: translateY(0); }
.reveal-delay-1 { transition-delay: .05s; }
.reveal-delay-2 { transition-delay: .12s; }
.reveal-delay-3 { transition-delay: .19s; }

/* ── Section spacing ───────────────────────────────────────── */
.news-main-content { padding-bottom: 80px; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- ═══════════════════════════════════════════════════════════
     PAGE HERO
═══════════════════════════════════════════════════════════════ -->
<section class="news-page-hero">
    <div class="container news-hero-content">
        <div class="news-hero-badge">📰 Tin tức &amp; Câu chuyện</div>
        <h1 class="news-hero-title">Những câu chuyện<br/><em>truyền cảm hứng</em></h1>
        <p class="news-hero-sub">Cập nhật hoạt động thiện nguyện, câu chuyện của những người được hỗ trợ và thông tin mới nhất từ cộng đồng.</p>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     FILTER BAR
═══════════════════════════════════════════════════════════════ -->
<div class="filter-bar-wrapper">
    <div class="filter-bar">
        <div class="search-box">
            <span class="search-box-icon">🔍</span>
            <input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm bài viết..." />
        </div>

        <div class="filter-divider"></div>

        <div class="category-pills" id="categoryPills">
            <button class="cat-pill active" data-cat="all">Tất cả</button>
            <button class="cat-pill" data-cat="hoatdong">Hoạt động</button>
            <button class="cat-pill" data-cat="cauchuy">Câu chuyện</button>
            <button class="cat-pill" data-cat="thongbao">Thông báo</button>
        </div>

        <div class="filter-divider"></div>

        <select class="sort-select" id="sortSelect">
            <option value="newest">Mới nhất</option>
            <option value="oldest">Cũ nhất</option>
            <option value="mostviewed">Xem nhiều nhất</option>
        </select>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     MAIN CONTENT
═══════════════════════════════════════════════════════════════ -->
<div class="news-main-content">
    <div class="news-list-section">

        <!-- Results Summary (nội dung cập nhật bởi JS) -->
        <div class="results-summary">
            <div class="results-count" id="resultsCount">
                Đang tải bài viết...
            </div>
        </div>

        <!-- ── FEATURED ARTICLE (bài nổi bật — bài mới nhất) ── -->
        <asp:Panel ID="pnlFeatured" runat="server">
    <div id="featuredSection">
        <asp:Repeater ID="rptFeatured" runat="server">
            <ItemTemplate>

                <a href='/ChiTietTinTuc.aspx?id=<%# Eval("MaTinTuc") %>'
                   class="news-featured-card"
                   data-date='<%# Convert.ToDateTime(Eval("NgayDang")).ToString("yyyyMMdd") %>'
                   data-views='<%# Eval("LuotXem") %>'
                   style="text-decoration:none; color:inherit">

                    <!-- ẢNH -->
                    <div class="featured-thumb">
                        <img src='<%# Eval("AnhBia") == DBNull.Value ? "/images/no-image.png" : Eval("AnhBia") %>' 
                             alt="" />

                        <!-- DANH MỤC (TEXT) -->
                        <span class="featured-tag">
                            <%# Eval("TenDanhMuc") %>
                        </span>

                        <!-- BADGE -->
                        <span class="featured-pin-badge">Nổi bật</span>
                    </div>

                    <!-- NỘI DUNG -->
                    <div class="featured-body">
                        <div class="featured-meta">
                            <span><%# Eval("NguoiDang") %></span>
                            <span><%# Convert.ToDateTime(Eval("NgayDang")).ToString("dd/MM/yyyy") %></span>
                            <span><%# Eval("LuotXem") %> lượt xem</span>
                        </div>

                        <h2 class="featured-title">
                            <%# Eval("TieuDe") %>
                        </h2>

                        <p class="featured-summary">
                            <%# Eval("TomTat") %>
                        </p>

                        <span class="btn-read-more">
                            Đọc bài viết đầy đủ →
                        </span>
                    </div>

                </a>

            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Panel>

        <!-- ── CARDS GRID ──────────────────────────────────────── -->
        <asp:Panel ID="pnlGrid" runat="server">
    <div class="news-cards-grid" id="newsGrid">
        <asp:Repeater ID="rptCards" runat="server">
            <ItemTemplate>

                <div class='news-card-item reveal <%# new[]{"reveal-delay-1","reveal-delay-2","reveal-delay-3"}[Container.ItemIndex % 3] %>'
                     data-date='<%# Convert.ToDateTime(Eval("NgayDang")).ToString("yyyyMMdd") %>'
                     data-views='<%# Eval("LuotXem") %>'>

                    <!-- ẢNH -->
                    <div class="card-thumb">
                        <img src='<%# Eval("AnhBia") == DBNull.Value ? "/images/no-image.png" : Eval("AnhBia") %>' 
                             alt="" />

                        <!-- DANH MỤC (TEXT ONLY) -->
                        <span class="card-cat-badge">
                            <%# Eval("TenDanhMuc") %>
                        </span>
                    </div>

                    <!-- NỘI DUNG -->
                    <div class="card-body">
                        <div class="card-meta">
                            <span><%# Eval("NguoiDang") %></span>
                            <span><%# Convert.ToDateTime(Eval("NgayDang")).ToString("dd/MM/yyyy") %></span>
                        </div>

                        <h3 class="card-title">
                            <%# Eval("TieuDe") %>
                        </h3>

                        <p class="card-summary">
                            <%# Eval("TomTat") %>
                        </p>

                        <div class="card-footer">
                            <a href='/ChiTietTinTuc.aspx?id=<%# Eval("MaTinTuc") %>'
                               class="card-read-link">
                                Đọc tiếp →
                            </a>

                            <span class="card-views">
                                <%# Eval("LuotXem") %> lượt xem
                            </span>
                        </div>
                    </div>

                </div>

            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Panel>

        <!-- ── EMPTY STATE ─────────────────────────────────────── -->
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="empty-state">
                <div class="empty-state-icon"></div>
                <h3>Chưa có bài viết nào</h3>
                <p>Vui lòng quay lại sau.</p>
            </div>
        </asp:Panel>

        <!-- Empty state client-side (lọc JS không tìm thấy) -->
        <div class="empty-state" id="emptyState" style="display:none">
            <div class="empty-state-icon"></div>
            <h3>Không tìm thấy bài viết</h3>
            <p>Thử thay đổi từ khóa hoặc chọn danh mục khác.</p>
        </div>

        <!-- Pagination -->
        <div class="pagination-wrapper" id="paginationWrapper" style="display:none">
            <button class="page-btn" id="prevBtn" disabled>‹ Trước</button>
            <button class="page-btn" id="nextBtn">Tiếp ›</button>
        </div>

    </div>
</div>

<!-- ─────────────────────────────────────────────────────────── -->
<script>
    (function () {

        var currentCat = 'all';
        var searchVal = '';
        var sortVal = 'newest';
        var currentPage = 1;
        var PER_PAGE = 6;

        var grid = document.getElementById('newsGrid');
        var featuredCard = document.getElementById('featuredCard');
        var featuredSect = document.getElementById('featuredSection');
        var emptyState = document.getElementById('emptyState');
        var resultsCount = document.getElementById('resultsCount');

        // Nếu không có dữ liệu từ server thì dừng
        if (!grid || !featuredCard) return;

        var allCards = Array.from(grid.querySelectorAll('.news-card-item'));

        /* Intersection observer for reveals */
        var io = new IntersectionObserver(function (entries) {
            entries.forEach(function (e) {
                if (e.isIntersecting) e.target.classList.add('visible');
            });
        }, { threshold: 0.1 });
        document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });

        /* ── Filter / search logic ──────────────────────────── */
        function getVisible() {
            return allCards.filter(function (card) {
                var cat = card.dataset.cat;
                var title = card.querySelector('.card-title').textContent.toLowerCase();
                var summ = card.querySelector('.card-summary').textContent.toLowerCase();
                var matchCat = (currentCat === 'all' || cat === currentCat);
                var matchSrch = (searchVal === '' || title.includes(searchVal) || summ.includes(searchVal));
                return matchCat && matchSrch;
            });
        }

        function sortCards(cards) {
            return cards.slice().sort(function (a, b) {
                if (sortVal === 'newest') return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                if (sortVal === 'oldest') return parseInt(a.dataset.date) - parseInt(b.dataset.date);
                if (sortVal === 'mostviewed') return parseInt(b.dataset.views) - parseInt(a.dataset.views);
                return 0;
            });
        }

        function renderPage() {
            var visible = sortCards(getVisible());
            var total = visible.length;
            var totalPages = Math.max(1, Math.ceil(total / PER_PAGE));
            currentPage = Math.min(currentPage, totalPages);

            var start = (currentPage - 1) * PER_PAGE;
            var pageItems = visible.slice(start, start + PER_PAGE);

            allCards.forEach(function (c) { c.style.display = 'none'; });

            /* Featured card filter */
            var featCat = featuredCard.dataset.cat;
            var featTitle = featuredCard.querySelector('.featured-title').textContent.toLowerCase();
            var showFeat = (currentCat === 'all' || featCat === currentCat) &&
                (searchVal === '' || featTitle.includes(searchVal));
            featuredSect.style.display = showFeat ? '' : 'none';

            if (pageItems.length === 0 && !showFeat) {
                emptyState.style.display = 'block';
                grid.style.display = 'none';
            } else {
                emptyState.style.display = 'none';
                grid.style.display = '';
                pageItems.forEach(function (c) { c.style.display = 'flex'; });
            }

            var totalDisp = total + (showFeat ? 1 : 0);
            resultsCount.innerHTML = 'Hiển thị <strong>' + pageItems.length +
                '</strong> trong tổng số <strong>' + totalDisp + '</strong> bài viết';

            renderPagination(totalPages);
        }

        function renderPagination(totalPages) {
            var wrapper = document.getElementById('paginationWrapper');
            wrapper.style.display = totalPages <= 1 ? 'none' : 'flex';

            var prevBtn = document.getElementById('prevBtn');
            var nextBtn = document.getElementById('nextBtn');
            prevBtn.disabled = currentPage === 1;
            nextBtn.disabled = currentPage === totalPages;

            wrapper.querySelectorAll('[data-page]').forEach(function (b) { b.remove(); });
            wrapper.querySelectorAll('.page-dots').forEach(function (d) { d.remove(); });

            var fragment = document.createDocumentFragment();
            for (var i = 1; i <= totalPages; i++) {
                if (i === 1 || i === totalPages || Math.abs(i - currentPage) <= 1) {
                    var btn = document.createElement('button');
                    btn.className = 'page-btn' + (i === currentPage ? ' active' : '');
                    btn.dataset.page = i;
                    btn.textContent = i;
                    btn.addEventListener('click', function () {
                        currentPage = parseInt(this.dataset.page);
                        renderPage();
                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    });
                    fragment.appendChild(btn);
                } else if (i === 2 || i === totalPages - 1) {
                    var dots = document.createElement('span');
                    dots.className = 'page-dots';
                    dots.textContent = '···';
                    fragment.appendChild(dots);
                }
            }
            nextBtn.before(fragment);
        }

        /* ── Event bindings ─────────────────────────────────── */
        document.getElementById('searchInput').addEventListener('input', function () {
            searchVal = this.value.toLowerCase().trim();
            currentPage = 1;
            renderPage();
        });

        document.getElementById('categoryPills').addEventListener('click', function (e) {
            var pill = e.target.closest('.cat-pill');
            if (!pill) return;
            document.querySelectorAll('.cat-pill').forEach(function (p) { p.classList.remove('active'); });
            pill.classList.add('active');
            currentCat = pill.dataset.cat;
            currentPage = 1;
            renderPage();
        });

        document.getElementById('sortSelect').addEventListener('change', function () {
            sortVal = this.value;
            currentPage = 1;
            renderPage();
        });

        document.getElementById('prevBtn').addEventListener('click', function () {
            if (currentPage > 1) { currentPage--; renderPage(); window.scrollTo({ top: 0, behavior: 'smooth' }); }
        });
        document.getElementById('nextBtn').addEventListener('click', function () {
            currentPage++;
            renderPage();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });

        renderPage();

    })();
</script>

</asp:Content>
