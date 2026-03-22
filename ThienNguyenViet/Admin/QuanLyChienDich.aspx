<%@ Page Title="Quản lý Chiến dịch" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyChienDich.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .topbar {
            display: flex; align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .topbar-title { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); }

        .filter-bar {
            display: flex; align-items: center;
            gap: 10px; flex-wrap: wrap;
        }
        .input-search {
            height: 34px; padding: 0 10px;
            border: 1px solid var(--admin-vien);
            border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font);
            color: var(--admin-chu-chinh);
            width: 220px; outline: none;
        }
        .input-search:focus { border-color: #3182CE; }

        .select-filter {
            height: 34px; padding: 0 8px;
            border: 1px solid var(--admin-vien);
            border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font);
            color: var(--admin-chu-chinh);
            background: #fff; cursor: pointer; outline: none;
        }

        .btn-primary-sm {
            height: 34px; padding: 0 14px;
            background: #3182CE; color: #fff;
            border: none; border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font); font-weight: 500;
            cursor: pointer;
        }
        .btn-primary-sm:hover { background: #2B6CB0; }

        .btn-outline-sm {
            height: 34px; padding: 0 12px;
            background: transparent; color: var(--admin-chu-phu);
            border: 1px solid var(--admin-vien);
            border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font); cursor: pointer;
        }
        .btn-outline-sm:hover { background: var(--admin-nen); }

        .btn-add-link {
            height: 36px; padding: 0 16px;
            background: #3182CE; color: #fff;
            border: none; border-radius: var(--r-nut);
            font-size: 13px; font-family: var(--font); font-weight: 500;
            text-decoration: none;
            display: inline-flex; align-items: center; gap: 4px;
        }
        .btn-add-link:hover { background: #2B6CB0; color: #fff; }

        .section-header {
            display: flex; align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }
        .section-title { font-size: 14px; font-weight: 600; }
        .count-label   { font-size: 12px; color: var(--admin-chu-phu); }

        .cd-name {
            font-size: 13px; font-weight: 500;
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
            max-width: 210px;
        }
        .cd-sub {
            font-size: 11px; color: var(--admin-chu-phu);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
            max-width: 210px; margin-top: 2px;
        }

        .prog-wrap {
            height: 5px; background: var(--admin-vien);
            border-radius: 99px; overflow: hidden; margin-bottom: 3px;
        }
        .prog-bar  { height: 100%; border-radius: 99px; }
        .prog-pct  { font-size: 11px; color: var(--admin-chu-phu); }

        .noibat-yes { color: #D69E2E; }

        /* Pagination */
        .pagination-wrap {
            display: flex; align-items: center;
            justify-content: space-between;
            padding-top: 14px;
            border-top: 1px solid var(--admin-vien);
            margin-top: 4px;
        }
        .paging-info { font-size: 12px; color: var(--admin-chu-phu); }
        .paging-btns { display: flex; align-items: center; gap: 6px; }
        .paging-btn {
            font-size: 12px; padding: 4px 10px;
            border-radius: var(--r-nut);
            background: #fff;
            border: 1px solid var(--admin-vien);
            color: var(--admin-chu-chinh);
            cursor: pointer;
        }
        .paging-btn:hover   { background: var(--admin-nen); }
        .paging-btn.active  { background: #3182CE; color: #fff; border-color: #3182CE; }
        .paging-btn:disabled { opacity: .4; cursor: default; }

        .alert-success {
            padding: 10px 14px; background: #C6F6D5; color: #276749;
            border-radius: var(--r-nut); font-size: 13px; margin-bottom: 16px;
        }
        #alertBox { display: none; }
    </style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Chiến dịch</h1>
    <p>Danh sách toàn bộ chiến dịch trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="alertBox" class="alert-success"></div>

    <%-- Topbar --%>
    <div class="topbar">
        <h1 class="topbar-title">Danh sách chiến dịch</h1>
        <a href="/Admin/FormChienDich.aspx" class="btn-add-link">＋ Thêm chiến dịch</a>
    </div>

    <%-- Filter --%>
    <div class="admin-card" style="margin-bottom:16px;padding:14px 20px;">
        <div class="filter-bar">
            <input type="text"     id="inputSearch"   class="input-search"  placeholder="Tìm theo tên chiến dịch..." />
            <select id="selDanhMuc"  class="select-filter">
                <option value="">Tất cả danh mục</option>
                <option value="1">Cứu trợ thiên tai</option>
                <option value="2">Học bổng &amp; Giáo dục</option>
                <option value="3">Y tế cộng đồng</option>
                <option value="4">Môi trường &amp; Cây xanh</option>
            </select>
            <select id="selTrangThai" class="select-filter">
                <option value="">Tất cả trạng thái</option>
                <option value="0">Nháp</option>
                <option value="1">Đang chạy</option>
                <option value="2">Tạm dừng</option>
                <option value="3">Đã kết thúc</option>
            </select>
            <button class="btn-primary-sm" onclick="applyFilter()">Tìm kiếm</button>
            <button class="btn-outline-sm" onclick="resetFilter()">Đặt lại</button>
        </div>
    </div>

    <%-- Table --%>
    <div class="admin-card">
        <div class="section-header">
            <span class="section-title">Danh sách chiến dịch</span>
            <span class="count-label" id="countLabel"></span>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width:26%">Chiến dịch</th>
                    <th>Danh mục</th>
                    <th>Mục tiêu</th>
                    <th>Đã quyên</th>
                    <th style="width:90px">Tiến độ</th>
                    <th>Ngày KT</th>
                    <th style="text-align:center">Nổi bật</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" style="display:none;text-align:center;padding:48px 0;color:var(--admin-chu-phu)">
            <div style="font-size:36px;margin-bottom:8px">📭</div>
            <div>Không tìm thấy chiến dịch nào phù hợp.</div>
        </div>

        <div class="pagination-wrap" id="pagingWrap">
            <span class="paging-info" id="pagingInfo"></span>
            <div class="paging-btns" id="pagingBtns"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ── Mock data (khớp SampleData.sql) ─────────────────────────── */
var MOCK_DATA = [
    {
        id: 1,
        ten: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026',
        moTa: 'Quyên góp hỗ trợ người dân miền Trung bị ảnh hưởng bởi đợt lũ lịch sử.',
        maDanhMuc: 1, tenDanhMuc: 'Cứu trợ thiên tai', mauDanhMuc: '#E53E3E',
        mucTieu: 500000000, daThu: 320000000,
        ngayKT: '30/04/2026', ngayCon: 38,
        trangThai: 1, noiBat: true
    },
    {
        id: 2,
        ten: 'Học bổng "Thắp sáng ước mơ" cho học sinh vùng cao',
        moTa: 'Trao học bổng cho 50 học sinh dân tộc thiểu số có hoàn cảnh khó khăn.',
        maDanhMuc: 2, tenDanhMuc: 'Học bổng & Giáo dục', mauDanhMuc: '#3182CE',
        mucTieu: 300000000, daThu: 185000000,
        ngayKT: '31/05/2026', ngayCon: 69,
        trangThai: 1, noiBat: true
    },
    {
        id: 3,
        ten: 'Phẫu thuật tim miễn phí cho trẻ em nghèo',
        moTa: 'Hỗ trợ chi phí phẫu thuật tim bẩm sinh cho 20 trẻ em hoàn cảnh khó khăn.',
        maDanhMuc: 3, tenDanhMuc: 'Y tế cộng đồng', mauDanhMuc: '#D69E2E',
        mucTieu: 2000000000, daThu: 950000000,
        ngayKT: '30/06/2026', ngayCon: 99,
        trangThai: 1, noiBat: true
    },
    {
        id: 4,
        ten: 'Trồng 10.000 cây xanh tại Hà Nội',
        moTa: 'Dự án trồng cây xanh tại các khu vực ven đô Hà Nội.',
        maDanhMuc: 4, tenDanhMuc: 'Môi trường & Cây xanh', mauDanhMuc: '#38A169',
        mucTieu: 150000000, daThu: 62000000,
        ngayKT: '10/05/2026', ngayCon: 48,
        trangThai: 1, noiBat: false
    },
    {
        id: 5,
        ten: 'Xây dựng điểm trường cho trẻ em Hà Giang',
        moTa: 'Xây dựng phòng học kiên cố thay thế phòng học tạm tại xã Lũng Cú.',
        maDanhMuc: 2, tenDanhMuc: 'Học bổng & Giáo dục', mauDanhMuc: '#3182CE',
        mucTieu: 400000000, daThu: 400000000,
        ngayKT: '28/02/2026', ngayCon: -23,
        trangThai: 3, noiBat: false
    },
    {
        id: 6,
        ten: 'Khám chữa bệnh miễn phí cho người cao tuổi',
        moTa: 'Tổ chức đoàn y tế lưu động khám và cấp thuốc miễn phí tại Nghệ An.',
        maDanhMuc: 3, tenDanhMuc: 'Y tế cộng đồng', mauDanhMuc: '#D69E2E',
        mucTieu: 80000000, daThu: 15000000,
        ngayKT: '15/04/2026', ngayCon: 23,
        trangThai: 1, noiBat: false
    }
];

var PAGE_SIZE    = 5;
var currentPage  = 1;
var filteredData = MOCK_DATA.slice();

/* ── Helpers ─────────────────────────────────────────────────── */
function fmtMoney(n) {
    if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ';
    if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ';
    return n.toLocaleString('vi-VN') + ' đ';
}

function trangThaiBadge(ts) {
    var map = {
        0: ['badge-nhap',       'Nháp'],
        1: ['badge-thanh-cong', 'Đang chạy'],
        2: ['badge-tam-dung',   'Tạm dừng'],
        3: ['badge-tu-choi',    'Đã kết thúc']
    };
    var b = map[ts] || ['badge-nhap', '—'];
    return '<span class="badge-admin ' + b[0] + '">' + b[1] + '</span>';
}

function hexToRgba(hex, a) {
    try {
        hex = hex.replace('#','');
        var r = parseInt(hex.substring(0,2),16);
        var g = parseInt(hex.substring(2,4),16);
        var b = parseInt(hex.substring(4,6),16);
        return 'rgba('+r+','+g+','+b+','+a+')';
    } catch(e) { return '#EDF2F7'; }
}

/* ── Render bảng ────────────────────────────────────────────── */
function renderTable() {
    var tbody    = document.getElementById('tableBody');
    var emptyMsg = document.getElementById('emptyMsg');
    var pagingWrap = document.getElementById('pagingWrap');

    if (filteredData.length === 0) {
        tbody.innerHTML    = '';
        emptyMsg.style.display  = 'block';
        pagingWrap.style.display = 'none';
        document.getElementById('countLabel').textContent = '0 chiến dịch';
        return;
    }

    emptyMsg.style.display   = 'none';
    pagingWrap.style.display = 'flex';

    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (currentPage > totalPages) currentPage = totalPages;

    var from = (currentPage - 1) * PAGE_SIZE;
    var to   = Math.min(from + PAGE_SIZE, filteredData.length);
    var page = filteredData.slice(from, to);

    document.getElementById('countLabel').textContent =
        'Hiển thị ' + (from+1) + '–' + to + ' / ' + filteredData.length + ' chiến dịch';
    document.getElementById('pagingInfo').textContent =
        'Trang ' + currentPage + ' / ' + totalPages;

    var html = '';
    page.forEach(function(c) {
        var pct      = Math.min(Math.round(c.daThu / c.mucTieu * 100), 100);
        var barColor = c.mauDanhMuc || '#3182CE';
        var bgColor  = hexToRgba(barColor, .15);

        var ngayCon = '';
        if (c.ngayCon > 0)
            ngayCon = '<div style="font-size:11px;color:#D69E2E">Còn ' + c.ngayCon + ' ngày</div>';
        else if (c.trangThai === 1)
            ngayCon = '<div style="font-size:11px;color:#E53E3E">Đã quá hạn</div>';

        var noiBat = c.noiBat
            ? '<span class="noibat-yes" title="Ghim trang chủ">★</span>'
            : '<span style="color:#CBD5E0">☆</span>';

        html +=
            '<tr>' +
            '<td>' +
                '<div class="cd-name">' + c.ten + '</div>' +
                '<div class="cd-sub">'  + c.moTa + '</div>' +
            '</td>' +
            '<td>' +
                '<span style="font-size:11px;padding:2px 8px;border-radius:4px;font-weight:500;' +
                      'background:' + bgColor + ';color:' + barColor + '">' + c.tenDanhMuc + '</span>' +
            '</td>' +
            '<td style="font-size:12px;white-space:nowrap">' + fmtMoney(c.mucTieu) + '</td>' +
            '<td style="font-size:12px;color:#38A169;font-weight:600;white-space:nowrap">' + fmtMoney(c.daThu) + '</td>' +
            '<td>' +
                '<div class="prog-wrap">' +
                    '<div class="prog-bar" style="width:' + pct + '%;background:' + barColor + '"></div>' +
                '</div>' +
                '<div class="prog-pct">' + pct + '%</div>' +
            '</td>' +
            '<td>' +
                '<div style="font-size:12px">' + c.ngayKT + '</div>' + ngayCon +
            '</td>' +
            '<td style="text-align:center">' + noiBat + '</td>' +
            '<td>' + trangThaiBadge(c.trangThai) + '</td>' +
            '<td style="white-space:nowrap">' +
                '<a href="/Admin/FormChienDich.aspx?id=' + c.id + '" class="btn-sua">Sửa</a> ' +
                '<button class="btn-xoa" onclick="xoaChienDich(' + c.id + ',\'' + c.ten + '\')">Xóa</button>' +
            '</td>' +
            '</tr>';
    });

    tbody.innerHTML = html;
    renderPaging(totalPages);
}

/* ── Phân trang ─────────────────────────────────────────────── */
function renderPaging(totalPages) {
    var btns  = document.getElementById('pagingBtns');
    var html  = '';
    var start = Math.max(1, currentPage - 2);
    var end   = Math.min(totalPages, start + 4);
    start     = Math.max(1, end - 4);

    html += '<button class="paging-btn" onclick="changePage(' + (currentPage-1) + ')"' +
            (currentPage <= 1 ? ' disabled' : '') + '>← Trước</button>';

    for (var p = start; p <= end; p++) {
        html += '<button class="paging-btn' + (p === currentPage ? ' active' : '') +
                '" onclick="changePage(' + p + ')">' + p + '</button>';
    }

    html += '<button class="paging-btn" onclick="changePage(' + (currentPage+1) + ')"' +
            (currentPage >= totalPages ? ' disabled' : '') + '>Tiếp →</button>';

    btns.innerHTML = html;
}

function changePage(p) {
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (p < 1 || p > totalPages) return;
    currentPage = p;
    renderTable();
}

/* ── Filter ─────────────────────────────────────────────────── */
function applyFilter() {
    var q  = document.getElementById('inputSearch').value.trim().toLowerCase();
    var dm = document.getElementById('selDanhMuc').value;
    var tt = document.getElementById('selTrangThai').value;

    filteredData = MOCK_DATA.filter(function(c) {
        var matchQ  = !q  || c.ten.toLowerCase().includes(q);
        var matchDm = !dm || String(c.maDanhMuc) === dm;
        var matchTt = tt === '' || String(c.trangThai) === tt;
        return matchQ && matchDm && matchTt;
    });

    currentPage = 1;
    renderTable();
}

function resetFilter() {
    document.getElementById('inputSearch').value   = '';
    document.getElementById('selDanhMuc').value    = '';
    document.getElementById('selTrangThai').value  = '';
    filteredData = MOCK_DATA.slice();
    currentPage  = 1;
    renderTable();
}

/* ── Xóa (client-side) ─────────────────────────────────────── */
function xoaChienDich(id, ten) {
    if (!confirm('Xóa chiến dịch "' + ten + '"?\nHành động này không thể hoàn tác.')) return;

    MOCK_DATA    = MOCK_DATA.filter(function(c) { return c.id !== id; });
    filteredData = filteredData.filter(function(c) { return c.id !== id; });
    renderTable();

    var box = document.getElementById('alertBox');
    box.textContent    = '✓ Đã xóa chiến dịch "' + ten + '" thành công.';
    box.style.display  = 'block';
    setTimeout(function() { box.style.display = 'none'; }, 3000);
}

/* ── Enter để tìm kiếm ─────────────────────────────────────── */
document.getElementById('inputSearch').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') applyFilter();
});

/* ── Init ───────────────────────────────────────────────────── */
renderTable();
</script>
</asp:Content>
