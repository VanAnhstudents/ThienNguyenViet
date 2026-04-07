<%@ Page Title="Báo cáo & Thống kê" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="BaoCao.aspx.cs"
         Inherits="ThienNguyenViet.Admin.BaoCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══ Toolbar ══════════════════════════════════════════════════════ */
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

/* ══ Summary cards — căn giữa, không icon ════════════════════════ */
.bc-summary-row {
    display: grid; grid-template-columns: repeat(4,1fr);
    gap: 14px; margin-bottom: 20px;
}
.bc-stat-card {
    background: var(--admin-card); border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien); padding: 20px 18px;
    text-align: center; display: flex; flex-direction: column;
    align-items: center; justify-content: center;
}
.bc-stat-label {
    font-size: 11px; font-weight: 600; text-transform: uppercase;
    letter-spacing: .04em; color: var(--admin-chu-phu); margin-bottom: 8px;
    text-align: center;
}
.bc-stat-value {
    font-size: 24px; font-weight: 700; color: var(--admin-chu-chinh);
    line-height: 1; margin-bottom: 6px; text-align: center;
}
.bc-stat-sub   { font-size: 11px; color: var(--admin-chu-phu); text-align: center; }
.bc-stat-up    { color: var(--admin-thanh-cong); font-weight: 600; }
.bc-stat-down  { color: var(--admin-loi); font-weight: 600; }

/* ══ Chart layout ══════════════════════════════════════════════════ */
.charts-row {
    display: grid; grid-template-columns: 1fr 380px;
    gap: 16px; margin-bottom: 20px;
}
.chart-wrap { position: relative; height: 280px; }
.card-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
.card-header h3  { font-size: 14px; font-weight: 600; }
.card-header .card-sub { font-size: 11px; color: var(--admin-chu-phu); margin-top: 2px; }
.btn-outline-xs {
    font-size: 11px; padding: 4px 10px; border-radius: var(--r-nut);
    background: transparent; border: 1px solid var(--admin-vien);
    color: var(--admin-chu-phu); cursor: pointer; font-family: var(--font);
    transition: background .12s;
}
.btn-outline-xs:hover { background: var(--admin-nen); }

/* ══ Pie legend ════════════════════════════════════════════════════ */
.pie-legend { display: flex; flex-direction: column; gap: 10px; margin-top: 16px; }
.pie-legend-item { display: flex; align-items: center; gap: 8px; }
.pie-dot { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.pie-label { font-size: 12px; color: var(--admin-chu-chinh); flex: 1; }
.pie-pct   { font-size: 12px; font-weight: 600; }
.pie-amt   { font-size: 11px; color: var(--admin-chu-phu); }

/* ══ Rank tables ════════════════════════════════════════════════════ */
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

/* Loading skeleton */
.skeleton {
    background: linear-gradient(90deg,#e2e8f0 25%,#f0f4f8 50%,#e2e8f0 75%);
    background-size: 400% 100%; border-radius: 4px; animation: skel 1.2s infinite;
}
@keyframes skel { 0%{background-position:100% 50%} 100%{background-position:0% 50%} }
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
