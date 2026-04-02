<%@ Page Title="Chiến dịch" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="FormChienDich.aspx.cs"
         Inherits="ThienNguyenViet.Admin.FormChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
    /* ── Layout ──────────────────────────────────────────── */
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

    /* ── Form controls ───────────────────────────────────── */
    .form-group          { margin-bottom: 14px; }
    .form-group:last-child { margin-bottom: 0; }
    .form-label          { display: block; font-size: 12px; font-weight: 600; color: var(--txt); margin-bottom: 4px; }
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
    select.form-control   { cursor: pointer; }

    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

    .section-divider {
        font-size: 11px; font-weight: 600; color: var(--txt-sub);
        text-transform: uppercase; letter-spacing: .06em;
        padding: 10px 0 8px;
        border-top: 1px solid var(--border); margin-top: 4px;
    }
    .card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 14px; color: var(--txt); }

    /* ── Checkbox ────────────────────────────────────────── */
    .checkbox-row { display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer; }
    .checkbox-row input[type=checkbox] { width:16px; height:16px; accent-color: var(--accent); cursor:pointer; }

    /* ── Buttons ─────────────────────────────────────────── */
    .btn-form {
        height: 36px; padding: 0 18px;
        border-radius: var(--r);
        font-size: 13px; font-family: var(--font); font-weight: 500;
        cursor: pointer; width: 100%; margin-bottom: 8px;
        border: none; transition: background .15s, color .15s;
    }
    .btn-form:last-child { margin-bottom: 0; }

    .btn-luu  { background: var(--accent); color: #fff; }
    .btn-luu:hover { background: #2B6CB0; }

    .btn-nhap { background: var(--accent-light); color: #2B6CB0; border: 1px solid var(--info-bg) !important; }
    .btn-nhap:hover { background: var(--info-bg); }

    .btn-huy  { background: transparent; color: var(--txt-sub); border: 1px solid var(--border) !important; }
    .btn-huy:hover { background: var(--bg); color: var(--txt); }

    /* ── Ảnh bìa ─────────────────────────────────────────── */
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

    /* ── Timeline tiến độ ────────────────────────────────── */
    .timeline { display: flex; flex-direction: column; gap: 12px; margin-bottom: 12px; }
    .timeline-item { display: flex; gap: 10px; }
    .timeline-dot  { width:9px; height:9px; border-radius:50%; background: var(--accent); flex-shrink:0; margin-top:4px; }
    .timeline-date  { font-size:11px; color: var(--txt-sub); margin-bottom:2px; }
    .timeline-title { font-size:13px; font-weight:600; color: var(--txt); }
    .timeline-body  { font-size:12px; color: var(--txt-sub); margin-top:2px; }
    .timeline-empty { font-size:12px; color: var(--txt-sub); text-align:center; padding:14px 0; }

    .tienDo-form {
        background: var(--bg);
        border-radius: var(--r);
        border: 1px solid var(--border);
        padding: 12px; margin-top: 10px;
    }
    .tienDo-form .form-group { margin-bottom: 8px; }
    .tienDo-form-title { font-size:12px; font-weight:600; color: var(--txt); margin-bottom:10px; }

    .btn-add-td {
        height: 30px; padding: 0 14px;
        background: var(--accent-light); color: #2B6CB0;
        border: 1px solid var(--info-bg); border-radius: var(--r);
        font-size: 12px; font-family: var(--font); cursor: pointer;
        transition: background .15s;
    }
    .btn-add-td:hover { background: var(--info-bg); }

    /* ── Meta box ────────────────────────────────────────── */
    .meta-box      { font-size:12px; color: var(--txt-sub); }
    .meta-box .meta-title { font-size:13px; font-weight:600; color: var(--txt); margin-bottom:8px; }
    .meta-row      { margin-bottom:4px; }

    /* ── Chỉ hiện khi edit ───────────────────────────────── */
    .edit-only { display: none; }

    /* ── Toast thông báo ─────────────────────────────────── */
    #toastWrap {
        position: fixed;
        top: 64px; right: 18px;
        z-index: 9999;
        display: flex; flex-direction: column; gap: 8px;
        pointer-events: none;
    }
    .toast-item {
        display: flex; align-items: flex-start; gap: 10px;
        background: #fff;
        border: 1px solid var(--border);
        border-left-width: 4px;
        border-radius: var(--r-card);
        padding: 10px 14px;
        min-width: 260px; max-width: 340px;
        pointer-events: all;
        box-shadow: 0 2px 10px rgba(0,0,0,.08);
        animation: toastIn .2s ease;
    }
    .toast-item.toast-ok  { border-left-color: var(--ok); }
    .toast-item.toast-err { border-left-color: var(--err); }
    .toast-item .t-msg    { font-size: 13px; color: var(--txt); flex: 1; }
    .toast-item .t-close  { font-size: 16px; color: var(--txt-sub); cursor: pointer; line-height: 1; }
    @keyframes toastIn { from { opacity:0; transform: translateX(12px); } to { opacity:1; transform: none; } }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1 id="topBarH1">Thêm chiến dịch mới</h1>
    <p  id="topBarSub">Tạo mới chiến dịch thiện nguyện</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Toast container --%>
    <div id="toastWrap"></div>

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
            <div class="adm-card">
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
            <div class="adm-card">
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
                <div class="adm-card">
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
            <div class="adm-card">
                <div class="card-section-title">Ảnh bìa chiến dịch</div>

                <div id="imgPlaceholder" class="img-placeholder">Chưa có ảnh bìa</div>
                <div id="imgPreviewBox"><img id="imgPreview" src="#" alt="Ảnh bìa" /></div>

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
            <div class="adm-card">
                <div class="card-section-title">Phân loại</div>

                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <select id="selDanhMuc" class="form-control">
                        <option value="">Chọn danh mục</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="checkbox-row">
                        <input type="checkbox" id="chkNoiBat" />
                        Ghim nổi bật (hiện trang chủ)
                    </label>
                    <div class="form-hint" style="margin-left:24px">
                        Chiến dịch xuất hiện ở vị trí ưu tiên trên trang chủ.
                    </div>
                </div>
            </div>

            <%-- Actions --%>
            <div class="adm-card">
                <div class="card-section-title">Hành động</div>

                <button class="btn-form btn-luu" onclick="luuChienDich(false)">Lưu chiến dịch</button>
                <button class="btn-form btn-nhap" onclick="luuChienDich(true)">Lưu nháp</button>
                <button class="btn-form btn-huy" onclick="window.location.href='/Admin/QuanLyChienDich.aspx'">Huỷ, quay lại</button>

                <div class="form-hint" style="margin-top:10px">
                    <strong>Lưu chiến dịch:</strong> dùng trạng thái đã chọn.<br/>
                    <strong>Lưu nháp:</strong> tự đặt trạng thái = Nháp.
                </div>
            </div>

            <%-- Meta (edit mode) --%>
            <div id="panelMeta" class="adm-card edit-only meta-box">
                <div class="meta-title">Thông tin</div>
                <div class="meta-row">Mã: #<span id="metaMa"></span></div>
                <div class="meta-row">Ngày tạo: <span id="metaNgayTao"></span></div>
                <div class="meta-row">Ngày cập nhật: <span id="metaNgayCapNhat"></span></div>
            </div>

        </div><%-- /cột phải --%>

    </div><%-- /form-grid --%>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    /* ── Đọc id từ URL ───────────────────────────────────────── */
    var urlParams = new URLSearchParams(window.location.search);
    var editId = parseInt(urlParams.get('id') || '0');
    var isEditMode = editId > 0;
    var tienDoList = [];

    /* ── Khởi tạo trang ──────────────────────────────────────── */
    (function init() {
        var today = new Date().toISOString().slice(0, 10);
        var in3month = new Date(Date.now() + 90 * 24 * 60 * 60 * 1000).toISOString().slice(0, 10);
        document.getElementById('txtNgayBD').value = today;
        document.getElementById('txtNgayKT').value = in3month;
        document.getElementById('txtTDNgay').value = today;

        loadDanhMuc().then(function () {
            if (isEditMode) loadEditMode(editId);
        });

        if (urlParams.get('saved') === '1') {
            showToast('Đã thêm chiến dịch thành công!', 'ok');
        }
    })();

    /* ── Load danh mục từ server ──────────────────────────────── */
    function loadDanhMuc() {
        return fetch(location.pathname + '?__ajax=true&action=danhMuc')
            .then(function (r) { return r.json(); })
            .then(function (json) {
                if (!json.ok) return;
                var sel = document.getElementById('selDanhMuc');
                json.data.forEach(function (dm) {
                    var opt = document.createElement('option');
                    opt.value = dm.ma;
                    opt.textContent = dm.ten;
                    sel.appendChild(opt);
                });
            })
            .catch(function () { });
    }

    /* ── Load edit mode từ server ─────────────────────────────── */
    function loadEditMode(id) {
        fetch(location.pathname + '?__ajax=true&action=get&id=' + id)
            .then(function (r) { return r.json(); })
            .then(function (json) {
                if (!json.ok) { showToast('Không tìm thấy chiến dịch #' + id, 'err'); return; }
                var cd = json.data;

                // Tiêu đề
                document.getElementById('topBarH1').textContent = 'Chỉnh sửa chiến dịch';
                document.getElementById('topBarSub').textContent = cd.TenChienDich;
                document.getElementById('breadcrumbCurrent').textContent = 'Chỉnh sửa';
                document.getElementById('pageTitle').textContent = 'Chỉnh sửa chiến dịch';
                document.title = 'Sửa chiến dịch — Admin';

                // Bind form
                document.getElementById('txtTen').value = cd.TenChienDich || '';
                document.getElementById('txtMoTa').value = cd.MoTaNgan || '';
                document.getElementById('txtNoiDung').value = cd.NoiDungChiTiet || '';
                document.getElementById('txtMucTieu').value = cd.MucTieu || '';
                document.getElementById('txtNgayBD').value = cd.NgayBatDau || '';
                document.getElementById('txtNgayKT').value = cd.NgayKetThuc || '';
                document.getElementById('txtToChuc').value = cd.ToChucChuTri || '';
                document.getElementById('txtNganHang').value = cd.TenNganHang || '';
                document.getElementById('txtSTK').value = cd.SoTaiKhoan || '';
                document.getElementById('txtChuTK').value = cd.TenChuTaiKhoan || '';
                document.getElementById('txtAnhBia').value = cd.AnhBia || '';
                document.getElementById('chkNoiBat').checked = cd.NoiBat;
                document.getElementById('selDanhMuc').value = cd.MaDanhMuc;
                document.getElementById('selTrangThai').value = cd.TrangThai;

                if (cd.AnhBia) previewAnhBiaUrl(cd.AnhBia);

                // Meta
                document.getElementById('metaMa').textContent = cd.MaChienDich;
                document.getElementById('metaNgayTao').textContent = cd.NgayTao || '—';
                document.getElementById('metaNgayCapNhat').textContent = cd.NgayCapNhat || '—';
                document.getElementById('panelMeta').style.display = 'block';

                // Tiến độ
                document.getElementById('panelTienDo').style.display = 'block';
                tienDoList = (cd.TienDo || []).slice();
                renderTienDo();
            })
            .catch(function () { showToast('Lỗi khi tải dữ liệu chiến dịch.', 'err'); });
    }

    /* ── Preview ảnh bìa ─────────────────────────────────────── */
    function previewAnhBia(input) {
        if (!input.files || !input.files[0]) return;
        showImgPreview(URL.createObjectURL(input.files[0]));
    }
    function previewAnhBiaUrl(url) {
        if (!url) { hideImgPreview(); return; }
        showImgPreview(url);
    }
    function showImgPreview(url) {
        document.getElementById('imgPreview').src = url;
        document.getElementById('imgPreviewBox').style.display = 'block';
        document.getElementById('imgPlaceholder').style.display = 'none';
    }
    function hideImgPreview() {
        document.getElementById('imgPreviewBox').style.display = 'none';
        document.getElementById('imgPlaceholder').style.display = 'flex';
    }

    /* ── Timeline tiến độ ────────────────────────────────────── */
    function renderTienDo() {
        var list = document.getElementById('timelineList');
        var empty = document.getElementById('timelineEmpty');
        if (tienDoList.length === 0) {
            list.innerHTML = '';
            empty.style.display = 'block';
            return;
        }
        empty.style.display = 'none';
        var html = '';
        tienDoList.forEach(function (t) {
            html +=
                '<div class="timeline-item">' +
                '<div class="timeline-dot"></div>' +
                '<div>' +
                '<div class="timeline-date">' + (t.NgayDang || t.ngay || '') + '</div>' +
                '<div class="timeline-title">' + (t.TieuDe || t.tieu || '') + '</div>' +
                '<div class="timeline-body">' + (t.NoiDung || t.noi || '') + '</div>' +
                '</div>' +
                '</div>';
        });
        list.innerHTML = html;
    }

    function themTienDo() {
        var tieu = document.getElementById('txtTDTieuDe').value.trim();
        var noi = document.getElementById('txtTDNoiDung').value.trim();
        var ngay = document.getElementById('txtTDNgay').value;
        if (!tieu || !noi) { showToast('Vui lòng nhập tiêu đề và nội dung tiến độ.', 'err'); return; }

        var ngayF = ngay ? new Date(ngay).toLocaleDateString('vi-VN') : new Date().toLocaleDateString('vi-VN');

        // Lưu tiến độ lên server
        var params = new URLSearchParams({
            __ajax: 'true', action: 'addTienDo',
            id: editId, tieu: tieu, noi: noi, ngay: ngay
        });
        fetch(location.pathname + '?' + params)
            .then(function (r) { return r.json(); })
            .then(function (json) {
                if (json.ok) {
                    tienDoList.unshift({ TieuDe: tieu, NoiDung: noi, NgayDang: ngayF });
                    renderTienDo();
                    document.getElementById('txtTDTieuDe').value = '';
                    document.getElementById('txtTDNoiDung').value = '';
                    showToast('Đã thêm cập nhật tiến độ.', 'ok');
                } else {
                    showToast(json.msg || 'Lỗi khi lưu tiến độ.', 'err');
                }
            })
            .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
    }

    /* ── Lưu chiến dịch ──────────────────────────────────────── */
    function luuChienDich(isDraft) {
        var ten = document.getElementById('txtTen').value.trim();
        var mucTieu = parseFloat(document.getElementById('txtMucTieu').value);
        var ngayBD = document.getElementById('txtNgayBD').value;
        var ngayKT = document.getElementById('txtNgayKT').value;
        var danhMuc = document.getElementById('selDanhMuc').value;

        if (!ten) { showToast('Vui lòng nhập tên chiến dịch.', 'err'); return; }
        if (!danhMuc) { showToast('Vui lòng chọn danh mục.', 'err'); return; }
        if (isNaN(mucTieu) || mucTieu < 0) { showToast('Mục tiêu phải là số dương hợp lệ.', 'err'); return; }
        if (!ngayBD || !ngayKT) { showToast('Vui lòng chọn ngày bắt đầu và kết thúc.', 'err'); return; }
        if (ngayKT <= ngayBD) { showToast('Ngày kết thúc phải sau ngày bắt đầu.', 'err'); return; }

        var trangThai = isDraft ? 0 : parseInt(document.getElementById('selTrangThai').value);

        var payload = new URLSearchParams({
            __ajax: 'true',
            action: isEditMode ? 'update' : 'insert',
            id: editId,
            ten: ten,
            moTa: document.getElementById('txtMoTa').value.trim(),
            noiDung: document.getElementById('txtNoiDung').value.trim(),
            mucTieu: mucTieu,
            ngayBD: ngayBD,
            ngayKT: ngayKT,
            toChuc: document.getElementById('txtToChuc').value.trim(),
            nganHang: document.getElementById('txtNganHang').value.trim(),
            stk: document.getElementById('txtSTK').value.trim(),
            chuTK: document.getElementById('txtChuTK').value.trim(),
            anhBia: document.getElementById('txtAnhBia').value.trim(),
            maDanhMuc: danhMuc,
            noiBat: document.getElementById('chkNoiBat').checked ? '1' : '0',
            trangThai: trangThai
        });

        fetch(location.pathname + '?' + payload)
            .then(function (r) { return r.json(); })
            .then(function (json) {
                if (json.ok) {
                    if (isEditMode) {
                        showToast('✓ Đã cập nhật chiến dịch "' + ten + '" thành công!', 'ok');
                    } else {
                        showToast('✓ Đã thêm chiến dịch "' + ten + '" thành công!', 'ok');
                        setTimeout(function () {
                            window.location.href = '/Admin/QuanLyChienDich.aspx';
                        }, 1500);
                    }
                } else {
                    showToast(json.msg || 'Lỗi khi lưu chiến dịch.', 'err');
                }
            })
            .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
    }

    /* ── Toast ───────────────────────────────────────────────── */
    function showToast(msg, type) {
        var wrap = document.getElementById('toastWrap');
        var toast = document.createElement('div');
        toast.className = 'toast-item toast-' + (type || 'ok');
        toast.innerHTML =
            '<span class="t-msg">' + msg + '</span>' +
            '<span class="t-close" onclick="this.parentElement.remove()">×</span>';
        wrap.appendChild(toast);
        setTimeout(function () {
            toast.style.opacity = '0';
            toast.style.transition = 'opacity .3s';
            setTimeout(function () { toast.remove(); }, 350);
        }, 4000);
    }
</script>
</asp:Content>
