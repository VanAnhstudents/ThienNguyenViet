<%@ Page Title="Báo cáo & Thống kê" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="BaoCao.aspx.cs"
         Inherits="ThienNguyenViet.Admin.BaoCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ═══════════════════════════════════════════════════════
   BaoCao — synced with QuanLyChienDich + TongQuan
═══════════════════════════════════════════════════════ */

/* ── CSS variable additions for BaoCao ── */
:root {
    --stat-xanh-vien: #2B6CB0;
    --stat-cam-vien:  #C05621;
    --stat-tim-vien:  #6B46C1;
    --stat-xanh-nen:  #EBF8FF;
    --stat-cam-nen:   #FEEBC8;
    --stat-tim-nen:   #E9D8FD;
    --stat-blue:      #2B6CB0;
    --stat-orange:    #C05621;
    --stat-purple:    #6B46C1;
    --stat-green:     #276749;
}

/* ── Toolbar (chuẩn filter-bar) ── */
.bc-toolbar {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 18px; flex-wrap: wrap; gap: 10px;
}
.bc-toolbar-title {
    font-size: 14px; font-weight: 600; color: var(--txt);
}
.bc-toolbar-right {
    display: flex; align-items: center; gap: 8px; flex-wrap: wrap;
}
.select-year {
    height: 36px; padding: 0 10px;
    border: 1px solid var(--border); border-radius: var(--r);
    font-family: var(--font); font-size: 13px; color: var(--txt);
    background: #fff; cursor: pointer;
    transition: border-color .15s;
}
.select-year:focus { outline: none; border-color: var(--accent); }
.btn-export {
    height: 36px; padding: 0 16px;
    background: var(--ok); color: #fff; border: none;
    border-radius: var(--r); font-family: var(--font);
    font-size: 13px; font-weight: 500; cursor: pointer;
    transition: opacity .15s;
}
.btn-export:hover { opacity: .88; }

/* ── Summary cards (chuẩn stat-card TongQuan) ── */
.bc-summary-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px; margin-bottom: 18px;
}
.bc-stat-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--r-card); padding: 18px 16px;
    text-align: center; position: relative; overflow: hidden;
    transition: box-shadow .2s;
}
.bc-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.1); }
.bc-stat-label {
    font-size: 10px; font-weight: 600; color: var(--txt-sub);
    text-transform: uppercase; letter-spacing: .04em;
    margin-bottom: 6px;
}
.bc-stat-value {
    font-size: 24px; font-weight: 700; line-height: 1.1;
    margin-bottom: 6px; color: var(--txt);
}
.bc-stat-sub { font-size: 11px; color: var(--txt-sub); }

/* ── Admin card (chuẩn adm-card) ── */
.admin-card {
    background: var(--card); border: 1px solid var(--border);
    border-radius: var(--r-card); padding: 18px 20px; margin-bottom: 18px;
}

/* ── Card header ── */
.card-header {
    display: flex; justify-content: space-between; align-items: flex-start;
    margin-bottom: 14px; gap: 10px; flex-wrap: wrap;
}
.card-header h3 { font-size: 13px; font-weight: 600; color: var(--txt); }
.card-sub { font-size: 11px; color: var(--txt-sub); margin-top: 2px; }
.btn-outline-xs {
    height: 28px; padding: 0 12px;
    border: 1px solid var(--border); border-radius: var(--r);
    background: transparent; color: var(--txt-sub);
    font-family: var(--font); font-size: 11px; cursor: pointer;
    white-space: nowrap; flex-shrink: 0;
    transition: background .15s, color .15s;
}
.btn-outline-xs:hover { background: var(--bg); color: var(--txt); }

/* ── Charts row (chuẩn main-row TongQuan) ── */
.charts-row {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 16px; margin-bottom: 18px;
    align-items: start;
}
.chart-wrap {
    position: relative; height: 240px;
}

/* ── Pie legend ── */
.pie-legend { display: flex; flex-direction: column; gap: 8px; margin-top: 12px; }
.pie-legend-item {
    display: flex; align-items: center; gap: 8px;
    font-size: 12px; flex-wrap: wrap;
}
.pie-dot  { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.pie-label { flex: 1; color: var(--txt); min-width: 80px; }
.pie-amt  { font-weight: 600; color: var(--txt); white-space: nowrap; }
.pie-pct  { font-size: 11px; font-weight: 600; white-space: nowrap; }

/* ── Tables row ── */
.tables-row {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 16px; margin-bottom: 18px;
    align-items: start;
}

/* ── Table (chuẩn adm-table) ── */
.admin-table { width: 100%; border-collapse: collapse; font-size: 12px; }
.admin-table thead tr { background: var(--thead); }
.admin-table thead th {
    padding: 9px 12px; font-size: 10px; font-weight: 600;
    color: var(--txt-sub); text-transform: uppercase;
    letter-spacing: .05em; text-align: left;
    border-bottom: 1px solid var(--border); white-space: nowrap;
}
.admin-table tbody td {
    padding: 9px 12px; border-bottom: 1px solid var(--border);
    vertical-align: middle; color: var(--txt);
}
.admin-table tbody tr:last-child td { border-bottom: none; }
.admin-table tbody tr:hover { background: var(--accent-light); }

/* ── Rank badge ── */
.rank-num {
    display: inline-flex; align-items: center; justify-content: center;
    width: 22px; height: 22px; border-radius: 50%;
    font-size: 11px; font-weight: 700; flex-shrink: 0;
}
.rank-1 { background: #F6E05E; color: #744210; }
.rank-2 { background: #E2E8F0; color: #4A5568; }
.rank-3 { background: #FEEBC8; color: #C05621; }
.rank-n { background: var(--bg); color: var(--txt-sub); }

/* ── Campaign in rank table ── */
.cat-dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }
.cd-name-rank {
    font-size: 12px; font-weight: 600; color: var(--txt);
    max-width: 200px; white-space: nowrap; overflow: hidden;
    text-overflow: ellipsis;
}

/* ── Progress bar in table ── */
.pct-bar-wrap { display: flex; align-items: center; gap: 6px; }
.pct-bar-bg   { flex: 1; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.pct-bar-fill { height: 100%; border-radius: 99px; transition: width .4s ease; }
.pct-text     { font-size: 10px; font-weight: 600; color: var(--accent); white-space: nowrap; }

/* ── Amount col ── */
.amount-col { font-weight: 600; color: var(--ok); white-space: nowrap; font-size: 12px; }

/* ── Donor in rank table (chuẩn donor-cell TongQuan) ── */
.donor-av {
    width: 28px; height: 28px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 10px; font-weight: 700; flex-shrink: 0;
}
.donor-name  { font-size: 12px; font-weight: 500; color: var(--txt); }
.donor-email { font-size: 10px; color: var(--txt-sub); }

/* ── Toast ── */
#toastWrap {
    position: fixed; top: 64px; right: 18px; z-index: 9999;
    display: flex; flex-direction: column; gap: 8px; pointer-events: none;
}
.toast-item {
    display: flex; align-items: flex-start; gap: 10px;
    background: var(--card); border: 1px solid var(--border);
    border-left: 4px solid var(--accent); border-radius: var(--r-card);
    padding: 10px 14px; min-width: 260px; max-width: 340px;
    pointer-events: all; box-shadow: 0 2px 10px rgba(0,0,0,.08);
    animation: toastIn .2s ease;
}
.toast-item.toast-ok  { border-left-color: var(--ok); }
.toast-item.toast-err { border-left-color: var(--err); }
.toast-item .t-msg    { font-size: 13px; color: var(--txt); flex: 1; }
.toast-item .t-close  { font-size: 16px; color: var(--txt-sub); cursor: pointer; line-height: 1; }
@keyframes toastIn { from { opacity:0; transform:translateX(12px); } to { opacity:1; transform:none; } }

/* ── Responsive ── */
@media (max-width: 1200px) {
    .charts-row   { grid-template-columns: 1fr 320px; }
    .tables-row   { grid-template-columns: 1fr 320px; }
}
@media (max-width: 1024px) {
    .charts-row     { grid-template-columns: 1fr; }
    .tables-row     { grid-template-columns: 1fr; }
    .bc-summary-row { grid-template-columns: repeat(2, 1fr); }
    .chart-wrap     { height: 220px; }
}
@media (max-width: 768px) {
    .bc-summary-row   { grid-template-columns: repeat(2, 1fr); gap: 10px; }
    .bc-toolbar       { flex-direction: column; align-items: flex-start; }
    .bc-toolbar-right { width: 100%; }
    .admin-table      { display: block; overflow-x: auto; white-space: nowrap; }
    .charts-row, .tables-row { grid-template-columns: 1fr; }
    .chart-wrap       { height: 200px; }
    .pie-legend       { gap: 6px; }
}
@media (max-width: 480px) {
    .bc-summary-row { grid-template-columns: 1fr 1fr; gap: 8px; }
    .bc-stat-value  { font-size: 20px; }
    .bc-stat-card   { padding: 14px 12px; }
    .btn-export     { width: 100%; justify-content: center; }
    .select-year    { flex: 1; }
}
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Báo cáo & Thống kê</h1>
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
        <button class="btn-export" onclick="exportExcel()">Xuất Excel</button>
    </div>
</div>

<%-- 4 Summary cards --%>
<div class="bc-summary-row" id="summaryRow">
    <div class="bc-stat-card"><div class="bc-stat-label">Đang tải</div><div class="bc-stat-value skeleton" style="width:80px;height:28px;display:inline-block">&nbsp;</div></div>
    <div class="bc-stat-card"><div class="bc-stat-label">Đang tải</div><div class="bc-stat-value skeleton" style="width:80px;height:28px;display:inline-block">&nbsp;</div></div>
    <div class="bc-stat-card"><div class="bc-stat-label">Đang tải</div><div class="bc-stat-value skeleton" style="width:80px;height:28px;display:inline-block">&nbsp;</div></div>
    <div class="bc-stat-card"><div class="bc-stat-label">Đang tải</div><div class="bc-stat-value skeleton" style="width:80px;height:28px;display:inline-block">&nbsp;</div></div>
</div>

<%-- Biểu đồ đường + Biểu đồ tròn --%>
<div class="charts-row">

    <div class="admin-card">
        <div class="card-header">
            <div>
                <h3>Quyên góp theo tháng</h3>
                <div class="card-sub">Tổng tiền đã duyệt (triệu đồng) — năm <span class="lblNamInline">2026</span></div>
            </div>
            <button class="btn-outline-xs" onclick="toggleChartType()">Đổi loại</button>
        </div>
        <div class="chart-wrap">
            <canvas id="chartLine"></canvas>
        </div>
    </div>

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
            <tbody id="topCDBody"><tr><td colspan="4" style="text-align:center;padding:24px;color:var(--admin-chu-phu)">Đang tải...</td></tr></tbody>
        </table>
    </div>

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
            <tbody id="topDonorBody"><tr><td colspan="4" style="text-align:center;padding:24px;color:var(--admin-chu-phu)">Đang tải...</td></tr></tbody>
        </table>
    </div>

</div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    (function () {
        'use strict';

        var chartLineInstance = null;
        var chartPieInstance = null;
        var chartType = 'line';
        var currentYear = 2026;
        var chartMonthlyData = []; // cached

        /* ── Helpers ────────────────────────────────────────────────── */
        var AV_COLORS = [
            { bg: '#EBF8FF', color: '#2B6CB0' }, { bg: '#E9D8FD', color: '#6B46C1' },
            { bg: '#C6F6D5', color: '#276749' }, { bg: '#FEEBC8', color: '#C05621' },
            { bg: '#FED7D7', color: '#C53030' }, { bg: '#E6FFFA', color: '#285E61' },
            { bg: '#FEFCBF', color: '#744210' }, { bg: '#F0FFF4', color: '#22543D' }
        ];
        function avColor(id) { return AV_COLORS[((id || 1) - 1) % AV_COLORS.length]; }
        function getInitials(name) {
            var p = name.trim().split(' ');
            if (p.length === 1) return p[0][0].toUpperCase();
            return (p[p.length - 2][0] + p[p.length - 1][0]).toUpperCase();
        }
        function fmtMoney(n) {
            if (!n || n === 0) return '0 đ';
            if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ';
            if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ';
            return parseInt(n).toLocaleString('vi-VN') + ' đ';
        }

        /* ── Load Summary Stats ──────────────────────────────────────── */
        function loadSummary(year) {
            fetch(location.pathname + '?__ajax=true&action=summary&year=' + year)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var d = j.data;
                    var colors = [
                        'var(--stat-xanh-vien)', 'var(--stat-cam-vien)',
                        'var(--admin-thanh-cong)', 'var(--stat-tim-vien)'
                    ];
                    var bgs = [
                        'var(--stat-xanh-nen)', 'var(--stat-cam-nen)',
                        '#C6F6D5', 'var(--stat-tim-nen)'
                    ];
                    var cards = [
                        { label: 'Tổng tiền quyên góp', value: fmtMoney(d.tongTienQuyen), sub: d.soThangCoDuLieu + ' tháng có dữ liệu' },
                        { label: 'Chiến dịch đang chạy', value: d.chiendichDangChay, sub: 'Tổng ' + d.tongChienDich + ' chiến dịch' },
                        { label: 'Tổng lượt quyên góp', value: d.tongLuotQuyen, sub: 'Giao dịch đã duyệt' },
                        { label: 'Người dùng hoạt động', value: d.nguoiDungHoatDong, sub: 'Tổng ' + d.tongNguoiDung + ' tài khoản' }
                    ];
                    var html = '';
                    cards.forEach(function (c, i) {
                        html += '<div class="bc-stat-card">'
                            + '<div class="bc-stat-label">' + c.label + '</div>'
                            + '<div class="bc-stat-value" style="color:' + colors[i] + '">' + c.value + '</div>'
                            + '<div class="bc-stat-sub">' + c.sub + '</div>'
                            + '</div>';
                    });
                    document.getElementById('summaryRow').innerHTML = html;
                })
                .catch(function () { });
        }

        /* ── Load Monthly Chart ──────────────────────────────────────── */
        function loadMonthlyChart(year) {
            fetch(location.pathname + '?__ajax=true&action=monthly&year=' + year)
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    chartMonthlyData = j.data; // [{thang,tongTien}]
                    renderLineChart();
                })
                .catch(function () { });
        }

        function renderLineChart() {
            var ctx = document.getElementById('chartLine').getContext('2d');
            var vals = [];
            for (var m = 1; m <= 12; m++) {
                var found = chartMonthlyData.filter(function (x) { return x.Thang === m; });
                vals.push(found.length ? (found[0].TongTien / 1e6) : 0);
            }

            var gradient = ctx.createLinearGradient(0, 0, 0, 280);
            gradient.addColorStop(0, 'rgba(49,130,206,.35)');
            gradient.addColorStop(1, 'rgba(49,130,206,0)');

            if (chartLineInstance) chartLineInstance.destroy();
            chartLineInstance = new Chart(ctx, {
                type: chartType,
                data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                    datasets: [{
                        label: 'Quyên góp (triệu đồng)',
                        data: vals,
                        fill: chartType === 'line',
                        backgroundColor: chartType === 'line' ? gradient : ['#E53E3E', '#3182CE', '#D69E2E', '#38A169', '#805AD5', '#DD6B20', '#2B6CB0', '#276749', '#C53030', '#C05621', '#6B46C1', '#285E61'],
                        borderColor: '#3182CE',
                        borderWidth: chartType === 'line' ? 2.5 : 0,
                        borderRadius: chartType === 'bar' ? 4 : 0,
                        pointBackgroundColor: '#3182CE',
                        pointRadius: chartType === 'line' ? 4 : 0,
                        pointHoverRadius: 6, tension: 0.4
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#1A365D', titleColor: '#90CDF4', bodyColor: '#fff', padding: 10,
                            callbacks: { label: function (c) { return ' ' + c.parsed.y.toLocaleString('vi-VN') + ' triệu đồng'; } }
                        }
                    },
                    scales: {
                        x: { grid: { display: false }, ticks: { font: { family: "'Be Vietnam Pro'", size: 11 }, color: '#718096' } },
                        y: {
                            grid: { color: '#EDF2F7' }, border: { dash: [4, 4] },
                            ticks: { font: { family: "'Be Vietnam Pro'", size: 11 }, color: '#718096', callback: function (v) { return v + 'tr'; } }
                        }
                    }
                }
            });
        }

        window.toggleChartType = function () {
            chartType = chartType === 'line' ? 'bar' : 'line';
            renderLineChart();
        };

        /* ── Load Pie Chart ──────────────────────────────────────────── */
        function loadPieChart() {
            fetch(location.pathname + '?__ajax=true&action=pie')
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var data = j.data;
                    var total = data.reduce(function (s, d) { return s + d.TongTien; }, 0);
                    var ctx = document.getElementById('chartPie').getContext('2d');

                    if (chartPieInstance) chartPieInstance.destroy();
                    chartPieInstance = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: data.map(function (d) { return d.TenDanhMuc; }),
                            datasets: [{
                                data: data.map(function (d) { return d.TongTien; }),
                                backgroundColor: data.map(function (d) { return d.MauSac; }),
                                borderWidth: 3, borderColor: '#FFFFFF', hoverOffset: 6
                            }]
                        },
                        options: {
                            responsive: true, maintainAspectRatio: false, cutout: '65%',
                            plugins: {
                                legend: { display: false },
                                tooltip: {
                                    backgroundColor: '#1A365D', bodyColor: '#fff', padding: 10,
                                    callbacks: { label: function (c) { return ' ' + fmtMoney(c.parsed) + ' (' + (c.parsed / total * 100).toFixed(1) + '%)'; } }
                                }
                            }
                        }
                    });

                    var html = '';
                    data.forEach(function (d) {
                        var pct = total > 0 ? (d.TongTien / total * 100).toFixed(1) : 0;
                        html += '<div class="pie-legend-item">'
                            + '<div class="pie-dot" style="background:' + d.MauSac + '"></div>'
                            + '<span class="pie-label">' + d.TenDanhMuc + '</span>'
                            + '<span class="pie-amt">' + fmtMoney(d.TongTien) + '</span>'
                            + '<span class="pie-pct" style="color:' + d.MauSac + '">' + pct + '%</span>'
                            + '</div>';
                    });
                    document.getElementById('pieLegend').innerHTML = html;
                })
                .catch(function () { });
        }

        /* ── Load Top Campaigns ──────────────────────────────────────── */
        function loadTopCD() {
            fetch(location.pathname + '?__ajax=true&action=topCD')
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var data = j.data;
                    if (!data || !data.length) { document.getElementById('topCDBody').innerHTML = '<tr><td colspan="4" style="text-align:center;padding:20px;color:var(--admin-chu-phu)">Không có dữ liệu.</td></tr>'; return; }
                    var maxTien = data[0].SoTienDaQuyen;
                    var html = '';
                    data.forEach(function (c, i) {
                        var rank = i + 1;
                        var rankClass = rank <= 3 ? 'rank-' + rank : 'rank-n';
                        var pct = c.MucTieu > 0 ? Math.round(c.SoTienDaQuyen * 100 / c.MucTieu) : 0;
                        var barPct = maxTien > 0 ? Math.round(c.SoTienDaQuyen * 100 / maxTien) : 0;
                        var color = c.MauDanhMuc || '#3182CE';

                        html += '<tr>'
                            + '<td><span class="rank-num ' + rankClass + '">' + rank + '</span></td>'
                            + '<td>'
                            + '<div style="display:flex;align-items:center;gap:6px">'
                            + '<div class="cat-dot" style="background:' + color + '"></div>'
                            + '<div class="cd-name-rank" title="' + c.TenChienDich + '">' + c.TenChienDich + '</div>'
                            + '</div>'
                            + '<div style="font-size:10px;color:var(--admin-chu-phu);margin-top:2px">' + c.TenDanhMuc + '</div>'
                            + '</td>'
                            + '<td class="amount-col">' + fmtMoney(c.SoTienDaQuyen) + '</td>'
                            + '<td><div class="pct-bar-wrap">'
                            + '<div class="pct-bar-bg"><div class="pct-bar-fill" style="width:' + barPct + '%;background:' + color + '"></div></div>'
                            + '<span class="pct-text">' + pct + '%</span>'
                            + '</div></td>'
                            + '</tr>';
                    });
                    document.getElementById('topCDBody').innerHTML = html;
                })
                .catch(function () { });
        }

        /* ── Load Top Donors ─────────────────────────────────────────── */
        function loadTopDonors() {
            fetch(location.pathname + '?__ajax=true&action=topDonors')
                .then(function (r) { return r.json(); })
                .then(function (j) {
                    if (!j.ok) return;
                    var data = j.data;
                    if (!data || !data.length) { document.getElementById('topDonorBody').innerHTML = '<tr><td colspan="4" style="text-align:center;padding:20px;color:var(--admin-chu-phu)">Không có dữ liệu.</td></tr>'; return; }
                    var html = '';
                    data.forEach(function (d, i) {
                        var rank = i + 1;
                        var rankClass = rank <= 3 ? 'rank-' + rank : 'rank-n';
                        var av = avColor(d.MaNguoiDung);
                        var ini = getInitials(d.HoTen);

                        html += '<tr>'
                            + '<td><span class="rank-num ' + rankClass + '">' + rank + '</span></td>'
                            + '<td><div style="display:flex;align-items:center;gap:8px">'
                            + '<div class="donor-av" style="background:' + av.bg + ';color:' + av.color + '">' + ini + '</div>'
                            + '<div><div class="donor-name">' + d.HoTen + '</div>'
                            + '<div class="donor-email">' + d.Email + '</div></div>'
                            + '</div></td>'
                            + '<td class="amount-col">' + fmtMoney(d.TongTienDaQuyen) + '</td>'
                            + '<td style="font-size:12px;font-weight:600;color:var(--admin-chu-chinh)">' + d.SoLanQuyen + ' lần</td>'
                            + '</tr>';
                    });
                    document.getElementById('topDonorBody').innerHTML = html;
                })
                .catch(function () { });
        }

        /* ── Year change ─────────────────────────────────────────────── */
        window.onYearChange = function () {
            currentYear = parseInt(document.getElementById('selNam').value);
            document.getElementById('lblNam').textContent = currentYear;
            document.querySelectorAll('.lblNamInline').forEach(function (el) { el.textContent = currentYear; });
            loadSummary(currentYear);
            loadMonthlyChart(currentYear);
        };

        /* ── Export ──────────────────────────────────────────────────── */
        window.exportExcel = function () {
            window.location.href = location.pathname + '?__ajax=true&action=export&year=' + currentYear;
        };

        /* ── Init ────────────────────────────────────────────────────── */
        loadSummary(currentYear);
        loadMonthlyChart(currentYear);
        loadPieChart();
        loadTopCD();
        loadTopDonors();

    })();
</script>
</asp:Content>
