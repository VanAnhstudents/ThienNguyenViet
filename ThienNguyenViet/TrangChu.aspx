<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="ThienNguyenViet.TrangChu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* ── Shared Layout ──────────────────────────────────────────── */
.container {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
}
.section-badge {
    display: inline-flex; align-items: center; gap: 6px;
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 11px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .1em; padding: 5px 14px; border-radius: 99px;
    margin-bottom: 12px;
}
.section-title {
    font-family: 'Playfair Display', serif;
    font-size: 36px; font-weight: 700; color: #1A3D28;
    line-height: 1.2; margin-bottom: 14px;
}
.section-sub {
    font-size: 16px; color: var(--chu-phu);
    max-width: 560px; line-height: 1.75;
}

/* Hero content */
.hero {
    position: relative;
    overflow: hidden;
    min-height: 640px;
    display: flex;
    align-items: center;
    background: url('https://res.cloudinary.com/dwzzfzxjh/image/upload/v1776450516/z7736959856691_2c1a304cf33c172680a2e2c5b8336111_nanuhg.jpg') center/cover no-repeat;
}

    .hero::after {
        content: '';
        position: absolute;
        inset: 0;
        background: rgba(0,0,0,0.4);
    }
.hero-content {
    position: relative; z-index: 1;
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
    width: 100%;
}
.hero-label {
    display: inline-flex; align-items: center; gap: 8px;
    background: rgba(255,255,255,.12); backdrop-filter: blur(8px);
    color: rgba(255,255,255,.9); font-size: 12px; font-weight: 600;
    text-transform: uppercase; letter-spacing: .1em;
    padding: 6px 16px; border-radius: 99px;
    border: 1px solid rgba(255,255,255,.2);
    margin-bottom: 20px;
    animation: heroFadeUp .8s ease both;
}
.hero-label::before { content: '●'; color: #4CAF50 }
@keyframes pulse { 0%,100% { opacity:1; } 50% { opacity:.4; } }

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(38px, 5vw, 62px);
    font-weight: 800; color: #fff;
    line-height: 1.1; max-width: 680px;
    margin-bottom: 22px;
    animation: heroFadeUp .8s .15s ease both;
}
.hero h1 em {
    font-style: italic; color: #7EE090;
    text-shadow: 0 0 40px rgba(126,224,144,.4);
}
.hero-sub {
    font-size: 17px; color: rgba(255,255,255,.78);
    max-width: 500px; line-height: 1.75;
    margin-bottom: 32px;
    animation: heroFadeUp .8s .3s ease both;
}
.hero-banner-img {
    margin-top: 24px;
    animation: heroFadeUp .8s .45s ease both;
}
.hero-banner-img img {
    max-width: 100%; height: auto; border-radius: 12px;
    max-height: 320px; object-fit: cover; width: 100%;
}

/* Slide dots */
.hero-dots {
    position: absolute; bottom: 28px; left: 50%; transform: translateX(-50%);
    display: flex; gap: 8px; z-index: 2;
}
.hero-dot {
    width: 8px; height: 8px; border-radius: 99px;
    background: rgba(255,255,255,.4); border: none; cursor: pointer;
    transition: all .3s; padding: 0;
}
.hero-dot.active { width: 24px; background: #fff; }

/* Scroll indicator */
.hero-scroll {
    position: absolute; bottom: 32px; right: 40px; z-index: 2;
    display: flex; align-items: center; gap: 8px;
    color: rgba(255,255,255,.5); font-size: 11px; font-weight: 600;
    text-transform: uppercase; letter-spacing: .08em;
    animation: heroFadeUp .8s .6s ease both;
}
.hero-scroll-line {
    width: 1px; height: 40px;
    background: linear-gradient(to bottom, rgba(255,255,255,.0), rgba(255,255,255,.5));
    animation: scrollPulse 1.8s infinite;
}
@keyframes scrollPulse { 0%,100%{transform:scaleY(1)} 50%{transform:scaleY(1.3)} }
@keyframes heroFadeUp {
    from { opacity:0; transform:translateY(24px); }
    to   { opacity:1; transform:translateY(0); }
}

.counter-section {
    padding: 56px 0;
    background: transparent;
}
.counter-grid {
    display: grid; grid-template-columns: repeat(3, 1fr);
    gap: 24px; max-width: 900px; margin: 0 auto;
}
.counter-card {
    text-align: center; padding: 32px 20px;
    background: #fff; border-radius: 16px;
    border: 1px solid #E2F0E8;
}
.counter-icon {
    font-size: 28px; margin-bottom: 12px; display: block;
}
.counter-number {
    font-family: 'Playfair Display', serif;
    font-size: 44px; font-weight: 800; color: #1A3D28;
    line-height: 1; margin-bottom: 8px;
    letter-spacing: -.02em;
}
.counter-suffix { font-size: 22px; }
.counter-label {
    font-size: 13px; color: var(--chu-phu);
    font-weight: 500; line-height: 1.4;
}

.campaigns-section { padding: 80px 0; }

.campaigns-header {
    display: flex; align-items: flex-end; justify-content: space-between;
    margin-bottom: 40px; flex-wrap: wrap; gap: 16px;
}
.view-all-link {
    display: inline-flex; align-items: center; gap: 6px;
    color: var(--mau-chinh); font-size: 14px; font-weight: 600;
    text-decoration: none;
    border-bottom: 1.5px solid var(--mau-chinh-nhat);
    padding-bottom: 2px; transition: border-color .15s;
}
.view-all-link:hover { border-color: var(--mau-chinh); }

.campaigns-grid {
    display: grid; grid-template-columns: repeat(3, 1fr);
    gap: 24px;
}

.campaign-card {
    background: #fff; border-radius: 16px;
    overflow: hidden;
    border: 1px solid #EBF4EE;
    display: flex; flex-direction: column;
}

.campaign-thumb {
    position: relative; height: 200px; overflow: hidden;
    background: linear-gradient(135deg, #EAF5EE, #B7DEC6);
    display: flex; align-items: center; justify-content: center;
    font-size: 60px;
}
.campaign-thumb img {
    width: 100%; height: 100%; object-fit: cover;
}

.campaign-cat-badge {
    position: absolute; top: 12px; left: 12px;
    font-size: 10px; font-weight: 700; padding: 4px 10px;
    border-radius: 99px; text-transform: uppercase; letter-spacing: .05em;
    backdrop-filter: blur(8px);
}

.campaign-urgent-badge {
    position: absolute; top: 12px; right: 12px;
    background: rgba(192,101,26,.9); color: #fff;
    font-size: 10px; font-weight: 700; padding: 4px 10px;
    border-radius: 99px; animation: blink 2s infinite;
}
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.7} }

.campaign-body { padding: 20px; flex: 1; display: flex; flex-direction: column; }
.campaign-name {
    font-family: 'Playfair Display', serif;
    font-size: 17px; font-weight: 700; color: #1A3D28;
    line-height: 1.35; margin-bottom: 8px;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.campaign-desc {
    font-size: 13px; color: var(--chu-phu); line-height: 1.65;
    margin-bottom: 18px; flex: 1;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}

/* Progress */
.campaign-money-row {
    display: flex; justify-content: space-between; align-items: center;
    margin-bottom: 16px;
}
.campaign-raised { font-size: 14px; font-weight: 700; color: var(--mau-chinh); }
.campaign-goal   { font-size: 12px; color: var(--chu-phu); }
.campaign-pct    { font-size: 12px; font-weight: 700; color: var(--mau-chinh); }

.btn-donate-card {
    width: 100%; height: 42px; border-radius: 10px;
    background: linear-gradient(135deg, #C0651A, #D97B2A);
    color: #fff; font-size: 14px; font-weight: 700;
    border: none; cursor: pointer; font-family: var(--font);
    display: flex; align-items: center; justify-content: center; gap: 6px;
    transition: all .2s; text-decoration: none;
    box-shadow: 0 3px 10px rgba(192,101,26,.25);
}
.btn-donate-card:hover {
    transform: translateY(-1px);
    box-shadow: 0 6px 18px rgba(192,101,26,.4);
    color: #fff;
}

.categories-section {
    padding: 72px 0;
    background: #F6FBF7;
}
.categories-grid {
    display: grid; grid-template-columns: repeat(4, 1fr);
    gap: 20px; margin-top: 48px;
}
.category-card {
    background: #fff; border-radius: 20px;
    padding: 36px 24px; text-align: center;
    border: 1px solid #E2F0E8;
    cursor: pointer; text-decoration: none; display: block;
}

.category-icon-wrap {
    width: 72px; height: 72px; border-radius: 22px;
    margin: 0 auto 18px;
    display: flex; align-items: center; justify-content: center;
    font-size: 32px;
}

.cat-red    .category-icon-wrap { background: #FFF5F5; }
.cat-blue   .category-icon-wrap { background: #EBF8FF; }
.cat-yellow .category-icon-wrap { background: #FEFCBF; }
.cat-green  .category-icon-wrap { background: #F0FFF4; }

.category-name {
    font-family: 'Playfair Display', serif;
    font-size: 17px; font-weight: 700; color: #1A3D28;
    margin-bottom: 6px;
}
.category-desc {
    font-size: 13px; color: var(--chu-phu); line-height: 1.55;
    margin-bottom: 14px;
}
.category-count {
    font-size: 12px; font-weight: 600; padding: 3px 12px;
    border-radius: 99px; display: inline-block;
}
.cat-red    .category-count { background: #FFF5F5; color: #C53030; }
.cat-blue   .category-count { background: #EBF8FF; color: #2B6CB0; }
.cat-yellow .category-count { background: #FEFCBF; color: #7B6914; }
.cat-green  .category-count { background: #F0FFF4; color: #276749; }

.news-section { padding: 80px 0; }
.news-grid {
    display: grid; grid-template-columns: repeat(3, 1fr);
    gap: 28px; margin-top: 48px;
}
.news-card {
    background: #fff; border-radius: 16px;
    overflow: hidden;
    border: 1px solid #E8F0EB;
    transition: all .3s;
}
.news-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 32px rgba(45,122,79,.12);
    border-color: var(--mau-chinh-nhat);
}
.news-thumb {
    height: 200px; overflow: hidden;
    background: linear-gradient(135deg, #EAF5EE, #D4EDDA);
    display: flex; align-items: center; justify-content: center;
    font-size: 56px; position: relative;
}
.news-thumb img { width: 100%; height: 100%; object-fit: cover; transition: transform .5s; }
.news-card:hover .news-thumb img { transform: scale(1.05); }

.news-cat {
    position: absolute; bottom: 12px; left: 12px;
    font-size: 10px; font-weight: 700; padding: 3px 10px;
    border-radius: 99px; text-transform: uppercase; letter-spacing: .05em;
}
.news-body { padding: 20px; }
.news-meta {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 10px; font-size: 12px; color: var(--chu-phu);
}
.news-meta span { display: flex; align-items: center; gap: 4px; }
.news-title {
    font-family: 'Playfair Display', serif;
    font-size: 16px; font-weight: 700; color: #1A3D28;
    line-height: 1.4; margin-bottom: 8px;
    display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.news-summary {
    font-size: 13px; color: var(--chu-phu); line-height: 1.65;
    display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
}
.news-link {
    display: inline-flex; align-items: center; gap: 5px;
    margin-top: 14px; color: var(--mau-chinh); font-size: 13px; font-weight: 600;
    text-decoration: none;
}
.news-link:hover { text-decoration: underline; }

.news-footer { text-align: center; margin-top: 40px; }
.btn-view-all {
    height: 48px; padding: 0 32px; border-radius: 12px;
    border: 2px solid var(--mau-chinh); color: var(--mau-chinh);
    background: transparent; font-size: 14px; font-weight: 700;
    cursor: pointer; font-family: var(--font); text-decoration: none;
    display: inline-flex; align-items: center; gap: 8px;
    transition: all .2s;
}
.btn-view-all:hover {
    background: var(--mau-chinh); color: #fff;
    box-shadow: 0 6px 20px rgba(45,122,79,.3);
}

/* ═══════════════════════════════════════════════════════════════
   6. PARTNERS
═══════════════════════════════════════════════════════════════ */
.partners-section {
    padding: 64px 0;
    background: #F6FBF7;
}
.partners-title {
    text-align: center; font-size: 13px; font-weight: 600;
    color: var(--chu-phu); text-transform: uppercase; letter-spacing: .1em;
    margin-bottom: 36px;
}
.partners-track {
    display: flex; gap: 20px; overflow: hidden;
    mask-image: linear-gradient(to right, transparent, black 10%, black 90%, transparent);
}
.partners-strip {
    display: flex; gap: 20px; flex-shrink: 0;
    animation: partnersScroll 30s linear infinite;
}
@keyframes partnersScroll {
    from { transform: translateX(0); }
    to   { transform: translateX(-100%); }
}
.partner-logo {
    width: 160px; height: 60px; border-radius: 12px;
    background: #fff; border: 1px solid #E2F0E8;
    display: flex; align-items: center; justify-content: center;
    font-size: 12px; font-weight: 700; color: #aaa;
    flex-shrink: 0; transition: all .3s; letter-spacing: .04em;
    padding: 0 16px; text-align: center; line-height: 1.3;
    filter: grayscale(1); opacity: .6;
}
.partner-logo:hover { filter: grayscale(0); opacity: 1; border-color: var(--mau-chinh-nhat); }

/* ═══════════════════════════════════════════════════════════════
   CTA BANNER
═══════════════════════════════════════════════════════════════ */
.cta-banner {
    margin: 0 0 80px;
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 50%, #3D9962 100%);
    padding: 72px 0; text-align: center; position: relative; overflow: hidden;
}
.cta-banner::before {
    content: ''; position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='80' height='80'%3E%3Ccircle cx='40' cy='40' r='1' fill='rgba(255,255,255,.06)'/%3E%3C/svg%3E");
}
.cta-banner-content { position: relative; z-index: 1; }
.cta-banner h2 {
    font-family: 'Playfair Display', serif;
    font-size: 38px; font-weight: 800; color: #fff;
    margin-bottom: 14px;
}
.cta-banner p { font-size: 16px; color: rgba(255,255,255,.75); margin-bottom: 32px; }
.cta-banner-btns { display: flex; align-items: center; justify-content: center; gap: 14px; flex-wrap: wrap; }
.btn-cta-white {
    height: 50px; padding: 0 28px; border-radius: 12px;
    background: #fff; color: var(--mau-chinh);
    font-size: 15px; font-weight: 700; font-family: var(--font);
    border: none; cursor: pointer; text-decoration: none;
    display: inline-flex; align-items: center; gap: 8px;
    box-shadow: 0 4px 20px rgba(0,0,0,.15); transition: all .2s;
}
.btn-cta-white:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(0,0,0,.2); color: var(--mau-chinh); }
.btn-cta-outline {
    height: 50px; padding: 0 28px; border-radius: 12px;
    background: transparent; color: #fff;
    font-size: 15px; font-weight: 600; font-family: var(--font);
    border: 2px solid rgba(255,255,255,.5); cursor: pointer; text-decoration: none;
    display: inline-flex; align-items: center; gap: 8px;
    transition: all .2s;
}
.btn-cta-outline:hover { background: rgba(255,255,255,.1); border-color: #fff; color: #fff; }

/* ── Intersection Observer Reveals ─────────────────────────── */
.reveal {
    opacity: 0; transform: translateY(32px);
    transition: opacity .65s ease, transform .65s ease;
}
.reveal.visible { opacity: 1; transform: translateY(0); }
.reveal-delay-1 { transition-delay: .1s; }
.reveal-delay-2 { transition-delay: .2s; }
.reveal-delay-3 { transition-delay: .3s; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- ═══════════════════════════════════════════════════════════
     1. HERO BANNER
═══════════════════════════════════════════════════════════════ -->
<section class="hero">

    <div class="hero-content">
        <h1>
            Chung tay vì<br/>
            <em>cộng đồng Việt</em>
        </h1>

        <p class="hero-sub">
            Mỗi đóng góp của bạn — dù nhỏ bé — đều có thể thay đổi cuộc đời của một người.
        </p>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     2. COUNTER SECTION
═══════════════════════════════════════════════════════════════ -->
<section class="counter-section">
    <div class="container">
        <div class="counter-grid">
            <!-- Tổng tiền -->
            <div class="counter-card">
                <span class="counter-icon"></span>
                <div class="counter-number">
                    <span class="js-count" 
                          data-target="<%= TongTienRaw %>" 
                          data-suffix="đ" 
                          data-format="billion">0</span>
                </div>
                <div class="counter-label">Tổng tiền quyên góp</div>
            </div>

            <!-- Chiến dịch -->
            <div class="counter-card">
                <span class="counter-icon"></span>
                <div class="counter-number">
                    <span class="js-count" 
                          data-target="<%= TongChienDich %>" 
                          data-suffix="" >0</span>
                </div>
                <div class="counter-label">Chiến dịch thành công</div>
            </div>

            <!-- Người tham gia -->
            <div class="counter-card">
                <span class="counter-icon"></span>
                <div class="counter-number">
                    <span class="js-count" 
                          data-target="<%= TongNguoiThamGia %>">0</span>
                </div>
                <div class="counter-label">Người tham gia</div>
        </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     3. CHIẾN DỊCH NỔI BẬT
═══════════════════════════════════════════════════════════════ -->
<section class="campaigns-section">
    <div class="container">

        <div class="campaigns-header">
            <div class="reveal">
                <div class="section-badge">Chiến dịch tiêu biểu</div>
                <h2 class="section-title">Những chiến dịch đang cần bạn
            </div>
            <a href="/DanhSachChienDich.aspx" class="view-all-link reveal">
                Xem tất cả chiến dịch →
            </a>
        </div>

        <div class="campaigns-grid">

            <asp:Repeater ID="rptChienDich" runat="server">
            <ItemTemplate>

            <div class="campaign-card">

                <div class="campaign-thumb">
                    <img src='<%# GetImage(Eval("AnhBia")) %>' />
                </div>

                <div class="campaign-body">

                    <div class="campaign-name">
                        <%# Eval("TenChienDich") %>
                    </div>

                    <div class="campaign-desc">
                        Chiến dịch đang được cập nhật...
                    </div>

                    <div class="progress-nen">
                        <div class="progress-thanh"
                             style='width:<%# GetPhanTramCss(Eval("PhanTram")) %>%'>
                        </div>
                    </div>

                    <div class="campaign-money-row">
                        <span class="campaign-raised">
                            <%# String.Format("{0:N0}", Eval("SoTienDaQuyen")) %>đ
                        </span>

                        <span class="campaign-goal">
                            / <%# String.Format("{0:N0}", Eval("MucTieu")) %>
                        </span>

                        <span class="campaign-pct">
                            <%# GetPhanTramHienThi(Eval("PhanTram")) %>%
                        </span>
                    </div>

                    <a href='QuyenGop.aspx?id=<%# Eval("MaChienDich") %>' class="btn-donate-card">
                        Quyên góp ngay
                    </a>

                </div>

            </div>

            </ItemTemplate>
            </asp:Repeater>

        </div>

    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     4. DANH MỤC
═══════════════════════════════════════════════════════════════ -->
<section class="categories-section">
    <div class="container">
        <div style="text-align:center" class="reveal">
            <div class="section-badge">Danh mục</div>
            <h2 class="section-title">Chúng tôi hoạt động trong lĩnh vực nào?</h2>
            <p class="section-sub" style="margin:0 auto">Từ cứu trợ khẩn cấp đến giáo dục dài hạn — mỗi chiến dịch là một bước thay đổi cuộc sống.</p>
        </div>

        <div class="categories-grid">

            <a href="/DanhSachChienDich.aspx?danhmuc=1" class="category-card cat-red reveal reveal-delay-1">
                <div class="category-name">Cứu trợ thiên tai</div>
                <div class="category-desc">Hỗ trợ khẩn cấp đồng bào bị ảnh hưởng bởi bão lũ, hạn hán, dịch bệnh.</div>
                <span class="category-count">12 chiến dịch</span>
            </a>

            <a href="/DanhSachChienDich.aspx?danhmuc=2" class="category-card cat-blue reveal reveal-delay-2">
                <div class="category-desc">Trao học bổng, xây trường, hỗ trợ học sinh khó khăn vươn lên tương lai.</div>
                <span class="category-count">28 chiến dịch</span>
            </a>

            <a href="/DanhSachChienDich.aspx?danhmuc=3" class="category-card cat-yellow reveal reveal-delay-3">
                <div class="category-desc">Khám chữa bệnh miễn phí, phẫu thuật, hỗ trợ thuốc men cho người nghèo.</div>
                <span class="category-count">19 chiến dịch</span>
            </a>

            <a href="/DanhSachChienDich.aspx?danhmuc=4" class="category-card cat-green reveal" style="transition-delay:.4s">
                <div class="category-name">Môi trường & Cây xanh</div>
                <div class="category-desc">Trồng rừng, bảo vệ nguồn nước, xây dựng môi trường sống bền vững.</div>
                <span class="category-count">9 chiến dịch</span>
            </a>

        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     5. TIN TỨC
═══════════════════════════════════════════════════════════════ -->
<section class="news-section">
    <div class="container">

        <div style="text-align:center;margin-bottom:0" class="reveal">
            <div class="section-badge">Tin tức & Câu chuyện</div>
            <h2 class="section-title">
                Những câu chuyện<br/>truyền cảm hứng
            </h2>
        </div>

        <div class="news-grid">

            <asp:Repeater ID="rptTinTuc" runat="server">
            <ItemTemplate>

                <div class="news-card reveal">
                    <div class="news-thumb">
                        <img src='<%# GetImage(Eval("AnhBia")) %>' 
                             onerror="this.src='/Content/images/banner.png'" />

                        <span class="news-cat">Tin tức</span>
                    </div>

                    <div class="news-body">
                        <div class="news-meta">
                            <span>Admin</span>
                            <span><%# Eval("NgayDang","{0:dd/MM/yyyy}") %></span>
                            <span><%# Eval("LuotXem") %></span>
                        </div>

                        <h3 class="news-title">
                            <%# Eval("TieuDe") %>
                        </h3>
                        <p class="news-summary">
                            <%# Eval("TomTat") %>
                        </p>

                        <a href='ChiTietTinTuc.aspx?id=<%# Eval("MaTinTuc") %>' 
                           class="news-link">
                            Đọc tiếp →
                        </a>
                    </div>
                </div>

            </ItemTemplate>
            </asp:Repeater>

        </div>

        <div class="news-footer reveal">
            <a href="/DanhSachTinTuc.aspx" class="btn-view-all">
                Xem tất cả tin tức
            </a>
        </div>

    </div>
</section>
<!-- ═══════════════════════════════════════════════════════════
     CTA BANNER
═══════════════════════════════════════════════════════════════ -->
<div class="cta-banner">
    <div class="container cta-banner-content">
        <h2>Bạn muốn tạo ra sự thay đổi?</h2>
        <p>Hãy cùng hàng nghìn người Việt đang chung tay xây dựng một cộng đồng tốt đẹp hơn.</p>
        <div class="cta-banner-btns">
            <a href="/DanhSachChienDich.aspx" class="btn-cta-white">Xem chiến dịch</a>
            <a href="/DangKy.aspx" class="btn-cta-outline">Đăng ký tình nguyện viên</a>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     SCRIPTS
═══════════════════════════════════════════════════════════════ -->
<script>
    (function () {

        /* ── 1. Hero Slider ──────────────────────────────────────── */
        var slides = document.querySelectorAll('.hero-slide');
        var dots = document.querySelectorAll('.hero-dot');
        var current = 0;
        var slideTimer;

        function goToSlide(n) {
            slides[current].classList.remove('active');
            dots[current].classList.remove('active');
            current = (n + slides.length) % slides.length;
            slides[current].classList.add('active');
            dots[current].classList.add('active');
        }

        function autoSlide() {
            slideTimer = setInterval(function () { goToSlide(current + 1); }, 5000);
        }

        dots.forEach(function (dot, i) {
            dot.addEventListener('click', function () {
                clearInterval(slideTimer);
                goToSlide(i);
                autoSlide();
            });
        });

        autoSlide();

        /* ── 2. Counter Animation ────────────────────────────────── */
        function animateCount(el) {
            var target = parseFloat(el.dataset.target);
            var format = el.dataset.format || 'normal';
            var suffix = el.dataset.suffix || '';
            var duration = 2200;
            var startTime = null;

            function easeOutCubic(t) { return 1 - Math.pow(1 - t, 3); }

            function step(timestamp) {
                if (!startTime) startTime = timestamp;
                var progress = Math.min((timestamp - startTime) / duration, 1);
                var value = Math.floor(easeOutCubic(progress) * target);

                var display;
                if (format === 'billion') {
                    display = (value / 1e9).toFixed(1) + ' tỷ';
                } else if (format === 'k') {
                    display = (value >= 1000) ? (value / 1000).toFixed(0) + 'K' : value;
                } else {
                    display = value.toLocaleString('vi-VN');
                }

                el.textContent = display + (progress < 1 ? '' : suffix);

                if (progress < 1) requestAnimationFrame(step);
                else el.textContent = (format === 'billion' ? (target / 1e9).toFixed(1) + ' tỷ' :
                    format === 'k' ? (target / 1000).toFixed(0) + 'K' :
                        target.toLocaleString('vi-VN')) + suffix;
            }

            requestAnimationFrame(step);
        }

        /* ── 3. Progress Bars ────────────────────────────────────── */
        function animateProgress(el) {
            var pct = el.dataset.pct;
            setTimeout(function () { el.style.width = pct + '%'; }, 300);
        }

        /* ── 4. Intersection Observer ────────────────────────────── */
        var io = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (!entry.isIntersecting) return;

                var el = entry.target;

                // Reveal
                if (el.classList.contains('reveal')) {
                    el.classList.add('visible');
                }

                // Counter
                if (el.classList.contains('js-count')) {
                    animateCount(el);
                    io.unobserve(el);
                }

                // Progress
                if (el.classList.contains('js-progress')) {
                    animateProgress(el);
                    io.unobserve(el);
                }
            });
        }, { threshold: 0.15 });

        document.querySelectorAll('.reveal, .js-count, .js-progress').forEach(function (el) {
            io.observe(el);
        });

    })();
</script>
</asp:Content>
