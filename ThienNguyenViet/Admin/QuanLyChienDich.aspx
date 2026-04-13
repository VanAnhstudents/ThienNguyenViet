<%@ Page Title="Quản lý Chiến dịch" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ── Filter bar ──────────────────────────────────────── */
.filter-bar {
    display: flex; align-items: center;
    gap: 10px; flex-wrap: wrap;
}
.filter-bar .input-search {
    flex: 1; min-width: 180px; max-width: 280px;
    height: 36px; padding: 0 12px;
    border: 1px solid var(--border); border-radius: var(--r);
    font-size: 13px; background: #fff;
}

/* ── Status button group ─────────────────────────────── */
.status-btn-group { display: flex; gap: 5px; flex-wrap: wrap; }
.status-btn {
    height: 36px; padding: 0 13px;
    border: 1px solid var(--border); border-radius: var(--r);
    background: var(--bg); font-family: var(--font);
    font-size: 12px; font-weight: 500; color: var(--txt-sub);
    cursor: pointer; white-space: nowrap;
    transition: all .15s;
}
.status-btn:hover { background: #e2e8f0; color: var(--txt); }
.status-btn.active {
    background: var(--accent); color: #fff;
    border-color: var(--accent); font-weight: 600;
}

/* ── Table cells ─────────────────────────────────────── */
.adm-table td .cd-name {
    font-size: 13px; font-weight: 600; color: var(--txt);
}
.adm-table td .cd-sub {
    font-size: 11px; color: var(--txt-sub); margin-top: 2px;
}
.prog-bar-container {
    height: 6px; background: var(--border);
    border-radius: 99px; overflow: hidden; margin-top: 4px;
}
.prog-bar { height: 100%; border-radius: 99px; }
.prog-pct { font-size: 11px; font-weight: 600; color: var(--accent); margin-top: 3px; }

/* ── Action buttons inline ───────────────────────────── */
.btn-action-row { display: flex; gap: 4px; flex-wrap: nowrap; }
.btn-action {
    font-size: 11px; padding: 3px 9px;
    border-radius: var(--r); border: none; cursor: pointer;
    font-family: var(--font); white-space: nowrap;
}

/* ── PAGINATION ──────────────────────────────────────── */
.tbl-footer {
    display: flex; align-items: center; justify-content: center;
    gap: 15px; padding: 15px 0;
    border-top: 1px solid #e2e8f0;
}
#pagingBtns { display: flex; align-items: center; gap: 6px; }
#pagingBtns button {
    min-width: 38px; height: 38px; padding: 0 12px;
    border: 1px solid #e2e8f0; background: #fff; color: #334155;
    border-radius: 8px; font-size: 13px; font-weight: 500; cursor: pointer;
}
#pagingBtns button:hover { background: #f8fafc; border-color: #cbd5e1; }
#pagingBtns button.active { background: #3182CE; color: #fff; border-color: #3182CE; }
#pagingBtns button:disabled { opacity: .4; cursor: not-allowed; }
#pagingInfo { font-size: 13px; color: #64748b; white-space: nowrap; }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Chiến dịch</h1>
    <p>Danh sách toàn bộ chiến dịch trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%-- Filter bar --%>
    <div class="adm-card" style="margin-bottom:18px">
        <div class="filter-bar">
            <input type="text" id="inputSearch" class="input-search"
                   placeholder="Tìm theo tên chiến dịch..." />

            <%-- Danh mục --%>
            <select id="selDanhMuc" style="height:36px;padding:0 10px;border:1px solid var(--border);border-radius:var(--r);font-size:13px;background:#fff;min-width:150px">
                <option value="">Tất cả danh mục</option>
                <option value="1">Cứu trợ thiên tai</option>
                <option value="2">Học bổng & Giáo dục</option>
                <option value="3">Y tế cộng đồng</option>
                <option value="4">Môi trường & Cây xanh</option>
            </select>

            <%-- Trạng thái - button group --%>
            <div class="status-btn-group" id="statusBtnGroup">
                <button type="button" class="status-btn active" data-val="" onclick="setStatusFilter(this,'')">Tất cả</button>
                <button type="button" class="status-btn" data-val="0" onclick="setStatusFilter(this,'0')">Nháp</button>
                <button type="button" class="status-btn" data-val="1" onclick="setStatusFilter(this,'1')">Đang chạy</button>
                <button type="button" class="status-btn" data-val="2" onclick="setStatusFilter(this,'2')">Tạm dừng</button>
                <button type="button" class="status-btn" data-val="3" onclick="setStatusFilter(this,'3')">Đã kết thúc</button>
            </div>

            <button type="button" class="btn-outline" onclick="resetFilter()">Đặt lại</button>

            <a href="<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>"
               class="btn-primary"
               style="margin-left:auto;text-decoration:none;height:36px;display:inline-flex;align-items:center;padding:0 14px;font-size:13px">
                + Thêm chiến dịch mới
            </a>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-hd">
            <div>
                <h3>Danh sách chiến dịch</h3>
                <div class="sub" id="countLabel">Đang tải...</div>
            </div>
        </div>

        <table class="adm-table" id="tblChienDich">
            <thead>
                <tr>
                    <th style="width:28%">Chiến dịch</th>
                    <th>Danh mục</th>
                    <th>Mục tiêu</th>
                    <th>Đã quyên góp</th>
                    <th style="width:110px">Tiến độ</th>
                    <th>Ngày kết thúc</th>
                    <th style="text-align:center;width:70px">Nổi bật</th>
                    <th>Trạng thái</th>
                    <th style="width:100px">Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" style="display:none;text-align:center;padding:60px 20px;color:var(--txt-sub);font-size:13px">
            Không tìm thấy chiến dịch nào phù hợp với điều kiện lọc.
        </div>

        <div class="tbl-footer" id="pagingWrap" style="display:none">
            <span id="pagingInfo"></span>
            <div id="pagingBtns"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';

        var currentPage = 1;
        var PAGE_SIZE = 8;
        var selectedStatus = '';   // '' | '0' | '1' | '2' | '3'
        var searchTimeout = null;

        /* ── Status filter buttons ────────────────────────────────── */
        window.setStatusFilter = function (btn, val) {
            document.querySelectorAll('#statusBtnGroup .status-btn').forEach(function (b) {
                b.classList.remove('active');
            });
            btn.classList.add('active');
            selectedStatus = val;
            currentPage = 1;
            loadData();
        };

        /* ── Helpers ─────────────────────────────────────────────── */
        function fmtMoney(n) {
            if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ';
            if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr';
            return n.toLocaleString('vi-VN');
        }

        function trangThaiBadge(ts) {
            var map = {
                0: '<span class="badge badge-wait">Nháp</span>',
                1: '<span class="badge badge-ok">Đang chạy</span>',
                2: '<span class="badge badge-info">Tạm dừng</span>',
                3: '<span class="badge badge-reject">Đã kết thúc</span>'
            };
            return map[ts] || '—';
        }

        /* ── Pagination ──────────────────────────────────────────── */
        function renderPagination(totalPages) {
            var wrap = document.getElementById('pagingWrap');
            var info = document.getElementById('pagingInfo');
            var btns = document.getElementById('pagingBtns');
            if (totalPages <= 1) { wrap.style.display = 'none'; return; }

            wrap.style.display = 'flex';
            info.innerHTML = 'Trang <strong>' + currentPage + '</strong> / ' + totalPages;
            btns.innerHTML = '';

            var btn = document.createElement('button');
            btn.type = 'button'; btn.innerHTML = '&laquo; Trước';
            btn.disabled = currentPage === 1;
            btn.onclick = function () { goToPage(currentPage - 1); };
            btns.appendChild(btn);

            var maxV = 7;
            var start = Math.max(1, currentPage - Math.floor(maxV / 2));
            var end = Math.min(totalPages, start + maxV - 1);
            if (end - start < maxV - 1) start = Math.max(1, end - maxV + 1);

            for (var i = start; i <= end; i++) {
                (function (page) {
                    btn = document.createElement('button');
                    btn.type = 'button'; btn.textContent = page;
                    if (page === currentPage) btn.classList.add('active');
                    btn.onclick = function () { goToPage(page); };
                    btns.appendChild(btn);
                })(i);
            }

            btn = document.createElement('button');
            btn.type = 'button'; btn.innerHTML = 'Sau &raquo;';
            btn.disabled = currentPage === totalPages;
            btn.onclick = function () { goToPage(currentPage + 1); };
            btns.appendChild(btn);
        }

        window.goToPage = function (page) { currentPage = page; loadData(); };

        /* ── Load data ───────────────────────────────────────────── */
        function loadData() {
            var params = new URLSearchParams({
                __ajax: 'true',
                action: 'list',
                TuKhoa: document.getElementById('inputSearch').value.trim(),
                MaDanhMuc: document.getElementById('selDanhMuc').value,
                TrangThai: selectedStatus,
                TrangHienTai: currentPage,
                SoDoiMoiTrang: PAGE_SIZE,
                SapXepTheo: 'NgayTao'
            });

            fetch(location.pathname + '?' + params, {
                method: 'GET', headers: { 'Cache-Control': 'no-cache' }
            })
                .then(function (r) { return r.json(); })
                .then(function (json) {
                    if (json.ok) renderTable(json.data, json.total);
                })
                .catch(function (err) { console.error('LoadData error:', err); });
        }

        /* ── Render table ────────────────────────────────────────── */
        function renderTable(data, total) {
            var tbody = document.getElementById('tableBody');
            var empty = document.getElementById('emptyMsg');

            if (!data || !data.length) {
                tbody.innerHTML = '';
                empty.style.display = 'block';
                document.getElementById('pagingWrap').style.display = 'none';
                document.getElementById('countLabel').innerHTML = '0 chiến dịch';
                return;
            }

            empty.style.display = 'none';
            document.getElementById('pagingWrap').style.display = 'flex';

            var html = '';
            data.forEach(function (c) {
                var pct = c.MucTieu > 0 ? Math.round(c.SoTienDaQuyen * 100 / c.MucTieu) : 0;
                var color = c.MauDanhMuc || '#3182CE';
                var tenEsc = c.TenChienDich.replace(/'/g, "\\'");
                html += '<tr>' +
                    '<td><div class="cd-name">' + c.TenChienDich + '</div><div class="cd-sub">' + (c.MoTaNgan || '') + '</div></td>' +
                    '<td><span style="background:rgba(49,130,206,0.1);color:' + color + ';padding:2px 8px;border-radius:4px;font-size:11px">' + c.TenDanhMuc + '</span></td>' +
                    '<td>' + fmtMoney(c.MucTieu) + '</td>' +
                    '<td style="color:#38A169;font-weight:600">' + fmtMoney(c.SoTienDaQuyen) + '</td>' +
                    '<td>' +
                    '<div class="prog-bar-container"><div class="prog-bar" style="width:' + pct + '%;background:' + color + '"></div></div>' +
                    '<div class="prog-pct">' + pct + '%</div>' +
                    '</td>' +
                    '<td>' + c.NgayKetThuc + '<br><small style="color:#D69E2E">Còn ' + c.SoNgayCon + ' ngày</small></td>' +
                    '<td style="text-align:center;font-size:18px">' + (c.NoiBat ? '⭐' : '☆') + '</td>' +
                    '<td>' + trangThaiBadge(c.TrangThai) + '</td>' +
                    '<td>' +
                    '<div class="btn-action-row">' +
                    '<a href="FormChienDich.aspx?id=' + c.MaChienDich + '" class="btn-edit btn-action">Sửa</a>' +
                    '<button type="button" class="btn-delete btn-action" onclick="xoaChienDich(' + c.MaChienDich + ',\'' + tenEsc + '\')">Xóa</button>' +
                    '</div>' +
                    '</td></tr>';
            });

            tbody.innerHTML = html;
            document.getElementById('countLabel').innerHTML =
                'Hiển thị <strong>' + ((currentPage - 1) * PAGE_SIZE + 1) + '</strong>–<strong>' +
                Math.min(currentPage * PAGE_SIZE, total) + '</strong> / ' + total + ' chiến dịch';

            renderPagination(Math.ceil(total / PAGE_SIZE));
        }

        /* ── Xóa chiến dịch (dùng admConfirm, không dùng alert) ──── */
        window.xoaChienDich = function (id, ten) {
            admConfirm({
                title: 'Xóa chiến dịch',
                msg: 'Bạn có chắc muốn xóa chiến dịch "' + ten + '"? Hành động này không thể hoàn tác.',
                okLabel: 'Xóa',
                okClass: 'btn-reject',
                onOk: function () {
                    var params = new URLSearchParams({ __ajax: 'true', action: 'delete', id: id });
                    fetch(location.pathname + '?' + params, { method: 'GET' })
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d.ok) {
                                admToast('Đã xóa', 'Chiến dịch đã được xóa thành công.', 'ok');
                                loadData();
                            } else {
                                admToast('Không thể xóa', d.msg || 'Chiến dịch có dữ liệu liên quan.', 'err');
                            }
                        })
                        .catch(function () { admToast('Lỗi kết nối', 'Không thể kết nối máy chủ.', 'err'); });
                }
            });
        };

        /* ── Events ──────────────────────────────────────────────── */
        window.applyFilter = function () { currentPage = 1; loadData(); };

        window.resetFilter = function () {
            document.getElementById('inputSearch').value = '';
            document.getElementById('selDanhMuc').value = '';
            selectedStatus = '';
            document.querySelectorAll('#statusBtnGroup .status-btn').forEach(function (b) {
                b.classList.remove('active');
                if (b.dataset.val === '') b.classList.add('active');
            });
            currentPage = 1;
            loadData();
        };

        function initEvents() {
            var searchInput = document.getElementById('inputSearch');
            var selDanhMuc = document.getElementById('selDanhMuc');

            searchInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') { e.preventDefault(); applyFilter(); }
            });
            searchInput.addEventListener('input', function () {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(applyFilter, 400);
            });
            selDanhMuc.addEventListener('change', applyFilter);
        }

        /* ── Init ────────────────────────────────────────────────── */
        window.onload = function () {
            initEvents();
            loadData();
        };

    })();
</script>
</asp:Content>
