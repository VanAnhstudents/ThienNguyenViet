<%@ Page Title="Báo cáo" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="BaoCao.aspx.cs"
    Inherits="ThienNguyenViet.Admin.BaoCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .bc-toolbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 18px; flex-wrap: wrap; gap: 10px;
    }
    .bc-toolbar h3 { font-size: 14px; font-weight: 600; }
    .bc-toolbar-right { display: flex; align-items: center; gap: 8px; }

    .bc-summary { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; }
    .bc-stat {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .bc-stat:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }

    /* Stat card chỉ 2 thành phần: label + value */
    .bc-stat-label { font-size: 10px; font-weight: 600; color: var(--txt-sub); text-transform: uppercase; margin-bottom: 6px; }
    .bc-stat-value { font-size: 22px; font-weight: 700; }

    .charts-row { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; margin-bottom: 18px; }
    .chart-wrap { position: relative; height: 280px; }
    .tables-row { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; margin-bottom: 18px; }

    /* rank-num: BỎ bo tròn, chỉ hiển thị số thuần */
    .rank-num {
        font-size: 13px; font-weight: 700; color: var(--txt);
    }
    .rank-1 { color: #C05621; }
    .rank-2 { color: #4A5568; }
    .rank-3 { color: #C53030; }

    .donor-name { font-size: 12px; font-weight: 500; }
    .donor-email { font-size: 10px; color: var(--txt-sub); }
    .amount-col { font-weight: 600; color: var(--ok); white-space: nowrap; }

    .pie-legend { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 10px; justify-content: center; }
    .pie-legend-item { display: flex; align-items: center; gap: 4px; font-size: 11px; }
    .pie-dot { width: 10px; height: 10px; border-radius: 2px; }

    @media (max-width: 1024px) {
        .bc-summary { grid-template-columns: repeat(2,1fr); }
        .charts-row { grid-template-columns: 1fr; }
        .tables-row { grid-template-columns: 1fr; }
    }
    @media (max-width: 425px) {
        .bc-summary { grid-template-columns: 1fr 1fr; gap: 8px; }
        .chart-wrap { height: 200px; }
    }
    @media (max-width: 375px) { .bc-summary { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Báo cáo & Thống kê</h1>
    <p>Tổng hợp dữ liệu hoạt động hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="bc-toolbar">
        <h3>Báo cáo năm <span id="lblNam"><%= DateTime.Now.Year %></span></h3>
        <div class="bc-toolbar-right">
            <select class="select" id="selNam" onchange="onYearChange()">
                <% for(int y = DateTime.Now.Year; y >= 2020; y--) { %>
                    <option value="<%= y %>"><%= y %></option>
                <% } %>
            </select>
        </div>
    </div>

    <%-- Thống kê - chỉ 2 thành phần: label + value --%>
    <div class="bc-summary" id="summaryRow">
        <div class="bc-stat">
            <div class="bc-stat-label">Tổng tiền quyên góp</div>
            <div class="bc-stat-value" id="bcTongTien" style="color:var(--accent)">--</div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Tổng lượt quyên góp</div>
            <div class="bc-stat-value" id="bcTongLuot">--</div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Chiến dịch đang chạy</div>
            <div class="bc-stat-value" id="bcChienDich" style="color:var(--ok)">--</div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Người dùng hoạt động</div>
            <div class="bc-stat-value" id="bcNguoiDung">--</div>
        </div>
    </div>

    <%-- Biểu đồ --%>
    <div class="charts-row">
        <div class="card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Triệu đồng — năm <span class="lblNamInline"><%= DateTime.Now.Year %></span></div>
                </div>
            </div>
            <div class="chart-wrap"><canvas id="chartLine"></canvas></div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3>Phân bố theo danh mục</h3>
            </div>
            <div class="chart-wrap" style="height:200px"><canvas id="chartPie"></canvas></div>
            <div class="pie-legend" id="pieLegend"></div>
        </div>
    </div>

    <%-- Bảng xếp hạng --%>
    <div class="tables-row">
        <div class="card">
            <div class="card-header"><h3>Top 10 chiến dịch tiêu biểu</h3></div>
            <table class="tbl">
                <thead><tr><th style="width:32px">STT</th><th>Chiến dịch</th><th>Số tiền</th><th>Tiến độ</th></tr></thead>
                <tbody id="topCDBody"><tr><td colspan="4" class="empty-state">Đang tải...</td></tr></tbody>
            </table>
        </div>
        <div class="card">
            <div class="card-header"><h3>Top 10 nhà hảo tâm</h3></div>
            <table class="tbl">
                <thead><tr><th style="width:32px">STT</th><th>Họ và tên</th><th>Tổng tiền</th><th>Số lần</th></tr></thead>
                <tbody id="topDonorBody"><tr><td colspan="4" class="empty-state">Đang tải...</td></tr></tbody>
            </table>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
(function(){
    'use strict';
    var BASE = '<%= ResolveUrl("~/Admin/BaoCao.aspx") %>';
    var currentYear = <%= DateTime.Now.Year %>;
        var lineChart, pieChart;

        function fmtMoney(v) {
            if (v >= 1e9) return (v / 1e9).toFixed(1) + ' tỷ';
            if (v >= 1e6) return (v / 1e6).toFixed(1) + ' triệu';
            return Number(v).toLocaleString('vi-VN') + ' VNĐ';
        }

        function loadSummary(year) {
            fetch(BASE + '?__ajax=true&action=summary&year=' + year)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    var s = d.data;
                    document.getElementById('bcTongTien').textContent = fmtMoney(s.tongTienQuyen);
                    document.getElementById('bcTongLuot').textContent = s.tongLuotQuyen;
                    document.getElementById('bcChienDich').textContent = s.chiendichDangChay + '/' + s.tongChienDich;
                    document.getElementById('bcNguoiDung').textContent = s.nguoiDungHoatDong + '/' + s.tongNguoiDung;
                });
        }

        function loadMonthlyChart(year) {
            fetch(BASE + '?__ajax=true&action=monthly&year=' + year)
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    var labels = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
                    var tienTr = d.data.map(function (v) { return Math.round(v.tien / 1e6); });
                    if (lineChart) lineChart.destroy();
                    lineChart = new Chart(document.getElementById('chartLine').getContext('2d'), {
                        type: 'bar',
                        data: {
                            labels: labels, datasets: [{
                                label: 'Quyên góp (triệu đồng)', data: tienTr,
                                backgroundColor: '#3182CE', borderRadius: 4, borderSkipped: false
                            }]
                        },
                        options: {
                            responsive: true, maintainAspectRatio: false, animation: false,
                            plugins: { legend: { display: false } },
                            scales: {
                                x: { grid: { display: false } },
                                y: { beginAtZero: true, ticks: { callback: function (v) { return v + ' triệu'; } } }
                            }
                        }
                    });
                });
        }

        function loadPieChart() {
            fetch(BASE + '?__ajax=true&action=pie')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    var labels = d.data.map(function (x) { return x.TenDanhMuc; });
                    var values = d.data.map(function (x) { return x.TongTien; });
                    var colors = d.data.map(function (x) { return x.MauSac || '#3182CE'; });

                    if (pieChart) pieChart.destroy();
                    pieChart = new Chart(document.getElementById('chartPie').getContext('2d'), {
                        type: 'doughnut',
                        data: { labels: labels, datasets: [{ data: values, backgroundColor: colors, borderWidth: 2 }] },
                        options: {
                            responsive: true, maintainAspectRatio: false,
                            plugins: { legend: { display: false } }
                        }
                    });

                    var leg = '';
                    d.data.forEach(function (x) {
                        leg += '<div class="pie-legend-item"><div class="pie-dot" style="background:' + (x.MauSac || '#3182CE') + '"></div>' + x.TenDanhMuc + '</div>';
                    });
                    document.getElementById('pieLegend').innerHTML = leg;
                });
        }

        function loadTopCD() {
            fetch(BASE + '?__ajax=true&action=topCD')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok || !d.data.length) return;
                    var html = '';
                    d.data.forEach(function (cd, i) {
                        var rank = i + 1;
                        var cls = rank <= 3 ? 'rank-' + rank : '';
                        var pct = cd.MucTieu > 0 ? Math.min(100, Math.round(cd.TongTienDaQuyen * 100 / cd.MucTieu)) : 0;
                        /* rank-num: BỎ bo tròn, chỉ hiển thị số thuần */
                        html += '<tr><td><span class="rank-num ' + cls + '">' + rank + '</span></td>' +
                            '<td style="font-size:12px;font-weight:500">' + cd.TenChienDich + '</td>' +
                            '<td class="amount-col">' + fmtMoney(cd.TongTienDaQuyen) + '</td>' +
                            '<td style="min-width:80px"><div class="prog-wrap"><div class="prog-fill" style="width:' + pct + '%"></div></div><div style="font-size:10px;color:var(--txt-sub);margin-top:2px">' + pct + '%</div></td></tr>';
                    });
                    document.getElementById('topCDBody').innerHTML = html;
                });
        }

        function loadTopDonors() {
            fetch(BASE + '?__ajax=true&action=topDonors')
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok || !d.data.length) return;
                    var html = '';
                    d.data.forEach(function (dn, i) {
                        var rank = i + 1;
                        var cls = rank <= 3 ? 'rank-' + rank : '';
                        /* BỎ donor-av avatar, chỉ hiển thị tên thuần */
                        html += '<tr><td><span class="rank-num ' + cls + '">' + rank + '</span></td>' +
                            '<td><div><div class="donor-name">' + dn.HoTen + '</div><div class="donor-email">' + dn.Email + '</div></div></td>' +
                            '<td class="amount-col">' + fmtMoney(dn.TongTienDaQuyen) + '</td>' +
                            '<td style="font-size:12px;font-weight:600">' + dn.SoLanQuyen + ' lần</td></tr>';
                    });
                    document.getElementById('topDonorBody').innerHTML = html;
                });
        }

        window.onYearChange = function () {
            currentYear = parseInt(document.getElementById('selNam').value);
            document.getElementById('lblNam').textContent = currentYear;
            document.querySelectorAll('.lblNamInline').forEach(function (el) { el.textContent = currentYear; });
            loadSummary(currentYear);
            loadMonthlyChart(currentYear);
        };

        loadSummary(currentYear);
        loadMonthlyChart(currentYear);
        loadPieChart();
        loadTopCD();
        loadTopDonors();
    })();
</script>
</asp:Content>
