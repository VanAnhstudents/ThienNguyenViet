<%@ Page Title="Bai viet" Language="C#"
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
    .status-toggle {
        display: flex; gap: 4px;
    }
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
    <h1>Bai viet</h1>
    <p>Them moi hoac chinh sua bai viet</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="breadcrumb">
        <a href="<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>">Tin tuc</a> / <span id="bcTitle">Them moi</span>
    </div>
    <h2 class="page-title" id="pageTitle">Them bai viet moi</h2>

    <input type="hidden" id="hdnTrangThai" value="1" />

    <div class="form-grid">
        <%-- Cot trai --%>
        <div>
            <div class="card">
                <div class="card-section-title">Noi dung bai viet</div>
                <div class="form-group">
                    <label class="form-label">Tieu de <span class="req">*</span></label>
                    <input type="text" class="input" id="txtTieuDe" style="width:100%" maxlength="200" />
                    <div class="char-counter"><span id="charTieuDe">0</span>/200</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Tom tat</label>
                    <textarea class="input" id="txtTomTat" rows="3" style="width:100%" maxlength="500"></textarea>
                    <div class="char-counter"><span id="charTomTat">0</span>/500</div>
                </div>
                <div class="form-group">
                    <label class="form-label">Noi dung chi tiet</label>
                    <div class="rte-toolbar">
                        <button type="button" class="rte-btn" onclick="document.execCommand('bold')"><b>B</b></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('italic')"><i>I</i></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('underline')"><u>U</u></button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('insertUnorderedList')">&#8226;</button>
                        <button type="button" class="rte-btn" onclick="document.execCommand('insertOrderedList')">1.</button>
                    </div>
                    <div class="rte-body" id="txtNoiDung" contenteditable="true"></div>
                </div>
            </div>
        </div>

        <%-- Cot phai --%>
        <div>
            <div class="card">
                <div class="card-section-title">Thong tin</div>
                <div class="form-group">
                    <label class="form-label">Danh muc <span class="req">*</span></label>
                    <select class="select" id="selDanhMuc" style="width:100%">
                        <option value="">Chon danh muc</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Ngay dang</label>
                    <input type="date" class="input" id="txtNgayDang" style="width:100%" />
                </div>
                <div class="form-group">
                    <label class="form-label">Trang thai</label>
                    <div class="status-toggle">
                        <div class="status-opt active" data-val="1" onclick="setTrangThai(this,1)">Xuat ban</div>
                        <div class="status-opt" data-val="0" onclick="setTrangThai(this,0)">Nhap</div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-section-title">Anh bia</div>
                <div class="form-group">
                    <label class="form-label">URL anh bia</label>
                    <input type="text" class="input" id="txtAnhBia" style="width:100%" placeholder="https://..." />
                </div>
                <div id="previewImg" style="margin-top:8px"></div>
            </div>

            <button type="button" class="btn btn-primary" style="width:100%;margin-top:10px" onclick="saveForm()">Luu bai viet</button>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var BASE = location.pathname;
        var isEditMode = false;
        var editId = 0;

        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('id')) {
            editId = parseInt(urlParams.get('id'));
            isEditMode = true;
            document.getElementById('bcTitle').textContent = 'Chinh sua';
            document.getElementById('pageTitle').textContent = 'Chinh sua bai viet';
        }

        // Default ngay hom nay
        document.getElementById('txtNgayDang').value = new Date().toISOString().split('T')[0];

        // Char counter
        document.getElementById('txtTieuDe').addEventListener('input', function () {
            document.getElementById('charTieuDe').textContent = this.value.length;
        });
        document.getElementById('txtTomTat').addEventListener('input', function () {
            document.getElementById('charTomTat').textContent = this.value.length;
        });

        // Set trang thai
        window.setTrangThai = function (el, val) {
            document.querySelectorAll('.status-opt').forEach(function (b) { b.classList.remove('active'); });
            el.classList.add('active');
            document.getElementById('hdnTrangThai').value = val;
        };

        // Preview anh
        document.getElementById('txtAnhBia').addEventListener('change', function () {
            var url = this.value;
            var el = document.getElementById('previewImg');
            if (url) {
                el.innerHTML = '<img src="' + url + '" style="width:100%;border-radius:var(--r)" onerror="this.parentNode.innerHTML=\'Khong tai duoc anh\'" />';
            } else { el.innerHTML = ''; }
        });

        // Load danh muc
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
            if (isEditMode) loadEditData();
        });

    // Load data khi edit
    function loadEditData() {
        fetch(BASE + '?__ajax=true&action=get&id=' + editId)
            .then(function(r){ return r.json(); })
            .then(function(d){
                if (!d.ok) { showToast('Loi', d.msg || 'Khong tim thay', 'err'); return; }
                var data = d.data;
                document.getElementById('txtTieuDe').value = data.TieuDe || '';
                document.getElementById('charTieuDe').textContent = (data.TieuDe || '').length;
                document.getElementById('txtTomTat').value = data.TomTat || '';
                document.getElementById('charTomTat').textContent = (data.TomTat || '').length;
                document.getElementById('txtNoiDung').innerHTML = data.NoiDung || '';
                document.getElementById('selDanhMuc').value = data.MaDanhMuc || '';
                document.getElementById('txtAnhBia').value = data.AnhBia || '';
                if (data.NgayDang) document.getElementById('txtNgayDang').value = data.NgayDang;
                document.getElementById('hdnTrangThai').value = data.TrangThai;

                // Update status toggle
                document.querySelectorAll('.status-opt').forEach(function(b){
                    b.classList.toggle('active', parseInt(b.getAttribute('data-val')) === data.TrangThai);
                });

                // Preview
                if (data.AnhBia) {
                    document.getElementById('previewImg').innerHTML =
                        '<img src="' + data.AnhBia + '" style="width:100%;border-radius:var(--r)" />';
                }
            });
    }

    // Save
    window.saveForm = function() {
        var tieuDe = document.getElementById('txtTieuDe').value.trim();
        var danhMuc = document.getElementById('selDanhMuc').value;
        var noiDung = document.getElementById('txtNoiDung').innerHTML.trim();

        if (!tieuDe) { showToast('Thieu thong tin', 'Nhap tieu de bai viet.', 'warn'); return; }
        if (!danhMuc) { showToast('Thieu thong tin', 'Chon danh muc.', 'warn'); return; }

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

        fetch(BASE + '?' + payload)
            .then(function(r){ return r.json(); })
            .then(function(j){
                if (j.ok) {
                    showToast('Thanh cong', (isEditMode ? 'Da cap nhat' : 'Da luu') + ' bai viet.', 'ok');
                    if (!isEditMode) {
                        setTimeout(function(){
                            window.location.href = '<%= ResolveUrl("~/Admin/QuanLyTinTuc.aspx") %>';
                        }, 1500);
                    }
                } else {
                    showToast('Loi', j.msg || 'Loi khi luu.', 'err');
                }
            })
                .catch(function () { showToast('Loi', 'Loi ket noi server.', 'err'); });
        };
    })();
</script>
</asp:Content>
