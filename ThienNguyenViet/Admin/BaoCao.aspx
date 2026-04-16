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
    .bc-summary { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; text-align: center }
    .bc-stat {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .bc-stat:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .bc-stat-label { font-size: 10px; font-weight: 600; text-transform: uppercase; margin-bottom: 6px; }
    .bc-stat-value { font-size: 22px; font-weight: 700; }
    .charts-row { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; margin-bottom: 18px; }
    .chart-wrap { position: relative; height: 280px; }
    .tables-row { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; margin-bottom: 18px; }
    .rank-num { font-size: 13px; font-weight: 700; }
    .donor-name { font-size: 12px; font-weight: 500; }
    .donor-email { font-size: 10px; }
    .amount-col { font-weight: 600; white-space: nowrap; }
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

    <!-- === HIDDEN FIELD CHO POSTBACK NĂM === -->
    <asp:HiddenField ID="hfYear" runat="server" />

    <%-- === PHẦN ĐÃ SỬA: Chọn năm qua postback === --%>
    <div class="bc-toolbar">
        <h3>Báo cáo năm <%= SelectedYear %></h3>
        <div class="bc-toolbar-right">
            <select class="select" onchange="changeYear(this.value)">
                <% for(int y = DateTime.Now.Year; y >= 2020; y--) { %>
                    <option value="<%= y %>" <%= y == SelectedYear ? "selected" : "" %>><%= y %></option>
                <% } %>
            </select>
        </div>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Thống kê render server-side === --%>
    <div class="bc-summary">
        <div class="bc-stat">
            <div class="bc-stat-label">Tổng tiền quyên góp</div>
            <div class="bc-stat-value"><%= FormatTien(TongTienQuyen) %></div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Tổng lượt quyên góp</div>
            <div class="bc-stat-value"><%= TongLuotQuyen.ToString("N0") %></div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Chiến dịch đang chạy</div>
            <div class="bc-stat-value"><%= ChienDichDangChay %>/<%= TongChienDich %></div>
        </div>
        <div class="bc-stat">
            <div class="bc-stat-label">Người dùng hoạt động</div>
            <div class="bc-stat-value"><%= NguoiDungHoatDong %>/<%= TongNguoiDung %></div>
        </div>
    </div>

    <%-- Biểu đồ --%>
    <div class="charts-row">
        <div class="card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Triệu đồng — năm <%= SelectedYear %></div>
                </div>
            </div>
            <div class="chart-wrap"><canvas id="chartLine"></canvas></div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3>Phân bố theo danh mục</h3>
            </div>
            <div class="chart-wrap" style="height:200px"><canvas id="chartPie"></canvas></div>
            <div class="pie-legend" id="pieLegend">
                <!-- === PHẦN ĐÃ SỬA: Pie legend render từ JS với data server-side === -->
            </div>
        </div>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Bảng xếp hạng render server-side === --%>
    <div class="tables-row">
        <div class="card">
            <div class="card-header"><h3>Top 10 chiến dịch tiêu biểu</h3></div>
            <table class="tbl">
                <thead><tr><th style="width:32px">STT</th><th>Chiến dịch</th><th>Số tiền</th><th>Tiến độ</th></tr></thead>
                <tbody>
                <% if (DtTopChienDich != null && DtTopChienDich.Rows.Count > 0) {
                    int stt = 1;
                    foreach (System.Data.DataRow cd in DtTopChienDich.Rows) {
                        string tenCD = cd["TenChienDich"].ToString();
                        long mucTieu = Convert.ToInt64(cd["MucTieu"]);
                        long tongTien = Convert.ToInt64(cd["TongTienDaQuyen"]);
                        int pct = mucTieu > 0 ? (int)Math.Min(100, Math.Round((double)tongTien * 100 / mucTieu)) : 0;
                %>
                    <tr>
                        <td><span class="rank-num"><%= stt %></span></td>
                        <td style="font-size:12px;font-weight:500"><%= Server.HtmlEncode(tenCD) %></td>
                        <td class="amount-col"><%= FormatTien(tongTien) %></td>
                        <td style="min-width:80px">
                            <div class="prog-wrap"><div class="prog-fill" style="width:<%= pct %>%"></div></div>
                            <div style="font-size:10px;margin-top:2px"><%= pct %>%</div>
                        </td>
                    </tr>
                <% stt++;
                    }
                } else { %>
                    <tr><td colspan="4" class="empty-state">Chưa có dữ liệu.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div class="card">
            <div class="card-header"><h3>Top 10 nhà hảo tâm</h3></div>
            <table class="tbl">
                <thead><tr><th style="width:32px">STT</th><th>Họ và tên</th><th>Tổng tiền</th><th>Số lần</th></tr></thead>
                <tbody>
                <% if (DtTopDonors != null && DtTopDonors.Rows.Count > 0) {
                    int stt2 = 1;
                    foreach (System.Data.DataRow dn in DtTopDonors.Rows) {
                        string hoTen = dn["HoTen"].ToString();
                        string email = dn["Email"].ToString();
                        long tongTien = Convert.ToInt64(dn["TongTienDaQuyen"]);
                        int soLan = Convert.ToInt32(dn["SoLanQuyen"]);
                %>
                    <tr>
                        <td><span class="rank-num"><%= stt2 %></span></td>
                        <td>
                            <div class="donor-name"><%= Server.HtmlEncode(hoTen) %></div>
                            <div class="donor-email" style="color:var(--txt-sub)"><%= Server.HtmlEncode(email) %></div>
                        </td>
                        <td class="amount-col"><%= FormatTien(tongTien) %></td>
                        <td style="font-size:12px;font-weight:600"><%= soLan %> lần</td>
                    </tr>
                <% stt2++;
                    }
                } else { %>
                    <tr><td colspan="4" class="empty-state">Chưa có dữ liệu.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
(function(){
    'use strict';

    // === PHẦN ĐÃ SỬA: Chart data từ server-side, không cần AJAX ===

    // Biểu đồ cột - quyên góp theo tháng
    var monthlyData = <%= ChartMonthlyJson %>;
    var labels = ['Tháng 1','Tháng 2','Tháng 3','Tháng 4','Tháng 5','Tháng 6','Tháng 7','Tháng 8','Tháng 9','Tháng 10','Tháng 11','Tháng 12'];
    var tienTr = monthlyData.map(function(v){ return Math.round(v / 1e6); });

    new Chart(document.getElementById('chartLine').getContext('2d'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Quyên góp (triệu đồng)',
                data: tienTr,
                backgroundColor: '#3182CE',
                borderRadius: 4,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false, animation: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false } },
                y: { beginAtZero: true, ticks: { callback: function(v){ return v + ' triệu'; } } }
            }
        }
    });

    // Biểu đồ tròn - phân bố danh mục
    var pieLabels = <%= ChartPieLabelsJson %>;
    var pieValues = <%= ChartPieValuesJson %>;
    var pieColors = <%= ChartPieColorsJson %>;

    if (pieValues.length > 0) {
        new Chart(document.getElementById('chartPie').getContext('2d'), {
            type: 'doughnut',
            data: {
                labels: pieLabels,
                datasets: [{ data: pieValues, backgroundColor: pieColors, borderWidth: 2 }]
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                plugins: { legend: { display: false } }
            }
        });

        // Legend
        var leg = '';
        for (var i = 0; i < pieLabels.length; i++) {
            leg += '<div class="pie-legend-item"><div class="pie-dot" style="background:' + pieColors[i] + '"></div>' + pieLabels[i] + '</div>';
        }
        document.getElementById('pieLegend').innerHTML = leg;
    }

    // Chọn năm - postback
    window.changeYear = function(year) {
        document.getElementById('<%= hfYear.ClientID %>').value = year;
        document.getElementById('form1').submit();
    };
})();
</script>
</asp:Content>
