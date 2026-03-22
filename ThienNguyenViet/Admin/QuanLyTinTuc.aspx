<%@ Page Title="Quản lý Tin tức" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyTinTuc.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   QUẢN LÝ TIN TỨC — PAGE STYLES
══════════════════════════════════════════════════════════════ */
.page-topbar {
    display: flex; align-items: center;
    justify-content: space-between; margin-bottom: 20px;
}
.page-topbar-title { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); }

/* Stat row */
.tt-stats-row {
    display: grid; grid-template-columns: repeat(4,1fr);
    gap: 14px; margin-bottom: 20px;
}
.tt-stat-card {
    background: var(--admin-card); border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien); padding: 16px 18px;
    display: flex; align-items: center; gap: 14px;
}
.tt-stat-icon {
    width: 40px; height: 40px; border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 18px; flex-shrink: 0;
}
.tt-stat-info strong { display: block; font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); line-height: 1.1; }
.tt-stat-info span   { font-size: 11px; color: var(--admin-chu-phu); }

/* Tab bar */
.tab-bar {
    display: flex; align-items: center; gap: 4px; margin-bottom: 16px;
    background: var(--admin-card); border: 0.5px solid var(--admin-vien);
    border-radius: var(--r-card); padding: 6px;
}
.tab-btn {
    height: 32px; padding: 0 16px; border-radius: 6px; border: none;
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
    background: transparent; color: var(--admin-chu-phu);
    display: flex; align-items: center; gap: 6px; transition: all .15s;
}
.tab-btn:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }
.tab-btn.active { background: #3182CE; color: #fff; }
.tab-count {
    font-size: 10px; font-weight: 700; min-width: 18px; height: 18px;
    border-radius: 99px; display: inline-flex; align-items: center; justify-content: center; padding: 0 5px;
}
.tab-btn.active .tab-count     { background: rgba(255,255,255,.25); color: #fff; }
.tab-btn:not(.active) .tab-count { background: var(--admin-vien); color: var(--admin-chu-phu); }

/* Filter */
.filter-bar { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
.input-search {
    height: 34px; padding: 0 10px; border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut); font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); width: 240px; outline: none; transition: border-color .15s;
}
.input-search:focus { border-color: #3182CE; }
.select-filter {
    height: 34px; padding: 0 8px; border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut); font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); background: #fff; cursor: pointer; outline: none;
}
.btn-primary-sm {
    height: 34px; padding: 0 14px; background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer; transition: background .15s;
}
.btn-primary-sm:hover { background: #2B6CB0; }
.btn-outline-sm {
    height: 34px; padding: 0 12px; background: transparent; color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); cursor: pointer; transition: background .15s;
}
.btn-outline-sm:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }
.btn-add-link {
    height: 36px; padding: 0 16px; background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500;
    text-decoration: none; display: inline-flex; align-items: center; gap: 4px;
}
.btn-add-link:hover { background: #2B6CB0; color: #fff; }

/* Section header */
.section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px; }
.section-title  { font-size: 14px; font-weight: 600; }
.section-count  { font-size: 12px; color: var(--admin-chu-phu); }

/* News thumbnail cell */
.news-cell { display: flex; align-items: center; gap: 12px; }
.news-thumb {
    width: 64px; height: 44px; border-radius: 6px; flex-shrink: 0;
    background: var(--admin-nen); border: 1px solid var(--admin-vien);
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; overflow: hidden;
}
.news-thumb img { width: 100%; height: 100%; object-fit: cover; }
.news-title {
    font-size: 13px; font-weight: 500; color: var(--admin-chu-chinh);
    max-width: 240px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
.news-summary {
    font-size: 11px; color: var(--admin-chu-phu);
    max-width: 240px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-top: 2px;
}

/* Cat badge */
.cat-badge {
    font-size: 10px; font-weight: 600; padding: 2px 8px; border-radius: 4px;
    display: inline-block; white-space: nowrap;
}

.view-count { font-size: 12px; color: var(--admin-chu-phu); }
.date-col   { font-size: 12px; color: var(--admin-chu-phu); }

/* Action buttons */
.btn-sua {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #EBF8FF; color: #2B6CB0; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s;
}
.btn-sua:hover { background: #BEE3F8; }
.btn-xoa {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #FED7D7; color: #C53030; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s;
}
.btn-xoa:hover { background: #FEB2B2; }
.btn-toggle {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #FEEBC8; color: #C05621; border: none; cursor: pointer;
    font-family: var(--font); transition: background .12s;
}
.btn-toggle:hover { background: #FBD38D; }
.btn-toggle.published { background: #C6F6D5; color: #276749; }
.btn-toggle.published:hover { background: #9AE6B4; }

/* Pagination */
.pagination-wrap {
    display: flex; align-items: center; justify-content: space-between;
    padding-top: 14px; border-top: 1px solid var(--admin-vien); margin-top: 4px;
}
.paging-info { font-size: 12px; color: var(--admin-chu-phu); }
.paging-btns { display: flex; align-items: center; gap: 6px; }
.paging-btn {
    font-size: 12px; padding: 4px 10px; border-radius: var(--r-nut);
    background: #fff; border: 1px solid var(--admin-vien);
    color: var(--admin-chu-chinh); cursor: pointer; font-family: var(--font); transition: background .12s;
}
.paging-btn:hover    { background: var(--admin-nen); }
.paging-btn.active   { background: #3182CE; color: #fff; border-color: #3182CE; }
.paging-btn:disabled { opacity: .4; cursor: default; }

/* Alert */
.alert-success { padding: 10px 14px; background: #C6F6D5; color: #276749; border-radius: var(--r-nut); font-size: 13px; margin-bottom: 16px; display: none; }

/* Empty */
.empty-state { text-align: center; padding: 48px 0; color: var(--admin-chu-phu); }
.empty-state .empty-icon { font-size: 38px; margin-bottom: 8px; }
.empty-state p { font-size: 13px; }

/* Confirm modal */
.modal-overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.45); z-index: 999;
    align-items: center; justify-content: center;
}
.modal-overlay.show { display: flex; }
.modal-box {
    background: var(--admin-card); border-radius: 12px; width: 400px; max-width: 94vw;
    box-shadow: 0 20px 60px rgba(0,0,0,.22); overflow: hidden; animation: modalIn .18s ease;
}
@keyframes modalIn {
    from { opacity:0; transform:translateY(-14px) scale(.97); }
    to   { opacity:1; transform:translateY(0) scale(1); }
}
.modal-header {
    padding: 16px 20px 14px; border-bottom: 1px solid var(--admin-vien);
    display: flex; align-items: center; justify-content: space-between;
}
.modal-header h3 { font-size: 15px; font-weight: 600; }
.modal-close {
    width: 28px; height: 28px; border-radius: 6px; border: none;
    background: var(--admin-nen); font-size: 15px; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    color: var(--admin-chu-phu); transition: background .12s;
}
.modal-close:hover { background: #FED7D7; color: #C53030; }
.modal-body  { padding: 20px; }
.modal-footer { padding: 14px 20px; border-top: 1px solid var(--admin-vien); display: flex; gap: 8px; justify-content: flex-end; }
.confirm-msg { font-size: 14px; color: var(--admin-chu-chinh); margin-bottom: 6px; }
.confirm-sub { font-size: 12px; color: var(--admin-chu-phu); }
.btn-confirm-danger {
    height: 34px; padding: 0 18px; background: #E53E3E; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer; transition: opacity .15s;
}
.btn-confirm-danger:hover { opacity: .88; }
.btn-cancel {
    height: 34px; padding: 0 14px; background: var(--admin-nen); color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); cursor: pointer;
}
.btn-cancel:hover { background: #EDF2F7; }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Tin tức</h1>
    <p>Danh sách bài viết và thông báo trong hệ thống</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="alertSuccess" class="alert-success"></div>

    <%-- Stat cards --%>
    <div class="tt-stats-row" id="statsRow"></div>

    <%-- Topbar --%>
    <div class="page-topbar">
        <span class="page-topbar-title">Danh sách bài viết</span>
        <a href="/Admin/FormTinTuc.aspx" class="btn-add-link">＋ Viết bài mới</a>
    </div>

    <%-- Tab lọc --%>
    <div class="tab-bar">
        <button class="tab-btn active" onclick="switchTab(this,'')"   data-tab="">Tất cả <span class="tab-count" id="cnt-all"></span></button>
        <button class="tab-btn"        onclick="switchTab(this,'1')"  data-tab="1">✅ Đã đăng <span class="tab-count" id="cnt-1"></span></button>
        <button class="tab-btn"        onclick="switchTab(this,'0')"  data-tab="0">📝 Nháp <span class="tab-count" id="cnt-0"></span></button>
    </div>

    <%-- Filter --%>
    <div class="admin-card" style="margin-bottom:16px;padding:14px 20px;">
        <div class="filter-bar">
            <input type="text" id="inputSearch" class="input-search" placeholder="Tìm theo tiêu đề bài viết..." />
            <select id="selDanhMuc" class="select-filter">
                <option value="">Tất cả danh mục</option>
                <option value="1">Hoạt động thiện nguyện</option>
                <option value="2">Câu chuyện truyền cảm hứng</option>
                <option value="3">Thông báo</option>
            </select>
            <button class="btn-primary-sm" onclick="applyFilter()">Tìm kiếm</button>
            <button class="btn-outline-sm" onclick="resetFilter()">Đặt lại</button>
        </div>
    </div>

    <%-- Table --%>
    <div class="admin-card">
        <div class="section-header">
            <span class="section-title">Danh sách tin tức</span>
            <span class="section-count" id="countLabel"></span>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width:38%">Bài viết</th>
                    <th>Danh mục</th>
                    <th>Lượt xem</th>
                    <th>Người đăng</th>
                    <th>Ngày đăng</th>
                    <th>Trạng thái</th>
                    <th style="text-align:center">Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" class="empty-state" style="display:none">
            <div class="empty-icon">📭</div>
            <p>Không tìm thấy bài viết nào.</p>
        </div>

        <div class="pagination-wrap" id="pagingWrap">
            <span class="paging-info" id="pagingInfo"></span>
            <div class="paging-btns" id="pagingBtns"></div>
        </div>
    </div>

    <%-- Modal xóa --%>
    <div class="modal-overlay" id="modalXoa" onclick="closeModalOutside(event)">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Xóa bài viết</h3>
                <button class="modal-close" onclick="closeModal()">✕</button>
            </div>
            <div class="modal-body">
                <div class="confirm-msg">Xóa bài viết "<strong id="xoa-title"></strong>"?</div>
                <div class="confirm-sub">Hành động này không thể hoàn tác.</div>
            </div>
            <div class="modal-footer">
                <button class="btn-confirm-danger" onclick="confirmXoa()">🗑 Xóa bài viết</button>
                <button class="btn-cancel" onclick="closeModal()">Hủy</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ══════════════════════════════════════════════════════════════
   MOCK DATA — khớp SampleData.sql
══════════════════════════════════════════════════════════════ */
var MOCK_DANHMUC = {
    1: { ten: 'Hoạt động thiện nguyện',     bg:'#EBF8FF', color:'#2B6CB0' },
    2: { ten: 'Câu chuyện truyền cảm hứng', bg:'#C6F6D5', color:'#276749' },
    3: { ten: 'Thông báo',                  bg:'#FEEBC8', color:'#C05621' }
};

var MOCK_TINTUC = [
    {
        id: 1,
        tieuDe:   'Thiện Nguyện Việt trao 500 phần quà cho bà con miền Trung',
        maDanhMuc: 1,
        tomTat:   'Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình...',
        anhBia:   null,
        luotXem:  1240,
        trangThai: 1,
        nguoiDang: 'Admin',
        ngayDang:  '07/03/2026'
    },
    {
        id: 2,
        tieuDe:   'Cậu bé 8 tuổi được cứu sống nhờ ca phẫu thuật tim từ quỹ từ thiện',
        maDanhMuc: 2,
        tomTat:   'Em Nguyễn Văn Khôi (8 tuổi, Cần Thơ) mắc bệnh tim bẩm sinh từ nhỏ...',
        anhBia:   null,
        luotXem:  3580,
        trangThai: 1,
        nguoiDang: 'Admin',
        ngayDang:  '20/02/2026'
    },
    {
        id: 3,
        tieuDe:   'Thông báo: Mở đăng ký tình nguyện viên đợt 2 năm 2026',
        maDanhMuc: 3,
        tomTat:   'Thiện Nguyện Việt mở đăng ký tình nguyện viên cho các chuyến đi trong tháng 4 và 5/2026.',
        anhBia:   null,
        luotXem:  892,
        trangThai: 1,
        nguoiDang: 'Admin',
        ngayDang:  '12/03/2026'
    },
    {
        id: 4,
        tieuDe:   '10.000 cây xanh sẽ được trồng tại Hà Nội trong tháng 4',
        maDanhMuc: 1,
        tomTat:   'Dự án trồng cây xanh do Thiện Nguyện Việt phối hợp với Trung tâm Bảo tồn Thiên nhiên Việt.',
        anhBia:   null,
        luotXem:  456,
        trangThai: 1,
        nguoiDang: 'Admin',
        ngayDang:  '14/03/2026'
    },
    {
        id: 5,
        tieuDe:   '[Nháp] Chương trình khám bệnh miễn phí sắp mở rộng sang tỉnh Hà Tĩnh',
        maDanhMuc: 1,
        tomTat:   'Sau thành công tại Nghệ An, đoàn y tế lưu động sẽ mở rộng địa bàn hoạt động...',
        anhBia:   null,
        luotXem:  0,
        trangThai: 0,
        nguoiDang: 'Admin',
        ngayDang:  '18/03/2026'
    },
    {
        id: 6,
        tieuDe:   '[Nháp] Báo cáo tổng kết chiến dịch học bổng quý 1/2026',
        maDanhMuc: 3,
        tomTat:   'Báo cáo tổng kết kết quả chiến dịch học bổng Thắp sáng ước mơ quý 1 năm 2026.',
        anhBia:   null,
        luotXem:  0,
        trangThai: 0,
        nguoiDang: 'Admin',
        ngayDang:  '20/03/2026'
    }
];

/* ── Helpers ────────────────────────────────────────────────── */
function fmtViews(n) {
    if (n >= 1000) return (n/1000).toFixed(1) + 'K';
    return n.toString();
}

function statusBadge(ts) {
    return ts === 1
        ? '<span class="badge-admin badge-thanh-cong">✅ Đã đăng</span>'
        : '<span class="badge-admin badge-nhap">📝 Nháp</span>';
}

/* ══════════════════════════════════════════════════════════════
   STATS
══════════════════════════════════════════════════════════════ */
function renderStats() {
    var total   = MOCK_TINTUC.length;
    var daDang  = MOCK_TINTUC.filter(function(t){ return t.trangThai === 1; }).length;
        var nhap  = MOCK_TINTUC.filter(function(t){ return t.trangThai === 0; }).length;
    var tongView= MOCK_TINTUC.reduce(function(s,t){ return s + t.luotXem; }, 0);

    var cards = [
        { icon:'📰', label:'Tổng bài viết',  value: total,             bg:'var(--stat-xanh-nen)',  color:'var(--stat-xanh-vien)' },
        { icon:'✅', label:'Đã đăng',        value: daDang,            bg:'#C6F6D5',               color:'var(--admin-thanh-cong)' },
        { icon:'📝', label:'Nháp',           value: nhap,              bg:'var(--stat-cam-nen)',   color:'var(--stat-cam-vien)' },
        { icon:'👁', label:'Tổng lượt xem', value: fmtViews(tongView)+'+ lượt', bg:'var(--stat-tim-nen)', color:'var(--stat-tim-vien)' }
    ];

    var html = '';
    cards.forEach(function(c) {
        html +=
            '<div class="tt-stat-card">' +
            '<div class="tt-stat-icon" style="background:' + c.bg + ';color:' + c.color + '">' + c.icon + '</div>' +
            '<div class="tt-stat-info"><strong style="color:' + c.color + '">' + c.value + '</strong><span>' + c.label + '</span></div>' +
            '</div>';
    });
    document.getElementById('statsRow').innerHTML = html;

    document.getElementById('cnt-all').textContent = total;
    document.getElementById('cnt-1').textContent   = daDang;
    document.getElementById('cnt-0').textContent   = nhap;
}

/* ══════════════════════════════════════════════════════════════
   TABLE + FILTER + PAGINATION
══════════════════════════════════════════════════════════════ */
var PAGE_SIZE    = 8;
var currentPage  = 1;
var activeTab    = '';
var filteredData = MOCK_TINTUC.slice();

function applyAllFilters() {
    var q  = document.getElementById('inputSearch').value.trim().toLowerCase();
    var dm = document.getElementById('selDanhMuc').value;

    filteredData = MOCK_TINTUC.filter(function(t) {
        var matchTab = activeTab === '' || String(t.trangThai) === activeTab;
        var matchQ   = !q  || t.tieuDe.toLowerCase().includes(q);
        var matchDm  = !dm || String(t.maDanhMuc) === dm;
        return matchTab && matchQ && matchDm;
    });

    currentPage = 1;
    renderTable();
}

function switchTab(btn, tab) {
    document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');
    activeTab = tab;
    applyAllFilters();
}

function applyFilter() { applyAllFilters(); }
function resetFilter() {
    document.getElementById('inputSearch').value  = '';
    document.getElementById('selDanhMuc').value   = '';
    applyAllFilters();
}

function renderTable() {
    var tbody      = document.getElementById('tableBody');
    var emptyMsg   = document.getElementById('emptyMsg');
    var pagingWrap = document.getElementById('pagingWrap');

    if (filteredData.length === 0) {
        tbody.innerHTML = ''; emptyMsg.style.display = 'block'; pagingWrap.style.display = 'none';
        document.getElementById('countLabel').textContent = '0 bài viết';
        return;
    }

    emptyMsg.style.display = 'none'; pagingWrap.style.display = 'flex';
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (currentPage > totalPages) currentPage = totalPages;

    var from = (currentPage - 1) * PAGE_SIZE;
    var to   = Math.min(from + PAGE_SIZE, filteredData.length);
    var page = filteredData.slice(from, to);

    document.getElementById('countLabel').textContent =
        'Hiển thị ' + (from+1) + '–' + to + ' / ' + filteredData.length + ' bài viết';
    document.getElementById('pagingInfo').textContent =
        'Trang ' + currentPage + ' / ' + totalPages;

    var html = '';
    page.forEach(function(t) {
        var dm  = MOCK_DANHMUC[t.maDanhMuc] || { ten:'—', bg:'#EDF2F7', color:'#718096' };
        var toggleLabel  = t.trangThai === 1 ? '📤 Ẩn bài' : '📢 Đăng';
        var toggleClass  = t.trangThai === 1 ? 'btn-toggle published' : 'btn-toggle';

        html +=
            '<tr id="tt-row-' + t.id + '">' +
            '<td>' +
                '<div class="news-cell">' +
                    '<div class="news-thumb">📰</div>' +
                    '<div>' +
                        '<div class="news-title" title="' + t.tieuDe + '">' + t.tieuDe + '</div>' +
                        '<div class="news-summary">' + t.tomTat + '</div>' +
                    '</div>' +
                '</div>' +
            '</td>' +
            '<td><span class="cat-badge" style="background:' + dm.bg + ';color:' + dm.color + '">' + dm.ten + '</span></td>' +
            '<td class="view-count">👁 ' + fmtViews(t.luotXem) + '</td>' +
            '<td style="font-size:12px">' + t.nguoiDang + '</td>' +
            '<td class="date-col">' + t.ngayDang + '</td>' +
            '<td>' + statusBadge(t.trangThai) + '</td>' +
            '<td style="text-align:center;white-space:nowrap">' +
                '<a href="/Admin/FormTinTuc.aspx?id=' + t.id + '" class="btn-sua" style="margin-right:3px">✏ Sửa</a>' +
                '<button class="' + toggleClass + '" onclick="toggleTrangThai(' + t.id + ')" style="margin-right:3px">' + toggleLabel + '</button>' +
                '<button class="btn-xoa" onclick="openXoa(' + t.id + ')">🗑 Xóa</button>' +
            '</td>' +
            '</tr>';
    });

    tbody.innerHTML = html;
    renderPaging(totalPages);
}

function renderPaging(totalPages) {
    var btns  = document.getElementById('pagingBtns');
    var start = Math.max(1, currentPage - 2);
    var end   = Math.min(totalPages, start + 4);
    start     = Math.max(1, end - 4);

    var html = '<button class="paging-btn" onclick="changePage(' + (currentPage-1) + ')"' +
               (currentPage <= 1 ? ' disabled':'') + '>← Trước</button>';
    for (var p = start; p <= end; p++) {
        html += '<button class="paging-btn' + (p === currentPage ? ' active':'') +
                '" onclick="changePage(' + p + ')">' + p + '</button>';
    }
    html += '<button class="paging-btn" onclick="changePage(' + (currentPage+1) + ')"' +
            (currentPage >= totalPages ? ' disabled':'') + '>Tiếp →</button>';
    btns.innerHTML = html;
}

function changePage(p) {
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (p < 1 || p > totalPages) return;
    currentPage = p; renderTable();
}

document.getElementById('inputSearch').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') applyAllFilters();
});

/* ── Toggle trạng thái ──────────────────────────────────────── */
function toggleTrangThai(id) {
    var t = MOCK_TINTUC.find(function(x){ return x.id === id; });
    if (!t) return;
    t.trangThai = t.trangThai === 1 ? 0 : 1;
    var action = t.trangThai === 1 ? 'đã đăng' : 'chuyển về nháp';
    renderStats(); applyAllFilters();
    showAlert('alertSuccess', '✓ Bài viết "' + t.tieuDe.substring(0,40) + '..." ' + action + ' thành công.');
}

/* ── Xóa ────────────────────────────────────────────────────── */
var pendingDeleteId = null;
function openXoa(id) {
    var t = MOCK_TINTUC.find(function(x){ return x.id === id; });
    if (!t) return;
    pendingDeleteId = id;
    document.getElementById('xoa-title').textContent = t.tieuDe.substring(0, 50) + (t.tieuDe.length > 50 ? '...' : '');
    document.getElementById('modalXoa').classList.add('show');
    document.body.style.overflow = 'hidden';
}
function confirmXoa() {
    if (!pendingDeleteId) return;
    var idx = MOCK_TINTUC.findIndex(function(x){ return x.id === pendingDeleteId; });
    if (idx > -1) {
        var title = MOCK_TINTUC[idx].tieuDe.substring(0,40);
        MOCK_TINTUC.splice(idx, 1);
        closeModal(); renderStats(); applyAllFilters();
        showAlert('alertSuccess', '🗑 Đã xóa bài viết "' + title + '..."');
    }
}
function closeModal() {
    document.getElementById('modalXoa').classList.remove('show');
    document.body.style.overflow = '';
}
function closeModalOutside(e) {
    if (e.target === document.getElementById('modalXoa')) closeModal();
}
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeModal();
});

function showAlert(id, msg) {
    var el = document.getElementById(id);
    el.textContent = msg; el.style.display = 'block';
    setTimeout(function(){ el.style.display = 'none'; }, 4000);
}

/* ── Init ───────────────────────────────────────────────────── */
renderStats(); applyAllFilters();
</script>
</asp:Content>
