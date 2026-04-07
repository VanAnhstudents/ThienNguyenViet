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

.form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

.section-divider {
    font-size: 11px; font-weight: 600; color: var(--txt-sub);
    text-transform: uppercase; letter-spacing: .06em;
    padding: 10px 0 8px;
    border-top: 1px solid var(--border); margin-top: 4px;
}
.card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 14px; color: var(--txt); }

/* ── Button groups (trạng thái + danh mục) ───────────── */
.seg-btn-group {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
}
.seg-btn {
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
.seg-btn:hover  { background: #e2e8f0; color: var(--txt); }
.seg-btn.active { background: var(--accent); color: #fff; border-color: var(--accent); }
.seg-btn.active-draft   { background: var(--warn-bg); color: var(--warn-txt); border-color: var(--warn); }
.seg-btn.active-running { background: var(--ok-bg);   color: var(--ok-txt);   border-color: var(--ok);   }
.seg-btn.active-pause   { background: var(--info-bg); color: var(--info-txt); border-color: #90cdf4;     }
.seg-btn.active-done    { background: var(--err-bg);  color: var(--err-txt);  border-color: var(--err);  }

/* ── Checkbox ────────────────────────────────────────── */
.checkbox-row { display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer; }
.checkbox-row input[type=checkbox] { width:16px; height:16px; accent-color: var(--accent); cursor:pointer; }

/* ── Buttons ─────────────────────────────────────────── */
.btn-form {
    height: 38px; padding: 0 18px;
    border-radius: var(--r);
    font-size: 13px; font-family: var(--font); font-weight: 500;
    cursor: pointer; width: 100%; margin-bottom: 8px;
    border: none; transition: background .15s, color .15s;
}
.btn-form:last-child { margin-bottom: 0; }

.btn-luu  { background: var(--accent); color: #fff; }
.btn-luu:hover { background: #2B6CB0; }

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
    background: var(--bg); border-radius: var(--r);
    border: 1px solid var(--border); padding: 12px; margin-top: 10px;
}
.tienDo-form .form-group { margin-bottom: 8px; }
.tienDo-form-title { font-size:12px; font-weight:600; color: var(--txt); margin-bottom:10px; }

.btn-add-td {
    height: 30px; padding: 0 14px;
    background: var(--accent-light); color: #2B6CB0;
    border: 1px solid var(--info-bg); border-radius: var(--r);
    font-size: 12px; font-family: var(--font); cursor: pointer;
}
.btn-add-td:hover { background: var(--info-bg); }

/* ── Meta box ────────────────────────────────────────── */
.meta-box      { font-size:12px; color: var(--txt-sub); }
.meta-box .meta-title { font-size:13px; font-weight:600; color: var(--txt); margin-bottom:8px; }
.meta-row      { margin-bottom:4px; }

/* ── Chỉ hiện khi edit ───────────────────────────────── */
.edit-only { display: none; }

/* ── Toast ───────────────────────────────────────────── */
#toastWrap {
    position: fixed; top: 64px; right: 18px;
    z-index: 9999; display: flex; flex-direction: column; gap: 8px;
    pointer-events: none;
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
@keyframes toastIn { from { opacity:0; transform: translateX(12px); } to { opacity:1; transform: none; } }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1 id="topBarH1">Thêm chiến dịch mới</h1>
    <p  id="topBarSub">Tạo mới chiến dịch thiện nguyện</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="toastWrap"></div>

    <div class="breadcrumb">
        <a href="<%= ResolveUrl("~/Admin/QuanLyChienDich.aspx") %>">Quản lý Chiến dịch</a> /
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
                    <div class="form-hint">Hỗ trợ HTML.</div>
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
                        <div class="seg-btn-group" id="tsBtnGroup">
                            <button type="button" class="seg-btn" data-val="0" onclick="setTrangThai(this,0)">Nháp</button>
                            <button type="button" class="seg-btn active active-running" data-val="1" onclick="setTrangThai(this,1)">Đang chạy</button>
                            <button type="button" class="seg-btn" data-val="2" onclick="setTrangThai(this,2)">Tạm dừng</button>
                            <button type="button" class="seg-btn" data-val="3" onclick="setTrangThai(this,3)">Đã kết thúc</button>
                        </div>
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
                        <div class="form-group">
                            <label class="form-label">Ngày đăng</label>
                            <input type="date" id="txtTDNgay" class="form-control" />
                        </div>
                        <button type="button" class="btn-add-td" onclick="themTienDo()">Thêm cập nhật</button>
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
                           placeholder="Nhập URL..."
                           oninput="previewAnhBiaUrl(this.value)" />
                </div>
            </div>

            <%-- Phân loại --%>
            <div class="adm-card">
                <div class="card-section-title">Phân loại</div>

                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <%-- Các nút được render động bởi loadDanhMuc() --%>
                    <div class="seg-btn-group" id="dmBtnGroup">
                        <span style="font-size:12px;color:var(--txt-sub)">Đang tải...</span>
                    </div>
                </div>

                <div class="form-group" style="margin-top:10px">
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
                <button type="button" class="btn-form btn-luu" onclick="luuChienDich()">Lưu chiến dịch</button>
                <button type="button" class="btn-form btn-huy"
                        onclick="window.location.href='<%= ResolveUrl("~/Admin/QuanLyChienDich.aspx") %>'">
                    Huỷ, quay lại
                </button>
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
    (function () {
        'use strict';

        var BASE_URL = '<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>';
        var urlParams = new URLSearchParams(window.location.search);
        var editId = parseInt(urlParams.get('id') || '0');
        var isEditMode = editId > 0;
        var tienDoList = [];

        /* ── State cho button groups ─────────────────────────────── */
        var selectedTrangThai = 1;   // mặc định: Đang chạy
        var selectedDanhMuc = '';  // chưa chọn

        var TS_ACTIVE_CLASS = {
            0: 'active active-draft',
            1: 'active active-running',
            2: 'active active-pause',
            3: 'active active-done'
        };

        /* ── Khởi tạo ────────────────────────────────────────────── */
        (function init() {
            var today = new Date().toISOString().slice(0, 10);
            var in3month = new Date(Date.now() + 90 * 24 * 60 * 60 * 1000).toISOString().slice(0, 10);
            document.getElementById('txtNgayBD').value = today;
            document.getElementById('txtNgayKT').value = in3month;
            document.getElementById('txtTDNgay').value = today;

            loadDanhMuc().then(function () {
                if (isEditMode) loadEditMode(editId);
            });

            if (urlParams.get('saved') === '1')
                showToast('Đã lưu chiến dịch thành công!', 'ok');
        })();

        /* ── Trạng thái buttons ──────────────────────────────────── */
        window.setTrangThai = function (btn, val) {
            document.querySelectorAll('#tsBtnGroup .seg-btn').forEach(function (b) {
                b.className = 'seg-btn';
            });
            btn.className = 'seg-btn ' + (TS_ACTIVE_CLASS[val] || 'active');
            selectedTrangThai = val;
        };

        /* ── Danh mục buttons (dynamic) ─────────────────────────── */
        function loadDanhMuc() {
            return fetch(BASE_URL + '?__ajax=true&action=danhMuc')
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (!json.ok) return;
                    var wrap = document.getElementById('dmBtnGroup');
                    wrap.innerHTML = '';
                    json.data.forEach(function (dm) {
                        var btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'seg-btn';
                        btn.dataset.val = dm.ma;
                        btn.textContent = dm.ten;
                        btn.onclick = function () { setDanhMuc(this, dm.ma); };
                        wrap.appendChild(btn);
                    });
                })
                .catch(function () {
                    document.getElementById('dmBtnGroup').innerHTML =
                        '<span style="font-size:12px;color:var(--err-txt)">Lỗi tải danh mục</span>';
                });
        }

        window.setDanhMuc = function (btn, val) {
            document.querySelectorAll('#dmBtnGroup .seg-btn').forEach(function (b) {
                b.className = 'seg-btn';
            });
            btn.className = 'seg-btn active';
            selectedDanhMuc = String(val);
        };

        /* ── Load edit mode ──────────────────────────────────────── */
        function loadEditMode(id) {
            fetch(BASE_URL + '?__ajax=true&action=get&id=' + id)
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (!json.ok) { showToast('Không tìm thấy chiến dịch #' + id, 'err'); return; }
                    var cd = json.data;

                    document.getElementById('topBarH1').textContent = 'Chỉnh sửa chiến dịch';
                    document.getElementById('topBarSub').textContent = cd.TenChienDich;
                    document.getElementById('breadcrumbCurrent').textContent = 'Chỉnh sửa';
                    document.getElementById('pageTitle').textContent = 'Chỉnh sửa chiến dịch';
                    document.title = 'Sửa chiến dịch — Admin';

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

                    if (cd.AnhBia) previewAnhBiaUrl(cd.AnhBia);

                    // Activate trạng thái button
                    var tsVal = parseInt(cd.TrangThai);
                    selectedTrangThai = tsVal;
                    var tsBtn = document.querySelector('#tsBtnGroup .seg-btn[data-val="' + tsVal + '"]');
                    if (tsBtn) {
                        document.querySelectorAll('#tsBtnGroup .seg-btn').forEach(function (b) { b.className = 'seg-btn'; });
                        tsBtn.className = 'seg-btn ' + (TS_ACTIVE_CLASS[tsVal] || 'active');
                    }

                    // Activate danh mục button (chờ DOM sau loadDanhMuc)
                    selectedDanhMuc = String(cd.MaDanhMuc);
                    var dmBtn = document.querySelector('#dmBtnGroup .seg-btn[data-val="' + cd.MaDanhMuc + '"]');
                    if (dmBtn) {
                        document.querySelectorAll('#dmBtnGroup .seg-btn').forEach(function (b) { b.className = 'seg-btn'; });
                        dmBtn.className = 'seg-btn active';
                    }

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

        /* ── Timeline tiến độ ────────────────────────────────────── */
        function renderTienDo() {
            var list = document.getElementById('timelineList');
            var empty = document.getElementById('timelineEmpty');
            if (!tienDoList.length) { list.innerHTML = ''; empty.style.display = 'block'; return; }
            empty.style.display = 'none';
            var html = '';
            tienDoList.forEach(function (t) {
                html += '<div class="timeline-item"><div class="timeline-dot"></div><div>' +
                    '<div class="timeline-date">' + (t.NgayDang || '') + '</div>' +
                    '<div class="timeline-title">' + (t.TieuDe || '') + '</div>' +
                    '<div class="timeline-body">' + (t.NoiDung || '') + '</div>' +
                    '</div></div>';
            });
            list.innerHTML = html;
        }

        window.themTienDo = function () {
            var tieu = document.getElementById('txtTDTieuDe').value.trim();
            var noi = document.getElementById('txtTDNoiDung').value.trim();
            var ngay = document.getElementById('txtTDNgay').value;
            if (!tieu || !noi) { showToast('Vui lòng nhập tiêu đề và nội dung tiến độ.', 'err'); return; }

            var ngayF = ngay
                ? new Date(ngay).toLocaleDateString('vi-VN')
                : new Date().toLocaleDateString('vi-VN');

            var params = new URLSearchParams({
                __ajax: 'true', action: 'addTienDo',
                id: editId, tieu: tieu, noi: noi, ngay: ngay
            });
            fetch(BASE_URL + '?' + params)
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
        };

        /* ── Lưu chiến dịch ──────────────────────────────────────── */
        window.luuChienDich = function () {
            var ten = document.getElementById('txtTen').value.trim();
            var mucTieu = parseFloat(document.getElementById('txtMucTieu').value);
            var ngayBD = document.getElementById('txtNgayBD').value;
            var ngayKT = document.getElementById('txtNgayKT').value;

            if (!ten) { showToast('Vui lòng nhập tên chiến dịch.', 'err'); return; }
            if (!selectedDanhMuc) { showToast('Vui lòng chọn danh mục.', 'err'); return; }
            if (isNaN(mucTieu) || mucTieu < 0) { showToast('Mục tiêu phải là số hợp lệ.', 'err'); return; }
            if (!ngayBD || !ngayKT) { showToast('Vui lòng chọn ngày bắt đầu và kết thúc.', 'err'); return; }
            if (ngayKT <= ngayBD) { showToast('Ngày kết thúc phải sau ngày bắt đầu.', 'err'); return; }

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
                maDanhMuc: selectedDanhMuc,
                noiBat: document.getElementById('chkNoiBat').checked ? '1' : '0',
                trangThai: selectedTrangThai
            });

            fetch(BASE_URL + '?' + payload)
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (json.ok) {
                        showToast('✓ ' + (isEditMode ? 'Đã cập nhật' : 'Đã thêm') +
                            ' chiến dịch "' + ten + '" thành công!', 'ok');
                        if (!isEditMode) {
                            setTimeout(function () {
                                window.location.href = BASE_URL.replace('FormChienDich.aspx', 'QuanLyChienDich.aspx');
                            }, 1400);
                        }
                    } else {
                        showToast(json.msg || 'Lỗi khi lưu chiến dịch.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi kết nối server.', 'err'); });
        };

        /* ── Toast ───────────────────────────────────────────────── */
        function showToast(msg, type) {
            var wrap = document.getElementById('toastWrap');
            var toast = document.createElement('div');
            toast.className = 'toast-item toast-' + (type || 'ok');
            toast.innerHTML = '<span class="t-msg">' + msg + '</span>' +
                '<span class="t-close" onclick="this.parentElement.remove()">×</span>';
            wrap.appendChild(toast);
            setTimeout(function () {
                toast.style.transition = 'opacity .3s';
                toast.style.opacity = '0';
                setTimeout(function () { toast.remove(); }, 350);
            }, 4000);
        }

    })();
</script>
</asp:Content>
