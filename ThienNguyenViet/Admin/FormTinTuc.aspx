<%@ Page Title="Bài viết" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="FormTinTuc.aspx.cs"
         Inherits="ThienNguyenViet.Admin.FormTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   FORM TIN TỨC — PAGE STYLES
══════════════════════════════════════════════════════════════ */
.breadcrumb   { font-size: 12px; color: var(--admin-chu-phu); margin-bottom: 4px; }
.breadcrumb a { color: #3182CE; text-decoration: none; }
.breadcrumb a:hover { text-decoration: underline; }
.page-title   { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); margin-bottom: 20px; }

/* 2-column layout */
.form-grid {
    display: grid; grid-template-columns: 1fr 300px;
    gap: 20px; align-items: start;
}

/* Form controls */
.card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 16px; }
.form-group          { margin-bottom: 16px; }
.form-group:last-child { margin-bottom: 0; }
.form-label          { display: block; font-size: 12px; font-weight: 600; color: var(--admin-chu-chinh); margin-bottom: 5px; }
.form-label .req     { color: #E53E3E; margin-left: 2px; }
.form-control {
    width: 100%; height: 36px; padding: 0 10px;
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); color: var(--admin-chu-chinh);
    outline: none; box-sizing: border-box; transition: border-color .15s;
}
.form-control:focus { border-color: #3182CE; box-shadow: 0 0 0 3px rgba(49,130,206,.1); }
textarea.form-control { height: auto; padding: 8px 10px; resize: vertical; line-height: 1.55; }
select.form-control   { background: #fff; cursor: pointer; }

.form-hint { font-size: 11px; color: var(--admin-chu-phu); margin-top: 4px; }

/* Rich text editor mock */
.rte-toolbar {
    display: flex; flex-wrap: wrap; gap: 4px;
    padding: 8px 10px; background: var(--admin-nen);
    border: 1px solid var(--admin-vien); border-bottom: none;
    border-radius: var(--r-nut) var(--r-nut) 0 0;
}
.rte-btn {
    height: 26px; min-width: 26px; padding: 0 7px;
    background: var(--admin-card); border: 1px solid var(--admin-vien);
    border-radius: 4px; font-size: 12px; cursor: pointer; font-family: var(--font);
    color: var(--admin-chu-chinh); transition: background .12s;
    display: flex; align-items: center; justify-content: center;
}
.rte-btn:hover { background: #EBF8FF; color: #2B6CB0; border-color: #3182CE; }
.rte-sep { width: 1px; background: var(--admin-vien); margin: 0 3px; align-self: stretch; }
.rte-area {
    width: 100%; min-height: 280px; padding: 12px 14px;
    border: 1px solid var(--admin-vien); border-radius: 0 0 var(--r-nut) var(--r-nut);
    font-size: 13px; font-family: var(--font); line-height: 1.7;
    color: var(--admin-chu-chinh); outline: none; box-sizing: border-box;
    resize: vertical;
}
.rte-area:focus { border-color: #3182CE; }

/* Char counter */
.char-counter { text-align: right; font-size: 11px; color: var(--admin-chu-phu); margin-top: 4px; }
.char-counter.over { color: #E53E3E; }

/* Image preview */
.img-placeholder {
    width: 100%; height: 120px; border: 2px dashed var(--admin-vien);
    border-radius: var(--r-nut); display: flex; align-items: center;
    justify-content: center; color: var(--admin-chu-phu); font-size: 12px; margin-bottom: 10px;
}
#imgPreviewBox { display: none; margin-bottom: 8px; }
#imgPreviewBox img {
    max-width: 100%; max-height: 180px; border-radius: var(--r-nut);
    border: 1px solid var(--admin-vien); object-fit: cover;
}

/* SEO preview box */
.seo-preview {
    background: var(--admin-nen); border-radius: var(--r-nut);
    border: 1px solid var(--admin-vien); padding: 12px 14px; font-size: 12px;
}
.seo-preview .seo-title   { font-size: 16px; color: #1a0dab; margin-bottom: 3px; line-height: 1.3; }
.seo-preview .seo-url     { color: #006621; font-size: 11px; margin-bottom: 4px; }
.seo-preview .seo-desc    { color: #545454; line-height: 1.5; }
.seo-preview-label        { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing:.06em; color: var(--admin-chu-phu); margin-bottom: 6px; }

/* Action buttons */
.btn-luu {
    height: 36px; padding: 0 20px; background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 600; cursor: pointer; width: 100%; margin-bottom: 8px;
}
.btn-luu:hover { background: #2B6CB0; }
.btn-nhap {
    height: 36px; padding: 0 16px; background: #EBF8FF; color: #2B6CB0;
    border: 1px solid #BEE3F8; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer; width: 100%; margin-bottom: 8px;
}
.btn-nhap:hover { background: #BEE3F8; }
.btn-huy {
    height: 36px; background: transparent; color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); text-decoration: none;
    display: flex; align-items: center; justify-content: center; width: 100%; box-sizing: border-box;
}
.btn-huy:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }

/* Meta info */
.meta-box     { font-size: 12px; color: var(--admin-chu-phu); }
.meta-title   { font-size: 13px; font-weight: 600; color: var(--admin-chu-chinh); margin-bottom: 8px; }
.meta-row     { margin-bottom: 4px; }
.meta-row b   { color: var(--admin-chu-chinh); }

/* Alerts */
.alert-success { padding:10px 14px; background:#C6F6D5; color:#276749; border-radius:var(--r-nut); font-size:13px; margin-bottom:16px; display:none; }
.alert-error   { padding:10px 14px; background:#FED7D7; color:#C53030; border-radius:var(--r-nut); font-size:13px; margin-bottom:16px; display:none; }

/* Status toggle */
.status-toggle {
    display: flex; gap: 8px; margin-bottom: 4px;
}
.status-opt {
    flex: 1; height: 34px; border-radius: var(--r-nut);
    border: 1px solid var(--admin-vien); background: var(--admin-nen);
    font-size: 12px; font-family: var(--font); font-weight: 500;
    cursor: pointer; color: var(--admin-chu-phu); transition: all .15s;
}
.status-opt.active-pub   { background: #C6F6D5; color: #276749; border-color: #9AE6B4; }
.status-opt.active-draft { background: #EBF8FF; color: #2B6CB0; border-color: #BEE3F8; }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1 id="topBarH1">Thêm bài viết mới</h1>
    <p  id="topBarSub">Soạn thảo và xuất bản bài viết</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="alertSuccess" class="alert-success"></div>
    <div id="alertError"   class="alert-error"></div>

    <div class="breadcrumb">
        <a href="/Admin/QuanLyTinTuc.aspx">Quản lý Tin tức</a> /
        <span id="breadcrumbCurrent">Thêm mới</span>
    </div>
    <div class="page-title" id="pageTitle">Thêm bài viết mới</div>

    <div class="form-grid">

        <%-- ═══ CỘT TRÁI ═══ --%>
        <div>

            <%-- Nội dung chính --%>
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

                    <%-- Toolbar giả lập rich text --%>
                    <div class="rte-toolbar">
                        <button class="rte-btn" title="In đậm" onclick="insertTag('b')"><b>B</b></button>
                        <button class="rte-btn" title="In nghiêng" onclick="insertTag('i')"><i>I</i></button>
                        <button class="rte-btn" title="Gạch chân" onclick="insertTag('u')"><u>U</u></button>
                        <div class="rte-sep"></div>
                        <button class="rte-btn" title="Tiêu đề H2" onclick="insertTag('h2')">H2</button>
                        <button class="rte-btn" title="Tiêu đề H3" onclick="insertTag('h3')">H3</button>
                        <div class="rte-sep"></div>
                        <button class="rte-btn" title="Danh sách" onclick="insertList()">≡</button>
                        <button class="rte-btn" title="Trích dẫn" onclick="insertTag('blockquote')">❝</button>
                        <div class="rte-sep"></div>
                        <button class="rte-btn" title="Chèn link" onclick="insertLink()">🔗</button>
                        <button class="rte-btn" title="Chèn ảnh"  onclick="insertImg()">🖼</button>
                    </div>
                    <textarea id="txtNoiDung" class="rte-area"
                              placeholder="Nhập nội dung đầy đủ...&#10;(Hỗ trợ HTML tags)"></textarea>
                    <div class="form-hint">Hỗ trợ HTML. Toolbar phía trên chèn tag mẫu để tham khảo.</div>
                </div>
            </div>

            <%-- SEO Preview --%>
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

        <%-- ═══ CỘT PHẢI ═══ --%>
        <div>

            <%-- Ảnh bìa --%>
            <div class="admin-card">
                <div class="card-section-title">Ảnh bìa</div>

                <div id="imgPlaceholder" class="img-placeholder">🖼 Chưa có ảnh bìa</div>
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
                           placeholder="/Uploads/TinTuc/..."
                           oninput="previewAnhBiaUrl(this.value)" />
                </div>
            </div>

            <%-- Phân loại & trạng thái --%>
            <div class="admin-card">
                <div class="card-section-title">Phân loại</div>

                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <select id="selDanhMuc" class="form-control">
                        <option value="">-- Chọn danh mục --</option>
                        <option value="1">Hoạt động thiện nguyện</option>
                        <option value="2">Câu chuyện truyền cảm hứng</option>
                        <option value="3">Thông báo</option>
                    </select>
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
                        <button class="status-opt active-pub" id="btnPub"   onclick="setStatus(1)">✅ Đăng ngay</button>
                        <button class="status-opt"            id="btnDraft" onclick="setStatus(0)">📝 Lưu nháp</button>
                    </div>
                    <input type="hidden" id="hdnTrangThai" value="1" />
                </div>

                <button class="btn-luu"  onclick="luuBaiViet(false)">💾 Lưu bài viết</button>
                <button class="btn-nhap" onclick="luuBaiViet(true)">📝 Lưu nháp</button>
                <a href="/Admin/QuanLyTinTuc.aspx" class="btn-huy">✕ Hủy, quay lại</a>
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
/* ══════════════════════════════════════════════════════════════
   MOCK DATA khớp SampleData.sql
══════════════════════════════════════════════════════════════ */
var MOCK_TINTUC = {
    1: {
        id: 1, tieuDe: 'Thiện Nguyện Việt trao 500 phần quà cho bà con miền Trung',
        maDanhMuc: '1', tomTat: 'Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình...',
        noiDung: '<p>Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình để trao tận tay 500 phần quà cho người dân vùng lũ.</p>',
        anhBia: null, trangThai: 1, ngayDang: '2026-03-07',
        tacGia: 'Admin', ngayTao: '07/03/2026', luotXem: 1240
    },
    2: {
        id: 2, tieuDe: 'Cậu bé 8 tuổi được cứu sống nhờ ca phẫu thuật tim từ quỹ từ thiện',
        maDanhMuc: '2', tomTat: 'Em Nguyễn Văn Khôi (8 tuổi, Cần Thơ) mắc bệnh tim bẩm sinh từ nhỏ. Nhờ sự hỗ trợ của chương trình, em đã được phẫu thuật thành công.',
        noiDung: '<p>Em Nguyễn Văn Khôi sinh ra đã mang trong mình căn bệnh tim bẩm sinh...</p>',
        anhBia: null, trangThai: 1, ngayDang: '2026-02-20',
        tacGia: 'Admin', ngayTao: '20/02/2026', luotXem: 3580
    },
    3: {
        id: 3, tieuDe: 'Thông báo: Mở đăng ký tình nguyện viên đợt 2 năm 2026',
        maDanhMuc: '3', tomTat: 'Thiện Nguyện Việt mở đăng ký tình nguyện viên cho các chuyến đi thiện nguyện tháng 4 và 5/2026.',
        noiDung: '<p>Để đáp ứng nhu cầu ngày càng tăng của các chiến dịch, chúng tôi mở đăng ký tình nguyện viên đợt 2...</p>',
        anhBia: null, trangThai: 1, ngayDang: '2026-03-12',
        tacGia: 'Admin', ngayTao: '12/03/2026', luotXem: 892
    },
    4: {
        id: 4, tieuDe: '10.000 cây xanh sẽ được trồng tại Hà Nội trong tháng 4',
        maDanhMuc: '1', tomTat: 'Dự án trồng cây xanh do Thiện Nguyện Việt phối hợp với Trung tâm Bảo tồn Thiên nhiên Việt sẽ chính thức khởi động vào ngày 05/04/2026.',
        noiDung: '<p>Dự án trồng 10.000 cây xanh tại các quận ngoại thành Hà Nội chính thức khởi động...</p>',
        anhBia: null, trangThai: 1, ngayDang: '2026-03-14',
        tacGia: 'Admin', ngayTao: '14/03/2026', luotXem: 456
    }
};

/* ── Init ───────────────────────────────────────────────────── */
var urlParams  = new URLSearchParams(window.location.search);
var editId     = parseInt(urlParams.get('id') || '0');
var isEditMode = editId > 0;

(function init() {
    document.getElementById('txtNgayDang').value = new Date().toISOString().slice(0,10);

    if (isEditMode && MOCK_TINTUC[editId]) {
        loadEditMode(editId);
    }
})();

function loadEditMode(id) {
    var t = MOCK_TINTUC[id];
    if (!t) { showError('Không tìm thấy bài viết #' + id); return; }

    document.getElementById('topBarH1').textContent          = 'Chỉnh sửa bài viết';
    document.getElementById('topBarSub').textContent         = t.tieuDe;
    document.getElementById('breadcrumbCurrent').textContent = 'Chỉnh sửa';
    document.getElementById('pageTitle').textContent         = 'Chỉnh sửa bài viết';
    document.title = 'Sửa tin tức — Admin';

    document.getElementById('txtTieuDe').value   = t.tieuDe;
    document.getElementById('txtTomTat').value   = t.tomTat;
    document.getElementById('txtNoiDung').value  = t.noiDung;
    document.getElementById('selDanhMuc').value  = t.maDanhMuc;
    document.getElementById('txtNgayDang').value = t.ngayDang;
    document.getElementById('txtAnhBia').value   = t.anhBia || '';

    setStatus(t.trangThai);
    onTieuDeChange(); onTomTatChange();
    updateSEO();

    if (t.anhBia) previewAnhBiaUrl(t.anhBia);

    // Meta
    document.getElementById('metaMa').textContent      = t.id;
    document.getElementById('metaTacGia').textContent  = t.tacGia;
    document.getElementById('metaNgayTao').textContent = t.ngayTao;
    document.getElementById('metaLuotXem').textContent = t.luotXem.toLocaleString('vi-VN') + ' lượt';
    document.getElementById('panelMeta').style.display = 'block';
}

/* ── Status toggle ──────────────────────────────────────────── */
function setStatus(val) {
    document.getElementById('hdnTrangThai').value = val;
    if (val === 1) {
        document.getElementById('btnPub').className   = 'status-opt active-pub';
        document.getElementById('btnDraft').className = 'status-opt';
    } else {
        document.getElementById('btnPub').className   = 'status-opt';
        document.getElementById('btnDraft').className = 'status-opt active-draft';
    }
}

/* ── Char counter ────────────────────────────────────────────── */
function onTieuDeChange() {
    var len = document.getElementById('txtTieuDe').value.length;
    var el  = document.getElementById('charTieuDe');
    el.textContent = len + ' / 250';
    el.className   = 'char-counter' + (len > 250 ? ' over' : '');
    updateSEO();
}
function onTomTatChange() {
    var len = document.getElementById('txtTomTat').value.length;
    var el  = document.getElementById('charTomTat');
    el.textContent = len + ' / 400';
    el.className   = 'char-counter' + (len > 400 ? ' over' : '');
    updateSEO();
}

/* ── SEO Preview ─────────────────────────────────────────────── */
function updateSEO() {
    var title = document.getElementById('txtTieuDe').value.trim();
    var desc  = document.getElementById('txtTomTat').value.trim();
    document.getElementById('seoTitle').textContent =
        (title || 'Tiêu đề bài viết') + ' — Thiện Nguyện Việt';
    document.getElementById('seoDesc').textContent  =
        desc || 'Tóm tắt bài viết sẽ hiển thị ở đây...';
}

/* ── Image preview ───────────────────────────────────────────── */
function previewAnhBia(input) {
    if (!input.files || !input.files[0]) return;
    showImgPreview(URL.createObjectURL(input.files[0]));
}
function previewAnhBiaUrl(url) {
    if (!url) { hideImgPreview(); return; }
    showImgPreview(url);
}
function showImgPreview(url) {
    document.getElementById('imgPreview').src                 = url;
    document.getElementById('imgPreviewBox').style.display   = 'block';
    document.getElementById('imgPlaceholder').style.display  = 'none';
}
function hideImgPreview() {
    document.getElementById('imgPreviewBox').style.display   = 'none';
    document.getElementById('imgPlaceholder').style.display  = 'flex';
}

/* ── RTE toolbar helpers ─────────────────────────────────────── */
function insertTag(tag) {
    var ta = document.getElementById('txtNoiDung');
    var start = ta.selectionStart, end = ta.selectionEnd;
    var sel  = ta.value.substring(start, end) || 'nội dung';
    var ins  = '<' + tag + '>' + sel + '</' + tag + '>';
    ta.value = ta.value.substring(0, start) + ins + ta.value.substring(end);
    ta.focus();
}
function insertList() {
    var ta = document.getElementById('txtNoiDung');
    var ins = '\n<ul>\n  <li>Mục 1</li>\n  <li>Mục 2</li>\n</ul>\n';
    ta.value += ins; ta.focus();
}
function insertLink() {
    var url  = prompt('Nhập URL:', 'https://');
    if (!url) return;
    var text = prompt('Chữ hiển thị:', 'Xem thêm');
    if (!text) return;
    insertRaw('<a href="' + url + '">' + text + '</a>');
}
function insertImg() {
    var url = prompt('Nhập URL ảnh:', '/Uploads/TinTuc/');
    if (!url) return;
    insertRaw('<img src="' + url + '" alt="Ảnh minh họa" style="max-width:100%" />');
}
function insertRaw(str) {
    var ta = document.getElementById('txtNoiDung');
    var pos = ta.selectionStart;
    ta.value = ta.value.substring(0, pos) + str + ta.value.substring(pos);
    ta.focus();
}

/* ── Lưu ─────────────────────────────────────────────────────── */
function luuBaiViet(forceNhap) {
    var tieuDe  = document.getElementById('txtTieuDe').value.trim();
    var noiDung = document.getElementById('txtNoiDung').value.trim();
    var danhMuc = document.getElementById('selDanhMuc').value;

    if (!tieuDe)  { showError('Vui lòng nhập tiêu đề bài viết.'); return; }
    if (!danhMuc) { showError('Vui lòng chọn danh mục.'); return; }
    if (!noiDung) { showError('Vui lòng nhập nội dung bài viết.'); return; }

    var trangThai = forceNhap ? 0 : parseInt(document.getElementById('hdnTrangThai').value);

    if (isEditMode) {
        showSuccess('✓ Đã cập nhật bài viết "' + tieuDe.substring(0,40) + (tieuDe.length>40?'...':'') + '" thành công!');
    } else {
        showSuccess('✓ Đã ' + (trangThai === 1 ? 'đăng' : 'lưu nháp') + ' bài viết thành công!');
        setTimeout(function() { window.location.href = '/Admin/QuanLyTinTuc.aspx'; }, 1500);
    }
}

/* ── Alerts ──────────────────────────────────────────────────── */
function showSuccess(msg) {
    var el = document.getElementById('alertSuccess');
    el.textContent = msg; el.style.display = 'block';
    document.getElementById('alertError').style.display = 'none';
    window.scrollTo({ top: 0, behavior: 'smooth' });
    setTimeout(function(){ el.style.display = 'none'; }, 4000);
}
function showError(msg) {
    var el = document.getElementById('alertError');
    el.textContent = msg; el.style.display = 'block';
    document.getElementById('alertSuccess').style.display = 'none';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}
</script>
</asp:Content>
