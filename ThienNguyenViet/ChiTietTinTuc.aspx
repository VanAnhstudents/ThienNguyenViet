<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietTinTuc.aspx.cs" Inherits="ThienNguyenViet.ChiTietTinTuc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   CHI TIẾT TIN TỨC — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Article Hero / Cover ───────────────────────────────────── */
.article-cover {
    position: relative;
    height: 480px;
    overflow: hidden;
    background: linear-gradient(135deg, #143D20 0%, #2D7A4F 60%, #3D9962 100%);
    display: flex; align-items: center; justify-content: center;
    font-size: 120px;
}
.article-cover img {
    position: absolute; inset: 0;
    width: 100%; height: 100%; object-fit: cover;
}
.article-cover-overlay {
    position: absolute; inset: 0;
    background: linear-gradient(to bottom,
        rgba(10,35,18,.25) 0%,
        rgba(10,35,18,.55) 60%,
        rgba(10,35,18,.80) 100%);
    z-index: 1;
}
.article-cover-content {
    position: absolute;
    bottom: 0; left: 0; right: 0;
    z-index: 2;
    padding: 0 0 40px;
}
.article-cover-inner {
    max-width: 860px; margin: 0 auto; padding: 0 24px;
}
.article-cover-cat {
    display: inline-flex; align-items: center; gap: 6px;
    font-size: 11px; font-weight: 700; padding: 5px 14px;
    border-radius: 99px; text-transform: uppercase; letter-spacing: .08em;
    margin-bottom: 14px;
    backdrop-filter: blur(8px);
}
.article-cover-title {
    font-family: 'Playfair Display', serif;
    font-size: clamp(24px, 3.5vw, 38px);
    font-weight: 800; color: #fff;
    line-height: 1.2; margin-bottom: 0;
    text-shadow: 0 2px 12px rgba(0,0,0,.3);
}

/* ── Breadcrumb ─────────────────────────────────────────────── */
.breadcrumb-bar {
    background: #fff;
    border-bottom: 1px solid #EBF4EE;
    padding: 10px 0;
}
.breadcrumb-inner {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
    display: flex; align-items: center; gap: 6px;
    font-size: 12px; color: var(--chu-phu);
}
.breadcrumb-inner a {
    color: var(--mau-chinh); text-decoration: none;
    font-weight: 500;
    transition: color .15s;
}
.breadcrumb-inner a:hover { color: var(--mau-chinh-hover); }
.breadcrumb-sep { color: #C8D8CE; }

/* ── Page Layout ────────────────────────────────────────────── */
.article-page {
    max-width: 1200px; margin: 0 auto; padding: 48px 24px 80px;
    display: grid;
    grid-template-columns: minmax(0, 1fr) 320px;
    gap: 40px;
    align-items: start;
}

/* ── Article Main ───────────────────────────────────────────── */
.article-main {}

/* Meta row */
.article-meta {
    display: flex; align-items: center; gap: 20px; flex-wrap: wrap;
    margin-bottom: 28px;
    padding-bottom: 20px;
    border-bottom: 1px solid #EBF4EE;
}
.article-meta-item {
    display: flex; align-items: center; gap: 6px;
    font-size: 13px; color: var(--chu-phu);
}
.article-meta-item strong { color: var(--chu-chinh); font-weight: 600; }
.meta-avatar {
    width: 28px; height: 28px; border-radius: 50%;
    background: linear-gradient(135deg, #2D7A4F, #3D9962);
    display: flex; align-items: center; justify-content: center;
    font-size: 13px; color: #fff; font-weight: 700;
    flex-shrink: 0;
}
.meta-dot {
    width: 4px; height: 4px; border-radius: 50%;
    background: var(--vien);
    flex-shrink: 0;
}

/* Reading time badge */
.reading-time-badge {
    margin-left: auto;
    display: inline-flex; align-items: center; gap: 5px;
    background: var(--mau-chinh-nen);
    color: var(--mau-chinh);
    font-size: 11px; font-weight: 700;
    padding: 4px 12px; border-radius: 99px;
}

/* ── Article Body / Rich Text ───────────────────────────────── */
.article-body {
    font-size: 16px;
    line-height: 1.85;
    color: #374151;
}
.article-body h2 {
    font-family: 'Playfair Display', serif;
    font-size: 24px; font-weight: 700;
    color: #1A3D28;
    margin: 36px 0 14px;
    padding-bottom: 10px;
    border-bottom: 2px solid #EAF5EE;
}
.article-body h3 {
    font-size: 18px; font-weight: 700;
    color: #1A3D28; margin: 28px 0 10px;
}
.article-body p {
    margin: 0 0 18px;
}
.article-body strong { color: var(--chu-chinh); }
.article-body em { color: var(--mau-chinh); font-style: italic; }

/* Lead paragraph */
.article-body .lead {
    font-size: 17.5px; font-weight: 500;
    color: var(--chu-chinh);
    line-height: 1.75;
    padding: 20px 24px;
    background: #F6FBF7;
    border-left: 4px solid var(--mau-chinh);
    border-radius: 0 10px 10px 0;
    margin-bottom: 24px;
}

/* Inline image */
.article-body .article-img {
    width: 100%; border-radius: 14px;
    overflow: hidden; margin: 28px 0;
    position: relative;
}
.article-body .article-img img {
    width: 100%; height: 320px; object-fit: cover;
    display: block;
}
.article-body .article-img .img-caption {
    background: #F6FBF7;
    padding: 10px 16px;
    font-size: 12px; color: var(--chu-phu);
    font-style: italic;
    border-top: 1px solid #EBF4EE;
}

/* Blockquote */
.article-body blockquote {
    background: linear-gradient(135deg, #F0FDF4, #EAF5EE);
    border-left: 4px solid var(--mau-chinh);
    padding: 22px 24px;
    border-radius: 0 12px 12px 0;
    margin: 24px 0;
    position: relative;
}
.article-body blockquote::before {
    content: '"';
    position: absolute; top: -8px; left: 14px;
    font-family: 'Playfair Display', serif;
    font-size: 64px; color: var(--mau-chinh-nhat);
    line-height: 1;
}
.article-body blockquote p {
    font-size: 16px; font-style: italic;
    color: #276749; font-weight: 500; margin: 0 0 6px;
}
.article-body blockquote cite {
    font-size: 13px; color: var(--chu-phu); font-style: normal;
    font-weight: 600;
}

/* Highlights box */
.article-body .highlight-box {
    background: linear-gradient(135deg, #FFFBEB, #FEFCE8);
    border: 1px solid #F6D860;
    border-radius: 12px; padding: 20px 22px; margin: 24px 0;
}
.article-body .highlight-box .hb-title {
    font-size: 13px; font-weight: 700; color: #92400E;
    text-transform: uppercase; letter-spacing: .08em;
    margin-bottom: 10px; display: flex; align-items: center; gap: 6px;
}
.article-body .highlight-box ul {
    margin: 0; padding-left: 18px;
}
.article-body .highlight-box ul li {
    font-size: 14px; color: #78350F; margin-bottom: 6px; line-height: 1.6;
}

/* ── Tags ───────────────────────────────────────────────────── */
.article-tags {
    margin-top: 36px; padding-top: 24px;
    border-top: 1px solid #EBF4EE;
    display: flex; align-items: flex-start; gap: 12px; flex-wrap: wrap;
}
.tags-label {
    font-size: 13px; font-weight: 700; color: var(--chu-chinh);
    padding-top: 2px; flex-shrink: 0;
}
.tags-list { display: flex; gap: 8px; flex-wrap: wrap; }
.tag-item {
    font-size: 12px; font-weight: 600;
    padding: 5px 14px; border-radius: 99px;
    background: var(--mau-chinh-nen);
    color: var(--mau-chinh);
    border: 1.5px solid var(--mau-chinh-nhat);
    text-decoration: none;
    transition: all .18s; cursor: pointer;
}
.tag-item:hover {
    background: var(--mau-chinh);
    color: #fff;
    border-color: var(--mau-chinh);
}

/* ── Share ──────────────────────────────────────────────────── */
.article-share {
    margin-top: 28px; padding: 22px 24px;
    background: linear-gradient(135deg, #F6FBF7, #EDF7F1);
    border-radius: 16px;
    border: 1px solid #D4EDDA;
    display: flex; align-items: center; gap: 16px; flex-wrap: wrap;
}
.share-label {
    font-size: 14px; font-weight: 700; color: var(--chu-chinh);
    flex-shrink: 0;
}
.share-btns { display: flex; gap: 8px; flex-wrap: wrap; }
.share-btn {
    height: 38px; padding: 0 16px;
    border-radius: 10px; border: none; cursor: pointer;
    font-size: 13px; font-weight: 600; font-family: var(--font);
    display: inline-flex; align-items: center; gap: 6px;
    transition: all .18s; text-decoration: none;
}
.share-fb   { background: #1877F2; color: #fff; }
.share-fb:hover   { background: #166FE5; color: #fff; transform: translateY(-1px); }
.share-zalo { background: #0068FF; color: #fff; }
.share-zalo:hover { background: #0058E0; color: #fff; transform: translateY(-1px); }
.share-copy { background: #fff; color: var(--chu-than); border: 1.5px solid var(--vien); }
.share-copy:hover { border-color: var(--mau-chinh); color: var(--mau-chinh); transform: translateY(-1px); }
.share-copy.copied { background: var(--mau-chinh); color: #fff; border-color: var(--mau-chinh); }

/* ── Author Box ─────────────────────────────────────────────── */
.author-box {
    margin-top: 36px; padding: 24px;
    background: #fff;
    border-radius: 16px;
    border: 1px solid #EBF4EE;
    box-shadow: 0 2px 12px rgba(45,122,79,.06);
    display: flex; align-items: flex-start; gap: 18px;
}
.author-avatar-lg {
    width: 62px; height: 62px; border-radius: 50%;
    background: linear-gradient(135deg, #2D7A4F, #3D9962);
    display: flex; align-items: center; justify-content: center;
    font-size: 24px; color: #fff; font-weight: 800;
    flex-shrink: 0;
    border: 3px solid #EAF5EE;
}
.author-info h4 {
    font-size: 16px; font-weight: 700; color: var(--chu-chinh);
    margin-bottom: 3px;
}
.author-role {
    font-size: 12px; color: var(--mau-chinh); font-weight: 600;
    margin-bottom: 8px;
}
.author-bio { font-size: 13px; color: var(--chu-phu); line-height: 1.65; }

/* ── Sidebar ────────────────────────────────────────────────── */
.article-sidebar {}

/* Sticky position */
.sidebar-sticky {
    position: sticky; top: 88px;
    display: flex; flex-direction: column; gap: 24px;
}

/* Progress reading */
.reading-progress-bar {
    position: fixed; top: 0; left: 0; right: 0;
    height: 3px; background: var(--mau-chinh);
    transform-origin: left; transform: scaleX(0);
    z-index: 9999; transition: transform .1s linear;
    border-radius: 0 2px 2px 0;
}

/* Stats widget */
.sidebar-stats {
    background: linear-gradient(135deg, #1A3D28, #2D7A4F);
    border-radius: 16px; padding: 22px;
    color: #fff;
}
.sidebar-stats h4 {
    font-size: 12px; font-weight: 700;
    text-transform: uppercase; letter-spacing: .1em;
    color: rgba(255,255,255,.55); margin-bottom: 16px;
    color: #fff;
}
.stat-row {
    display: flex; justify-content: space-between; align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid rgba(255,255,255,.1);
}
.stat-row:last-child { border-bottom: none; padding-bottom: 0; }
.stat-label { font-size: 13px; color: rgba(255,255,255,.7); display: flex; align-items: center; gap: 6px; }
.stat-value { font-size: 15px; font-weight: 700; color: #fff; }

/* Related campaign widget */
.sidebar-campaign {
    background: #fff; border-radius: 16px;
    border: 1px solid #EBF4EE;
    overflow: hidden;
    box-shadow: 0 2px 12px rgba(45,122,79,.06);
}
.sidebar-campaign-thumb {
    height: 130px; background: linear-gradient(135deg, #EAF5EE, #B7DEC6);
    display: flex; align-items: center; justify-content: center;
    font-size: 44px; position: relative; overflow: hidden;
}
.sidebar-campaign-body { padding: 16px; }
.sidebar-campaign-cat {
    font-size: 10px; font-weight: 700;
    color: var(--mau-chinh); text-transform: uppercase;
    letter-spacing: .06em; margin-bottom: 6px;
}
.sidebar-campaign-name {
    font-family: 'Playfair Display', serif;
    font-size: 15px; font-weight: 700; color: #1A3D28;
    line-height: 1.35; margin-bottom: 12px;
}
.sidebar-progress { height: 10px; background: #fff; border-radius: 6px; overflow: hidden; margin-bottom: 8px; border: 1px solid #000; }
.sidebar-progress-fill { height: 100%; background: #2D7A4F; border-radius: 5px; }
.sidebar-money-row {
    display: flex; justify-content: space-between;
    font-size: 12px; color: var(--chu-phu); margin-bottom: 14px;
}
.sidebar-money-row strong { color: var(--mau-chinh); }
.btn-sidebar-donate {
    width: 100%; height: 38px;
    background: linear-gradient(135deg, #C0651A, #D97B2A);
    color: #fff; border: none; border-radius: 9px;
    font-size: 13px; font-weight: 700; font-family: var(--font);
    cursor: pointer; text-decoration: none;
    display: flex; align-items: center; justify-content: center; gap: 5px;
    transition: all .2s; box-shadow: 0 2px 8px rgba(192,101,26,.25);
}
.btn-sidebar-donate:hover {
    transform: translateY(-1px);
    box-shadow: 0 5px 14px rgba(192,101,26,.4);
    color: #fff;
}

/* TOC (Table of Contents) */
.sidebar-toc {
    background: #fff; border-radius: 16px;
    border: 1px solid #EBF4EE; padding: 20px;
}
.sidebar-toc h4 {
    font-size: 12px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .1em; color: var(--chu-phu); margin-bottom: 14px;
}
.toc-list { list-style: none; padding: 0; margin: 0; }
.toc-list li {
    padding: 7px 0;
    border-bottom: 1px solid #F0F7F2;
}
.toc-list li:last-child { border-bottom: none; padding-bottom: 0; }
.toc-list a {
    font-size: 13px; color: var(--chu-than); text-decoration: none;
    display: flex; align-items: flex-start; gap: 8px;
    line-height: 1.4; transition: color .15s;
}
.toc-list a:hover { color: var(--mau-chinh); }
.toc-num {
    width: 20px; height: 20px; border-radius: 50%;
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 11px; font-weight: 700;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0; margin-top: 1px;
}

/* ── Related Articles ───────────────────────────────────────── */
.related-section {
    max-width: 1200px; margin: 0 auto; padding: 0 24px 80px;
}
.related-header {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 28px;
}
.related-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: 24px; font-weight: 800; color: #1A3D28;
}
.related-grid {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px;
}
.related-card {
    background: #fff; border-radius: 14px;
    overflow: hidden; border: 1px solid #E8F0EB;
    transition: all .3s; display: flex; flex-direction: column;
    text-decoration: none; color: inherit;
}
.related-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 14px 36px rgba(45,122,79,.13);
    border-color: var(--mau-chinh-nhat);
}
.related-thumb {
    height: 160px; overflow: hidden;
    background: linear-gradient(135deg, #EAF5EE, #B7DEC6);
    display: flex; align-items: center; justify-content: center;
    font-size: 48px; position: relative;
}
.related-thumb img { width: 100%; height: 100%; object-fit: cover; transition: transform .5s; }
.related-card:hover .related-thumb img { transform: scale(1.06); }
.related-cat {
    position: absolute; bottom: 10px; left: 10px;
    font-size: 9px; font-weight: 700; padding: 3px 9px; border-radius: 99px;
    text-transform: uppercase; letter-spacing: .05em;
    backdrop-filter: blur(8px);
}
.related-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
.related-date { font-size: 11px; color: var(--chu-phu); margin-bottom: 7px; }
.related-title {
    font-family: 'Playfair Display', serif;
    font-size: 15px; font-weight: 700; color: #1A3D28;
    line-height: 1.4; flex: 1;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.related-link {
    font-size: 12px; font-weight: 600; color: var(--mau-chinh);
    margin-top: 12px; display: flex; align-items: center; gap: 4px;
    transition: gap .15s;
}
.related-card:hover .related-link { gap: 7px; }

/* ── Back button ────────────────────────────────────────────── */
.back-btn {
    display: inline-flex; align-items: center; gap: 7px;
    height: 38px; padding: 0 18px;
    background: #fff; border: 1.5px solid var(--vien);
    border-radius: 9px; font-size: 13px; font-weight: 600;
    color: var(--chu-than); text-decoration: none;
    transition: all .18s; margin-bottom: 28px;
    cursor: pointer;
}
.back-btn:hover { border-color: var(--mau-chinh); color: var(--mau-chinh); background: var(--mau-chinh-nen); }

/* Divider */
.section-divider {
    max-width: 1200px; margin: 0 auto 48px; padding: 0 24px;
    border: none; border-top: 1px solid #EBF4EE;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Reading progress bar -->
<div class="reading-progress-bar" id="readingProgress"></div>

<!-- ═══════════════════════════════════════════════════════════
     ARTICLE COVER / HERO IMAGE
═══════════════════════════════════════════════════════════════ -->
<div class="article-cover">
    <asp:Image ID="imgAnhBia" runat="server" CssClass="cover-img" />

    <div class="article-cover-overlay"></div>

    <div class="article-cover-content">
        <div class="article-cover-inner">

            <div class="article-cover-cat">
                <asp:Label ID="lblDanhMuc" runat="server" />
            </div>

            <h1 class="article-cover-title">
                <asp:Label ID="lblTieuDe" runat="server" />
            </h1>

        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     BREADCRUMB
═══════════════════════════════════════════════════════════════ -->
<nav class="breadcrumb-bar" aria-label="breadcrumb">
    <div class="breadcrumb-inner">
        <a href="/TrangChu.aspx">🏠 Trang chủ</a>
        <span class="breadcrumb-sep">›</span>
        <a href="/DanhSachTinTuc.aspx">Tin tức</a>
        <span class="breadcrumb-sep">›</span>
        <a href="/DanhSachTinTuc.aspx?cat=hoatdong">Hoạt động</a><a href="#">
    <asp:Label ID="lblDanhMuc2" runat="server" />
</a>
        <span class="breadcrumb-sep">›</span>
        <span><asp:Label ID="lblTieuDe2" runat="server" /></span>
    </div>
</nav>

<!-- ═══════════════════════════════════════════════════════════
     ARTICLE LAYOUT (2 COLS)
═══════════════════════════════════════════════════════════════ -->
<div class="article-page">

    <!-- ─── ARTICLE MAIN COLUMN ────────────────────────────── -->
    <article class="article-main">

        <!-- Back button -->
        <a href="/DanhSachTinTuc.aspx" class="back-btn">← Quay lại danh sách tin</a>

        <!-- Meta row -->
        <div class="article-meta">
    <div class="article-meta-item">
        Đăng bởi <strong><asp:Label ID="lblNguoiDang" runat="server" /></strong>
    </div>

    <div class="meta-dot"></div>

    <div class="article-meta-item">
        <strong><asp:Label ID="lblNgayDang" runat="server" /></strong>
    </div>

    <div class="meta-dot"></div>

    <div class="article-meta-item">
        <strong><asp:Label ID="lblLuotXem" runat="server" /></strong> lượt xem
    </div>
</div>
           

        <!-- ─── RICH TEXT BODY ─────────────────────────────── -->
<div class="article-content">

    <h3 style="margin-bottom:15px;">NỘI DUNG BÀI VIẾT</h3>

    <div class="article-body" id="articleBody">
        <asp:Literal ID="litNoiDung" runat="server" />
    </div>

</div>

        <!-- Tags -->
        <div class="article-tags">
            <span class="tags-label">🏷️ Tags:</span>
            <div class="tags-list">
                <a href="#" class="tag-item">thiện nguyện</a>
                <a href="#" class="tag-item">miền Trung</a>
                <a href="#" class="tag-item">quảng bình</a>
                <a href="#" class="tag-item">lũ lụt 2026</a>
                <a href="#" class="tag-item">trao quà</a>
                <a href="#" class="tag-item">tình nguyện viên</a>
            </div>
        </div>

        <!-- Share -->
        <div class="article-share">
            <span class="share-label">📤 Chia sẻ bài viết:</span>
            <div class="share-btns">
                <a href="#" class="share-btn share-fb" onclick="return false;">🔵 Facebook</a>
                <a href="#" class="share-btn share-zalo" onclick="return false;">🟢 Zalo</a>
                <button class="share-btn share-copy" id="copyLinkBtn" onclick="copyLink()">🔗 Sao chép link</button>
            </div>
        </div>

        <!-- Author -->
        <div class="author-box">

    <!-- Avatar -->
    <div class="author-avatar-lg">
        <asp:Label ID="lblAvatar" runat="server" />
    </div>

    <!-- Thông tin -->
    <div class="author-info">

        <!-- Tên -->
        <h4>
            <asp:Label ID="lblNguoiDang2" runat="server" />
        </h4>

        <!-- Vai trò -->
        <div class="author-role">
            Biên tập viên nội dung
        </div>

        <!-- Mô tả -->
        <p class="author-bio">
            Thành viên của Thiện Nguyện Việt.
        </p>

    </div>

</div>

    <!-- ─── SIDEBAR ─────────────────────────────────────────── -->
    <aside class="article-sidebar">
        <div class="sidebar-sticky">

            <!-- Article Stats -->
            <div class="sidebar-stats">
                <h4>📊 Thống kê bài viết</h4>
                <div class="stat-row">
                    <span class="stat-label">👁️ Lượt xem</span>
                    <span class="stat-value">
                    <asp:Label ID="lblLuotXem2" runat="server" />
                </span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">💬 Bình luận</span>
                    <span class="stat-value">
                    <asp:Label ID="lblBinhLuan" runat="server" />
                </span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">📤 Chia sẻ</span>
                    <span class="stat-value">
    <asp:Label ID="lblShare" runat="server" />
</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">📅 Ngày đăng</span>
                    <span class="stat-value">
                    <asp:Label ID="lblNgayDang2" runat="server" /></span>
                </div>
            </div>

            <!-- Table of Contents -->
            <div class="sidebar-toc">
    <h4>Nội dung bài viết</h4>
    <ul class="toc-list" id="tocList"></ul>
</div>

<!-- ═══════════════════════════════════════════════════════════
     RELATED ARTICLES
═══════════════════════════════════════════════════════════════ -->
<hr class="section-divider"/>
<section class="related-section">
    <div class="related-header">
        <h2>📰 Bài viết liên quan</h2>
        <a href="/DanhSachTinTuc.aspx" class="view-all-link">Xem tất cả →</a>
    </div>

    <div class="related-grid">

        <!-- Related 1 -->
        <asp:Repeater ID="rptRelated" runat="server">
<ItemTemplate>

<a href='/ChiTietTinTuc.aspx?id=<%# Eval("MaTinTuc") %>' 
   class="related-card reveal">

    <div class="related-thumb">
        <img src='<%# Eval("AnhBia") %>' alt="" />

        <span class="related-cat">
            <%# Eval("TenDanhMuc") %>
        </span>
    </div>

    <div class="related-body">

        <div class="related-date">
            <%# Eval("NgayDang","{0:dd/MM/yyyy}") %>
            &nbsp;·&nbsp;
            <%# Eval("LuotXem") %> lượt xem
        </div>

        <h3 class="related-title">
            <%# Eval("TieuDe") %>
        </h3>

        <span class="related-link">
            Đọc tiếp →
        </span>

    </div>

</a>

</ItemTemplate>
</asp:Repeater>

        <!-- Related 2 -->
        

<!-- ─────────────────────────────────────────────────────────── -->
<script>
(function () {

    /* ── Reading Progress Bar ────────────────────────────── */
    var progressBar = document.getElementById('readingProgress');
    var body        = document.getElementById('articleBody');

    window.addEventListener('scroll', function () {
        var bodyTop    = body.getBoundingClientRect().top + window.scrollY;
        var bodyBottom = bodyTop + body.offsetHeight;
        var scrolled   = window.scrollY + window.innerHeight;
        var progress   = Math.min(1, Math.max(0, (scrolled - bodyTop) / (bodyBottom - bodyTop)));
        progressBar.style.transform = 'scaleX(' + progress + ')';
    });

    /* ── Smooth scroll for TOC ───────────────────────────── */
    document.querySelectorAll('.toc-list a').forEach(function (a) {
        a.addEventListener('click', function (e) {
            e.preventDefault();
            var target = document.querySelector(this.getAttribute('href'));
            if (target) {
                var offset = 90;
                window.scrollTo({
                    top: target.getBoundingClientRect().top + window.scrollY - offset,
                    behavior: 'smooth'
                });
            }
        });
    });

    /* ── Intersection reveals ────────────────────────────── */
    var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (e) {
            if (e.isIntersecting) e.target.classList.add('visible');
        });
    }, { threshold: 0.1 });
    document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });

})();

/* ── Copy link ───────────────────────────────────────────── */
function copyLink() {
    var btn = document.getElementById('copyLinkBtn');
    navigator.clipboard.writeText(window.location.href).then(function () {
        btn.textContent = '✅ Đã sao chép!';
        btn.classList.add('copied');
        setTimeout(function () {
            btn.textContent = '🔗 Sao chép link';
            btn.classList.remove('copied');
        }, 2000);
    }).catch(function () {
        btn.textContent = '✅ Đã sao chép!';
        setTimeout(function () { btn.textContent = '🔗 Sao chép link'; }, 2000);
    });
}
</script>
</asp:Content>
