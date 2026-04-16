<%@ Page Title="Chiến dịch" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="FormChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.FormChienDich"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .page-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; }
    .form-layout { display: grid; grid-template-columns: 1fr 300px; gap: 20px; align-items: start; }
    .card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 14px; }

    .rte-toolbar {
        display: flex; gap: 3px; padding: 6px 8px;
        border: 1px solid var(--border); border-bottom: none;
        border-radius: var(--r) var(--r) 0 0; background: var(--thead);
    }
    .rte-btn {
        width: 30px; height: 28px; border: 1px solid var(--border);
        border-radius: 3px; background: #fff; cursor: pointer;
        font-size: 12px; font-weight: 700;
        display: flex; align-items: center; justify-content: center;
    }
    .rte-btn:hover { background: var(--accent-light); }
    .rte-body {
        border: 1px solid var(--border); border-radius: 0 0 var(--r) var(--r);
        min-height: 250px; padding: 10px; font-size: 13px; line-height: 1.6;
        outline: none; overflow-y: auto; background: #fff;
    }

    .td-list { list-style: none; margin-top: 12px; }
    .td-list li {
        padding: 10px 0; border-bottom: 1px solid var(--border); font-size: 12px;
    }
    .td-list li:last-child { border-bottom: none; }

    @media (max-width: 768px) {
        .form-layout { grid-template-columns: 1fr; }
    }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Chiến dịch</h1>
    <p>Thêm mới hoặc chỉnh sửa chiến dịch</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="breadcrumb">
        <a href="<%= ResolveUrl("~/Admin/QuanLyChienDich.aspx") %>">Chiến dịch</a> / <span id="bcTitle">Thêm mới</span>
    </div>
    <h2 class="page-title" id="pageTitle">Thêm chiến dịch mới</h2>

    <div class="form-layout">
        <%-- Cột trái: nội dung chính --%>
        <div>
            <div class="card">
                <div class="card-section-title">Thông tin chiến dịch</div>
                <div class="form-group">
                    <label class="form-label">Tên chiến dịch <span class="req">*</span></label>
                    <input type="text" class="input" id="fTen" style="width:100%" maxlength="200"
                        placeholder="Ví dụ: Chung tay hỗ trợ đồng bào miền Trung" />
                    <div class="form-hint">Tên ngắn gọn, rõ ràng, dễ hiểu (tối đa 200 ký tự)</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Mô tả ngắn</label>
                    <textarea class="input" id="fMoTa" rows="2" style="width:100%"
                        placeholder="Mô tả ngắn gọn về chiến dịch (hiển thị ở danh sách)"></textarea>
                    <div class="form-hint">Tóm tắt nội dung chiến dịch trong 1-2 câu</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Nội dung chi tiết</label>
                    <div class="rte-toolbar">
                        <button type="button" class="rte-btn" onclick="document.execCommand('bold')"><b>B</b></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('italic')"><i>I</i></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('underline')"><u>U</u></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('insertUnorderedList')">&#8226;</button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('insertOrderedList')">1.</button>
                    </div>
                    <div class="rte-body" id="fNoiDung" contenteditable="true"></div>
                    <div class="form-hint">Mô tả chi tiết: hoàn cảnh, mục đích sử dụng kinh phí, đối tượng thụ hưởng...</div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Mục tiêu & Ngân sách</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
                    <div class="form-group">
                        <label class="form-label">Mục tiêu quyên góp (VNĐ) <span class="req">*</span></label>
                        <input type="number" class="input" id="fMucTieu" style="width:100%" min="0"
                            placeholder="Ví dụ: 100000000" />
                        <div class="form-hint">Nhập số tiền mục tiêu, không có dấu chấm hoặc phẩy</div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tổ chức chủ trì</label>
                        <input type="text" class="input" id="fToChuc" style="width:100%"
                            placeholder="Ví dụ: Hội Chữ thập đỏ Việt Nam" />
                        <div class="form-hint">Tên đơn vị tổ chức chiến dịch</div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Thông tin ngân hàng</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
                    <div class="form-group">
                        <label class="form-label">Ngân hàng</label>
                        <input type="text" class="input" id="fNganHang" style="width:100%"
                            placeholder="Ví dụ: Vietcombank" />
                        <div class="form-hint">Tên ngân hàng nhận quyên góp</div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số tài khoản</label>
                        <input type="text" class="input" id="fSTK" style="width:100%"
                            placeholder="Ví dụ: 0123456789" />
                        <div class="form-hint">Số tài khoản ngân hàng</div>
                    </div>
                    <div class="form-group" style="grid-column:1/-1">
                        <label class="form-label">Chủ tài khoản</label>
                        <input type="text" class="input" id="fChuTK" style="width:100%"
                            placeholder="Ví dụ: NGUYEN VAN A" />
                        <div class="form-hint">Tên chủ tài khoản (viết in hoa, không dấu)</div>
                    </div>
                </div>
            </div>

            <%-- Tiến độ (chỉ hiện khi edit) --%>
            <div class="card" id="sectionTienDo" style="display:none">
                <div class="card-section-title">Cập nhật tiến độ</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:10px">
                    <div class="form-group">
                        <label class="form-label">Tiêu đề</label>
                        <input type="text" class="input" id="fTDTieuDe" style="width:100%"
                            placeholder="Ví dụ: Đã trao quà đợt 1" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ngày</label>
                        <input type="date" class="input" id="fTDNgay" style="width:100%" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Nội dung</label>
                    <textarea class="input" id="fTDNoiDung" rows="2" style="width:100%"
                        placeholder="Mô tả chi tiết tiến độ triển khai..."></textarea>
                </div>
                <button type="button" class="btn btn-outline btn-sm" onclick="addTienDo()">Thêm tiến độ</button>
                <ul class="td-list" id="tdList"></ul>
            </div>
        </div>

        <%-- Cột phải: sidebar --%>
        <div>
            <div class="card">
                <div class="card-section-title">Phân loại</div>
                <div class="form-group">
                    <label class="form-label">Danh mục <span class="req">*</span></label>
                    <select class="select" id="fDanhMuc" style="width:100%">
                        <option value="">Chọn danh mục</option>
                        <%= RenderDanhMucOptions() %>
                    </select>
                    <div class="form-hint">Chọn danh mục phù hợp với chiến dịch</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Trạng thái</label>
                    <select class="select" id="fTrangThai" style="width:100%">
                        <option value="0">Nháp</option>
                        <option value="1">Đang chạy</option>
                        <option value="2">Kết thúc</option>
                    </select>
                    <div class="form-hint">Nháp = chưa công khai, Đang chạy = hiển thị cho người dùng</div>
                </div>
                <div class="form-group">
                    <label class="form-label" style="display:flex;align-items:center;gap:6px">
                        <input type="checkbox" id="fNoiBat" /> Nổi bật
                    </label>
                    <div class="form-hint">Chiến dịch nổi bật sẽ hiển thị ở trang chủ</div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Thời gian</div>
                <div class="form-group">
                    <label class="form-label">Ngày bắt đầu <span class="req">*</span></label>
                    <input type="date" class="input" id="fNgayBD" style="width:100%" />
                    <div class="form-hint">Ngày chiến dịch bắt đầu nhận quyên góp</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Ngày kết thúc <span class="req">*</span></label>
                    <input type="date" class="input" id="fNgayKT" style="width:100%" />
                    <div class="form-hint">Ngày dự kiến kết thúc chiến dịch</div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Ảnh bìa</div>
                <div class="form-group">
                    <label class="form-label">URL ảnh bìa</label>
                    <input type="text" class="input" id="fAnhBia" style="width:100%"
                        placeholder="https://example.com/anh-bia.jpg" />
                    <div class="form-hint">Dán đường dẫn ảnh bìa (định dạng JPG, PNG). Ảnh sẽ hiển thị xem trước bên dưới.</div>
                </div>
                <div id="previewImg" class="img-preview" style="display:none"></div>
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

        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('id')) {
            editId = parseInt(urlParams.get('id'));
            isEditMode = true;
            document.getElementById('bcTitle').textContent = 'Chỉnh sửa';
            document.getElementById('pageTitle').textContent = 'Chỉnh sửa chiến dịch';
        }

        if (isEditMode) loadEditData();

        function loadEditData() {
            fetch(BASE_URL + '?__ajax=true&action=get&id=' + editId)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) { showToast('Lỗi', d.msg || 'Không tìm thấy chiến dịch.', 'err'); return; }
                    var data = d.data;

                    // Điền toàn bộ dữ liệu lên form
                    document.getElementById('fTen').value = data.TenChienDich || '';
                    document.getElementById('fMoTa').value = data.MoTaNgan || '';
                    document.getElementById('fNoiDung').innerHTML = data.NoiDung || '';
                    document.getElementById('fMucTieu').value = data.MucTieu || '';
                    document.getElementById('fToChuc').value = data.ToChuc || '';
                    document.getElementById('fNganHang').value = data.NganHang || '';
                    document.getElementById('fSTK').value = data.SoTaiKhoan || '';
                    document.getElementById('fChuTK').value = data.ChuTaiKhoan || '';
                    document.getElementById('fNgayBD').value = data.NgayBatDau || '';
                    document.getElementById('fNgayKT').value = data.NgayKetThuc || '';
                    document.getElementById('fDanhMuc').value = data.MaDanhMuc || '';
                    document.getElementById('fTrangThai').value = data.TrangThai != null ? data.TrangThai : '0';
                    document.getElementById('fNoiBat').checked = !!data.NoiBat;

                    // Ảnh bìa + preview
                    if (data.AnhBia) {
                        document.getElementById('fAnhBia').value = data.AnhBia;
                        showPreviewImage(data.AnhBia);
                    }

                    // Tiến độ
                    if (data.tienDo && data.tienDo.length) {
                        document.getElementById('sectionTienDo').style.display = 'block';
                        var tdHtml = '';
                        data.tienDo.forEach(function (td) {
                            tdHtml += '<li><strong>' + td.TieuDe + '</strong> — ' + td.NgayDang + '<br/><span>' + (td.NoiDung || '') + '</span></li>';
                        });
                        document.getElementById('tdList').innerHTML = tdHtml;
                    }

                    // Hiện phần tiến độ khi edit
                    document.getElementById('sectionTienDo').style.display = 'block';
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối khi tải dữ liệu chiến dịch.', 'err'); });
        }

        // Preview ảnh bìa - lắng nghe cả input và paste
        function showPreviewImage(url) {
            var el = document.getElementById('previewImg');
            if (url && url.trim()) {
                el.style.display = 'block';
                el.innerHTML = '<img src="' + url + '" style="width:100%;border-radius:var(--r)" onerror="this.parentNode.innerHTML=\'<div style=padding:20px;text-align:center;>Không tải được ảnh</div>\'" />';
            } else {
                el.style.display = 'none';
                el.innerHTML = '';
            }
        }

        var anhBiaInput = document.getElementById('fAnhBia');
        anhBiaInput.addEventListener('input', function () { showPreviewImage(this.value); });
        anhBiaInput.addEventListener('paste', function () {
            var self = this;
            setTimeout(function () { showPreviewImage(self.value); }, 100);
        });
        anhBiaInput.addEventListener('change', function () { showPreviewImage(this.value); });

        // Lưu form
        window.saveForm = function () {
            var ten = document.getElementById('fTen').value.trim();
            var ngayBD = document.getElementById('fNgayBD').value;
            var ngayKT = document.getElementById('fNgayKT').value;
            var mucTieu = document.getElementById('fMucTieu').value;
            var danhMuc = document.getElementById('fDanhMuc').value;

            if (!ten) { showToast('Thiếu thông tin', 'Vui lòng nhập tên chiến dịch.', 'warn'); return; }
            if (!ngayBD || !ngayKT) { showToast('Thiếu thông tin', 'Vui lòng chọn ngày bắt đầu và kết thúc.', 'warn'); return; }
            if (!mucTieu || mucTieu <= 0) { showToast('Thiếu thông tin', 'Mục tiêu phải lớn hơn 0.', 'warn'); return; }
            if (!danhMuc) { showToast('Thiếu thông tin', 'Vui lòng chọn danh mục.', 'warn'); return; }

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

            fetch(BASE_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: payload.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (json.ok) {
                        showToast('Thành công', json.msg || 'Đã lưu chiến dịch.', 'ok');
                        if (!isEditMode) {
                            setTimeout(function () {
                                window.location.href = BASE_URL.replace('FormChienDich.aspx', 'QuanLyChienDich.aspx');
                            }, 1400);
                        }
                    } else {
                        showToast('Lỗi', json.msg || 'Lỗi khi lưu.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };

        // Thêm tiến độ
        window.addTienDo = function () {
            if (!isEditMode || !editId) return;
            var tieuDe = document.getElementById('fTDTieuDe').value.trim();
            var ngay = document.getElementById('fTDNgay').value;
            var noiDung = document.getElementById('fTDNoiDung').value.trim();
            if (!tieuDe) { showToast('Thiếu thông tin', 'Nhập tiêu đề tiến độ.', 'warn'); return; }

            var payload = new URLSearchParams({
                __ajax: 'true', action: 'addTienDo',
                id: editId, tieu: tieuDe, ngay: ngay || '', noi: noiDung
            });

            fetch(BASE_URL + '?' + payload)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (j.ok) {
                        showToast('Thành công', 'Đã thêm cập nhật tiến độ.', 'ok');
                        document.getElementById('fTDTieuDe').value = '';
                        document.getElementById('fTDNoiDung').value = '';
                        loadEditData(); // Reload lại tiến độ
                    } else { showToast('Lỗi', j.msg || 'Lỗi khi thêm tiến độ.', 'err'); }
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };
    })();
</script>
</asp:Content>
