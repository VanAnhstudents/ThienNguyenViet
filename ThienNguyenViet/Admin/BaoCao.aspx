<%@ Page Title="Báo cáo & Thống kê" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="BaoCao.aspx.cs"
         Inherits="ThienNguyenViet.Admin.BaoCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   BÁO CÁO & THỐNG KÊ — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* Year selector */
.bc-toolbar {
    display: flex; align-items: center;
    justify-content: space-between; margin-bottom: 20px;
}
.bc-toolbar-title { font-size: 20px; font-weight: 700; color: var(--admin-chu-chinh); }
.bc-toolbar-right { display: flex; align-items: center; gap: 10px; }
.select-year {
    height: 34px; padding: 0 10px; border: 1px solid var(--admin-vien);
    border-radius: var(--r-nut); font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); background: #fff; cursor: pointer; outline: none;
}
.btn-export {
    height: 34px; padding: 0 16px; background: #38A169; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
    display: flex; align-items: center; gap: 6px; transition: background .15s;
}
.btn-export:hover { background: #276749; }

/* Summary row */
.bc-summary-row {
    display: grid; grid-template-columns: repeat(4,1fr);
    gap: 14px; margin-bottom: 20px;
}
.bc-stat-card {
    background: var(--admin-card); border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien); padding: 16px 18px;
}
.bc-stat-label { font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .04em; color: var(--admin-chu-phu); margin-bottom: 8px; }
.bc-stat-value { font-size: 24px; font-weight: 700; color: var(--admin-chu-chinh); line-height: 1; margin-bottom: 6px; }
.bc-stat-sub   { font-size: 11px; color: var(--admin-chu-phu); }
.bc-stat-up    { color: var(--admin-thanh-cong); font-weight: 600; }
.bc-stat-down  { color: var(--admin-loi); font-weight: 600; }

/* Chart cards */
.charts-row {
    display: grid; grid-template-columns: 1fr 380px;
    gap: 16px; margin-bottom: 20px;
}
.chart-wrap { position: relative; height: 280px; }
.card-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
.card-header h3  { font-size: 14px; font-weight: 600; }
.card-header .card-sub { font-size: 11px; color: var(--admin-chu-phu); margin-top: 2px; }
.btn-outline-xs {
    font-size: 11px; padding: 4px 10px;
    border-radius: var(--r-nut); background: transparent;
    border: 1px solid var(--admin-vien); color: var(--admin-chu-phu);
    cursor: pointer; font-family: var(--font); transition: background .12s;
}
.btn-outline-xs:hover { background: var(--admin-nen); }

/* Pie legend */
.pie-legend { display: flex; flex-direction: column; gap: 10px; margin-top: 16px; }
.pie-legend-item { display: flex; align-items: center; gap: 8px; }
.pie-dot { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.pie-label { font-size: 12px; color: var(--admin-chu-chinh); flex: 1; }
.pie-pct   { font-size: 12px; font-weight: 600; color: var(--admin-chu-chinh); }
.pie-amt   { font-size: 11px; color: var(--admin-chu-phu); }

/* Table rank */
.rank-num {
    width: 24px; height: 24px; border-radius: 50%;
    display: inline-flex; align-items: center; justify-content: center;
    font-size: 11px; font-weight: 700; flex-shrink: 0;
}
.rank-1 { background: #F6E05E; color: #744210; }
.rank-2 { background: #E2E8F0; color: #2D3748; }
.rank-3 { background: #F7C59F; color: #7B341E; }
.rank-n { background: var(--admin-nen); color: var(--admin-chu-phu); }

.cd-name-rank { font-size: 12px; font-weight: 500; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.cat-dot { width: 8px; height: 8px; border-radius: 50%; display: inline-block; margin-right: 4px; flex-shrink: 0; }

.amount-col { font-size: 13px; font-weight: 600; color: var(--admin-thanh-cong); white-space: nowrap; }
.pct-bar-wrap { display: flex; align-items: center; gap: 8px; }
.pct-bar-bg   { flex: 1; height: 6px; background: var(--admin-vien); border-radius: 99px; overflow: hidden; }
.pct-bar-fill { height: 100%; border-radius: 99px; }
.pct-text     { font-size: 11px; color: var(--admin-chu-phu); white-space: nowrap; width: 36px; text-align: right; }

.donor-av {
    width: 30px; height: 30px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 11px; font-weight: 700; flex-shrink: 0;
}
.donor-name  { font-size: 12px; font-weight: 500; }
.donor-email { font-size: 11px; color: var(--admin-chu-phu); }
.tables-row  { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Báo cáo &amp; Thống kê</h1>
    <p>Tổng quan hiệu quả hoạt động thiện nguyện</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Toolbar --%>
    <div class="bc-toolbar">
        <span class="bc-toolbar-title">Tổng quan năm <span id="lblNam">2026</span></span>
        <div class="bc-toolbar-right">
            <select class="select-year" id="selNam" onchange="onYearChange()">
                <option value="2026" selected>Năm 2026</option>
                <option value="2025">Năm 2025</option>
            </select>
            <button class="btn-export" onclick="exportExcel()">⬇ Xuất Excel</button>
        </div>
    </div>

    <%-- 4 Summary cards --%>
    <div class="bc-summary-row" id="summaryRow"></div>

    <%-- Biểu đồ đường + Biểu đồ tròn --%>
    <div class="charts-row">

        <%-- Biểu đồ đường: quyên góp 12 tháng --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="card-sub">Tổng tiền đã duyệt (triệu đồng) — năm <span class="lblNamInline">2026</span></div>
                </div>
                <button class="btn-outline-xs" onclick="toggleChartType()">⇌ Đổi loại</button>
            </div>
            <div class="chart-wrap">
                <canvas id="chartLine"></canvas>
            </div>
        </div>

        <%-- Biểu đồ tròn: phân bổ theo danh mục --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Phân bổ theo danh mục</h3>
                    <div class="card-sub">Tỷ lệ số tiền quyên góp</div>
                </div>
            </div>
            <div class="chart-wrap" style="height:200px">
                <canvas id="chartPie"></canvas>
            </div>
            <div class="pie-legend" id="pieLegend"></div>
        </div>

    </div>

    <%-- 2 bảng xếp hạng --%>
    <div class="tables-row">

        <%-- Top 10 chiến dịch --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Top 10 chiến dịch thành công nhất</h3>
                    <div class="card-sub">Xếp hạng theo số tiền quyên góp</div>
                </div>
            </div>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th style="width:32px">#</th>
                        <th>Chiến dịch</th>
                        <th>Số tiền</th>
                        <th style="width:120px">Tiến độ</th>
                    </tr>
                </thead>
                <tbody id="topCDBody"></tbody>
            </table>
        </div>

        <%-- Top 10 người quyên góp --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Top 10 người quyên góp nhiều nhất</h3>
                    <div class="card-sub">Chỉ hiển thị người không ẩn danh</div>
                </div>
            </div>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th style="width:32px">#</th>
                        <th>Người quyên góp</th>
                        <th>Tổng góp</th>
                        <th>Số lần</th>
                    </tr>
                </thead>
                <tbody id="topDonorBody"></tbody>
            </table>
        </div>

    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
/* ══════════════════════════════════════════════════════════════
   MOCK DATA
══════════════════════════════════════════════════════════════ */

/* Dữ liệu theo tháng — 2026 (3 tháng đầu có thật từ SampleData) */
var DATA_THEO_THANG = {
    2026: [0, 185000000, 320000000, 15000000, 0, 0, 0, 0, 0, 0, 0, 0],
    2025: [42000000, 58000000, 67000000, 71000000, 95000000, 124000000,
           88000000, 103000000, 116000000, 98000000, 145000000, 132000000]
};

var DANH_MUC_PIE = [
    { ten: 'Cứu trợ thiên tai',      tien: 320000000, color: '#E53E3E' },
    { ten: 'Học bổng & Giáo dục',    tien: 585000000, color: '#3182CE' },
    { ten: 'Y tế cộng đồng',         tien: 965000000, color: '#D69E2E' },
    { ten: 'Môi trường & Cây xanh',  tien:  62000000, color: '#38A169' }
];

var TOP_CHIEN_DICH = [
    { ten: 'Phẫu thuật tim miễn phí cho trẻ em nghèo',  cat: 'Y tế cộng đồng',    catColor:'#D69E2E', tien: 950000000, mucTieu: 2000000000 },
    { ten: 'Học bổng "Thắp sáng ước mơ"',               cat: 'Học bổng & GD',      catColor:'#3182CE', tien: 185000000, mucTieu: 300000000 },
    { ten: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026',   cat: 'Cứu trợ thiên tai',  catColor:'#E53E3E', tien: 320000000, mucTieu: 500000000 },
    { ten: 'Xây dựng điểm trường Hà Giang',              cat: 'Học bổng & GD',      catColor:'#3182CE', tien: 400000000, mucTieu: 400000000 },
    { ten: 'Trồng 10.000 cây xanh tại Hà Nội',          cat: 'Môi trường',         catColor:'#38A169', tien:  62000000, mucTieu: 150000000 },
    { ten: 'Khám chữa bệnh miễn phí',                   cat: 'Y tế cộng đồng',    catColor:'#D69E2E', tien:  15000000, mucTieu:  80000000 }
];

var TOP_DONORS = [
    { ten: 'Lê Hoàng Minh',       email: 'minh.le@gmail.com',        tien: 5500000, soLan: 2, id: 4 },
    { ten: 'Đỗ Thị Lan',          email: 'lan.do@gmail.com',          tien: 2200000, soLan: 2, id: 7 },
    { ten: 'Trần Thị Bình',        email: 'binh.tran@gmail.com',      tien: 1200000, soLan: 2, id: 3 },
    { ten: 'User',                 email: 'user@thiennguyen.vn',      tien: 1300000, soLan: 3, id: 2 },
    { ten: 'Phạm Thị Thu Hương',  email: 'huong.pham@gmail.com',     tien:  800000, soLan: 2, id: 5 },
    { ten: 'Vũ Đức Thắng',        email: 'thang.vu@gmail.com',       tien:  200000, soLan: 1, id: 6 }
];

TOP_DONORS.sort(function(a,b){ return b.tien - a.tien; });

/* ── Helpers ────────────────────────────────────────────────── */
var AV_COLORS = [
    {bg:'#EBF8FF',color:'#2B6CB0'},{bg:'#E9D8FD',color:'#6B46C1'},
    {bg:'#C6F6D5',color:'#276749'},{bg:'#FEEBC8',color:'#C05621'},
    {bg:'#FED7D7',color:'#C53030'},{bg:'#E6FFFA',color:'#285E61'},
    {bg:'#FEFCBF',color:'#744210'},{bg:'#F0FFF4',color:'#22543D'}
];
function avColor(id){ return AV_COLORS[((id||1)-1) % AV_COLORS.length]; }

function fmtMoney(n) {
    if (!n) return '0 đ';
    if (n >= 1e9) return (n/1e9).toFixed(2).replace(/\.?0+$/,'') + ' tỷ đ';
    if (n >= 1e6) return (n/1e6).toFixed(1).replace(/\.?0+$/,'') + ' tr đ';
    return n.toLocaleString('vi-VN') + ' đ';
}

function getInitials(name) {
    var p = name.trim().split(' ');
    if (p.length === 1) return p[0][0].toUpperCase();
    return (p[p.length-2][0] + p[p.length-1][0]).toUpperCase();
}

/* ══════════════════════════════════════════════════════════════
   SUMMARY CARDS
══════════════════════════════════════════════════════════════ */
function renderSummary(nam) {
    var data    = DATA_THEO_THANG[nam] || [];
    var tongTien= data.reduce(function(s,v){ return s+v; }, 0);
    var soThang = data.filter(function(v){ return v > 0; }).length;

    var cards = [
        { label: 'Tổng tiền quyên góp', value: fmtMoney(tongTien), sub: '<span class="bc-stat-up">▲ ' + soThang + ' tháng có dữ liệu</span>', icon: '💰', color: 'var(--stat-xanh-vien)' },
        { label: 'Chiến dịch đang chạy', value: 4, sub: '2 chiến dịch sắp kết thúc', icon: '🎯', color: 'var(--stat-cam-vien)' },
        { label: 'Tổng lượt quyên góp',  value: 12, sub: 'Đã duyệt / 14 giao dịch', icon: '✅', color: 'var(--admin-thanh-cong)' },
        { label: 'Người dùng hoạt động', value: 7, sub: '1 tài khoản bị khóa', icon: '👥', color: 'var(--stat-tim-vien)' }
    ];

    var bgMap = ['var(--stat-xanh-nen)','var(--stat-cam-nen)','#C6F6D5','var(--stat-tim-nen)'];

    var html = '';
    cards.forEach(function(c, i) {
        html +=
            '<div class="bc-stat-card">' +
            '<div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:10px">' +
                '<div>' +
                    '<div class="bc-stat-label">' + c.label + '</div>' +
                    '<div class="bc-stat-value" style="color:' + c.color + '">' + c.value + '</div>' +
                '</div>' +
                '<div style="width:38px;height:38px;border-radius:10px;background:' + bgMap[i] + ';color:' + c.color + ';display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0">' + c.icon + '</div>' +
            '</div>' +
            '<div class="bc-stat-sub">' + c.sub + '</div>' +
            '</div>';
    });
    document.getElementById('summaryRow').innerHTML = html;
}

/* ══════════════════════════════════════════════════════════════
   BIỂU ĐỒ ĐƯỜNG
══════════════════════════════════════════════════════════════ */
var chartLineInstance = null;
var chartType = 'line';

function renderLineChart(nam) {
    var ctx  = document.getElementById('chartLine').getContext('2d');
    var data = DATA_THEO_THANG[nam] || [];
    var vals = data.map(function(v){ return v / 1e6; }); // triệu đồng

    var gradient = ctx.createLinearGradient(0, 0, 0, 280);
    gradient.addColorStop(0, 'rgba(49,130,206,.35)');
    gradient.addColorStop(1, 'rgba(49,130,206,0)');

    if (chartLineInstance) chartLineInstance.destroy();

    chartLineInstance = new Chart(ctx, {
        type: chartType,
        data: {
            labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'],
            datasets: [{
                label: 'Quyên góp (triệu đồng)',
                data: vals,
                fill: chartType === 'line',
                backgroundColor: chartType === 'line' ? gradient : [
                    '#E53E3E','#3182CE','#D69E2E','#38A169',
                    '#805AD5','#DD6B20','#2B6CB0','#276749',
                    '#C53030','#C05621','#6B46C1','#285E61'
                ],
                borderColor: '#3182CE',
                borderWidth: chartType === 'line' ? 2.5 : 0,
                borderRadius: chartType === 'bar' ? 4 : 0,
                pointBackgroundColor: '#3182CE',
                pointRadius: chartType === 'line' ? 4 : 0,
                pointHoverRadius: 6,
                tension: 0.4
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#1A365D', titleColor: '#90CDF4', bodyColor: '#fff', padding: 10,
                    callbacks: {
                        label: function(ctx) { return ' ' + ctx.parsed.y.toLocaleString('vi-VN') + ' triệu đồng'; }
                    }
                }
            },
            scales: {
                x: { grid: { display: false }, ticks: { font: { family:"'Be Vietnam Pro'", size:11 }, color:'#718096' } },
                y: {
                    grid: { color: '#EDF2F7' }, border: { dash: [4,4] },
                    ticks: {
                        font: { family:"'Be Vietnam Pro'", size:11 }, color:'#718096',
                        callback: function(v){ return v + ' tr'; }
                    }
                }
            }
        }
    });
}

function toggleChartType() {
    chartType = chartType === 'line' ? 'bar' : 'line';
    var nam = parseInt(document.getElementById('selNam').value);
    renderLineChart(nam);
}

/* ══════════════════════════════════════════════════════════════
   BIỂU ĐỒ TRÒN
══════════════════════════════════════════════════════════════ */
function renderPieChart() {
    var ctx   = document.getElementById('chartPie').getContext('2d');
    var total = DANH_MUC_PIE.reduce(function(s,d){ return s + d.tien; }, 0);

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: DANH_MUC_PIE.map(function(d){ return d.ten; }),
            datasets: [{
                data:            DANH_MUC_PIE.map(function(d){ return d.tien; }),
                backgroundColor: DANH_MUC_PIE.map(function(d){ return d.color; }),
                borderWidth: 3,
                borderColor: '#FFFFFF',
                hoverOffset: 6
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            cutout: '65%',
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#1A365D', bodyColor: '#fff', padding: 10,
                    callbacks: {
                        label: function(ctx) {
                            var pct = (ctx.parsed / total * 100).toFixed(1);
                            return ' ' + fmtMoney(ctx.parsed) + ' (' + pct + '%)';
                        }
                    }
                }
            }
        }
    });

    // Legend
    var html = '';
    DANH_MUC_PIE.forEach(function(d) {
        var pct = (d.tien / total * 100).toFixed(1);
        html +=
            '<div class="pie-legend-item">' +
            '<div class="pie-dot" style="background:' + d.color + '"></div>' +
            '<span class="pie-label">' + d.ten + '</span>' +
            '<span class="pie-amt">' + fmtMoney(d.tien) + '</span>' +
            '<span class="pie-pct" style="color:' + d.color + '">' + pct + '%</span>' +
            '</div>';
    });
    document.getElementById('pieLegend').innerHTML = html;
}

/* ══════════════════════════════════════════════════════════════
   TOP CHIẾN DỊCH
══════════════════════════════════════════════════════════════ */
function renderTopChienDich() {
    var maxTien = TOP_CHIEN_DICH[0].tien;
    var html = '';
    TOP_CHIEN_DICH.slice(0,10).forEach(function(cd, i) {
        var rank = i + 1;
        var rankClass = rank <= 3 ? 'rank-' + rank : 'rank-n';
        var pct  = Math.round(cd.tien / cd.mucTieu * 100);
        var barPct = Math.round(cd.tien / maxTien * 100);

        html +=
            '<tr>' +
            '<td><span class="rank-num ' + rankClass + '">' + rank + '</span></td>' +
            '<td>' +
                '<div style="display:flex;align-items:center;gap:6px">' +
                    '<div class="cat-dot" style="background:' + cd.catColor + '"></div>' +
                    '<div class="cd-name-rank" title="' + cd.ten + '">' + cd.ten + '</div>' +
                '</div>' +
                '<div style="font-size:10px;color:var(--admin-chu-phu);margin-top:2px">' + cd.cat + '</div>' +
            '</td>' +
            '<td class="amount-col">' + fmtMoney(cd.tien) + '</td>' +
            '<td>' +
                '<div class="pct-bar-wrap">' +
                    '<div class="pct-bar-bg">' +
                        '<div class="pct-bar-fill" style="width:' + barPct + '%;background:' + cd.catColor + '"></div>' +
                    '</div>' +
                    '<span class="pct-text">' + pct + '%</span>' +
                '</div>' +
            '</td>' +
            '</tr>';
    });
    document.getElementById('topCDBody').innerHTML = html;
}

/* ══════════════════════════════════════════════════════════════
   TOP DONORS
══════════════════════════════════════════════════════════════ */
function renderTopDonors() {
    var maxTien = TOP_DONORS[0].tien;
    var html = '';
    TOP_DONORS.slice(0,10).forEach(function(d, i) {
        var rank = i + 1;
        var rankClass = rank <= 3 ? 'rank-' + rank : 'rank-n';
        var av  = avColor(d.id);
        var ini = getInitials(d.ten);

        html +=
            '<tr>' +
            '<td><span class="rank-num ' + rankClass + '">' + rank + '</span></td>' +
            '<td>' +
                '<div style="display:flex;align-items:center;gap:8px">' +
                    '<div class="donor-av" style="background:' + av.bg + ';color:' + av.color + '">' + ini + '</div>' +
                    '<div>' +
                        '<div class="donor-name">' + d.ten + '</div>' +
                        '<div class="donor-email">' + d.email + '</div>' +
                    '</div>' +
                '</div>' +
            '</td>' +
            '<td class="amount-col">' + fmtMoney(d.tien) + '</td>' +
            '<td style="font-size:12px;font-weight:600;color:var(--admin-chu-chinh)">' + d.soLan + ' lần</td>' +
            '</tr>';
    });
    document.getElementById('topDonorBody').innerHTML = html;
}

/* ── Year change ────────────────────────────────────────────── */
function onYearChange() {
    var nam = parseInt(document.getElementById('selNam').value);
    document.getElementById('lblNam').textContent = nam;
    document.querySelectorAll('.lblNamInline').forEach(function(el){ el.textContent = nam; });
    renderSummary(nam);
    renderLineChart(nam);
}

/* ── Export mock ────────────────────────────────────────────── */
function exportExcel() {
    var nam = document.getElementById('selNam').value;
    alert('📊 Đang xuất báo cáo Excel năm ' + nam + '...\n(Chức năng thực tế sẽ kết nối backend.)');
}

/* ── Init ───────────────────────────────────────────────────── */
(function init() {
    var nam = parseInt(document.getElementById('selNam').value);
    renderSummary(nam);
    renderLineChart(nam);
    renderPieChart();
    renderTopChienDich();
    renderTopDonors();
})();
</script>
</asp:Content>
