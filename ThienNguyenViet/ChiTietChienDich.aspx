<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietChienDich.aspx.cs" Inherits="ThienNguyenViet.ChiTietChienDich" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
/* ═══════════════════════════════════════════════════════════════
   CHI TIẾT CHIẾN DỊCH — STYLES
═══════════════════════════════════════════════════════════════ */

/* ── Variables (dự phòng nếu style.css chưa load) ─────────── */
:root {
    --mau-chinh:        #2D7A4F;
    --mau-chinh-hover:  #235f3d;
    --mau-chinh-nen:    #EAF5EE;
    --mau-chinh-nhat:   #B7DEC6;
    --mau-cam:          #C0651A;
    --chu-chinh:        #1A2E1F;
    --chu-than:         #2D3748;
    --chu-phu:          #718096;
    --vien:             #E2EDE6;
    --font:             'Be Vietnam Pro', sans-serif;
}

/* ── Breadcrumb ─────────────────────────────────────────────── */
.breadcrumb-bar {
    background: #F6FBF7;
    border-bottom: 1px solid var(--vien);
    padding: 12px 0;
}
.breadcrumb-inner {
    max-width: 1200px; margin: 0 auto; padding: 0 24px;
    display: flex; align-items: center; gap: 6px;
    font-size: 12.5px; color: var(--chu-phu);
    flex-wrap: wrap;
}
.breadcrumb-inner a {
    color: var(--chu-phu); text-decoration: none;
    transition: color .15s;
}
.breadcrumb-inner a:hover { color: var(--mau-chinh); }
.breadcrumb-sep { color: #CBD5E0; }
.breadcrumb-current {
    color: var(--mau-chinh); font-weight: 600;
    max-width: 300px;
    overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}

/* ── Page Layout ────────────────────────────────────────────── */
.detail-page {
    max-width: 1200px; margin: 0 auto;
    padding: 32px 24px 80px;
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 32px;
    align-items: start;
}

/* ═══════════════════════════════════════════════════════════════
   LEFT COLUMN
═══════════════════════════════════════════════════════════════ */
.detail-left { min-width: 0; }

/* ── Hero Image ─────────────────────────────────────────────── */
.hero-gallery { margin-bottom: 24px; }

.hero-img-main {
    position: relative;
    border-radius: 18px;
    overflow: hidden;
    aspect-ratio: 16/9;
    background: linear-gradient(135deg, #1A3D28, #2D7A4F);
    cursor: zoom-in;
    margin-bottom: 10px;
    box-shadow: 0 4px 24px rgba(0,0,0,.1);
}
.hero-img-main img,
.hero-img-main .hero-img-placeholder {
    width: 100%; height: 100%; object-fit: cover;
    transition: transform .5s ease;
    display: flex; align-items: center; justify-content: center;
    font-size: 96px;
}
.hero-img-main:hover img { transform: scale(1.02); }

.hero-img-badge {
    position: absolute; top: 16px; left: 16px;
    display: flex; gap: 8px; flex-wrap: wrap;
}
.hero-cat-badge {
    font-size: 11px; font-weight: 700; padding: 5px 12px;
    border-radius: 99px; backdrop-filter: blur(8px);
    text-transform: uppercase; letter-spacing: .04em;
}
.hero-status-badge {
    font-size: 11px; font-weight: 700; padding: 5px 12px;
    border-radius: 99px; backdrop-filter: blur(8px);
}
.status-urgent { background: rgba(192,101,26,.9); color: #fff; animation: urgentBlink 2s infinite; }
.status-active { background: rgba(45,122,79,.9); color: #fff; }
.status-ending { background: rgba(214,158,46,.9); color: #fff; }
.status-done   { background: rgba(100,100,100,.85); color: #fff; }
@keyframes urgentBlink { 0%,100%{opacity:1} 50%{opacity:.7} }

/* Gallery thumbnails */
.hero-thumbs {
    display: flex; gap: 8px; overflow-x: auto;
    padding-bottom: 4px; scrollbar-width: thin;
}
.hero-thumb-item {
    width: 88px; height: 62px; border-radius: 10px;
    overflow: hidden; flex-shrink: 0;
    cursor: pointer; border: 2px solid transparent;
    transition: all .2s;
    background: linear-gradient(135deg, #2D7A4F, #3D9962);
    display: flex; align-items: center; justify-content: center;
    font-size: 24px;
}
.hero-thumb-item:hover { border-color: var(--mau-chinh); transform: translateY(-2px); }
.hero-thumb-item.active { border-color: var(--mau-chinh); box-shadow: 0 2px 8px rgba(45,122,79,.3); }

/* ── Campaign Title Block ───────────────────────────────────── */
.campaign-title-block { margin-bottom: 20px; }

.campaign-cat-tag {
    display: inline-flex; align-items: center; gap: 6px;
    font-size: 11.5px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .08em; padding: 4px 12px; border-radius: 99px;
    margin-bottom: 12px;
}

.campaign-h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(24px, 3vw, 32px);
    font-weight: 800; color: var(--chu-chinh);
    line-height: 1.25; margin-bottom: 16px;
}

.campaign-meta-row {
    display: flex; align-items: center; gap: 20px;
    flex-wrap: wrap; font-size: 13px; color: var(--chu-phu);
    padding-bottom: 18px; border-bottom: 1px solid var(--vien);
}
.meta-item {
    display: flex; align-items: center; gap: 5px;
    font-weight: 500;
}
.meta-item strong { color: var(--chu-chinh); }
.meta-item.urgent-text { color: #C53030; font-weight: 700; }

/* ── Tabs ───────────────────────────────────────────────────── */
.tabs-nav {
    display: flex; gap: 0;
    border-bottom: 2px solid var(--vien);
    margin-bottom: 28px;
    overflow-x: auto; scrollbar-width: none;
}
.tabs-nav::-webkit-scrollbar { display: none; }

.tab-btn {
    padding: 12px 22px;
    background: none; border: none; cursor: pointer;
    font-family: var(--font); font-size: 14px; font-weight: 600;
    color: var(--chu-phu); position: relative;
    white-space: nowrap; transition: color .2s;
}
.tab-btn::after {
    content: ''; position: absolute;
    bottom: -2px; left: 0; right: 0; height: 2px;
    background: var(--mau-chinh);
    transform: scaleX(0); transition: transform .25s;
}
.tab-btn:hover { color: var(--mau-chinh); }
.tab-btn.active { color: var(--mau-chinh); }
.tab-btn.active::after { transform: scaleX(1); }

.tab-count {
    display: inline-flex; align-items: center; justify-content: center;
    width: 20px; height: 20px; border-radius: 99px;
    background: var(--mau-chinh-nen); color: var(--mau-chinh);
    font-size: 10px; margin-left: 6px; font-weight: 700;
}

.tab-panel { display: none; }
.tab-panel.active { display: block; animation: tabFadeIn .3s ease; }
@keyframes tabFadeIn { from{opacity:0;transform:translateY(8px)} to{opacity:1;transform:none} }

/* ── Tab: Mô Tả ─────────────────────────────────────────────── */
.mo-ta-content {
    font-size: 15px; color: var(--chu-than); line-height: 1.85;
}
.mo-ta-content h2, .mo-ta-content h3 {
    font-family: 'Playfair Display', serif;
    color: var(--chu-chinh); margin: 28px 0 14px;
}
.mo-ta-content h2 { font-size: 22px; }
.mo-ta-content h3 { font-size: 18px; }
.mo-ta-content p { margin-bottom: 16px; }
.mo-ta-content img {
    width: 100%; border-radius: 12px; margin: 16px 0;
    box-shadow: 0 4px 16px rgba(0,0,0,.08);
}
.mo-ta-content ul, .mo-ta-content ol {
    padding-left: 20px; margin-bottom: 16px;
}
.mo-ta-content li { margin-bottom: 8px; }
.mo-ta-content blockquote {
    margin: 24px 0; padding: 16px 20px;
    border-left: 4px solid var(--mau-chinh);
    background: var(--mau-chinh-nen);
    border-radius: 0 10px 10px 0;
    font-style: italic; color: var(--chu-than);
}
.mo-ta-content .highlight-box {
    background: #FFF9F0; border: 1px solid #FDDCB4;
    border-radius: 12px; padding: 20px;
    margin: 20px 0;
}

/* ── Tab: Cập Nhật Tiến Độ ──────────────────────────────────── */
.timeline { position: relative; padding-left: 40px; }
.timeline::before {
    content: ''; position: absolute; left: 14px; top: 0; bottom: 0;
    width: 2px; background: linear-gradient(to bottom, var(--mau-chinh), var(--mau-chinh-nhat), transparent);
}

.timeline-item {
    position: relative; margin-bottom: 36px;
    animation: timelineFadeIn .5s ease both;
}
@keyframes timelineFadeIn { from{opacity:0;transform:translateX(-8px)} to{opacity:1;transform:none} }

.timeline-dot {
    position: absolute; left: -32px; top: 4px;
    width: 28px; height: 28px; border-radius: 50%;
    background: var(--mau-chinh);
    border: 3px solid #fff;
    box-shadow: 0 0 0 3px var(--mau-chinh-nhat);
    display: flex; align-items: center; justify-content: center;
    font-size: 12px; color: #fff; font-weight: 700;
}
.timeline-dot.dot-first { background: #C0651A; box-shadow: 0 0 0 3px #FDDCB4; }

.timeline-card {
    background: #fff; border: 1px solid var(--vien);
    border-radius: 14px; overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,.04);
    transition: box-shadow .2s;
}
.timeline-card:hover { box-shadow: 0 6px 20px rgba(45,122,79,.1); }

.timeline-card-header {
    padding: 16px 18px 12px;
    border-bottom: 1px solid var(--vien);
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 8px;
}
.timeline-title {
    font-size: 15px; font-weight: 700; color: var(--chu-chinh);
}
.timeline-date {
    font-size: 12px; color: var(--chu-phu);
    display: flex; align-items: center; gap: 4px;
    background: var(--mau-chinh-nen); padding: 3px 10px;
    border-radius: 99px;
}
.timeline-body { padding: 16px 18px; font-size: 14px; color: var(--chu-than); line-height: 1.75; }
.timeline-img {
    width: 100%; max-height: 260px; object-fit: cover;
    margin-top: 12px; border-radius: 10px;
}

/* ── Tab: Người Quyên Góp ───────────────────────────────────── */
.donors-header {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 18px;
}
.donors-header h3 {
    font-size: 16px; font-weight: 700; color: var(--chu-chinh);
}
.btn-view-all-donors {
    font-size: 13px; font-weight: 600; color: var(--mau-chinh);
    background: none; border: 1.5px solid var(--mau-chinh);
    border-radius: 8px; padding: 6px 14px;
    cursor: pointer; font-family: var(--font);
    transition: all .18s;
}
.btn-view-all-donors:hover { background: var(--mau-chinh); color: #fff; }

.donors-table-wrap {
    background: #fff; border: 1px solid var(--vien);
    border-radius: 14px; overflow: hidden;
}
.donors-table {
    width: 100%; border-collapse: collapse;
}
.donors-table thead th {
    background: #F6FBF7; padding: 12px 16px;
    font-size: 11.5px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .07em; color: var(--chu-phu);
    text-align: left; border-bottom: 1px solid var(--vien);
}
.donors-table tbody td {
    padding: 14px 16px; border-bottom: 1px solid #F0F4F1;
    font-size: 13.5px; color: var(--chu-than); vertical-align: middle;
}
.donors-table tbody tr:last-child td { border-bottom: none; }
.donors-table tbody tr {
    transition: background .15s;
}
.donors-table tbody tr:hover { background: #FAFDF8; }

.donor-rank {
    font-size: 14px; font-weight: 700;
    display: flex; align-items: center; justify-content: center;
    width: 28px;
}
.rank-1 { color: #F6AD55; }
.rank-2 { color: #A0AEC0; }
.rank-3 { color: #C05621; }

.donor-avatar-wrap {
    display: flex; align-items: center; gap: 10px;
}
.donor-avatar {
    width: 36px; height: 36px; border-radius: 50%;
    background: linear-gradient(135deg, var(--mau-chinh), #3D9962);
    color: #fff; font-size: 13px; font-weight: 700;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
}
.donor-name { font-weight: 600; color: var(--chu-chinh); }
.donor-anon { color: var(--chu-phu); font-style: italic; }

.donor-amount { font-weight: 700; color: var(--mau-chinh); }
.donor-date { color: var(--chu-phu); font-size: 12.5px; }

.donor-msg {
    font-size: 12.5px; color: var(--chu-phu);
    font-style: italic;
    max-width: 220px;
    overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}

.donors-empty {
    text-align: center; padding: 48px 24px; color: var(--chu-phu);
}
.donors-empty-icon { font-size: 40px; margin-bottom: 12px; }
.donors-footer {
    padding: 14px 18px; border-top: 1px solid var(--vien);
    text-align: center; background: #FAFDF8;
}
.donors-total-text { font-size: 13px; color: var(--chu-phu); }
.donors-total-text strong { color: var(--mau-chinh); }

/* ═══════════════════════════════════════════════════════════════
   RIGHT COLUMN — STICKY SIDEBAR
═══════════════════════════════════════════════════════════════ */
.detail-right {
    position: sticky;
    top: calc(var(--header-h, 68px) + 20px);
    display: flex; flex-direction: column; gap: 16px;
}

/* ── Donation Box ───────────────────────────────────────────── */
.donation-box {
    background: #fff;
    border: 1px solid var(--vien);
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 24px rgba(45,122,79,.1);
}

.donation-box-header {
    background: linear-gradient(135deg, #1A3D28, #2D7A4F);
    padding: 20px 22px 18px;
    position: relative; overflow: hidden;
}
.donation-box-header::before {
    content: '';
    position: absolute; inset: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Ccircle cx='30' cy='30' r='1.5' fill='rgba(255,255,255,.07)'/%3E%3C/svg%3E");
}
.donation-money-label {
    font-size: 11.5px; font-weight: 600; text-transform: uppercase;
    letter-spacing: .09em; color: rgba(255,255,255,.6);
    margin-bottom: 4px; position: relative;
}
.donation-raised {
    font-family: 'Playfair Display', serif;
    font-size: 30px; font-weight: 800; color: #fff;
    line-height: 1; margin-bottom: 4px; position: relative;
}
.donation-goal-text {
    font-size: 13px; color: rgba(255,255,255,.65);
    position: relative;
}

/* Large progress bar */
.donation-progress-wrap {
    margin: 14px 0 10px; position: relative;
}
.donation-progress-track {
    height: 10px; background: rgba(255,255,255,.2);
    border-radius: 99px; overflow: hidden; position: relative;
}
.donation-progress-fill {
    height: 100%; border-radius: 99px;
    background: linear-gradient(90deg, #7EE090, #4CAF50);
    position: relative; overflow: hidden;
    transition: width 1.4s cubic-bezier(.25,.46,.45,.94);
}
.donation-progress-fill::after {
    content: ''; position: absolute; top: 0; right: 0; bottom: 0; width: 40px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,.4));
    animation: progressShimmer 2s infinite;
}
@keyframes progressShimmer { from{transform:translateX(-40px)} to{transform:translateX(60px)} }

.donation-pct-badge {
    position: absolute; right: 0; top: -22px;
    font-size: 12px; font-weight: 800; color: #7EE090;
    font-family: 'Playfair Display', serif;
}

.donation-stats-row {
    display: flex; gap: 12px; position: relative;
}
.donation-stat {
    display: flex; align-items: center; gap: 5px;
    font-size: 12px; color: rgba(255,255,255,.65); font-weight: 500;
}
.donation-stat strong { color: #fff; }

/* Donation form body */
.donation-form-body { padding: 20px 22px; }

/* Quick amounts */
.quick-label {
    font-size: 12px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .07em; color: var(--chu-phu); margin-bottom: 10px;
}
.quick-amounts {
    display: grid; grid-template-columns: repeat(4, 1fr);
    gap: 7px; margin-bottom: 14px;
}
.quick-btn {
    height: 34px; border: 1.5px solid var(--vien);
    border-radius: 8px; background: #fff;
    font-family: var(--font); font-size: 12.5px; font-weight: 600;
    color: var(--chu-than); cursor: pointer;
    transition: all .18s; white-space: nowrap;
}
.quick-btn:hover { border-color: var(--mau-chinh); color: var(--mau-chinh); background: var(--mau-chinh-nen); }
.quick-btn.active { background: var(--mau-chinh); border-color: var(--mau-chinh); color: #fff; }

/* Amount input */
.amount-input-wrap {
    position: relative; margin-bottom: 14px;
}
.amount-input-prefix {
    position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
    font-size: 13px; font-weight: 700; color: var(--mau-chinh);
    pointer-events: none;
}
.amount-input {
    width: 100%; height: 48px;
    padding: 0 100px 0 44px;
    border: 2px solid var(--vien); border-radius: 12px;
    font-family: var(--font); font-size: 18px; font-weight: 700;
    color: var(--chu-chinh); outline: none;
    transition: border-color .2s, box-shadow .2s;
}
.amount-input:focus {
    border-color: var(--mau-chinh);
    box-shadow: 0 0 0 4px rgba(45,122,79,.1);
}
.amount-input-suffix {
    position: absolute; right: 14px; top: 50%; transform: translateY(-50%);
    font-size: 13px; color: var(--chu-phu); font-weight: 500;
    pointer-events: none;
}

/* Error hint */
.amount-error {
    font-size: 12px; color: #C53030; margin-top: -10px;
    margin-bottom: 12px; display: none;
}

/* Options */
.donation-option {
    display: flex; align-items: flex-start; gap: 9px;
    margin-bottom: 12px; cursor: pointer;
}
.donation-option input[type="checkbox"] { display: none; }
.option-box {
    width: 18px; height: 18px; border-radius: 5px;
    border: 1.5px solid #CBD5E0; background: #fff;
    flex-shrink: 0; margin-top: 1px;
    display: flex; align-items: center; justify-content: center;
    font-size: 10px; color: transparent; transition: all .15s;
}
.donation-option input:checked + .option-box {
    background: var(--mau-chinh); border-color: var(--mau-chinh); color: #fff;
}
.option-label { font-size: 13.5px; color: var(--chu-than); line-height: 1.4; }
.option-label small { display: block; font-size: 12px; color: var(--chu-phu); margin-top: 1px; }

/* Message textarea */
.msg-label {
    font-size: 12.5px; font-weight: 600; color: var(--chu-than);
    display: block; margin-bottom: 7px;
}
.msg-textarea {
    width: 100%; height: 76px;
    padding: 10px 14px; resize: none;
    border: 1.5px solid var(--vien); border-radius: 10px;
    font-family: var(--font); font-size: 13.5px; color: var(--chu-than);
    outline: none; transition: border-color .2s, box-shadow .2s;
    margin-bottom: 16px; box-sizing: border-box;
}
.msg-textarea:focus {
    border-color: var(--mau-chinh);
    box-shadow: 0 0 0 3px rgba(45,122,79,.08);
}
.msg-textarea::placeholder { color: #A0AEC0; }

/* Donate CTA button */
.btn-donate-cta {
    width: 100%; height: 52px;
    border-radius: 14px; border: none;
    background: linear-gradient(135deg, #B7550A, #C0651A 40%, #D97B2A);
    background-size: 200% 100%;
    color: #fff; font-family: var(--font);
    font-size: 16px; font-weight: 800;
    cursor: pointer; letter-spacing: .02em;
    display: flex; align-items: center; justify-content: center; gap: 8px;
    box-shadow: 0 4px 16px rgba(192,101,26,.4);
    transition: all .25s;
    position: relative; overflow: hidden;
}
.btn-donate-cta::after {
    content: ''; position: absolute; inset: 0;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,.15), transparent);
    transform: translateX(-100%);
    transition: transform .5s ease;
}
.btn-donate-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(192,101,26,.5);
}
.btn-donate-cta:hover::after { transform: translateX(100%); }
.btn-donate-cta:active { transform: translateY(0); }

.donate-note {
    text-align: center; margin-top: 10px;
    font-size: 11.5px; color: var(--chu-phu); line-height: 1.6;
}
.donate-note strong { color: var(--chu-than); }

/* ── Bank Info (revealed) ───────────────────────────────────── */
.bank-info-box {
    margin-top: 16px; border-top: 1px solid var(--vien);
    padding-top: 16px;
    display: none;
}
.bank-info-box.show { display: block; animation: bankReveal .35s ease; }
@keyframes bankReveal { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:none} }

.bank-info-title {
    font-size: 12px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .08em; color: var(--chu-phu); margin-bottom: 12px;
}
.bank-card {
    background: linear-gradient(135deg, #1A3D28 0%, #2D7A4F 100%);
    border-radius: 14px; padding: 16px 18px;
    position: relative; overflow: hidden;
}
.bank-card::before {
    content: ''; position: absolute;
    width: 120px; height: 120px; border-radius: 50%;
    background: rgba(255,255,255,.05);
    top: -40px; right: -30px;
}
.bank-card::after {
    content: ''; position: absolute;
    width: 80px; height: 80px; border-radius: 50%;
    background: rgba(255,255,255,.03);
    bottom: -20px; left: 10px;
}
.bank-name {
    font-size: 11px; font-weight: 700; letter-spacing: .1em;
    text-transform: uppercase; color: rgba(255,255,255,.6);
    margin-bottom: 6px; position: relative;
}
.bank-account-num {
    font-family: 'Playfair Display', serif;
    font-size: 20px; font-weight: 700; color: #fff;
    letter-spacing: .08em; margin-bottom: 6px; position: relative;
}
.bank-holder {
    font-size: 13px; font-weight: 600; color: rgba(255,255,255,.85);
    position: relative; margin-bottom: 12px;
}
.bank-amount-highlight {
    display: inline-flex; align-items: center; gap: 6px;
    background: rgba(255,255,255,.12); backdrop-filter: blur(4px);
    border: 1px solid rgba(255,255,255,.2);
    border-radius: 8px; padding: 6px 12px;
    font-size: 13px; font-weight: 700; color: #fff; position: relative;
}
.bank-copy-btn {
    width: 100%; height: 34px; border-radius: 8px; border: none;
    background: rgba(255,255,255,.12); color: rgba(255,255,255,.85);
    font-family: var(--font); font-size: 12.5px; font-weight: 600;
    cursor: pointer; margin-top: 12px; position: relative;
    transition: background .18s; display: flex; align-items: center;
    justify-content: center; gap: 6px;
}
.bank-copy-btn:hover { background: rgba(255,255,255,.2); color: #fff; }
.bank-qr-note {
    font-size: 11px; color: rgba(255,255,255,.5);
    text-align: center; margin-top: 8px; position: relative;
}

/* ── Share Box ──────────────────────────────────────────────── */
.share-box {
    background: #fff; border: 1px solid var(--vien);
    border-radius: 16px; padding: 18px 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,.04);
}
.share-box-title {
    font-size: 13px; font-weight: 700; color: var(--chu-chinh);
    margin-bottom: 14px; display: flex; align-items: center; gap: 7px;
}
.share-btns { display: flex; gap: 8px; }
.share-btn {
    flex: 1; height: 38px; border-radius: 10px; border: none;
    font-family: var(--font); font-size: 12.5px; font-weight: 600;
    cursor: pointer; display: flex; align-items: center;
    justify-content: center; gap: 5px; transition: all .18s;
}
.share-fb   { background: #1877F2; color: #fff; }
.share-fb:hover   { background: #166FE5; transform: translateY(-1px); }
.share-zalo { background: #0068FF; color: #fff; }
.share-zalo:hover { background: #0055D4; transform: translateY(-1px); }
.share-copy { background: #F6FBF7; color: var(--chu-than); border: 1px solid var(--vien); }
.share-copy:hover { background: var(--mau-chinh-nen); color: var(--mau-chinh); border-color: var(--mau-chinh-nhat); transform: translateY(-1px); }
.share-copy.copied { background: var(--mau-chinh); color: #fff; border-color: var(--mau-chinh); }

/* ── Org Box ────────────────────────────────────────────────── */
.org-box {
    background: #fff; border: 1px solid var(--vien);
    border-radius: 16px; padding: 18px 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,.04);
}
.org-box-title {
    font-size: 11.5px; font-weight: 700; text-transform: uppercase;
    letter-spacing: .08em; color: var(--chu-phu); margin-bottom: 14px;
}
.org-info {
    display: flex; align-items: center; gap: 14px;
}
.org-logo {
    width: 52px; height: 52px; border-radius: 12px;
    background: linear-gradient(135deg, var(--mau-chinh), #3D9962);
    display: flex; align-items: center; justify-content: center;
    font-size: 24px; flex-shrink: 0;
    box-shadow: 0 2px 8px rgba(45,122,79,.2);
}
.org-name { font-size: 14px; font-weight: 700; color: var(--chu-chinh); margin-bottom: 3px; }
.org-meta { font-size: 12px; color: var(--chu-phu); }
.org-link {
    display: inline-flex; align-items: center; gap: 4px; margin-top: 4px;
    font-size: 12px; font-weight: 600; color: var(--mau-chinh);
    text-decoration: none;
}
.org-link:hover { text-decoration: underline; }
.org-verified {
    display: inline-flex; align-items: center; gap: 4px;
    margin-top: 10px; font-size: 12px; color: var(--mau-chinh);
    background: var(--mau-chinh-nen); padding: 5px 10px;
    border-radius: 8px; font-weight: 600;
}

/* ── Lightbox ───────────────────────────────────────────────── */
.lightbox-overlay {
    position: fixed; inset: 0; z-index: 9999;
    background: rgba(0,0,0,.88); backdrop-filter: blur(8px);
    display: none; align-items: center; justify-content: center;
    padding: 20px;
}
.lightbox-overlay.open { display: flex; animation: lbFadeIn .2s ease; }
@keyframes lbFadeIn { from{opacity:0} to{opacity:1} }
.lightbox-img {
    max-width: 90vw; max-height: 85vh; border-radius: 12px;
    box-shadow: 0 8px 40px rgba(0,0,0,.5);
    object-fit: contain;
}
.lightbox-close {
    position: fixed; top: 20px; right: 24px; z-index: 10000;
    width: 40px; height: 40px; border-radius: 50%;
    background: rgba(255,255,255,.15); color: #fff;
    border: none; font-size: 20px; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    transition: background .15s;
}
.lightbox-close:hover { background: rgba(255,255,255,.3); }

/* ── Toast notification ─────────────────────────────────────── */
.toast {
    position: fixed; bottom: 28px; left: 50%; transform: translateX(-50%) translateY(20px);
    background: #1A3D28; color: #fff;
    padding: 12px 24px; border-radius: 12px;
    font-size: 13.5px; font-weight: 600;
    display: flex; align-items: center; gap: 8px;
    box-shadow: 0 8px 24px rgba(0,0,0,.25);
    opacity: 0; transition: all .3s ease; z-index: 10000;
    pointer-events: none; white-space: nowrap;
}
.toast.show { opacity: 1; transform: translateX(-50%) translateY(0); }

/* ── Donate success flash ───────────────────────────────────── */
.success-message {
    display: none; text-align: center;
    padding: 24px; animation: successPop .4s cubic-bezier(.175,.885,.32,1.275);
}
@keyframes successPop { from{opacity:0;transform:scale(.9)} to{opacity:1;transform:scale(1)} }
.success-message .success-icon { font-size: 48px; margin-bottom: 10px; }
.success-message h3 { font-size: 17px; font-weight: 700; color: var(--mau-chinh); margin-bottom: 6px; }
.success-message p { font-size: 13.5px; color: var(--chu-phu); }

/* ── Responsive ─────────────────────────────────────────────── */
@media (max-width: 960px) {
    .detail-page {
        grid-template-columns: 1fr;
    }
    .detail-right { position: static; }
    .quick-amounts { grid-template-columns: repeat(2, 1fr); }
    .share-btns { flex-wrap: wrap; }
}
@media (max-width: 640px) {
    .donation-raised { font-size: 24px; }
    .campaign-h1 { font-size: 22px; }
    .donors-table thead { display: none; }
    .donors-table tbody td { display: block; padding: 8px 16px; border: none; }
    .donors-table tbody tr { border-bottom: 1px solid var(--vien); }
    .hero-thumbs { gap: 6px; }
    .hero-thumb-item { width: 70px; height: 50px; }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb-bar">
    <div class="breadcrumb-inner">
        <a href="/TrangChu.aspx">🏠 Trang chủ</a>
        <span class="breadcrumb-sep">›</span>
        <a href="/DanhSachChienDich.aspx">Chiến dịch</a>
        <span class="breadcrumb-sep">›</span>
        <span class="breadcrumb-current" id="bcCampaignName">Cứu trợ khẩn cấp lũ lụt miền Trung 2026</span>
    </div>
</div>

<!-- ══ Main Layout ══ -->
<div class="detail-page">

    <!-- ════════════════════════════════════
         LEFT COLUMN
    ════════════════════════════════════ -->
    <div class="detail-left">

        <!-- Hero Gallery -->
        <div class="hero-gallery">
            <div class="hero-img-main" id="heroMainImg" onclick="openLightbox(0)">
                <div class="hero-img-placeholder" id="heroEmoji"
                     style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;
                            background:linear-gradient(135deg,#1E40AF,#3B82F6);font-size:96px">
                    🌊
                </div>
                <div class="hero-img-badge">
                    <span class="hero-cat-badge" style="background:rgba(229,62,62,.85);color:#fff" id="catBadge">
                        🚨 Thiên tai & Khẩn cấp
                    </span>
                    <span class="hero-status-badge status-urgent" id="statusBadge">🔴 Khẩn cấp</span>
                </div>
            </div>

            <!-- Thumbnail strip -->
            <div class="hero-thumbs" id="thumbStrip">
                <!-- Rendered by JS -->
            </div>
        </div>

        <!-- Title Block -->
        <div class="campaign-title-block">
            <span class="campaign-cat-tag" style="background:#FEE2E2;color:#C53030" id="catTagTop">
                🚨 Thiên tai & Khẩn cấp
            </span>
            <h1 class="campaign-h1" id="campaignTitle">
                Cứu trợ khẩn cấp lũ lụt miền Trung 2026
            </h1>
            <div class="campaign-meta-row">
                <div class="meta-item urgent-text">
                    <span>⏰</span>
                    <span>Còn <strong id="metaDays">5</strong> ngày</span>
                </div>
                <div class="meta-item">
                    <span>👥</span>
                    <span><strong id="metaDonors">3,821</strong> lượt quyên góp</span>
                </div>
                <div class="meta-item">
                    <span>📅</span>
                    <span>Bắt đầu <strong>20/03/2026</strong></span>
                </div>
                <div class="meta-item">
                    <span>🏢</span>
                    <span>Hội Chữ Thập Đỏ Việt Nam</span>
                </div>
            </div>
        </div>

        <!-- ── Tabs ── -->
        <div class="tabs-nav">
            <button class="tab-btn active" onclick="switchTab('mo-ta', this)">
                📋 Mô tả chiến dịch
            </button>
            <button class="tab-btn" onclick="switchTab('tien-do', this)">
                📊 Cập nhật tiến độ
                <span class="tab-count">4</span>
            </button>
            <button class="tab-btn" onclick="switchTab('nguoi-gop', this)">
                ❤️ Người quyên góp
                <span class="tab-count" id="donorCountTab">10</span>
            </button>
        </div>

        <!-- Tab: Mô Tả -->
        <div class="tab-panel active" id="tab-mo-ta">
            <div class="mo-ta-content">
                <div class="highlight-box">
                    <strong>🚨 Tình hình khẩn cấp:</strong> Tính đến ngày 24/03/2026, đợt lũ lịch sử đã nhấn chìm hơn 12.000 hecta đất nông nghiệp, 8.500 ngôi nhà bị ngập, khiến hơn 45.000 người phải sơ tán khẩn cấp tại các tỉnh Quảng Bình, Hà Tĩnh, Nghệ An.
                </div>

                <h2>📌 Mục tiêu của chiến dịch</h2>
                <p>Chiến dịch <strong>"Cứu trợ khẩn cấp lũ lụt miền Trung 2026"</strong> được khởi động nhằm quyên góp nguồn lực hỗ trợ khẩn cấp cho hàng chục nghìn người dân đang bị ảnh hưởng nặng nề bởi đợt lũ lịch sử tháng 3/2026. Toàn bộ số tiền quyên góp sẽ được sử dụng minh bạch cho các mục đích sau:</p>

                <ul>
                    <li>🍚 Cung cấp <strong>lương thực, nước uống</strong> sạch cho các hộ bị cô lập</li>
                    <li>🏥 Túi thuốc y tế và hỗ trợ chăm sóc sức khỏe khẩn cấp</li>
                    <li>🛖 Dựng <strong>lều tạm và chăn màn</strong> cho người mất nhà</li>
                    <li>📚 Sách vở, đồ dùng học tập cho trẻ em sau lũ</li>
                    <li>🔧 Hỗ trợ vật liệu tu sửa nhà cửa sau khi nước rút</li>
                </ul>

                <h3>📍 Địa bàn hoạt động</h3>
                <p>Chiến dịch tập trung vào các huyện bị thiệt hại nặng nhất:</p>
                <ul>
                    <li><strong>Quảng Bình:</strong> Huyện Lệ Thủy, Quảng Ninh, Bố Trạch</li>
                    <li><strong>Hà Tĩnh:</strong> Huyện Hương Khê, Vũ Quang, Cẩm Xuyên</li>
                    <li><strong>Nghệ An:</strong> Huyện Anh Sơn, Con Cuông, Tương Dương</li>
                </ul>

                <blockquote>
                    "Chúng tôi đã mất tất cả — nhà cửa, lúa gạo, gia súc. Chỉ kịp bế các con chạy lên mái nhà hàng xóm. Bây giờ chỉ cần gạo ăn qua ngày..." — Chị Nguyễn Thị Hoa, 38 tuổi, xã Phúc Trạch, Hương Khê.
                </blockquote>

                <h3>💰 Cam kết minh bạch 100%</h3>
                <p>Thiện Nguyện Việt cam kết <strong>công khai toàn bộ</strong> danh sách thu chi, hóa đơn mua hàng và ảnh/video phân phối quà sau mỗi chuyến đi. Báo cáo tài chính được đăng tải định kỳ trên website và fanpage chính thức.</p>

                <p>Mọi thông tin chi tiết và câu hỏi, xin vui lòng liên hệ: <strong>contact@thiennguyen.vn</strong> hoặc hotline <strong>1800 1234</strong> (miễn phí, 8:00 – 17:30 các ngày trong tuần).</p>
            </div>
        </div>

        <!-- Tab: Cập Nhật Tiến Độ -->
        <div class="tab-panel" id="tab-tien-do">
            <div class="timeline" id="timelineContainer">
                <!-- Rendered by JS -->
            </div>
        </div>

        <!-- Tab: Người Quyên Góp -->
        <div class="tab-panel" id="tab-nguoi-gop">
            <div class="donors-header">
                <h3>🏆 Top người quyên góp nhiều nhất</h3>
                <button class="btn-view-all-donors" onclick="showToast('⚙️ Tính năng đang phát triển...')">
                    Xem tất cả →
                </button>
            </div>
            <div class="donors-table-wrap">
                <table class="donors-table" id="donorsTable">
                    <thead>
                        <tr>
                            <th style="width:40px">#</th>
                            <th>Người quyên góp</th>
                            <th>Số tiền</th>
                            <th>Lời nhắn</th>
                            <th>Thời gian</th>
                        </tr>
                    </thead>
                    <tbody id="donorsTbody">
                        <!-- Rendered by JS -->
                    </tbody>
                </table>
                <div class="donors-footer">
                    <span class="donors-total-text">
                        Hiển thị top 10 / <strong id="totalDonors">3.821</strong> lượt quyên góp
                    </span>
                </div>
            </div>
        </div>

    </div><!-- /detail-left -->


    <!-- ════════════════════════════════════
         RIGHT COLUMN — STICKY
    ════════════════════════════════════ -->
    <div class="detail-right">

        <!-- Donation Box -->
        <div class="donation-box">

            <!-- Header: progress -->
            <div class="donation-box-header">
                <div class="donation-money-label">Đã quyên góp được</div>
                <div class="donation-raised" id="raisedDisplay">8.400.000.000 đ</div>
                <div class="donation-goal-text">Mục tiêu: <strong style="color:rgba(255,255,255,.9)">10.000.000.000 đ</strong></div>

                <div class="donation-progress-wrap">
                    <div class="donation-pct-badge" id="pctBadge">84%</div>
                    <div class="donation-progress-track">
                        <div class="donation-progress-fill" id="progressFill" style="width:0%"></div>
                    </div>
                </div>

                <div class="donation-stats-row">
                    <div class="donation-stat">
                        ⏳ Còn <strong id="daysLeftStat">5</strong>&nbsp;ngày
                    </div>
                    <div class="donation-stat">
                        ❤️ <strong id="donorsStat">3.821</strong>&nbsp;lượt góp
                    </div>
                </div>
            </div>

            <!-- Form -->
            <div class="donation-form-body">

                <!-- Success screen (hidden by default) -->
                <div class="success-message" id="successMsg">
                    <div class="success-icon">🎉</div>
                    <h3>Cảm ơn bạn đã quyên góp!</h3>
                    <p>Thông tin chuyển khoản đã được ghi nhận.<br/>
                       Ban quản trị sẽ xác nhận trong vòng 24 giờ.</p>
                    <button class="btn-donate-cta" style="margin-top:16px;font-size:13px;height:40px"
                            onclick="resetForm()">
                        ← Quyên góp thêm
                    </button>
                </div>

                <!-- Form fields -->
                <div id="donationFormFields">
                    <p class="quick-label">Chọn số tiền quyên góp</p>

                    <div class="quick-amounts">
                        <button class="quick-btn" onclick="selectAmount(50000, this)">50k</button>
                        <button class="quick-btn" onclick="selectAmount(100000, this)">100k</button>
                        <button class="quick-btn" onclick="selectAmount(200000, this)">200k</button>
                        <button class="quick-btn" onclick="selectAmount(500000, this)">500k</button>
                        <button class="quick-btn" onclick="selectAmount(1000000, this)">1 triệu</button>
                        <button class="quick-btn" onclick="selectAmount(2000000, this)">2 triệu</button>
                        <button class="quick-btn" onclick="selectAmount(5000000, this)">5 triệu</button>
                        <button class="quick-btn" onclick="selectAmount(0, this)" id="btnCustom">Khác</button>
                    </div>

                    <div class="amount-input-wrap">
                        <span class="amount-input-prefix">₫</span>
                        <input type="number" class="amount-input" id="amountInput"
                               placeholder="0" min="10000" step="1000"
                               oninput="onAmountInput(this.value)" />
                        <span class="amount-input-suffix">VNĐ</span>
                    </div>
                    <div class="amount-error" id="amountError">
                        ⚠️ Số tiền tối thiểu là 10.000 đ
                    </div>

                    <label class="donation-option">
                        <input type="checkbox" id="chkAnonymous" onchange="toggleAnonymous()" />
                        <span class="option-box">✓</span>
                        <span class="option-label">
                            Quyên góp ẩn danh
                            <small>Tên của bạn sẽ không hiển thị công khai</small>
                        </span>
                    </label>

                    <label class="msg-label" for="donorMsg">
                        💬 Lời nhắn (không bắt buộc)
                    </label>
                    <textarea class="msg-textarea" id="donorMsg"
                              placeholder="Gửi một lời động viên đến các bạn miền Trung..."></textarea>

                    <button class="btn-donate-cta" onclick="handleDonate()">
                        ❤ Quyên góp ngay
                    </button>

                    <p class="donate-note">
                        🔒 Thông tin được bảo mật · Mọi giao dịch đều được <strong>xác nhận thủ công</strong> bởi ban quản trị
                    </p>

                    <!-- Bank info (shown after amount entered) -->
                    <div class="bank-info-box" id="bankInfoBox">
                        <p class="bank-info-title">📲 Thông tin chuyển khoản</p>
                        <div class="bank-card">
                            <div class="bank-name">Vietcombank</div>
                            <div class="bank-account-num">1234 5678 9012</div>
                            <div class="bank-holder">HỘI CHỮ THẬP ĐỎ VIỆT NAM</div>
                            <div class="bank-amount-highlight">
                                <span>💰</span>
                                <span id="bankAmountDisplay">Nhập số tiền phía trên</span>
                            </div>
                            <button class="bank-copy-btn" onclick="copyBankInfo()">
                                📋 Sao chép thông tin TK
                            </button>
                            <p class="bank-qr-note">Nội dung CK: UNGHO [Họ tên của bạn]</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Share Box -->
        <div class="share-box">
            <div class="share-box-title">
                🔗 Chia sẻ chiến dịch
            </div>
            <div class="share-btns">
                <button class="share-btn share-fb" onclick="shareFb()">
                    🔵 Facebook
                </button>
                <button class="share-btn share-zalo" onclick="shareZalo()">
                    🟢 Zalo
                </button>
                <button class="share-btn share-copy" id="copyLinkBtn" onclick="copyLink()">
                    🔗 Copy link
                </button>
            </div>
        </div>

        <!-- Org Box -->
        <div class="org-box">
            <p class="org-box-title">🏢 Tổ chức chủ trì</p>
            <div class="org-info">
                <div class="org-logo">✚</div>
                <div>
                    <div class="org-name">Hội Chữ Thập Đỏ Việt Nam</div>
                    <div class="org-meta">Chi hội tỉnh Quảng Bình</div>
                    <a href="#" class="org-link">Xem hồ sơ tổ chức →</a>
                </div>
            </div>
            <div class="org-verified">
                ✅ Tổ chức đã được xác minh bởi Thiện Nguyện Việt
            </div>
        </div>

    </div><!-- /detail-right -->

</div><!-- /detail-page -->

<!-- ══ Lightbox ══ -->
<div class="lightbox-overlay" id="lightbox" onclick="closeLightbox(event)">
    <button class="lightbox-close" onclick="closeLightbox()">✕</button>
    <div style="font-size:160px;user-select:none" id="lightboxContent">🌊</div>
</div>

<!-- ══ Toast ══ -->
<div class="toast" id="toastMsg">
    <span id="toastText">✅ Đã sao chép!</span>
</div>


<!-- ══ Scripts ══ -->
<script>
(function () {
'use strict';

/* ─────────────────────────────────────────────────────────
   CAMPAIGN DATA (mock — sẽ được thay bằng DB khi có API)
───────────────────────────────────────────────────────── */
var CAMPAIGN = {
    id: 1,
    title: 'Cứu trợ khẩn cấp lũ lụt miền Trung 2026',
    cat: 'Thiên tai & Khẩn cấp',
    catColor: '#C53030',
    catBg: '#FEE2E2',
    status: 'urgent',
    raised: 8400000000,
    goal: 10000000000,
    pct: 84,
    donors: 3821,
    daysLeft: 5,
    startDate: '20/03/2026',
    endDate: '31/03/2026',
    emoji: '🌊',
    gradFrom: '#1E40AF',
    gradTo: '#3B82F6',
    org: 'Hội Chữ Thập Đỏ Việt Nam',
    bank: {
        name: 'Vietcombank',
        account: '1234 5678 9012',
        holder: 'HỘI CHỮ THẬP ĐỎ VIỆT NAM',
        content: 'UNGHO [Họ tên của bạn]'
    },
    gallery: [
        { emoji: '🌊', grad: 'linear-gradient(135deg,#1E40AF,#3B82F6)' },
        { emoji: '🏠', grad: 'linear-gradient(135deg,#374151,#6B7280)' },
        { emoji: '🤝', grad: 'linear-gradient(135deg,#065F46,#34D399)' },
        { emoji: '🚁', grad: 'linear-gradient(135deg,#92400E,#F59E0B)' },
        { emoji: '📦', grad: 'linear-gradient(135deg,#1E3A8A,#818CF8)' },
    ]
};

var UPDATES = [
    {
        title: 'Đợt hàng cứu trợ thứ 3 đã đến tay bà con',
        date: '24/03/2026',
        body: 'Sáng ngày 24/03, đoàn thiện nguyện gồm 15 thành viên đã hoàn thành việc phân phối 2.000 túi quà (gạo, mì, nước lọc, khẩu trang) đến 4 xã thuộc huyện Lệ Thủy. Bà con nhận quà trong xúc động và gửi lời cảm ơn chân thành đến các nhà hảo tâm.',
        emoji: '📦', hasDot: 'dot-first'
    },
    {
        title: 'Cập nhật tình hình: 8.500 hộ bị ảnh hưởng',
        date: '22/03/2026',
        body: 'Theo thống kê mới nhất từ Ban chỉ đạo phòng chống thiên tai, đến 18:00 ngày 22/03, tổng số hộ bị ngập lụt đã lên đến 8.500 hộ. Trong đó có 1.200 hộ bị ngập sâu trên 1,5m, cần hỗ trợ khẩn cấp nhất. Chúng tôi đang ưu tiên tiếp cận những hộ này.',
        emoji: '📊', hasDot: ''
    },
    {
        title: 'Đội cứu trợ đầu tiên xuất phát',
        date: '21/03/2026',
        body: 'Ngay sau khi chiến dịch đạt 1 tỷ đồng, ban tổ chức đã điều phối ngay chuyến xe đầu tiên chở 500 phần quà từ Hà Nội vào Quảng Bình. Đoàn đã có mặt tại điểm tập kết lúc 14:00 và phân phát toàn bộ quà trong chiều cùng ngày.',
        emoji: '🚚', hasDot: ''
    },
    {
        title: 'Chiến dịch chính thức khởi động',
        date: '20/03/2026',
        body: 'Sau khi nhận được thông tin về tình hình lũ lụt nghiêm trọng, Thiện Nguyện Việt phối hợp với Hội Chữ Thập Đỏ Việt Nam chính thức phát động chiến dịch cứu trợ. Trong 24 giờ đầu tiên, đã có hơn 500 nhà hảo tâm đóng góp với tổng số tiền vượt 200 triệu đồng.',
        emoji: '🚀', hasDot: ''
    }
];

var DONORS = [
    { rank: 1, name: 'Nguyễn Hải Anh', amount: 50000000, date: '24/03', msg: 'Chúc bà con sớm vượt qua khó khăn!' },
    { rank: 2, name: 'Ẩn danh', amount: 30000000, date: '23/03', msg: 'Mong bình an đến mọi nhà.', anon: true },
    { rank: 3, name: 'Trần Thị Minh Châu', amount: 20000000, date: '24/03', msg: 'Cố lên miền Trung!' },
    { rank: 4, name: 'Công ty TNHH ABC', amount: 10000000, date: '22/03', msg: 'Đồng hành cùng đồng bào.' },
    { rank: 5, name: 'Lê Quang Vinh', amount: 5000000, date: '23/03', msg: '' },
    { rank: 6, name: 'Phạm Thu Hương', amount: 3000000, date: '23/03', msg: 'Thương bà con lắm 💙' },
    { rank: 7, name: 'Ẩn danh', amount: 2000000, date: '22/03', msg: '', anon: true },
    { rank: 8, name: 'Vũ Đình Khôi', amount: 1500000, date: '21/03', msg: 'Mong được giúp ích một phần nhỏ.' },
    { rank: 9, name: 'Đặng Thị Lan', amount: 1000000, date: '21/03', msg: '' },
    { rank: 10, name: 'Hoàng Minh Tuấn', amount: 500000, date: '20/03', msg: 'Cảm ơn vì đã tổ chức!' },
];

/* ─────────────────────────────────────────────────────────
   INIT PAGE
───────────────────────────────────────────────────────── */
window.addEventListener('DOMContentLoaded', function () {
    renderGallery();
    renderTimeline();
    renderDonors();
    animateProgress();
    updateBreadcrumb();
});

function updateBreadcrumb() {
    var el = document.getElementById('bcCampaignName');
    if (el) el.textContent = CAMPAIGN.title;
}

/* ─────────────────────────────────────────────────────────
   GALLERY
───────────────────────────────────────────────────────── */
var currentThumb = 0;

function renderGallery() {
    var strip = document.getElementById('thumbStrip');
    strip.innerHTML = CAMPAIGN.gallery.map(function (g, i) {
        return '<div class="hero-thumb-item' + (i === 0 ? ' active' : '') + '" ' +
            'onclick="selectThumb(' + i + ')" ' +
            'style="background:' + g.grad + '">' +
            g.emoji +
        '</div>';
    }).join('');
}

function selectThumb(idx) {
    currentThumb = idx;
    var thumbs = document.querySelectorAll('.hero-thumb-item');
    thumbs.forEach(function (t, i) {
        t.classList.toggle('active', i === idx);
    });

    var hero = document.getElementById('heroEmoji');
    var g = CAMPAIGN.gallery[idx];
    hero.style.background = g.grad;
    hero.textContent = g.emoji;
}

/* ─────────────────────────────────────────────────────────
   LIGHTBOX
───────────────────────────────────────────────────────── */
function openLightbox(idx) {
    var g = CAMPAIGN.gallery[currentThumb];
    var lb = document.getElementById('lightbox');
    var lbContent = document.getElementById('lightboxContent');
    lbContent.textContent = g.emoji;
    lbContent.style.background = g.grad;
    lbContent.style.borderRadius = '20px';
    lbContent.style.padding = '40px 60px';
    lb.classList.add('open');
    document.body.style.overflow = 'hidden';
}

window.openLightbox = openLightbox;

window.closeLightbox = function (e) {
    if (e && e.target !== document.getElementById('lightbox') &&
        !e.target.classList.contains('lightbox-close')) return;
    document.getElementById('lightbox').classList.remove('open');
    document.body.style.overflow = '';
};

/* ─────────────────────────────────────────────────────────
   TABS
───────────────────────────────────────────────────────── */
window.switchTab = function (tabId, btn) {
    document.querySelectorAll('.tab-panel').forEach(function (p) { p.classList.remove('active'); });
    document.querySelectorAll('.tab-btn').forEach(function (b) { b.classList.remove('active'); });
    document.getElementById('tab-' + tabId).classList.add('active');
    btn.classList.add('active');
};

/* ─────────────────────────────────────────────────────────
   TIMELINE
───────────────────────────────────────────────────────── */
function renderTimeline() {
    var container = document.getElementById('timelineContainer');
    container.innerHTML = UPDATES.map(function (u, i) {
        return '<div class="timeline-item" style="animation-delay:' + (i * 0.1) + 's">' +
            '<div class="timeline-dot ' + u.hasDot + '">' + u.emoji + '</div>' +
            '<div class="timeline-card">' +
                '<div class="timeline-card-header">' +
                    '<div class="timeline-title">' + u.title + '</div>' +
                    '<div class="timeline-date">📅 ' + u.date + '</div>' +
                '</div>' +
                '<div class="timeline-body">' + u.body + '</div>' +
            '</div>' +
        '</div>';
    }).join('');
}

/* ─────────────────────────────────────────────────────────
   DONORS TABLE
───────────────────────────────────────────────────────── */
function renderDonors() {
    var tbody = document.getElementById('donorsTbody');
    var rankIcons = ['🥇', '🥈', '🥉'];

    tbody.innerHTML = DONORS.map(function (d) {
        var rankClass = d.rank <= 3 ? 'rank-' + d.rank : '';
        var rankDisplay = d.rank <= 3 ? rankIcons[d.rank - 1] : d.rank;
        var initials = d.anon ? '?' : d.name.trim().split(' ').slice(-1)[0][0];
        var nameDisplay = d.anon
            ? '<span class="donor-anon">🕵️ Ẩn danh</span>'
            : '<span class="donor-name">' + d.name + '</span>';

        return '<tr>' +
            '<td><div class="donor-rank ' + rankClass + '">' + rankDisplay + '</div></td>' +
            '<td><div class="donor-avatar-wrap">' +
                '<div class="donor-avatar">' + initials + '</div>' +
                nameDisplay +
            '</div></td>' +
            '<td><span class="donor-amount">' + formatMoney(d.amount) + '</span></td>' +
            '<td><span class="donor-msg">' + (d.msg || '<span style="color:#CBD5E0">—</span>') + '</span></td>' +
            '<td><span class="donor-date">' + d.date + '</span></td>' +
        '</tr>';
    }).join('');
}

function formatMoney(n) {
    if (n >= 1e9) return (n / 1e9).toFixed(n % 1e9 === 0 ? 0 : 1) + ' tỷ đ';
    if (n >= 1e6) return (n / 1e6).toFixed(n % 1e6 === 0 ? 0 : 1) + ' triệu đ';
    if (n >= 1000) return (n / 1000).toFixed(0) + '.000 đ';
    return n.toLocaleString('vi-VN') + ' đ';
}

/* ─────────────────────────────────────────────────────────
   PROGRESS BAR ANIMATION
───────────────────────────────────────────────────────── */
function animateProgress() {
    var fill = document.getElementById('progressFill');
    var pct = CAMPAIGN.pct;
    setTimeout(function () { fill.style.width = pct + '%'; }, 200);
}

/* ─────────────────────────────────────────────────────────
   DONATION FORM
───────────────────────────────────────────────────────── */
var selectedAmount = 0;

window.selectAmount = function (amount, btn) {
    selectedAmount = amount;
    document.querySelectorAll('.quick-btn').forEach(function (b) { b.classList.remove('active'); });
    if (amount > 0) {
        btn.classList.add('active');
        document.getElementById('amountInput').value = amount;
    } else {
        btn.classList.add('active');
        document.getElementById('amountInput').value = '';
        document.getElementById('amountInput').focus();
    }
    updateBankDisplay(amount);
    hideError();
};

window.onAmountInput = function (val) {
    selectedAmount = parseInt(val) || 0;
    document.querySelectorAll('.quick-btn').forEach(function (b) { b.classList.remove('active'); });
    updateBankDisplay(selectedAmount);
    hideError();
};

function updateBankDisplay(amount) {
    var bankBox = document.getElementById('bankInfoBox');
    var bankAmountEl = document.getElementById('bankAmountDisplay');
    if (amount >= 10000) {
        bankBox.classList.add('show');
        bankAmountEl.textContent = amount.toLocaleString('vi-VN') + ' đ';
    } else {
        bankBox.classList.remove('show');
        bankAmountEl.textContent = 'Nhập số tiền phía trên';
    }
}

function hideError() {
    document.getElementById('amountError').style.display = 'none';
}

window.toggleAnonymous = function () {
    // visual only — logic handled server-side
};

window.handleDonate = function () {
    var amount = parseInt(document.getElementById('amountInput').value) || selectedAmount;
    if (!amount || amount < 10000) {
        var err = document.getElementById('amountError');
        err.style.display = 'block';
        document.getElementById('amountInput').focus();
        return;
    }
    // Show success screen
    document.getElementById('donationFormFields').style.display = 'none';
    document.getElementById('successMsg').style.display = 'block';
};

window.resetForm = function () {
    document.getElementById('donationFormFields').style.display = 'block';
    document.getElementById('successMsg').style.display = 'none';
    document.getElementById('amountInput').value = '';
    selectedAmount = 0;
    document.querySelectorAll('.quick-btn').forEach(function (b) { b.classList.remove('active'); });
    document.getElementById('bankInfoBox').classList.remove('show');
};

/* ─────────────────────────────────────────────────────────
   BANK INFO COPY
───────────────────────────────────────────────────────── */
window.copyBankInfo = function () {
    var amount = parseInt(document.getElementById('amountInput').value) || selectedAmount;
    var text = 'Ngân hàng: ' + CAMPAIGN.bank.name + '\n' +
               'Số TK: ' + CAMPAIGN.bank.account + '\n' +
               'Chủ TK: ' + CAMPAIGN.bank.holder + '\n' +
               'Số tiền: ' + (amount > 0 ? amount.toLocaleString('vi-VN') + ' đ' : '...') + '\n' +
               'Nội dung CK: ' + CAMPAIGN.bank.content;
    navigator.clipboard.writeText(text).then(function () {
        showToast('✅ Đã sao chép thông tin chuyển khoản!');
    }).catch(function () {
        showToast('📋 Vui lòng chép thủ công thông tin phía trên');
    });
};

/* ─────────────────────────────────────────────────────────
   SHARE
───────────────────────────────────────────────────────── */
window.shareFb = function () {
    var url = encodeURIComponent(window.location.href);
    window.open('https://www.facebook.com/sharer/sharer.php?u=' + url, '_blank', 'width=600,height=400');
};

window.shareZalo = function () {
    var url = encodeURIComponent(window.location.href);
    window.open('https://zalo.me/share?href=' + url, '_blank', 'width=600,height=400');
};

window.copyLink = function () {
    navigator.clipboard.writeText(window.location.href).then(function () {
        var btn = document.getElementById('copyLinkBtn');
        btn.classList.add('copied');
        btn.textContent = '✅ Đã sao chép!';
        showToast('🔗 Đã sao chép link chiến dịch!');
        setTimeout(function () {
            btn.classList.remove('copied');
            btn.textContent = '🔗 Copy link';
        }, 2500);
    });
};

/* ─────────────────────────────────────────────────────────
   TOAST
───────────────────────────────────────────────────────── */
var toastTimer = null;
window.showToast = function (msg) {
    var toast = document.getElementById('toastMsg');
    document.getElementById('toastText').textContent = msg;
    toast.classList.add('show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () { toast.classList.remove('show'); }, 2800);
};

}()); // end IIFE
</script>
</asp:Content>
