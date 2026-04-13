<%@ Page Title="Bài viết" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="FormTinTuc.aspx.cs"
    Inherits="ThienNguyenViet.Admin.FormTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .page-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; }
    .form-grid { display: grid; grid-template-columns: 1fr 300px; gap: 20px; align-items: start; }
    .card-section-title { font-size: 14px; font-weight: 600; margin-bottom: 14px; }

    /* Rich text toolbar */
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
        min-height: 250px; padding: 10px; font-size: 13px; line-height: 1.6;
        outline: none; overflow-y: auto; background: #fff;
    }

    /* Char counter */
    .char-counter { font-size: 11px; color: var(--txt-sub); text-align: right; margin-top: 3px; }
    .char-counter.over { color: var(--err); font-weight: 600; }

    /* Status toggle */
    .status-toggle { display: flex; gap: 4px; }
    .status-opt {
        flex: 1; padding: 8px; text-align: center;
        border: 1px solid var(--border); border-radius: var(--r);
        font-size: 12px; font-weight: 500; cursor: pointer;
        transition: all .15s; background: var(--bg); color: var(--txt-sub);
    }
    .status-opt.active {
        background: var(--accent); color: #fff; border-color: var(--accent);
    }

    @media (max-width: 768px) {
        .form-grid { grid-template-columns: 1fr; }
    }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bài viết</h1>
    <p>Thêm mới hoặc chỉnh sửa bài viết</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="breadcrumb">
        <a href="<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>">Tin tức</a> / <span id="bcTitle">Thêm mới</span>
    </div>
    <h2 class="page-title" id="pageTitle">Thêm bài viết mới</h2>

    <input type="hidden" id="hdnTrangThai" value="1" />

    <div class="form-grid">
        <%-- Cột trái --%>
        <div>
            <div class="card">
                <div class="card-section-title">Nội dung bài viết</div>
                <div class="form-group">
                    <label class="form-label">Tiêu đề <span class="req">*</span></label>
                    <input type="text" class="input" id="txtTieuDe" style="width:100%" maxlength="200"
                        placeholder="Ví dụ: Hành trình thiện nguyện tại vùng cao Tây Bắc" />
                    <div class="form-hint">Tiêu đề bài viết, ngắn gọn và thu hút (tối đa 200 ký tự)</div>
                    <div class="char-counter"><span id="charTieuDe">0</span>/200</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Tóm tắt</label>
                    <textarea class="input" id="txtTomTat" rows="3" style="width:100%" maxlength="500"
                        placeholder="Tóm tắt nội dung bài viết trong 2-3 câu. Phần này sẽ hiển thị ở danh sách bài viết."></textarea>
                    <div class="form-hint">Phần mô tả ngắn hiển thị trên trang danh sách (tối đa 500 ký tự)</div>
                    <div class="char-counter"><span id="charTomTat">0</span>/500</div>
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
                    <div class="rte-body" id="txtNoiDung" contenteditable="true"></div>
                    <div class="form-hint">Nội dung bài viết đầy đủ. Có thể định dạng in đậm, in nghiêng, gạch chân...</div>
                </div>
            </div>
        </div>

        <%-- Cột phải --%>
        <div>
            <div class="card">
                <div class="card-section-title">Trạng thái</div>
                <div class="status-toggle">
                    <div class="status-opt active" onclick="setTrangThai(this,'1')">Xuất bản</div>
                    <div class="status-opt" onclick="setTrangThai(this,'0')">Bản nháp</div>
                </div>
                <div class="form-hint" style="margin-top:6px">Xuất bản = hiển thị cho người dùng, Bản nháp = chưa công khai</div>
            </div>

            <div class="card">
                <div class="card-section-title">Phân loại</div>
                <div class="form-group">
                    <label class="form-label">Danh mục</label>
                    <select class="select" id="selDanhMuc" style="width:100%">
                        <option value="">Chọn danh mục</option>
                    </select>
                    <div class="form-hint">Chọn danh mục phù hợp cho bài viết</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Ngày đăng</label>
                    <input type="date" class="input" id="txtNgayDang" style="width:100%" />
                    <div class="form-hint">Ngày hiển thị trên bài viết</div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Ảnh bìa</div>
                <div class="form-group">
                    <label class="form-label">URL ảnh bìa</label>
                    <input type="text" class="input" id="txtAnhBia" style="width:100%"
                        placeholder="https://example.com/anh-bai-viet.jpg" />
                    <div class="form-hint">Dán đường dẫn ảnh bìa (JPG, PNG). Ảnh sẽ xem trước bên dưới.</div>
                </div>
                <div id="previewImg" class="img-preview" style="display:none"></div>
            </div>

            <button type="button" class="btn btn-primary" style="width:100%;margin-top:10px" onclick="saveTinTuc()">Lưu bài viết</button>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = '<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>';
        var isEditMode = false;
        var editId = 0;

        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('id')) {
            editId = parseInt(urlParams.get('id'));
            isEditMode = true;
            document.getElementById('bcTitle').textContent = 'Chỉnh sửa';
            document.getElementById('pageTitle').textContent = 'Chỉnh sửa bài viết';
        }

        // Default ngày hôm nay
        document.getElementById('txtNgayDang').value = new Date().toISOString().split('T')[0];

        // Char counter
        document.getElementById('txtTieuDe').addEventListener('input', function () {
            document.getElementById('charTieuDe').textContent = this.value.length;
        });
        document.getElementById('txtTomTat').addEventListener('input', function () {
            document.getElementById('charTomTat').textContent = this.value.length;
        });

        // Set trạng thái
        window.setTrangThai = function (el, val) {
            document.querySelectorAll('.status-opt').forEach(function (b) { b.classList.remove('active'); });
            el.classList.add('active');
            document.getElementById('hdnTrangThai').value = val;
        };

        // Preview ảnh bìa - lắng nghe input, paste, change
        function showPreviewImage(url) {
            var el = document.getElementById('previewImg');
            if (url && url.trim()) {
                el.style.display = 'block';
                el.innerHTML = '<img src="' + url + '" style="width:100%;border-radius:var(--r)" onerror="this.parentNode.innerHTML=\'<div style=padding:20px;text-align:center;color:var(--err)>Không tải được ảnh</div>\'" />';
            } else {
                el.style.display = 'none';
                el.innerHTML = '';
            }
        }

        var anhBiaInput = document.getElementById('txtAnhBia');
        anhBiaInput.addEventListener('input', function(){ showPreviewImage(this.value); });
        anhBiaInput.addEventListener('paste', function(){
            var self = this;
            setTimeout(function(){ showPreviewImage(self.value); }, 100);
        });
        anhBiaInput.addEventListener('change', function(){ showPreviewImage(this.value); });

        // Load danh mục
        fetch('<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>?__ajax=true&action=danhMuc')
            .then(function(r){ return r.json(); })
            .then(function(d){
                if (!d.ok || !d.data) return;
                var sel = document.getElementById('selDanhMuc');
                d.data.forEach(function(dm){
                    var opt = document.createElement('option');
                    opt.value = dm.MaDanhMuc;
                    opt.textContent = dm.TenDanhMuc;
                    sel.appendChild(opt);
                });

                // FIX: Load dữ liệu edit SAU KHI danh mục đã load xong
                if (isEditMode) loadEditData();
            });

        // FIX: Load toàn bộ dữ liệu tin tức khi ở chế độ edit
        function loadEditData() {
            fetch(BASE + '?__ajax=true&action=get&id=' + editId)
                .then(function(r){ return r.json(); })
                .then(function(d){
                    if (!d.ok) { showToast('Lỗi', d.msg || 'Không tìm thấy bài viết.', 'err'); return; }
                    var data = d.data;

                    // Điền toàn bộ dữ liệu lên form
                    document.getElementById('txtTieuDe').value = data.TieuDe || '';
                    document.getElementById('charTieuDe').textContent = (data.TieuDe || '').length;
                    document.getElementById('txtTomTat').value = data.TomTat || '';
                    document.getElementById('charTomTat').textContent = (data.TomTat || '').length;
                    document.getElementById('txtNoiDung').innerHTML = data.NoiDung || '';
                    document.getElementById('selDanhMuc').value = data.MaDanhMuc || '';
                    document.getElementById('txtNgayDang').value = data.NgayDang || '';

                    // Trạng thái
                    var trangThai = data.TrangThai != null ? String(data.TrangThai) : '1';
                    document.getElementById('hdnTrangThai').value = trangThai;
                    document.querySelectorAll('.status-opt').forEach(function(b){ b.classList.remove('active'); });
                    if (trangThai === '1') {
                        document.querySelectorAll('.status-opt')[0].classList.add('active');
                    } else {
                        document.querySelectorAll('.status-opt')[1].classList.add('active');
                    }

                    // Ảnh bìa + preview
                    if (data.AnhBia) {
                        document.getElementById('txtAnhBia').value = data.AnhBia;
                        showPreviewImage(data.AnhBia);
                    }
                })
                .catch(function(){ showToast('Lỗi', 'Lỗi kết nối khi tải dữ liệu bài viết.', 'err'); });
        }

        // Lưu bài viết
        window.saveTinTuc = function () {
            var tieuDe = document.getElementById('txtTieuDe').value.trim();
            if (!tieuDe) { showToast('Thiếu thông tin', 'Vui lòng nhập tiêu đề bài viết.', 'warn'); return; }

            var payload = new URLSearchParams({
                __ajax: 'true',
                action: isEditMode ? 'update' : 'insert',
                id: editId || '',
                tieuDe: tieuDe,
                tomTat: document.getElementById('txtTomTat').value,
                noiDung: document.getElementById('txtNoiDung').innerHTML,
                anhBia: document.getElementById('txtAnhBia').value,
                maDanhMuc: document.getElementById('selDanhMuc').value,
                trangThai: document.getElementById('hdnTrangThai').value,
                ngayDang: document.getElementById('txtNgayDang').value
            });

            fetch(BASE + '?' + payload)
                .then(function(r){ return r.json(); })
                .then(function(j){
                    if (j.ok) {
                        showToast('Thành công', (isEditMode ? 'Đã cập nhật' : 'Đã lưu') + ' bài viết.', 'ok');
                        if (!isEditMode) {
                            setTimeout(function(){
                                window.location.href = '<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>';
                            }, 1500);
                        }
                    } else {
                        showToast('Lỗi', j.msg || 'Lỗi khi lưu.', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi', 'Lỗi kết nối server.', 'err'); });
        };
    })();
</script>
</asp:Content>
