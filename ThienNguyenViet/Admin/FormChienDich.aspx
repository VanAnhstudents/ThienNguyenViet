<%@ Page Title="Form Chien dich" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="FormChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.FormChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .page-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; }
    .form-grid { display: grid; grid-template-columns: 1fr 300px; gap: 20px; align-items: start; }
    .card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 14px; }

    /* Rich text simple toolbar */
    .rte-toolbar {
        display: flex; gap: 3px; padding: 6px 8px;
        border: 1px solid var(--border); border-bottom: none;
        border-radius: var(--r) var(--r) 0 0; background: var(--thead);
    }
    .rte-btn {
        width: 30px; height: 28px; border: 1px solid var(--border);
        border-radius: 3px; background: #fff; cursor: pointer;
        font-size: 12px; font-weight: 700; color: var(--txt);
        display: flex; align-items: center; justify-content: center;
    }
    .rte-btn:hover { background: var(--accent-light); }
    .rte-body {
        border: 1px solid var(--border); border-radius: 0 0 var(--r) var(--r);
        min-height: 200px; padding: 10px; font-size: 13px; line-height: 1.6;
        outline: none; overflow-y: auto; background: #fff;
    }

    /* Tien do section */
    .td-list { list-style: none; margin-top: 10px; }
    .td-item {
        padding: 10px; border: 1px solid var(--border);
        border-radius: var(--r); margin-bottom: 8px; background: var(--thead);
    }
    .td-item-title { font-size: 13px; font-weight: 600; }
    .td-item-date { font-size: 11px; color: var(--txt-sub); }
    .td-item-content { font-size: 12px; margin-top: 4px; color: var(--txt-sub); }

    @media (max-width: 768px) {
        .form-grid { grid-template-columns: 1fr; }
    }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý chiến dịch</h1>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="breadcrumb">
        <a href="<%= ResolveUrl("~/Admin/QuanLyChienDich.aspx") %>">Quản lý chiến dịch</a> / <span id="bcTitle">Thêm mới</span>
    </div>
    <h2 class="page-title" id="pageTitle">Thêm mới chiến dịch</h2>

    <div class="form-grid">
        <%-- Cot trai: thong tin chinh --%>
        <div>
            <div class="card">
                <div class="card-section-title">Thông tin cơ bản</div>
                <div class="form-group">
                    <label class="form-label">Tên chiến dịch <span class="req">*</span></label>
                    <input type="text" class="input" id="fTen" style="width:100%" maxlength="200" />
                </div>
                <div class="form-group">
                    <label class="form-label">Mô tả ngắn</label>
                    <textarea class="input" id="fMoTa" rows="2" style="width:100%" maxlength="300"></textarea>
                    <div class="form-hint">Tối đa 300 ký tự</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Nội dung chi tiết</label>
                    <div class="rte-toolbar">
                        <button type="button" class="rte-btn" onclick="document.execCommand('bold')"><b>B</b></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('italic')"><i>I</i></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('underline')"><u>U</u></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('insertUnorderedList')">&#8226;</button>
                    </div>
                    <div class="rte-body" id="fNoiDung" contenteditable="true"></div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Tài chính</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
                    <div class="form-group">
                        <label class="form-label">Mục tiêu (VND) <span class="req">*</span></label>
                        <input type="number" class="input" id="fMucTieu" style="width:100%" min="0" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tổ chức</label>
                        <input type="text" class="input" id="fToChuc" style="width:100%" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ngân hàng</label>
                        <input type="text" class="input" id="fNganHang" style="width:100%" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số tài khoản</label>
                        <input type="text" class="input" id="fSTK" style="width:100%" />
                    </div>
                    <div class="form-group" style="grid-column:1/-1">
                        <label class="form-label">Chủ tài khoản</label>
                        <input type="text" class="input" id="fChuTK" style="width:100%" />
                    </div>
                </div>
            </div>

            <%-- Tien do (chi hien khi edit) --%>
            <div class="card" id="sectionTienDo" style="display:none">
                <div class="card-section-title">Cập nhật tiến độ</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:10px">
                    <div class="form-group">
                        <label class="form-label">Tiêu đề</label>
                        <input type="text" class="input" id="fTDTieuDe" style="width:100%" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ngày</label>
                        <input type="date" class="input" id="fTDNgay" style="width:100%" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Nội dung</label>
                    <textarea class="input" id="fTDNoiDung" rows="2" style="width:100%"></textarea>
                </div>
                <button type="button" class="btn btn-outline btn-sm" onclick="addTienDo()">Thêm tiến độ</button>
                <ul class="td-list" id="tdList"></ul>
            </div>
        </div>

        <%-- Cot phai: sidebar --%>
        <div>
            <div class="card">
                <div class="card-section-title">Phân loại</div>
                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <select class="select" id="fDanhMuc" style="width:100%">
                        <option value="">Chọn danh mục</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Trạng thái</label>
                    <select class="select" id="fTrangThai" style="width:100%">
                        <option value="0">Nháp</option>
                        <option value="1">Đang chạy</option>
                        <option value="2">Kết thúc</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" style="display:flex;align-items:center;gap:6px">
                        <input type="checkbox" id="fNoiBat" /> Nổi bật
                    </label>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Thời gian</div>
                <div class="form-group">
                    <label class="form-label">Ngày bắt đầu <span class="req">*</span></label>
                    <input type="date" class="input" id="fNgayBD" style="width:100%" />
                </div>
                <div class="form-group">
                    <label class="form-label">Ngày kết thúc <span class="req">*</span></label>
                    <input type="date" class="input" id="fNgayKT" style="width:100%" />
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Ảnh bìa</div>
                <div class="form-group">
                    <label class="form-label">URL ảnh bìa</label>
                    <input type="text" class="input" id="fAnhBia" style="width:100%" placeholder="https://..." />
                </div>
                <div id="previewImg" style="margin-top:8px;border-radius:var(--r);overflow:hidden"></div>
            </div>

            <button type="button" class="btn btn-primary" style="width:100%;margin-top:10px" onclick="saveForm()">Lưu chiến dịch</button>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
(function(){
    'use strict';
    var BASE_URL = '<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>';
        var isEditMode = false;
        var editId = 0;

        // Lay id tu URL
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('id')) {
            editId = parseInt(urlParams.get('id'));
            isEditMode = true;
            document.getElementById('bcTitle').textContent = 'Chỉnh sửa';
            document.getElementById('pageTitle').textContent = 'Chỉnh sửa chiến dịch';
            document.getElementById('sectionTienDo').style.display = 'block';
        }

        // Load danh muc
        fetch(BASE_URL + '?__ajax=true&action=danhMuc')
            .then(function (r) { return r.json(); })
            .then(function (d) {
                if (!d.ok) return;
                var sel = document.getElementById('fDanhMuc');
                d.data.forEach(function (dm) {
                    var opt = document.createElement('option');
                    opt.value = dm.ma;
                    opt.textContent = dm.ten;
                    sel.appendChild(opt);
                });
                // Neu edit mode, load data sau khi danh muc da san sang
                if (isEditMode) loadEditData();
            });

        // Load du lieu khi edit
        function loadEditData() {
            fetch(BASE_URL + '?__ajax=true&action=get&id=' + editId)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) { showToast('Loi', d.msg || 'Không tìm thấy', 'err'); return; }
                    var data = d.data;
                    document.getElementById('fTen').value = data.TenChienDich || '';
                    document.getElementById('fMoTa').value = data.MoTaNgan || '';
                    document.getElementById('fNoiDung').innerHTML = data.NoiDung || '';
                    document.getElementById('fMucTieu').value = data.MucTieu || 0;
                    document.getElementById('fToChuc').value = data.ToChuc || '';
                    document.getElementById('fNganHang').value = data.NganHang || '';
                    document.getElementById('fSTK').value = data.SoTaiKhoan || '';
                    document.getElementById('fChuTK').value = data.ChuTaiKhoan || '';
                    document.getElementById('fDanhMuc').value = data.MaDanhMuc || '';
                    document.getElementById('fTrangThai').value = data.TrangThai || 0;
                    document.getElementById('fNoiBat').checked = data.NoiBat || false;
                    if (data.NgayBatDau) document.getElementById('fNgayBD').value = data.NgayBatDau.substring(0, 10);
                    if (data.NgayKetThuc) document.getElementById('fNgayKT').value = data.NgayKetThuc.substring(0, 10);
                    document.getElementById('fAnhBia').value = data.AnhBia || '';
                    updatePreview();

                    // Hien thi tien do
                    if (data.tienDo && data.tienDo.length > 0) {
                        renderTienDo(data.tienDo);
                    }
                });
        }

        function renderTienDo(items) {
            var list = document.getElementById('tdList');
            var html = '';
            items.forEach(function (td) {
                html += '<li class="td-item"><div class="td-item-title">' + esc(td.TieuDe) + '</div>' +
                    '<div class="td-item-date">' + td.NgayDang + '</div>' +
                    '<div class="td-item-content">' + esc(td.NoiDung) + '</div></li>';
            });
            list.innerHTML = html;
        }

        // Preview anh bia
        document.getElementById('fAnhBia').addEventListener('change', updatePreview);
        function updatePreview() {
            var url = document.getElementById('fAnhBia').value;
            var el = document.getElementById('previewImg');
            if (url) {
                el.innerHTML = '<img src="' + url + '" style="width:100%;border-radius:var(--r)" onerror="this.parentNode.innerHTML=\'Không tải được ảnh\'" />';
            } else {
                el.innerHTML = '';
            }
        }

        // Luu form
        window.saveForm = function () {
            var ten = document.getElementById('fTen').value.trim();
            var ngayBD = document.getElementById('fNgayBD').value;
            var ngayKT = document.getElementById('fNgayKT').value;
            var mucTieu = document.getElementById('fMucTieu').value;
            var danhMuc = document.getElementById('fDanhMuc').value;

            if (!ten) { showToast('Thieu thong tin', 'Vui long nhap ten chien dich.', 'warn'); return; }
            if (!ngayBD || !ngayKT) { showToast('Thieu thong tin', 'Vui long chon ngay bat dau va ket thuc.', 'warn'); return; }
            if (!mucTieu || mucTieu <= 0) { showToast('Thieu thong tin', 'Muc tieu phai lon hon 0.', 'warn'); return; }
            if (!danhMuc) { showToast('Thieu thong tin', 'Vui long chon danh muc.', 'warn'); return; }

            var selectedTrangThai = document.getElementById('fTrangThai').value;

            var payload = new URLSearchParams({
                __ajax: 'true',
                action: isEditMode ? 'update' : 'insert',
                id: editId || '',
                ten: ten,
                moTa: document.getElementById('fMoTa').value,
                noiDung: document.getElementById('fNoiDung').innerHTML,
                mucTieu: mucTieu,
                ngayBD: ngayBD,
                ngayKT: ngayKT,
                toChuc: document.getElementById('fToChuc').value,
                nganHang: document.getElementById('fNganHang').value,
                stk: document.getElementById('fSTK').value,
                chuTK: document.getElementById('fChuTK').value,
                anhBia: document.getElementById('fAnhBia').value,
                maDanhMuc: danhMuc,
                noiBat: document.getElementById('fNoiBat').checked ? '1' : '0',
                trangThai: selectedTrangThai
            });

            fetch(BASE_URL + '?' + payload)
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (json.ok) {
                        showToast('Thanh cong', json.msg || 'Da luu chien dich.', 'ok');
                        if (!isEditMode) {
                            setTimeout(function () {
                                window.location.href = BASE_URL.replace('FormChienDich.aspx', 'QuanLyChienDich.aspx');
                            }, 1400);
                        }
                    } else {
                        showToast('Loi', json.msg || 'Loi khi luu.', 'err');
                    }
                })
                .catch(function () { showToast('Loi', 'Loi ket noi server.', 'err'); });
        };

        // Them tien do
        window.addTienDo = function () {
            if (!isEditMode || !editId) return;
            var tieuDe = document.getElementById('fTDTieuDe').value.trim();
            var ngay = document.getElementById('fTDNgay').value;
            var noiDung = document.getElementById('fTDNoiDung').value.trim();
            if (!tieuDe) { showToast('Thieu thong tin', 'Nhap tieu de tien do.', 'warn'); return; }

            var payload = new URLSearchParams({
                __ajax: 'true', action: 'addTienDo',
                id: editId, tieu: tieuDe, ngay: ngay || '', noi: noiDung
            });

            fetch(BASE_URL + '?' + payload)
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (json.ok) {
                        showToast('Thanh cong', json.msg, 'ok');
                        document.getElementById('fTDTieuDe').value = '';
                        document.getElementById('fTDNgay').value = '';
                        document.getElementById('fTDNoiDung').value = '';
                        loadEditData(); // Reload tien do
                    } else {
                        showToast('Loi', json.msg || 'Loi.', 'err');
                    }
                })
                .catch(function () { showToast('Loi', 'Loi ket noi.', 'err'); });
        };

        function esc(s) {
            var d = document.createElement('div'); d.textContent = s; return d.innerHTML;
        }
    })();
</script>
</asp:Content>
