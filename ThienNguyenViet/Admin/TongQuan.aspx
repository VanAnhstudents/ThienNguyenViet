<%@ Page Title="" Language="C#" 
    MasterPageFile="~/Admin.Master" AutoEventWireup="true" 
    CodeBehind="TongQuan.aspx.cs" 
    Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .stat-card { text-align: center }
    .main-row { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; margin-bottom: 18px; }
    .cd-list { list-style: none; }
    .cd-item {
        padding: 12px 0; border-bottom: 1px solid var(--border);
        display: flex; justify-content: space-between; align-items: center;
    }
    .cd-item:last-child { border-bottom: none; }
    .cd-item-name { font-size: 13px; font-weight: 500; flex: 1; margin-right: 10px; }
    .cd-item-pct { font-size: 12px; font-weight: 600; white-space: nowrap; }
    .cd-item-bar { width: 100%; }
    .amount-cell { font-weight: 600; font-size: 12px; white-space: nowrap; }
    .proof-wrap {
        margin-top: 6px; border: 1px solid var(--border);
        border-radius: var(--r); padding: 10px;
        display: flex; align-items: center;
        justify-content: center; background: var(--bg);
        min-height: 60px; font-size: 12px;
    }
    .proof-wrap img { max-width: 100%; max-height: 260px; border-radius: var(--r); }
    @media (max-width: 1024px) { .main-row { grid-template-columns: 1fr; } }
    @media (max-width: 425px) { .chart-wrap { height: 200px; } }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bảng điều khiển</h1>
    <p>Tổng quan hoạt động hệ thống</p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- === HIDDEN FIELDS CHO POSTBACK === -->
    <asp:HiddenField ID="hfAction" runat="server" />
    <asp:HiddenField ID="hfParam" runat="server" />

    <%-- 4 Thẻ thống kê --%>
    <div class="stat-grid">
        <div class="stat-card s-blue">
            <div class="stat-card-label">Tổng quyên góp</div>
            <div class="stat-card-value"><%= FormatTien(TongTienDaQuyen) %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">Chiến dịch đang chạy</div>
            <div class="stat-card-value"><%= ChienDichDangChay %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">Người dùng đăng ký</div>
            <div class="stat-card-value"><%= TongNguoiDung.ToString("N0") %></div>
        </div>
        <div class="stat-card s-green">
            <div class="stat-card-label">Giao dịch chờ duyệt</div>
            <div class="stat-card-value"><%= TongChoXuLy %></div>
        </div>
    </div>

    <%-- Biểu đồ + Chiến dịch tiêu biểu (SERVER-SIDE RENDER) --%>
    <div class="main-row">
        <div class="card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Tổng tiền (triệu đồng) — năm <%= DateTime.Now.Year %></div>
                </div>
                <button type="button" class="btn btn-outline btn-sm" onclick="xuatCSVBieuDo()">Xuất CSV</button>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQG"></canvas>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3>Chiến dịch tiêu biểu</h3>
            </div>
            <!-- === PHẦN ĐÃ SỬA: Render server-side thay vì AJAX === -->
            <ul class="cd-list">
            <% if (DtChienDichNoiBat != null && DtChienDichNoiBat.Rows.Count > 0) {
                foreach (System.Data.DataRow cd in DtChienDichNoiBat.Rows) {
                    decimal pct = Convert.ToDecimal(cd["PhanTram"]);
                    if (pct > 100) pct = 100;
            %>
                <li class="cd-item">
                    <div style="flex:1">
                        <div class="cd-item-name"><%= Server.HtmlEncode(cd["TenChienDich"].ToString()) %></div>
                        <div class="cd-item-bar"><div class="prog-wrap"><div class="prog-fill" style="width: <%= pct %>%"></div></div></div>
                    </div>
                    <div class="cd-item-pct"><%= pct.ToString("0.0") %>%</div>
                </li>
            <% }
            } else { %>
                <li class="empty-state">Chưa có chiến dịch tiêu biểu.</li>
            <% } %>
            </ul>
        </div>
    </div>

    <%-- Bảng giao dịch gần đây --%>
    <div class="card">
        <div class="card-header">
            <h3>Giao dịch gần đây</h3>
            <a href="<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>" class="btn btn-outline btn-sm">Xem tất cả</a>
        </div>
        <table class="tbl">
            <thead>
                <tr>
                    <th>Mã</th>
                    <th>Người quyên góp</th>
                    <th>Chiến dịch</th>
                    <th>Số tiền</th>
                    <th>Ngày</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <% if (DtGiaoDich != null && DtGiaoDich.Rows.Count > 0) {
                foreach (System.Data.DataRow r in DtGiaoDich.Rows) {
                    int maQG = Convert.ToInt32(r["MaQuyenGop"]);
                    string hoTen = r["HoTen"].ToString();
                    string email = r["Email"] == DBNull.Value ? "" : r["Email"].ToString();
                    string tenCD = r["TenChienDich"].ToString();
                    long soTien = Convert.ToInt64(r["SoTien"]);
                    int ts = Convert.ToInt32(r["TrangThai"]);
                    bool anDanh = r["AnDanh"] != DBNull.Value && Convert.ToBoolean(r["AnDanh"]);
                    string ngay = Convert.ToDateTime(r["NgayTao"]).ToString("dd/MM/yyyy");
                    string loiNhan = r["LoiNhan"] == DBNull.Value ? "" : r["LoiNhan"].ToString();
                    string anhXN = r["AnhXacNhan"] == DBNull.Value ? "" : r["AnhXacNhan"].ToString();

                    string tsLabel = new[]{"Chờ duyệt","Đã duyệt","Từ chối"}[ts < 3 ? ts : 0];
                    string tsCls = new[]{"badge-warn","badge-ok","badge-err"}[ts < 3 ? ts : 0];
            %>
                <tr>
                    <td>#<%= maQG %></td>
                    <td>
                        <div style="font-size:12px;font-weight:500"><%= Server.HtmlEncode(hoTen) %></div>
                        <div style="font-size:10px;color:var(--txt-sub)"><%= Server.HtmlEncode(email) %></div>
                    </td>
                    <td style="font-size:12px"><%= Server.HtmlEncode(tenCD) %></td>
                    <td class="amount-cell"><%= soTien.ToString("N0") %> đ</td>
                    <td style="font-size:11px;white-space:nowrap"><%= ngay %></td>
                    <td><span class="badge <%= tsCls %>"><%= tsLabel %></span></td>
                    <td>
                        <button type="button" class="btn btn-xs btn-outline"
                            onclick="openDetail(<%= maQG %>,'<%= Server.HtmlEncode(hoTen).Replace("'","\\'") %>','<%= Server.HtmlEncode(email).Replace("'","\\'") %>','<%= Server.HtmlEncode(tenCD).Replace("'","\\'") %>',<%= soTien %>,'<%= ngay %>',<%= ts %>,<%= anDanh.ToString().ToLower() %>,'<%= Server.HtmlEncode(loiNhan).Replace("'","\\'") %>','<%= Server.HtmlEncode(anhXN).Replace("'","\\'") %>')">Xem</button>
                        <!-- === PHẦN ĐÃ SỬA: Duyệt/Từ chối qua postback thay vì AJAX === -->
                        <% if (ts == 0) { %>
                        <button type="button" class="btn btn-xs btn-success" onclick="duyetGiaoDich(<%= maQG %>,'duyet')">Duyệt</button>
                        <button type="button" class="btn btn-xs btn-danger" onclick="duyetGiaoDich(<%= maQG %>,'tuchoi')">Từ chối</button>
                        <% } %>
                    </td>
                </tr>
            <% }
            } else { %>
                <tr><td colspan="7" class="empty-state">Chưa có giao dịch nào.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <%-- Modal chi tiết --%>
    <div class="overlay" id="detailOverlay" onclick="if(event.target===this)closeDetail()">
        <div class="modal modal-wide">
            <div class="modal-hd">
                <h3>Chi tiết giao dịch</h3>
                <button type="button" class="modal-close" onclick="closeDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid">
                    <div class="detail-item"><label>Mã giao dịch</label><span class="detail-val" id="dlId"></span></div>
                    <div class="detail-item"><label>Ngày tạo</label><span class="detail-val" id="dlNgay"></span></div>
                    <div class="detail-item"><label>Người góp</label><span class="detail-val" id="dlNguoi"></span></div>
                    <div class="detail-item"><label>Email</label><span class="detail-val" id="dlEmail"></span></div>
                    <div class="detail-item"><label>Chiến dịch</label><span class="detail-val" id="dlCD"></span></div>
                    <div class="detail-item"><label>Số tiền</label><span class="detail-val" id="dlSoTien" style="font-size:15px;font-weight:700;color:var(--ok)"></span></div>
                    <div class="detail-item"><label>Trạng thái</label><span class="detail-val" id="dlTT"></span></div>
                    <div class="detail-item"><label>Ẩn danh</label><span class="detail-val" id="dlAnDanh"></span></div>
                    <div class="detail-item detail-full"><label>Lời nhắn</label><span class="detail-val" id="dlLoiNhan" style="font-style:italic;color:var(--txt-sub)"></span></div>
                    <div class="detail-item detail-full"><label>Ảnh xác nhận</label><div class="proof-wrap" id="dlAnh"></div></div>
                </div>
            </div>
            <div class="modal-ft" id="detailFt">
                <button type="button" class="btn btn-outline" onclick="closeDetail()">Đóng</button>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';

        // === PHẦN ĐÃ SỬA: Chart data từ server-side, không cần AJAX ===
        var chartTien = <%= ChartDataJson %>;
        var labels = ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'];
        var tienTrieu = chartTien.map(function(v){ return Math.round(v / 1000000); });
        var ctx = document.getElementById('chartQG').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Quyên góp (triệu đồng)',
                    data: tienTrieu,
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
                    y: { beginAtZero: true, ticks: { callback: function(v){ return v + ' Tr'; } } }
                }
            }
        });

        // Xuất CSV biểu đồ quyên góp theo tháng
        window.xuatCSVBieuDo = function () {
            var nam = <%= DateTime.Now.Year %>;
            var csv = 'Tháng,Số tiền (VNĐ)\n';
            for (var i = 0; i < 12; i++) {
                csv += 'Tháng ' + (i + 1) + '/' + nam + ',' + chartTien[i] + '\n';
            }
            var blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
            var link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'QuyenGopTheoThang_' + nam + '.csv';
            link.click();
            URL.revokeObjectURL(link.href);
        };

        // Modal chi tiết (giữ nguyên client-side)
        window.openDetail = function (id, nguoi, email, cd, soTien, ngay, tt, anDanh, loiNhan, anhXN) {
            document.getElementById('dlId').textContent = '#' + id;
            document.getElementById('dlNgay').textContent = ngay;
            document.getElementById('dlNguoi').textContent = nguoi;
            document.getElementById('dlEmail').textContent = email || '(không có)';
            document.getElementById('dlCD').textContent = cd;
            document.getElementById('dlSoTien').textContent = Number(soTien).toLocaleString('vi-VN') + ' đ';
            var ttNames = ['Chờ duyệt','Đã duyệt','Từ chối'];
            var ttClasses = ['badge-warn','badge-ok','badge-err'];
            document.getElementById('dlTT').innerHTML = '<span class="badge ' + (ttClasses[tt]||'') + '">' + (ttNames[tt]||'') + '</span>';
            document.getElementById('dlAnDanh').textContent = anDanh ? 'Có' : 'Không';
            document.getElementById('dlLoiNhan').textContent = loiNhan || '(không có lời nhắn)';
            var anhEl = document.getElementById('dlAnh');
            if (anhXN) { anhEl.innerHTML = '<img src="' + anhXN + '" alt="Ảnh xác nhận" />'; }
            else { anhEl.innerHTML = 'Chưa có ảnh xác nhận'; }
            document.getElementById('detailOverlay').classList.add('show');
        };
        window.closeDetail = function () {
            document.getElementById('detailOverlay').classList.remove('show');
        };

        // === PHẦN ĐÃ SỬA: Duyệt/Từ chối qua postback thay vì AJAX ===
        window.duyetGiaoDich = function (id, action) {
            if (!confirm(action === 'duyet' ? 'Duyệt giao dịch #' + id + '?' : 'Từ chối giao dịch #' + id + '?')) return;
            document.getElementById('<%= hfAction.ClientID %>').value = action;
            document.getElementById('<%= hfParam.ClientID %>').value = id;
            document.getElementById('form1').submit();
        };
    })();
</script>
</asp:Content>
