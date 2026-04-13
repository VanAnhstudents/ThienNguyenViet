<%@ Page Title="Bài viết" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="FormTinTuc.aspx.cs"
         Inherits="ThienNguyenViet.Admin.FormTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ═══════════════════════════════════════════════════════
   FormTinTuc — synced with FormChienDich
═══════════════════════════════════════════════════════ */

/* ── Layout (chuẩn FormChienDich) ── */
.breadcrumb   { font-size: 12px; color: var(--txt-sub); margin-bottom: 4px; }
.breadcrumb a { color: var(--accent); text-decoration: none; }
.breadcrumb a:hover { text-decoration: underline; }
.page-title   { font-size: 20px; font-weight: 700; color: var(--txt); margin-bottom: 20px; }

.form-grid {
    display: grid;
    grid-template-columns: 1fr 300px;
    gap: 20px;
    align-items: start;
}

/* ── Admin card (chuẩn adm-card) ── */
.admin-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--r-card); padding: 18px 20px; margin-bottom: 18px;
}
.card-section-title {
    font-size: 14px; font-weight: 600; color: var(--txt); margin-bottom: 14px;
}

/* ── Form controls (chuẩn FormChienDich) ── */
.form-group          { margin-bottom: 14px; }
.form-group:last-child { margin-bottom: 0; }
.form-label          { display: block; font-size: 12px; font-weight: 600; color: var(--txt); margin-bottom: 6px; }
.form-label .req     { color: var(--err); margin-left: 2px; }
.form-hint           { font-size: 11px; color: var(--txt-sub); margin-top: 3px; }

.form-control {
    width: 100%; height: 36px;
    padding: 0 10px;
    border: 1px solid var(--border);
    border-radius: var(--r);
    font-size: 13px; font-family: var(--font);
    color: var(--txt); background: #fff;
    outline: none; box-sizing: border-box;
    transition: border-color .15s, box-shadow .15s;
}
.form-control:focus  { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(49,130,206,.1); }
textarea.form-control { height: auto; padding: 8px 10px; resize: vertical; line-height: 1.5; }

/* ── Char counter ── */
.char-counter {
    font-size: 11px; color: var(--txt-sub); text-align: right; margin-top: 3px;
}
.char-counter.over { color: var(--err); font-weight: 600; }

/* ── Rich Text Editor ── */
.rte-toolbar {
    display: flex; align-items: center; gap: 3px; flex-wrap: wrap;
    border: 1px solid var(--border); border-bottom: none;
    border-radius: var(--r) var(--r) 0 0;
    padding: 6px 8px; background: var(--thead);
}
.rte-btn {
    display: inline-flex; align-items: center; justify-content: center;
    min-width: 30px; height: 28px; padding: 0 6px;
    border: 1px solid var(--border); border-radius: 4px;
    background: #fff; font-family: var(--font); font-size: 12px;
    color: var(--txt); cursor: pointer;
    transition: background .15s, border-color .15s;
}
.rte-btn:hover { background: var(--accent-light); border-color: var(--accent); color: var(--accent); }
.rte-sep { width: 1px; height: 20px; background: var(--border); margin: 0 3px; }

.rte-area {
    display: block; width: 100%;
    min-height: 240px; padding: 10px 12px;
    border: 1px solid var(--border);
    border-radius: 0 0 var(--r) var(--r);
    font-size: 13px; font-family: var(--font);
    color: var(--txt); background: #fff;
    resize: vertical; box-sizing: border-box; line-height: 1.7;
    outline: none; transition: border-color .15s;
}
.rte-area:focus { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(49,130,206,.1); }

/* ── SEO Preview ── */
.seo-preview {
    background: var(--bg); border: 1px solid var(--border);
    border-radius: var(--r); padding: 14px 16px;
}
.seo-preview-label {
    font-size: 10px; font-weight: 600; color: var(--txt-sub);
    text-transform: uppercase; letter-spacing: .05em; margin-bottom: 8px;
}
.seo-title {
    font-size: 16px; color: #1a0dab; font-weight: 600;
    margin-bottom: 3px; line-height: 1.3;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.seo-url {
    font-size: 12px; color: #006621; margin-bottom: 4px;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.seo-desc { font-size: 12px; color: #545454; line-height: 1.55;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
            overflow: hidden; }

/* ── Ảnh bìa (chuẩn FormChienDich) ── */
.img-placeholder {
    width: 100%; height: 110px;
    border: 2px dashed var(--border); border-radius: var(--r);
    display: flex; align-items: center; justify-content: center;
    color: var(--txt-sub); font-size: 12px; margin-bottom: 10px;
}
#imgPreviewBox { display: none; margin-bottom: 8px; }
#imgPreviewBox img {
    max-width: 100%; max-height: 160px;
    border-radius: var(--r); border: 1px solid var(--border);
    object-fit: cover;
}

/* ── Danh mục button group (chuẩn seg-btn-group) ── */
.dm-btn-group {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    margin-top: 4px;
}
.dm-btn {
    padding: 5px 13px;
    border: 1px solid var(--border);
    border-radius: var(--r);
    background: var(--bg);
    font-family: var(--font);
    font-size: 12px;
    font-weight: 500;
    color: var(--txt-sub);
    cursor: pointer;
    transition: all .15s;
}
.dm-btn:hover  { background: #e2e8f0; color: var(--txt); }
.dm-btn.active {
    background: var(--accent); color: #fff;
    border-color: var(--accent); font-weight: 600;
}

/* ── Status toggle (chuẩn seg-btn) ── */
.status-toggle {
    display: flex; border: 1px solid var(--border); border-radius: var(--r);
    overflow: hidden; margin-bottom: 14px;
}
.status-opt {
    flex: 1; height: 36px; border: none; background: var(--bg);
    font-family: var(--font); font-size: 12px; font-weight: 500;
    color: var(--txt-sub); cursor: pointer;
    transition: background .15s, color .15s;
}
.status-opt + .status-opt { border-left: 1px solid var(--border); }
.status-opt.active-pub   { background: var(--ok);     color: #fff; font-weight: 600; }
.status-opt.active-draft { background: var(--warn-bg); color: var(--warn-txt); font-weight: 600; }

/* ── Buttons (chuẩn FormChienDich) ── */
.btn-luu {
    height: 38px; padding: 0 18px;
    border-radius: var(--r);
    font-size: 13px; font-family: var(--font); font-weight: 500;
    cursor: pointer; width: 100%; margin-bottom: 8px;
    border: none; background: var(--accent); color: #fff;
    transition: background .15s;
}
.btn-luu:hover { background: #2B6CB0; }

.btn-huy {
    display: flex; align-items: center; justify-content: center;
    height: 38px; padding: 0 18px;
    border-radius: var(--r);
    font-size: 13px; font-family: var(--font); font-weight: 500;
    cursor: pointer; width: 100%;
    border: 1px solid var(--border); background: transparent; color: var(--txt-sub);
    text-decoration: none;
    transition: background .15s, color .15s;
}
.btn-huy:hover { background: var(--bg); color: var(--txt); }

/* ── Meta box ── */
.meta-box      { font-size: 12px; color: var(--txt-sub); }
.meta-box .meta-title { font-size: 13px; font-weight: 600; color: var(--txt); margin-bottom: 8px; }
.meta-row      { margin-bottom: 4px; }
.meta-row b    { color: var(--txt); font-weight: 600; }

/* ── Toast ── */
#toastWrap {
    position: fixed; top: 64px; right: 18px; z-index: 9999;
    display: flex; flex-direction: column; gap: 8px; pointer-events: none;
}
.toast-item {
    display: flex; align-items: flex-start; gap: 10px;
    background: #fff; border: 1px solid var(--border);
    border-left-width: 4px; border-radius: var(--r-card);
    padding: 10px 14px; min-width: 260px; max-width: 340px;
    pointer-events: all; box-shadow: 0 2px 10px rgba(0,0,0,.08);
    animation: toastIn .2s ease;
}
.toast-item.toast-ok  { border-left-color: var(--ok); }
.toast-item.toast-err { border-left-color: var(--err); }
.toast-item .t-msg    { font-size: 13px; color: var(--txt); flex: 1; }
.toast-item .t-close  { font-size: 16px; color: var(--txt-sub); cursor: pointer; line-height: 1; }
@keyframes toastIn { from { opacity:0; transform:translateX(12px); } to { opacity:1; transform:none; } }

/* ── Responsive ── */
@media (max-width: 1024px) {
    .form-grid { grid-template-columns: 1fr 260px; gap: 16px; }
}
@media (max-width: 768px) {
    .form-grid    { grid-template-columns: 1fr; }
    .rte-toolbar  { gap: 4px; }
    .seo-title    { font-size: 14px; }
    .dm-btn-group { gap: 5px; }
}
@media (max-width: 480px) {
    .page-title    { font-size: 17px; }
    .rte-btn       { min-width: 26px; height: 26px; font-size: 11px; }
    .dm-btn        { font-size: 11px; padding: 4px 10px; }
    .status-toggle { flex-direction: column; }
    .status-opt + .status-opt { border-left: none; border-top: 1px solid var(--border); }
}
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1 id="topBarH1">Thêm bài viết mới</h1>
    <p  id="topBarSub">Soạn thảo và xuất bản bài viết</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="toastWrap"></div>

<div class="breadcrumb">
    <a href="/Admin/QuanLyTinTuc.aspx">Quản lý Tin tức</a> /
    <span id="breadcrumbCurrent">Thêm mới</span>
</div>
<div class="page-title" id="pageTitle">Thêm bài viết mới</div>

<div class="form-grid">

    <%-- CỘT TRÁI --%>
    <div>

        <div class="admin-card">
            <div class="card-section-title">Nội dung bài viết</div>

            <div class="form-group">
                <label class="form-label">Tiêu đề <span class="req">*</span></label>
                <input type="text" id="txtTieuDe" class="form-control" maxlength="250"
                       placeholder="Nhập tiêu đề bài viết..."
                       oninput="onTieuDeChange()" />
                <div class="char-counter" id="charTieuDe">0 / 250</div>
            </div>

            <div class="form-group">
                <label class="form-label">Tóm tắt</label>
                <textarea id="txtTomTat" class="form-control" rows="3" maxlength="400"
                          placeholder="Mô tả ngắn hiển thị trên danh sách (tối đa 400 ký tự)..."
                          oninput="onTomTatChange()"></textarea>
                <div class="char-counter" id="charTomTat">0 / 400</div>
            </div>

            <div class="form-group">
                <label class="form-label">Nội dung chi tiết <span class="req">*</span></label>
                <div class="rte-toolbar">
                    <button class="rte-btn" title="In đậm" onclick="insertTag('b')"><b>B</b></button>
                    <button class="rte-btn" title="In nghiêng" onclick="insertTag('i')"><i>I</i></button>
                    <button class="rte-btn" title="Gạch chân" onclick="insertTag('u')"><u>U</u></button>
                    <div class="rte-sep"></div>
                    <button class="rte-btn" title="Tiêu đề H2" onclick="insertTag('h2')">H2</button>
                    <button class="rte-btn" title="Tiêu đề H3" onclick="insertTag('h3')">H3</button>
                    <div class="rte-sep"></div>
                    <button class="rte-btn" title="Danh sách" onclick="insertList()">List</button>
                    <button class="rte-btn" title="Trích dẫn" onclick="insertTag('blockquote')">Quote</button>
                    <div class="rte-sep"></div>
                    <button class="rte-btn" title="Chèn link" onclick="insertLink()">Link</button>
                    <button class="rte-btn" title="Chèn ảnh"  onclick="insertImg()">Img</button>
                </div>
                <textarea id="txtNoiDung" class="rte-area"
                          placeholder="Nhập nội dung đầy đủ...&#10;(Hỗ trợ HTML tags)"></textarea>
                <div class="form-hint">Hỗ trợ HTML.</div>
            </div>
        </div>

        <div class="admin-card">
            <div class="card-section-title">Xem trước SEO</div>
            <div class="seo-preview">
                <div class="seo-preview-label">Google Search Preview</div>
                <div class="seo-title"  id="seoTitle">Tiêu đề bài viết — Thiện Nguyện Việt</div>
                <div class="seo-url">thiennguyen.vn/chi-tiet-tin-tuc?id=...</div>
                <div class="seo-desc"  id="seoDesc">Tóm tắt bài viết sẽ hiển thị ở đây...</div>
            </div>
        </div>

    </div>

    <%-- CỘT PHẢI --%>
    <div>

        <%-- Ảnh bìa --%>
        <div class="admin-card">
            <div class="card-section-title">Ảnh bìa</div>

            <div id="imgPlaceholder" class="img-placeholder">Chưa có ảnh bìa</div>
            <div id="imgPreviewBox"><img id="imgPreview" src="" alt="Ảnh bìa" /></div>

            <div class="form-group">
                <label class="form-label">Tải ảnh lên</label>
                <input type="file" id="fuAnhBia" accept="image/*" style="font-size:12px"
                       onchange="previewAnhBia(this)" />
                <div class="form-hint">JPG, PNG — nên dùng 1200×630px</div>
            </div>

            <div class="form-group">
                <label class="form-label">Hoặc nhập URL</label>
                <input type="text" id="txtAnhBia" class="form-control" maxlength="255"
                       placeholder="Nhập URL..."
                       oninput="previewAnhBiaUrl(this.value)" />
            </div>
        </div>

        <%-- Phân loại — 4 nút button --%>
        <div class="admin-card">
            <div class="card-section-title">Phân loại</div>

            <div class="form-group">
                <label class="form-label">Danh mục <span class="req">*</span></label>
                <div class="dm-btn-group" id="dmBtnGroup">
                    <button type="button" class="dm-btn" data-val="1" onclick="setDanhMuc(this,1)">Hoạt động TN</button>
                    <button type="button" class="dm-btn" data-val="2" onclick="setDanhMuc(this,2)">Cảm hứng</button>
                    <button type="button" class="dm-btn" data-val="3" onclick="setDanhMuc(this,3)">Thông báo</button>
                </div>
                <input type="hidden" id="hdnMaDanhMuc" value="" />
            </div>

            <div class="form-group">
                <label class="form-label">Ngày đăng</label>
                <input type="date" id="txtNgayDang" class="form-control" />
            </div>
        </div>

        <%-- Xuất bản --%>
        <div class="admin-card">
            <div class="card-section-title">Xuất bản</div>

            <div class="form-group">
                <label class="form-label">Trạng thái</label>
                <div class="status-toggle">
                    <button class="status-opt active-pub" id="btnPub"   onclick="setStatus(1)">Đăng ngay</button>
                    <button class="status-opt"            id="btnDraft" onclick="setStatus(0)">Lưu nháp</button>
                </div>
                <input type="hidden" id="hdnTrangThai" value="1" />
            </div>

            <button class="btn-luu" onclick="luuBaiViet()">Lưu bài viết</button>
            <a href="/Admin/QuanLyTinTuc.aspx" class="btn-huy">Hủy, quay lại</a>
        </div>

        <%-- Meta (edit mode) --%>
        <div id="panelMeta" class="admin-card meta-box" style="display:none">
            <div class="meta-title">Thông tin bài viết</div>
            <div class="meta-row">Mã: #<b id="metaMa"></b></div>
            <div class="meta-row">Tác giả: <b id="metaTacGia"></b></div>
            <div class="meta-row">Ngày tạo: <b id="metaNgayTao"></b></div>
            <div class="meta-row">Lượt xem: <b id="metaLuotXem"></b></div>
        </div>

    </div>

</div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';

        /* ── State ──────────────────────────────────────────────────── */
        var urlParams = new URLSearchParams(window.location.search);
        var editId = parseInt(urlParams.get('id') || '0');
        var isEditMode = editId > 0;
        var selectedDanhMuc = 0;

        /* ── Toast ──────────────────────────────────────────────────── */
        function showToast(msg, type) {
            var wrap = document.getElementById('toastWrap');
            var t = document.createElement('div');
            t.className = 'toast-item toast-' + (type || 'ok');
            t.innerHTML = '<span class="t-msg">' + msg + '</span><span class="t-close" onclick="this.parentElement.remove()">×</span>';
            wrap.appendChild(t);
            setTimeout(function () { t.style.transition = 'opacity .3s'; t.style.opacity = '0'; setTimeout(function () { t.remove(); }, 350); }, 4500);
        }

        /* ── Init ────────────────────────────────────────────────────── */
        (function init() {
            document.getElementById('txtNgayDang').value = new Date().toISOString().slice(0, 10);
            if (isEditMode) loadEditData(editId);
        })();

        /* ── Load edit data từ DB ─────────────────────────────────────── */
        function loadEditData(id) {
            fetch(location.pathname + '?__ajax=true&action=get&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) { showToast('Không tìm thấy bài viết #' + id, 'err'); return; }
                    var d = j.data;

                    document.getElementById('topBarH1').textContent = 'Chỉnh sửa bài viết';
                    document.getElementById('topBarSub').textContent = d.TieuDe;
                    document.getElementById('breadcrumbCurrent').textContent = 'Chỉnh sửa';
                    document.getElementById('pageTitle').textContent = 'Chỉnh sửa bài viết';
                    document.title = 'Sửa tin tức — Admin';

                    document.getElementById('txtTieuDe').value = d.TieuDe || '';
                    document.getElementById('txtTomTat').value = d.TomTat || '';
                    document.getElementById('txtNoiDung').value = d.NoiDung || '';
                    document.getElementById('txtNgayDang').value = d.NgayDang || '';
                    document.getElementById('txtAnhBia').value = d.AnhBia || '';

                    // Danh mục
                    if (d.MaDanhMuc) setDanhMucByVal(d.MaDanhMuc);
                    // Trạng thái
                    setStatus(d.TrangThai);

                    onTieuDeChange(); onTomTatChange(); updateSEO();
                    if (d.AnhBia) previewAnhBiaUrl(d.AnhBia);

                    // Meta
                    document.getElementById('metaMa').textContent = d.MaTinTuc;
                    document.getElementById('metaTacGia').textContent = d.NguoiDang || 'Admin';
                    document.getElementById('metaNgayTao').textContent = d.NgayDang || '—';
                    document.getElementById('metaLuotXem').textContent = (d.LuotXem || 0).toLocaleString('vi-VN') + ' lượt';
                    document.getElementById('panelMeta').style.display = 'block';
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        }

        /* ── Danh mục buttons ─────────────────────────────────────────── */
        window.setDanhMuc = function (btn, val) {
            document.querySelectorAll('#dmBtnGroup .dm-btn').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            selectedDanhMuc = val;
            document.getElementById('hdnMaDanhMuc').value = val;
        };

        function setDanhMucByVal(val) {
            var btn = document.querySelector('#dmBtnGroup .dm-btn[data-val="' + val + '"]');
            if (btn) { btn.click(); }
        }

        /* ── Status toggle ─────────────────────────────────────────────── */
        window.setStatus = function (val) {
            document.getElementById('hdnTrangThai').value = val;
            if (val === 1 || val === '1') {
                document.getElementById('btnPub').className = 'status-opt active-pub';
                document.getElementById('btnDraft').className = 'status-opt';
            } else {
                document.getElementById('btnPub').className = 'status-opt';
                document.getElementById('btnDraft').className = 'status-opt active-draft';
            }
        };

        /* ── Char counters ─────────────────────────────────────────────── */
        window.onTieuDeChange = function () {
            var len = document.getElementById('txtTieuDe').value.length;
            var el = document.getElementById('charTieuDe');
            el.textContent = len + ' / 250';
            el.className = 'char-counter' + (len > 250 ? ' over' : '');
            updateSEO();
        };
        window.onTomTatChange = function () {
            var len = document.getElementById('txtTomTat').value.length;
            var el = document.getElementById('charTomTat');
            el.textContent = len + ' / 400';
            el.className = 'char-counter' + (len > 400 ? ' over' : '');
            updateSEO();
        };

        /* ── SEO Preview ─────────────────────────────────────────────── */
        function updateSEO() {
            var title = document.getElementById('txtTieuDe').value.trim();
            var desc = document.getElementById('txtTomTat').value.trim();
            document.getElementById('seoTitle').textContent = (title || 'Tiêu đề bài viết') + ' — Thiện Nguyện Việt';
            document.getElementById('seoDesc').textContent = desc || 'Tóm tắt bài viết sẽ hiển thị ở đây...';
        }

        /* ── Image preview ───────────────────────────────────────────── */
        window.previewAnhBia = function (input) {
            if (input.files && input.files[0]) showImgPreview(URL.createObjectURL(input.files[0]));
        };
        window.previewAnhBiaUrl = function (url) {
            if (url) showImgPreview(url); else hideImgPreview();
        };
        function showImgPreview(url) {
            document.getElementById('imgPreview').src = url;
            document.getElementById('imgPreviewBox').style.display = 'block';
            document.getElementById('imgPlaceholder').style.display = 'none';
        }
        function hideImgPreview() {
            document.getElementById('imgPreviewBox').style.display = 'none';
            document.getElementById('imgPlaceholder').style.display = 'flex';
        }

        /* ── RTE toolbar helpers ─────────────────────────────────────── */
        window.insertTag = function (tag) {
            var ta = document.getElementById('txtNoiDung');
            var s = ta.selectionStart, e = ta.selectionEnd;
            var sel = ta.value.substring(s, e) || 'nội dung';
            ta.value = ta.value.substring(0, s) + '<' + tag + '>' + sel + '</' + tag + '>' + ta.value.substring(e);
            ta.focus();
        };
        window.insertList = function () {
            var ta = document.getElementById('txtNoiDung');
            ta.value += '\n<ul>\n  <li>Mục 1</li>\n  <li>Mục 2</li>\n</ul>\n';
            ta.focus();
        };
        window.insertLink = function () {
            var url = prompt('Nhập URL:', 'https://'); if (!url) return;
            var txt = prompt('Chữ hiển thị:', 'Xem thêm'); if (!txt) return;
            insertRaw('<a href="' + url + '">' + txt + '</a>');
        };
        window.insertImg = function () {
            var url = prompt('Nhập URL ảnh:', ''); if (!url) return;
            insertRaw('<img src="' + url + '" alt="Ảnh minh họa" style="max-width:100%" />');
        };
        function insertRaw(str) {
            var ta = document.getElementById('txtNoiDung');
            var pos = ta.selectionStart;
            ta.value = ta.value.substring(0, pos) + str + ta.value.substring(pos);
            ta.focus();
        }

        /* ── Lưu bài viết → gọi backend ─────────────────────────────── */
        window.luuBaiViet = function () {
            var tieuDe = document.getElementById('txtTieuDe').value.trim();
            var noiDung = document.getElementById('txtNoiDung').value.trim();
            var danhMuc = document.getElementById('hdnMaDanhMuc').value;

            if (!tieuDe) { showToast('Vui lòng nhập tiêu đề bài viết.', 'err'); return; }
            if (!danhMuc) { showToast('Vui lòng chọn danh mục.', 'err'); return; }
            if (!noiDung) { showToast('Vui lòng nhập nội dung bài viết.', 'err'); return; }

            var payload = new URLSearchParams({
                __ajax: 'true',
                action: isEditMode ? 'update' : 'insert',
                id: editId,
                tieuDe: tieuDe,
                tomTat: document.getElementById('txtTomTat').value.trim(),
                noiDung: noiDung,
                maDanhMuc: danhMuc,
                anhBia: document.getElementById('txtAnhBia').value.trim(),
                ngayDang: document.getElementById('txtNgayDang').value,
                trangThai: document.getElementById('hdnTrangThai').value
            });

            fetch(location.pathname + '?' + payload)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) {
                        var label = isEditMode ? 'Đã cập nhật' : 'Đã lưu';
                        showToast(label + ' bài viết "' + tieuDe.substring(0, 40) + (tieuDe.length > 40 ? '...' : '') + '" thành công!', 'ok');
                        if (!isEditMode) {
                            setTimeout(function () { window.location.href = '/Admin/QuanLyTinTuc.aspx'; }, 1500);
                        }
                    } else {
                        showToast(j.msg || 'Lỗi khi lưu bài viết.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };

    })();
</script>
</asp:Content>
