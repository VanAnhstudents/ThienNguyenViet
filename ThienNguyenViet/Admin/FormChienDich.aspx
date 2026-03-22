<%@ Page Title="Chiến dịch" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="FormChienDich.aspx.cs"
         Inherits="ThienNguyenViet.Admin.FormChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .breadcrumb   { font-size: 12px; color: var(--admin-chu-phu); margin-bottom: 4px; }
        .breadcrumb a { color: #3182CE; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }
        .page-title   { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); margin-bottom: 20px; }

        /* Layout 2 cột */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 20px;
            align-items: start;
        }

        /* Form group */
        .form-group          { margin-bottom: 16px; }
        .form-group:last-child { margin-bottom: 0; }
        .form-label          { display: block; font-size: 12px; font-weight: 600; color: var(--admin-chu-chinh); margin-bottom: 5px; }
        .form-label .req     { color: #E53E3E; margin-left: 2px; }

        .form-control {
            width: 100%; height: 36px;
            padding: 0 10px;
            border: 1px solid var(--admin-vien);
            border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font);
            color: var(--admin-chu-chinh);
            outline: none; box-sizing: border-box;
        }
        .form-control:focus  { border-color: #3182CE; box-shadow: 0 0 0 3px rgba(49,130,206,.1); }
        textarea.form-control { height: auto; padding: 8px 10px; resize: vertical; line-height: 1.5; }
        select.form-control   { background: #fff; cursor: pointer; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

        .section-divider {
            font-size: 11px; font-weight: 600;
            color: var(--admin-chu-phu);
            text-transform: uppercase; letter-spacing: .06em;
            padding: 12px 0 8px;
            border-top: 1px solid var(--admin-vien); margin-top: 4px;
        }
        .card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 16px; }

        /* Checkbox */
        .checkbox-row { display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer; }
        .checkbox-row input[type=checkbox] { width:16px; height:16px; accent-color:#3182CE; cursor:pointer; }

        /* Buttons */
        .btn-luu {
            height: 36px; padding: 0 20px;
            background: #3182CE; color: #fff;
            border: none; border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font); font-weight: 600;
            cursor: pointer; width: 100%; margin-bottom: 8px;
        }
        .btn-luu:hover { background: #2B6CB0; }

        .btn-nhap {
            height: 36px; padding: 0 16px;
            background: #EBF8FF; color: #2B6CB0;
            border: 1px solid #BEE3F8; border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font); font-weight: 500;
            cursor: pointer; width: 100%; margin-bottom: 8px;
        }
        .btn-nhap:hover { background: #BEE3F8; }

        .btn-huy {
            height: 36px;
            background: transparent; color: var(--admin-chu-phu);
            border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font);
            text-decoration: none;
            display: flex; align-items: center; justify-content: center;
            width: 100%; box-sizing: border-box;
        }
        .btn-huy:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }

        /* Ảnh bìa */
        .img-placeholder {
            width: 100%; height: 120px;
            border: 2px dashed var(--admin-vien); border-radius: var(--r-nut);
            display: flex; align-items: center; justify-content: center;
            color: var(--admin-chu-phu); font-size: 12px; margin-bottom: 10px;
        }
        #imgPreviewBox { display: none; margin-bottom: 8px; }
        #imgPreviewBox img {
            max-width: 100%; max-height: 180px;
            border-radius: var(--r-nut); border: 1px solid var(--admin-vien);
            object-fit: cover;
        }

        /* Timeline tiến độ */
        .timeline { display: flex; flex-direction: column; gap: 14px; margin-bottom: 14px; }
        .timeline-item { display: flex; gap: 12px; }
        .timeline-dot  { width:10px; height:10px; border-radius:50%; background:#3182CE; flex-shrink:0; margin-top:4px; }
        .timeline-date  { font-size:11px; color:var(--admin-chu-phu); margin-bottom:2px; }
        .timeline-title { font-size:13px; font-weight:600; color:var(--admin-chu-chinh); }
        .timeline-body  { font-size:12px; color:var(--admin-chu-phu); margin-top:2px; }
        .timeline-empty { font-size:12px; color:var(--admin-chu-phu); text-align:center; padding:16px 0; }

        /* Form tiến độ */
        .tienDo-form {
            background: var(--admin-nen);
            border-radius: var(--r-nut);
            border: 1px solid var(--admin-vien);
            padding: 14px; margin-top: 12px;
        }
        .tienDo-form .form-group { margin-bottom: 10px; }
        .tienDo-form-title { font-size:12px; font-weight:600; color:var(--admin-chu-chinh); margin-bottom:10px; }

        .btn-add-td {
            height: 32px; padding: 0 14px;
            background: #EBF8FF; color: #2B6CB0;
            border: 1px solid #BEE3F8; border-radius: var(--r-nut);
            font-size: 12px; font-family: var(--font); cursor: pointer;
        }
        .btn-add-td:hover { background: #BEE3F8; }

        /* Alerts */
        .alert-success { padding:10px 14px; background:#C6F6D5; color:#276749; border-radius:var(--r-nut); font-size:13px; margin-bottom:16px; }
        .alert-error   { padding:10px 14px; background:#FED7D7; color:#C53030; border-radius:var(--r-nut); font-size:13px; margin-bottom:16px; }
        .form-hint     { font-size:11px; color:var(--admin-chu-phu); margin-top:4px; }

        /* Meta box */
        .meta-box      { font-size:12px; color:var(--admin-chu-phu); }
        .meta-box .meta-title { font-size:13px; font-weight:600; color:var(--admin-chu-chinh); margin-bottom:8px; }
        .meta-row      { margin-bottom:4px; }

        /* Hidden khi thêm mới */
        .edit-only { display: none; }
    </style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1 id="topBarH1">Thêm chiến dịch mới</h1>
    <p  id="topBarSub">Tạo mới chiến dịch thiện nguyện</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Alert --%>
    <div id="alertSuccess" class="alert-success" style="display:none"></div>
    <div id="alertError"   class="alert-error"   style="display:none"></div>

    <%-- Breadcrumb --%>
    <div class="breadcrumb">
        <a href="/Admin/QuanLyChienDich.aspx">Quản lý Chiến dịch</a> /
        <span id="breadcrumbCurrent">Thêm mới</span>
    </div>
    <div class="page-title" id="pageTitle">Thêm chiến dịch mới</div>

    <div class="form-grid">

        <%-- ═══ CỘT TRÁI ═══ --%>
        <div>

            <%-- Thông tin cơ bản --%>
            <div class="admin-card">
                <div class="card-section-title">Thông tin chiến dịch</div>

                <div class="form-group">
                    <label class="form-label">Tên chiến dịch <span class="req">*</span></label>
                    <input type="text" id="txtTen" class="form-control" maxlength="200"
                           placeholder="Nhập tên chiến dịch..." />
                </div>

                <div class="form-group">
                    <label class="form-label">Mô tả ngắn</label>
                    <textarea id="txtMoTa" class="form-control" rows="2" maxlength="300"
                              placeholder="Mô tả ngắn hiển thị trên danh sách (tối đa 300 ký tự)..."></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Nội dung chi tiết</label>
                    <textarea id="txtNoiDung" class="form-control" rows="8"
                              placeholder="Nhập nội dung đầy đủ (hỗ trợ HTML)..."></textarea>
                    <div class="form-hint">Hỗ trợ HTML. Sau này có thể tích hợp rich text editor.</div>
                </div>
            </div>

            <%-- Tài chính & Thời gian --%>
            <div class="admin-card">
                <div class="card-section-title">Tài chính &amp; Thời gian</div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Mục tiêu (VNĐ) <span class="req">*</span></label>
                        <input type="number" id="txtMucTieu" class="form-control" min="0"
                               placeholder="VD: 500000000" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Trạng thái <span class="req">*</span></label>
                        <select id="selTrangThai" class="form-control">
                            <option value="0">Nháp</option>
                            <option value="1" selected>Đang chạy</option>
                            <option value="2">Tạm dừng</option>
                            <option value="3">Đã kết thúc</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Ngày bắt đầu <span class="req">*</span></label>
                        <input type="date" id="txtNgayBD" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ngày kết thúc <span class="req">*</span></label>
                        <input type="date" id="txtNgayKT" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Tổ chức chủ trì</label>
                    <input type="text" id="txtToChuc" class="form-control" maxlength="200"
                           placeholder="VD: Hội Chữ Thập Đỏ Việt Nam" />
                </div>

                <div class="section-divider">Thông tin ngân hàng</div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Tên ngân hàng</label>
                        <input type="text" id="txtNganHang" class="form-control" maxlength="100"
                               placeholder="VD: Vietcombank" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số tài khoản</label>
                        <input type="text" id="txtSTK" class="form-control" maxlength="50"
                               placeholder="1234567890" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Chủ tài khoản</label>
                    <input type="text" id="txtChuTK" class="form-control" maxlength="100"
                           placeholder="Tên chủ tài khoản" />
                </div>
            </div>

            <%-- Cập nhật tiến độ (chỉ hiện khi edit) --%>
            <div id="panelTienDo" class="edit-only">
                <div class="admin-card">
                    <div class="card-section-title">Cập nhật tiến độ</div>

                    <div class="timeline" id="timelineList"></div>
                    <div id="timelineEmpty" class="timeline-empty">Chưa có cập nhật tiến độ nào.</div>

                    <div class="tienDo-form">
                        <div class="tienDo-form-title">＋ Thêm cập nhật tiến độ mới</div>

                        <div class="form-group">
                            <label class="form-label">Tiêu đề <span class="req">*</span></label>
                            <input type="text" id="txtTDTieuDe" class="form-control" maxlength="200"
                                   placeholder="VD: Đợt 1 – Đã trao 200 phần quà tại Quảng Bình" />
                        </div>
                        <div class="form-group">
                            <label class="form-label">Nội dung <span class="req">*</span></label>
                            <textarea id="txtTDNoiDung" class="form-control" rows="3"
                                      placeholder="Mô tả chi tiết..."></textarea>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Ngày đăng</label>
                                <input type="date" id="txtTDNgay" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="form-label">Ảnh minh họa</label>
                                <input type="file" id="fuAnhTD" accept="image/*"
                                       style="font-size:12px;margin-top:6px" />
                                <div class="form-hint">JPG, PNG – tối đa 5MB</div>
                            </div>
                        </div>
                        <button class="btn-add-td" onclick="themTienDo()">Thêm cập nhật</button>
                    </div>
                </div>
            </div>

        </div><%-- /cột trái --%>

        <%-- ═══ CỘT PHẢI ═══ --%>
        <div>

            <%-- Ảnh bìa --%>
            <div class="admin-card">
                <div class="card-section-title">Ảnh bìa chiến dịch</div>

                <div id="imgPlaceholder" class="img-placeholder">🖼 Chưa có ảnh bìa</div>
                <div id="imgPreviewBox"><img id="imgPreview" src="" alt="Ảnh bìa" /></div>

                <div class="form-group">
                    <label class="form-label">Tải ảnh lên</label>
                    <input type="file" id="fuAnhBia" accept="image/*"
                           style="font-size:12px" onchange="previewAnhBia(this)" />
                    <div class="form-hint">JPG, PNG – nên dùng 800×450px</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Hoặc nhập URL</label>
                    <input type="text" id="txtAnhBia" class="form-control" maxlength="255"
                           placeholder="/Uploads/ChienDich/..."
                           oninput="previewAnhBiaUrl(this.value)" />
                </div>
            </div>

            <%-- Phân loại --%>
            <div class="admin-card">
                <div class="card-section-title">Phân loại</div>

                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <select id="selDanhMuc" class="form-control">
                        <option value="">-- Chọn danh mục --</option>
                        <option value="1">Cứu trợ thiên tai</option>
                        <option value="2">Học bổng &amp; Giáo dục</option>
                        <option value="3">Y tế cộng đồng</option>
                        <option value="4">Môi trường &amp; Cây xanh</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="checkbox-row">
                        <input type="checkbox" id="chkNoiBat" />
                        ★ Ghim nổi bật (hiện trang chủ)
                    </label>
                    <div class="form-hint" style="margin-left:24px">
                        Chiến dịch xuất hiện ở vị trí ưu tiên trên trang chủ.
                    </div>
                </div>
            </div>

            <%-- Actions --%>
            <div class="admin-card">
                <div class="card-section-title">Hành động</div>

                <button class="btn-luu"  onclick="luuChienDich(false)">💾 Lưu chiến dịch</button>
                <button class="btn-nhap" onclick="luuChienDich(true)">📝 Lưu nháp</button>
                <a href="/Admin/QuanLyChienDich.aspx" class="btn-huy">✕ Huỷ, quay lại</a>

                <div class="form-hint" style="margin-top:10px">
                    <strong>Lưu chiến dịch:</strong> dùng trạng thái đã chọn.<br/>
                    <strong>Lưu nháp:</strong> tự đặt trạng thái = Nháp.
                </div>
            </div>

            <%-- Meta (edit mode) --%>
            <div id="panelMeta" class="admin-card edit-only meta-box">
                <div class="meta-title">Thông tin</div>
                <div class="meta-row">Mã: #<span id="metaMa"></span></div>
                <div class="meta-row">Ngày tạo: <span id="metaNgayTao"></span></div>
            </div>

        </div><%-- /cột phải --%>

    </div><%-- /form-grid --%>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ── Mock data chiến dịch (khớp SampleData.sql) ─────────────── */
var MOCK_CHIEN_DICH = {
    1: {
        id: 1, ten: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026',
        moTa: 'Quyên góp hỗ trợ người dân miền Trung bị ảnh hưởng bởi đợt lũ lịch sử tháng 3/2026.',
        noiDung: '<p>Đợt mưa lũ lịch sử tháng 3/2026 đã gây thiệt hại nặng nề tại các tỉnh miền Trung...</p>',
        maDanhMuc: '1', trangThai: '1', mucTieu: 500000000,
        ngayBD: '2026-03-01', ngayKT: '2026-04-30',
        toChuc: 'Hội Chữ Thập Đỏ Việt Nam',
        nganHang: 'Vietcombank', stk: '1234567890', chuTK: 'Quỹ Thiện Nguyện Việt',
        anhBia: '', noiBat: true, ngayTao: '01/03/2026',
        tienDo: [
            { tieu: 'Đợt 1: Đã trao 500 phần quà tại Quảng Bình', noi: 'Ngày 05/03/2026, đoàn thiện nguyện đã trao 500 phần quà cho các hộ dân bị ảnh hưởng nặng nhất.', ngay: '06/03/2026' },
            { tieu: 'Đợt 2: Hỗ trợ sửa chữa 30 căn nhà bị hư hỏng', noi: 'Đoàn đã hỗ trợ vật liệu xây dựng để sửa chữa 30 căn nhà bị hư hỏng do lũ tại Quảng Trị.', ngay: '15/03/2026' }
        ]
    },
    2: {
        id: 2, ten: 'Học bổng "Thắp sáng ước mơ" cho học sinh vùng cao',
        moTa: 'Trao học bổng cho 50 học sinh dân tộc thiểu số có hoàn cảnh khó khăn tại miền núi phía Bắc.',
        noiDung: '<p>Chương trình học bổng <strong>Thắp sáng ước mơ</strong> hỗ trợ các em học sinh dân tộc thiểu số...</p>',
        maDanhMuc: '2', trangThai: '1', mucTieu: 300000000,
        ngayBD: '2026-02-01', ngayKT: '2026-05-31',
        toChuc: 'Quỹ Hỗ Trợ Giáo Dục Miền Núi',
        nganHang: 'Vietcombank', stk: '1234567890', chuTK: 'Quỹ Thiện Nguyện Việt',
        anhBia: '', noiBat: true, ngayTao: '01/02/2026',
        tienDo: [
            { tieu: 'Đã xét duyệt và trao 20 suất học bổng đầu tiên', noi: 'Ban tổ chức đã trao 20 suất học bổng đầu tiên cho học sinh tại Hà Giang và Cao Bằng.', ngay: '21/02/2026' }
        ]
    },
    3: {
        id: 3, ten: 'Phẫu thuật tim miễn phí cho trẻ em nghèo',
        moTa: 'Hỗ trợ chi phí phẫu thuật tim bẩm sinh cho 20 trẻ em có hoàn cảnh khó khăn.',
        noiDung: '<p>Mỗi ca phẫu thuật tim bẩm sinh tốn khoảng 80–120 triệu đồng...</p>',
        maDanhMuc: '3', trangThai: '1', mucTieu: 2000000000,
        ngayBD: '2026-01-15', ngayKT: '2026-06-30',
        toChuc: 'Bệnh Viện Nhi Đồng 1 TP.HCM',
        nganHang: 'Vietcombank', stk: '1234567890', chuTK: 'Quỹ Thiện Nguyện Việt',
        anhBia: '', noiBat: true, ngayTao: '15/01/2026', tienDo: []
    }
};

/* ── Đọc id từ URL ───────────────────────────────────────────── */
var urlParams   = new URLSearchParams(window.location.search);
var editId      = parseInt(urlParams.get('id') || '0');
var isEditMode  = editId > 0;
var tienDoList  = []; // buffer tiến độ khi edit

/* ── Khởi tạo trang ─────────────────────────────────────────── */
(function init() {
    // Default ngày
    var today    = new Date().toISOString().slice(0,10);
    var in3month = new Date(Date.now() + 90*24*60*60*1000).toISOString().slice(0,10);
    document.getElementById('txtNgayBD').value  = today;
    document.getElementById('txtNgayKT').value  = in3month;
    document.getElementById('txtTDNgay').value  = today;

    if (isEditMode && MOCK_CHIEN_DICH[editId]) {
        loadEditMode(editId);
    }

    // Thông báo "saved"
    if (urlParams.get('saved') === '1') {
        showSuccess('Đã thêm chiến dịch thành công!');
    }
})();

function loadEditMode(id) {
    var cd = MOCK_CHIEN_DICH[id];
    if (!cd) { showError('Không tìm thấy chiến dịch #' + id); return; }

    // Cập nhật tiêu đề
    document.getElementById('topBarH1').textContent       = 'Chỉnh sửa chiến dịch';
    document.getElementById('topBarSub').textContent      = cd.ten;
    document.getElementById('breadcrumbCurrent').textContent = 'Chỉnh sửa';
    document.getElementById('pageTitle').textContent      = 'Chỉnh sửa chiến dịch';
    document.title = 'Sửa chiến dịch — Admin';

    // Bind form
    document.getElementById('txtTen').value          = cd.ten;
    document.getElementById('txtMoTa').value         = cd.moTa;
    document.getElementById('txtNoiDung').value      = cd.noiDung;
    document.getElementById('txtMucTieu').value      = cd.mucTieu;
    document.getElementById('txtNgayBD').value       = cd.ngayBD;
    document.getElementById('txtNgayKT').value       = cd.ngayKT;
    document.getElementById('txtToChuc').value       = cd.toChuc;
    document.getElementById('txtNganHang').value     = cd.nganHang;
    document.getElementById('txtSTK').value          = cd.stk;
    document.getElementById('txtChuTK').value        = cd.chuTK;
    document.getElementById('txtAnhBia').value       = cd.anhBia;
    document.getElementById('chkNoiBat').checked     = cd.noiBat;
    document.getElementById('selDanhMuc').value      = cd.maDanhMuc;
    document.getElementById('selTrangThai').value    = cd.trangThai;

    // Ảnh bìa preview
    if (cd.anhBia) previewAnhBiaUrl(cd.anhBia);

    // Meta
    document.getElementById('metaMa').textContent      = cd.id;
    document.getElementById('metaNgayTao').textContent = cd.ngayTao;
    document.getElementById('panelMeta').style.display = 'block';

    // Tiến độ
    document.getElementById('panelTienDo').style.display = 'block';
    tienDoList = (cd.tienDo || []).slice();
    renderTienDo();
}

/* ── Preview ảnh bìa ────────────────────────────────────────── */
function previewAnhBia(input) {
    if (!input.files || !input.files[0]) return;
    var url = URL.createObjectURL(input.files[0]);
    showImgPreview(url);
}

function previewAnhBiaUrl(url) {
    if (!url) { hideImgPreview(); return; }
    showImgPreview(url);
}

function showImgPreview(url) {
    document.getElementById('imgPreview').src         = url;
    document.getElementById('imgPreviewBox').style.display  = 'block';
    document.getElementById('imgPlaceholder').style.display = 'none';
}

function hideImgPreview() {
    document.getElementById('imgPreviewBox').style.display  = 'none';
    document.getElementById('imgPlaceholder').style.display = 'flex';
}

/* ── Timeline tiến độ ───────────────────────────────────────── */
function renderTienDo() {
    var list  = document.getElementById('timelineList');
    var empty = document.getElementById('timelineEmpty');

    if (tienDoList.length === 0) {
        list.innerHTML       = '';
        empty.style.display  = 'block';
        return;
    }

    empty.style.display = 'none';
    var html = '';
    tienDoList.forEach(function(t) {
        html +=
            '<div class="timeline-item">' +
                '<div class="timeline-dot"></div>' +
                '<div>' +
                    '<div class="timeline-date">'  + (t.ngay || '') + '</div>' +
                    '<div class="timeline-title">' + t.tieu + '</div>' +
                    '<div class="timeline-body">'  + t.noi  + '</div>' +
                '</div>' +
            '</div>';
    });
    list.innerHTML = html;
}

function themTienDo() {
    var tieu = document.getElementById('txtTDTieuDe').value.trim();
    var noi  = document.getElementById('txtTDNoiDung').value.trim();
    var ngay = document.getElementById('txtTDNgay').value;

    if (!tieu || !noi) {
        showError('Vui lòng nhập tiêu đề và nội dung tiến độ.');
        return;
    }

    // Format ngày dd/MM/yyyy
    var d     = ngay ? new Date(ngay) : new Date();
    var ngayF = d.toLocaleDateString('vi-VN');

    tienDoList.unshift({ tieu: tieu, noi: noi, ngay: ngayF });
    renderTienDo();

    document.getElementById('txtTDTieuDe').value  = '';
    document.getElementById('txtTDNoiDung').value = '';
    showSuccess('Đã thêm cập nhật tiến độ.');
}

/* ── Lưu chiến dịch ─────────────────────────────────────────── */
function luuChienDich(isDraft) {
    var ten     = document.getElementById('txtTen').value.trim();
    var mucTieu = parseFloat(document.getElementById('txtMucTieu').value);
    var ngayBD  = document.getElementById('txtNgayBD').value;
    var ngayKT  = document.getElementById('txtNgayKT').value;
    var danhMuc = document.getElementById('selDanhMuc').value;

    // Validate
    if (!ten)        { showError('Vui lòng nhập tên chiến dịch.');  return; }
    if (!danhMuc)    { showError('Vui lòng chọn danh mục.');        return; }
    if (isNaN(mucTieu) || mucTieu < 0)
                     { showError('Mục tiêu phải là số dương hợp lệ.'); return; }
    if (!ngayBD || !ngayKT)
                     { showError('Vui lòng chọn ngày bắt đầu và kết thúc.'); return; }
    if (ngayKT <= ngayBD)
                     { showError('Ngày kết thúc phải sau ngày bắt đầu.'); return; }

    var trangThai = isDraft ? 0 : parseInt(document.getElementById('selTrangThai').value);

    if (isEditMode) {
        showSuccess('✓ Đã cập nhật chiến dịch "' + ten + '" thành công!');
    } else {
        // Giả lập redirect sau khi thêm
        showSuccess('✓ Đã thêm chiến dịch "' + ten + '" thành công!');
        setTimeout(function() {
            window.location.href = '/Admin/QuanLyChienDich.aspx';
        }, 1500);
    }
}

/* ── Alerts ─────────────────────────────────────────────────── */
function showSuccess(msg) {
    var el = document.getElementById('alertSuccess');
    el.textContent  = msg;
    el.style.display = 'block';
    document.getElementById('alertError').style.display = 'none';
    window.scrollTo({ top: 0, behavior: 'smooth' });
    setTimeout(function() { el.style.display = 'none'; }, 4000);
}

function showError(msg) {
    var el = document.getElementById('alertError');
    el.textContent  = msg;
    el.style.display = 'block';
    document.getElementById('alertSuccess').style.display = 'none';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}
</script>
</asp:Content>
