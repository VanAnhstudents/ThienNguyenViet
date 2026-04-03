<%@ Page Title="Quản lý Chiến dịch" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .filter-bar {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

            .filter-bar .input-search {
                flex: 1;
                min-width: 260px;
                height: 38px;
                padding: 0 14px;
                border: 1px solid var(--border);
                border-radius: var(--r);
                font-size: 13px;
                background: #fff;
            }

            .filter-bar select {
                height: 38px;
                padding: 0 12px;
                border: 1px solid var(--border);
                border-radius: var(--r);
                font-size: 13px;
                background: #fff;
                min-width: 160px;
            }

            .filter-bar .btn-primary-sm,
            .filter-bar .btn-outline-sm {
                height: 38px;
                padding: 0 18px;
                font-size: 13px;
                font-weight: 500;
            }

        .adm-table td .cd-name {
            font-size: 13px;
            font-weight: 600;
            color: var(--txt);
        }

        .adm-table td .cd-sub {
            font-size: 11px;
            color: var(--txt-sub);
            margin-top: 2px;
        }

        /* Progress bar reuse từ TongQuan */
        .prog-bar-container {
            height: 6px;
            background: var(--border);
            border-radius: 99px;
            overflow: hidden;
            margin-top: 4px;
        }

        .prog-bar {
            height: 100%;
            border-radius: 99px;
        }

        .prog-pct {
            font-size: 11px;
            font-weight: 600;
            color: var(--accent);
            margin-top: 3px;
        }

        /* Nút hành động */
        .btn-action {
            font-size: 12px;
            padding: 4px 12px;
            border-radius: var(--r);
            margin-right: 4px;
        }

        /* PAGINATION */
        .tbl-footer {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            padding: 15px 0;
            border-top: 1px solid #e2e8f0;
        }

        #pagingBtns {
            display: flex;
            align-items: center;
            gap: 6px;
        }

            #pagingBtns button {
                min-width: 38px;
                height: 38px;
                padding: 0 12px;
                border: 1px solid #e2e8f0;
                background: #fff;
                color: #334155;
                border-radius: 8px;
                font-size: 13px;
                font-weight: 500;
                cursor: pointer;
            }

                #pagingBtns button:hover {
                    background: #f8fafc;
                    border-color: #cbd5e1;
                }

                #pagingBtns button.active {
                    background: #3182CE;
                    color: #fff;
                    border-color: #3182CE;
                }

                #pagingBtns button:disabled {
                    opacity: 0.4;
                    cursor: not-allowed;
                }

        #pagingInfo {
            font-size: 13px;
            color: #64748b;
            white-space: nowrap;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Chiến dịch</h1>
    <p>Danh sách toàn bộ chiến dịch trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="adm-card" style="margin-bottom: 18px;">
        <div class="filter-bar">
            <input type="text" id="inputSearch" class="input-search" placeholder="Tìm theo tên chiến dịch..." />

            <select id="selDanhMuc" class="form-control">
                <option value="">Tất cả danh mục</option>
                <option value="1">Cứu trợ thiên tai</option>
                <option value="2">Học bổng & Giáo dục</option>
                <option value="3">Y tế cộng đồng</option>
                <option value="4">Môi trường & Cây xanh</option>
            </select>

            <select id="selTrangThai" class="form-control">
                <option value="">Tất cả trạng thái</option>
                <option value="0">Nháp</option>
                <option value="1">Đang chạy</option>
                <option value="2">Tạm dừng</option>
                <option value="3">Đã kết thúc</option>
            </select>

            <button type="button" class="btn-primary" onclick="applyFilter()" style="display: none;">Tìm kiếm</button>
            <button type="button" class="btn-outline" onclick="resetFilter()">Đặt lại</button>

            <!-- Nút thêm mới – đã chuyển thành button đẹp -->
            <a href="FormChienDich.aspx" class="btn-primary" style="margin-left: auto; text-decoration: none;">＋ Thêm chiến dịch mới
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
                    <th style="width: 28%">Chiến dịch</th>
                    <th>Danh mục</th>
                    <th>Mục tiêu</th>
                    <th>Đã quyên góp</th>
                    <th style="width: 110px">Tiến độ</th>
                    <th>Ngày kết thúc</th>
                    <th style="text-align: center; width: 70px">Nổi bật</th>
                    <th>Trạng thái</th>
                    <th style="width: 110px">Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" style="display: none; text-align: center; padding: 60px 20px; color: var(--txt-sub); font-size: 13px;">
            Không tìm thấy chiến dịch nào phù hợp với điều kiện lọc.
        </div>

        <div class="tbl-footer" id="pagingWrap" style="display: none;">
            <span id="pagingInfo"></span>
            <div id="pagingBtns"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        let currentPage = 1;
        const PAGE_SIZE = 8;
        let searchTimeout = null;

        function fmtMoney(n) {
            if (n >= 1000000000) return (n / 1000000000).toFixed(2) + ' tỷ';
            if (n >= 1000000) return (n / 1000000).toFixed(1) + ' tr';
            return n.toLocaleString('vi-VN');
        }

        function trangThaiBadge(ts) {
            const map = {
                0: '<span class="badge badge-wait">Nháp</span>',
                1: '<span class="badge badge-ok">Đang chạy</span>',
                2: '<span class="badge badge-warn">Tạm dừng</span>',
                3: '<span class="badge badge-info">Đã kết thúc</span>'
            };
            return map[ts] || '—';
        }

        function log(msg) {
            console.log(`[QuanLyChienDich] ${msg}`);
        }

        /* ====================== PAGINATION ====================== */
        function renderPagination(totalPages) {
            const pagingWrap = document.getElementById('pagingWrap');
            const pagingInfo = document.getElementById('pagingInfo');
            const pagingBtns = document.getElementById('pagingBtns');

            if (totalPages <= 1) {
                pagingWrap.style.display = 'none';
                return;
            }

            pagingWrap.style.display = 'flex';
            pagingInfo.innerHTML = `Trang <strong>${currentPage}</strong> / ${totalPages}`;

            pagingBtns.innerHTML = '';

            let btn = document.createElement('button');
            btn.type = 'button';
            btn.innerHTML = '&laquo; Trước';
            btn.disabled = currentPage === 1;
            btn.onclick = () => goToPage(currentPage - 1);
            pagingBtns.appendChild(btn);

            const maxVisible = 7;
            let start = Math.max(1, currentPage - Math.floor(maxVisible / 2));
            let end = Math.min(totalPages, start + maxVisible - 1);
            if (end - start < maxVisible - 1) start = Math.max(1, end - maxVisible + 1);

            for (let i = start; i <= end; i++) {
                btn = document.createElement('button');
                btn.type = 'button';
                btn.textContent = i;
                if (i === currentPage) btn.classList.add('active');
                btn.onclick = () => goToPage(i);
                pagingBtns.appendChild(btn);
            }

            btn = document.createElement('button');
            btn.type = 'button';
            btn.innerHTML = 'Sau &raquo;';
            btn.disabled = currentPage === totalPages;
            btn.onclick = () => goToPage(currentPage + 1);
            pagingBtns.appendChild(btn);
        }

        /* ====================== LOAD DATA ====================== */
        async function loadData() {
            log(`Đang load trang ${currentPage}`);

            const params = new URLSearchParams({
                __ajax: 'true',
                action: 'list',
                TuKhoa: document.getElementById('inputSearch').value.trim(),
                MaDanhMuc: document.getElementById('selDanhMuc').value,
                TrangThai: document.getElementById('selTrangThai').value,
                TrangHienTai: currentPage,
                SoDoiMoiTrang: PAGE_SIZE,
                SapXepTheo: 'NgayTao'
            });

            try {
                const res = await fetch(`${location.pathname}?${params}`, {
                    method: 'GET',
                    headers: { 'Cache-Control': 'no-cache' }
                });

                const json = await res.json();

                if (json.ok) {
                    log(`✅ Load thành công: ${json.data.length} dòng`);
                    renderTable(json.data, json.total);
                } else {
                    log('❌ Lỗi server: ' + (json.msg || 'không rõ'));
                }
            } catch (err) {
                console.error('LoadData error:', err);
            }
        }

        function renderTable(data, total) {
            const tbody = document.getElementById('tableBody');
            const empty = document.getElementById('emptyMsg');

            if (!data || data.length === 0) {
                tbody.innerHTML = '';
                empty.style.display = 'block';
                document.getElementById('pagingWrap').style.display = 'none';
                document.getElementById('countLabel').innerHTML = '0 chiến dịch';
                return;
            }

            empty.style.display = 'none';
            document.getElementById('pagingWrap').style.display = 'flex';

            let html = '';
            data.forEach(c => {
                const pct = c.MucTieu > 0 ? Math.round(c.SoTienDaQuyen * 100 / c.MucTieu) : 0;
                const color = c.MauDanhMuc || '#3182CE';
                html += `
            <tr>
                <td><div class="cd-name">${c.TenChienDich}</div><div class="cd-sub">${c.MoTaNgan || ''}</div></td>
                <td><span style="background:rgba(49,130,206,0.1);color:${color};padding:2px 8px;border-radius:4px;font-size:11px;">${c.TenDanhMuc}</span></td>
                <td>${fmtMoney(c.MucTieu)}</td>
                <td style="color:#38A169;font-weight:600">${fmtMoney(c.SoTienDaQuyen)}</td>
                <td>
                    <div class="prog-bar-container"><div class="prog-bar" style="width:${pct}%;background:${color}"></div></div>
                    <div class="prog-pct">${pct}%</div>
                </td>
                <td>${c.NgayKetThuc}<br><small style="color:#D69E2E">Còn ${c.SoNgayCon} ngày</small></td>
                <td style="text-align:center;font-size:18px">${c.NoiBat ? '⭐' : '☆'}</td>
                <td>${trangThaiBadge(c.TrangThai)}</td>
                <td>
                    <a href="FormChienDich.aspx?id=${c.MaChienDich}" class="btn-edit btn-action">Sửa</a>
                    <button type="button" onclick="xoaChienDich(${c.MaChienDich}, '${c.TenChienDich.replace(/'/g, "\\'")}')" class="btn-delete btn-action">Xóa</button>
                </td>
            </tr>`;
            });

            tbody.innerHTML = html;
            document.getElementById('countLabel').innerHTML =
                `Hiển thị <strong>${(currentPage - 1) * PAGE_SIZE + 1}</strong>–<strong>${Math.min(currentPage * PAGE_SIZE, total)}</strong> / ${total} chiến dịch`;

            renderPagination(Math.ceil(total / PAGE_SIZE));
        }

        /* ====================== TỰ ĐỘNG LỌC ====================== */
        function applyFilter() {
            currentPage = 1;
            loadData();
        }

        /* ====================== KHỞI TẠO EVENT ====================== */
        function initEvents() {
            const searchInput = document.getElementById('inputSearch');
            const selDanhMuc = document.getElementById('selDanhMuc');
            const selTrangThai = document.getElementById('selTrangThai');

            // 1. Tìm kiếm bằng Enter
            searchInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    applyFilter();
                }
            });

            // Tìm kiếm realtime (debounce 400ms)
            searchInput.addEventListener('input', function () {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    applyFilter();
                }, 400);
            });

            // 2. Chọn danh mục hoặc trạng thái → lọc ngay
            selDanhMuc.addEventListener('change', applyFilter);
            selTrangThai.addEventListener('change', applyFilter);
        }

        window.goToPage = function (page) {
            currentPage = parseInt(page);
            loadData();
        };

        window.resetFilter = () => {
            document.getElementById('inputSearch').value = '';
            document.getElementById('selDanhMuc').value = '';
            document.getElementById('selTrangThai').value = '';
            currentPage = 1;
            loadData();
        };

        window.xoaChienDich = async (id, ten) => {
            if (!confirm(`Xóa chiến dịch "${ten}"?`)) return;
            const params = new URLSearchParams({ __ajax: 'true', action: 'delete', id: id });
            try {
                await fetch(`${location.pathname}?${params}`, { method: 'GET' });
                loadData();
            } catch (e) { }
        };

        window.onload = () => {
            log('Trang đã load - bắt đầu loadData()');
            initEvents();
            loadData();
        };
    </script>
</asp:Content>
