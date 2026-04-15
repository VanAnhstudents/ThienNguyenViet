<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .main-row { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; margin-bottom: 18px; }

    /* Campaign list */
    .cd-list { list-style: none; }
    .cd-item {
        padding: 12px 0; border-bottom: 1px solid var(--border);
        display: flex; justify-content: space-between; align-items: center;
    }
    .cd-item:last-child { border-bottom: none; }
    .cd-item-name { font-size: 13px; font-weight: 500; flex: 1; margin-right: 10px; }
    .cd-item-pct { font-size: 12px; font-weight: 600; white-space: nowrap; }
    .cd-item-bar { width: 100%; margin-top: 6px; }

    .amount-cell { font-weight: 600; font-size: 12px; white-space: nowrap; }

    /* Proof image */
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

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bảng điều khiển</h1>
    <p>Tổng quan hoạt động hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- 4 Thẻ thống kê - CHỈ 2 THÀNH PHẦN: label + value --%>
    <div class="stat-grid">
        <div class="stat-card s-blue">
            <div class="stat-card-label">Tổng quyên góp</div>
            <div class="stat-card-value" id="statTongTien"><%= FormatTien(TongTienDaQuyen) %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">Chiến dịch đang chạy</div>
            <div class="stat-card-value" id="statChienDich"><%= ChienDichDangChay %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">Người dùng đăng ký</div>
            <div class="stat-card-value" id="statNguoiDung"><%= TongNguoiDung.ToString("N0") %></div>
        </div>
        <div class="stat-card s-green">
            <div class="stat-card-label">Giao dịch chờ duyệt</div>
            <div class="stat-card-value" id="statChoDuyet"><%= TongChoXuLy %></div>
        </div>
    </div>

    <%-- Biểu đồ + Chiến dịch tiêu biểu --%>
    <div class="main-row">
        <div class="card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Tổng tiền (triệu đồng) — năm <%= DateTime.Now.Year %></div>
                </div>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQG"></canvas>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3>Chiến dịch tiêu biểu</h3>
            </div>
            <ul class="cd-list" id="cdList">
                <li class="empty-state">Đang tải...</li>
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
                    <%-- BỎ avatar, chỉ hiển thị tên thuần --%>
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
                        <% if (ts == 0) { %>
                        <button type="button" class="btn btn-xs btn-success" onclick="ajaxDuyet(<%= maQG %>,'duyet')">Duyệt</button>
                        <button type="button" class="btn btn-xs btn-danger" onclick="ajaxDuyet(<%= maQG %>,'tuchoi','Từ chối từ tổng quan')">Từ chối</button>
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

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var PAGE_URL = '<%= ResolveUrl("~/Admin/TongQuan.aspx") %>';
        var chart;

        function initChart(data) {
            var labels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
            var tienTrieu = data.tien.map(function (v) { return Math.round(v / 1000000); });
            var ctx = document.getElementById('chartQG').getContext('2d');
            chart = new Chart(ctx, {
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
                        y: { beginAtZero: true, ticks: { callback: function (v) { return v + ' Tr'; } } }
                    }
                }
            });
        }

        function fetchChartData() {
            fetch(PAGE_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: '__ajax=true&action=chartdata'
            })
                .then(function (r) { return r.json(); })
                .then(function (d) { if (d.ok) initChart(d.data); })
                .catch(function () { });
        }

        function fetchCampaigns() {
            fetch(PAGE_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: '__ajax=true&action=campaigns'
            })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    var list = document.getElementById('cdList');
                    if (!d.ok || !d.data || d.data.length === 0) {
                        list.innerHTML = '<li class="empty-state">Chưa có chiến dịch tiêu biểu.</li>';
                        return;
                    }
                    var html = '';
                    d.data.forEach(function (cd) {
                        var pct = cd.PhanTram || 0;
                        if (pct > 100) pct = 100;
                        html += '<li class="cd-item"><div style="flex:1">' +
                            '<div class="cd-item-name">' + cd.TenChienDich + '</div>' +
                            '<div class="cd-item-bar"><div class="prog-wrap"><div class="prog-fill" style="width:' + pct + '%"></div></div></div>' +
                            '</div><div class="cd-item-pct">' + pct.toFixed(1) + '%</div></li>';
                    });
                    list.innerHTML = html;
                })
                .catch(function () { });
        }

        // Modal chi tiết
        window.openDetail = function (id, nguoi, email, cd, soTien, ngay, tt, anDanh, loiNhan, anhXN) {
            document.getElementById('dlId').textContent = '#' + id;
            document.getElementById('dlNgay').textContent = ngay;
            document.getElementById('dlNguoi').textContent = nguoi;
            document.getElementById('dlEmail').textContent = email || '(không có)';
            document.getElementById('dlCD').textContent = cd;
            document.getElementById('dlSoTien').textContent = Number(soTien).toLocaleString('vi-VN') + ' đ';
            var ttNames = ['Chờ duyệt', 'Đã duyệt', 'Từ chối'];
            var ttClasses = ['badge-warn', 'badge-ok', 'badge-err'];
            document.getElementById('dlTT').innerHTML = '<span class="badge ' + (ttClasses[tt] || '') + '">' + (ttNames[tt] || '') + '</span>';
            document.getElementById('dlAnDanh').textContent = anDanh ? 'Có' : 'Không';
            document.getElementById('dlLoiNhan').textContent = loiNhan || '(không có lời nhắn)';

            var anhEl = document.getElementById('dlAnh');
            if (anhXN) {
                anhEl.innerHTML = '<img src="' + anhXN + '" alt="Ảnh xác nhận" />';
            } else {
                anhEl.innerHTML = 'Chưa có ảnh xác nhận';
            }
            document.getElementById('detailOverlay').classList.add('show');
        };
        window.closeDetail = function () {
            document.getElementById('detailOverlay').classList.remove('show');
        };

        // Duyệt / Từ chối từ Tổng quan
        window.ajaxDuyet = function (id, action, lydo) {
            var body = '__ajax=true&action=' + action + '&id=' + id;
            if (lydo) body += '&lydo=' + encodeURIComponent(lydo);
            fetch(PAGE_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (d.ok) {
                        showToast('Thành công', d.msg, 'ok');
                        setTimeout(function () { location.reload(); }, 1200);
                    } else {
                        showToast('Lỗi', d.msg || 'Có lỗi xảy ra', 'err');
                    }
                })
                .catch(function () { showToast('Lỗi', 'Không thể kết nối server.', 'err'); });
        };

        fetchChartData();
        fetchCampaigns();
    })();
</script>
</asp:Content>
