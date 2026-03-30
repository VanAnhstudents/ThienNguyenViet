<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<%-- ── CSS riêng trang ──────────────────────────────────── --%>
<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* Không cần CSS riêng nhiều — đã có admin.css */
/* Chỉ override nhỏ nếu cần */
.stat-card { position: relative; overflow: hidden; }
</style>
</asp:Content>

<%-- ── Topbar title ──────────────────────────────────────── --%>
<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bảng điều khiển</h1>
    <p>Tổng quan hoạt động hệ thống</p>
</asp:Content>

<%-- ══════════════ NỘI DUNG CHÍNH ══════════════════════════ --%>
<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- 4 Thẻ thống kê ─────────────────────────────────────── --%>
    <div class="stat-grid">

        <div class="stat-card s-blue">
            <div class="stat-card-top">
                <div class="stat-label">Tổng quyên góp</div>
                <div class="stat-value" id="statTongTien">
                    <%= FormatTien(TongTienDaQuyen) %>
                </div>
            </div>
            <div class="stat-sub">Tính đến hôm nay</div>
        </div>

        <div class="stat-card s-orange">
            <div class="stat-card-top">
                <div class="stat-label">Chiến dịch đang chạy</div>
                <div class="stat-value" id="statChienDich">
                    <%= ChienDichDangChay %>
                </div>
            </div>
            <div class="stat-sub">Đang hoạt động</div>
        </div>

        <div class="stat-card s-purple">
            <div class="stat-card-top">
                <div class="stat-label">Người dùng đăng ký</div>
                <div class="stat-value" id="statNguoiDung">
                    <%= TongNguoiDung.ToString("N0") %>
                </div>
            </div>
            <div class="stat-sub">Tài khoản người dùng</div>
        </div>

        <div class="stat-card s-green">
            <div class="stat-card-top">
                <div class="stat-label">Giao dịch chờ duyệt</div>
                <div class="stat-value" id="statChoDuyet">
                    <%= TongChoXuLy %>
                </div>
            </div>
            <div class="stat-sub">
                <% if (TongChoXuLy > 0) { %>
                    <span class="down">Cần xử lý ngay</span>
                <% } else { %>
                    Không có giao dịch chờ
                <% } %>
            </div>
        </div>

    </div><%-- /stat-grid --%>

    <%-- Biểu đồ + Chiến dịch tiêu biểu ────────────────────── --%>
    <div class="main-row">

        <%-- Biểu đồ --%>
        <div class="adm-card">
            <div class="adm-card-hd">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Tổng tiền (triệu đồng) — năm <%= DateTime.Now.Year %></div>
                </div>
                <button class="btn-outline" onclick="exportCSV()">Xuất CSV</button>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQG"></canvas>
            </div>
        </div>

        <%-- Chiến dịch nổi bật --%>
        <div class="adm-card">
            <div class="adm-card-hd">
                <div>
                    <h3>Chiến dịch tiêu biểu</h3>
                    <div class="sub">Tiến độ theo mục tiêu</div>
                </div>
            </div>
            <div class="campaign-list" id="campaignList">
                <%-- Skeleton loading --%>
                <% for (int i = 0; i < 4; i++) { %>
                <div>
                    <div class="skeleton" style="width:70%;margin-bottom:6px"></div>
                    <div class="skeleton" style="width:100%;height:4px;border-radius:99px"></div>
                </div>
                <% } %>
            </div>
        </div>

    </div><%-- /main-row --%>

    <%-- 3 Summary cards ─────────────────────────────────────── --%>
    <div class="summary-row">
        <div class="summary-card">
            <strong><%= GiaoDichThang.ToString("N0") %></strong>
            <span>Giao dịch trong tháng <%= DateTime.Now.Month %></span>
        </div>
        <div class="summary-card">
            <strong><%= GiaoDichDaDuyet.ToString("N0") %></strong>
            <span>Giao dịch đã được duyệt</span>
        </div>
        <div class="summary-card">
            <strong><%= ChienDichHoanThanh %></strong>
            <span>Chiến dịch hoàn thành mục tiêu</span>
        </div>
    </div>

    <%-- Bảng giao dịch gần đây ─────────────────────────────── --%>
    <div class="adm-card">
        <div class="adm-card-hd">
            <div>
                <h3>Giao dịch quyên góp gần đây</h3>
                <div class="sub">10 giao dịch mới nhất</div>
            </div>
        </div>

        <%-- Thanh thông báo inline (thay thế alert) --%>
        <div id="tblMsg" style="display:none;margin-bottom:10px;padding:8px 12px;border-radius:6px;font-size:12px;"></div>

        <table class="adm-table" id="tblGiaoDich">
            <thead>
                <tr>
                    <th>Mã GD</th>
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
                       int    ma       = Convert.ToInt32(r["MaQuyenGop"]);
                       string hoTen    = r["HoTen"].ToString();
                       string email    = r["Email"] == DBNull.Value ? "" : r["Email"].ToString();
                       string chiDich  = r["TenChienDich"].ToString();
                       long   soTien   = Convert.ToInt64(r["SoTien"]);
                       int    ts       = Convert.ToInt32(r["TrangThai"]);
                       DateTime ngay   = Convert.ToDateTime(r["NgayTao"]);
                       bool   anDanh   = Convert.ToBoolean(r["AnDanh"]);
            %>
                <tr id="row-<%= ma %>">
                    <td>#<%= ma %></td>
                    <td>
                        <div class="donor-cell">
                            <div class="donor-av"><%= Initials(hoTen) %></div>
                            <div>
                                <div class="donor-name"><%= Server.HtmlEncode(hoTen) %></div>
                                <% if (!anDanh && !string.IsNullOrEmpty(email)) { %>
                                <div class="donor-email"><%= Server.HtmlEncode(email) %></div>
                                <% } %>
                            </div>
                        </div>
                    </td>
                    <td><%= Server.HtmlEncode(chiDich) %></td>
                    <td class="amount-pos">
                        <%= string.Format("{0:N0}", soTien) %> ₫
                    </td>
                    <td><%= ngay.ToString("dd/MM/yy HH:mm") %></td>
                    <td><%= BadgeTrangThai(ts) %></td>
                    <td>
                    <% if (ts == 0) { %>
                        <button class="btn-approve"
                            onclick="doAction(<%= ma %>,'duyet')">Duyệt</button>
                        <button class="btn-reject"
                            onclick="doAction(<%= ma %>,'tuchoi')">Từ chối</button>
                    <% } else { %>
                        <span style="font-size:11px;color:var(--txt-sub)">—</span>
                    <% } %>
                    </td>
                </tr>
            <%  }
               } else { %>
                <tr>
                    <td colspan="7" style="text-align:center;color:var(--txt-sub);padding:20px">
                        Chưa có giao dịch nào.
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <div class="tbl-footer">
            <span>Hiển thị 10 / <%= GiaoDichThang %> giao dịch tháng này</span>
            <a href="<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>">
                Xem toàn bộ lịch sử →
            </a>
        </div>
    </div><%-- /adm-card --%>

</asp:Content>

<%-- ══════════════ SCRIPT ════════════════════════════════════ --%>
<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
(function () {
    'use strict';

    var PAGE_URL = '<%= ResolveUrl("~/Admin/TongQuan.aspx") %>';

    // ── 1. Load biểu đồ qua AJAX ──────────────────────────────
    var chart;

    function initChart(data) {
        var labels = ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'];
        // Đổi sang đơn vị triệu
        var tienTrieu = data.tien.map(function (v) {
            return Math.round(v / 1000000);
        });

        var ctx = document.getElementById('chartQG').getContext('2d');
        chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Quyên góp (tr.đ)',
                    data: tienTrieu,
                    backgroundColor: '#3182CE',
                    borderRadius: 4,
                    borderSkipped: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                animation: false,          // tắt animation
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function (ctx) {
                                return ' ' + ctx.parsed.y.toLocaleString('vi-VN') + ' tr.đ';
                            }
                        }
                    }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (v) {
                                return v.toLocaleString('vi-VN') + ' tr';
                            }
                        }
                    }
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
        .then(function (d) {
            if (d.ok) initChart(d);
        })
        .catch(function () {
            // Nếu fetch lỗi, hiển thị chart rỗng
            initChart({ tien: new Array(12).fill(0), luot: new Array(12).fill(0) });
        });
    }

    // ── 2. Load chiến dịch nổi bật ────────────────────────────
    function fetchCampaigns() {
        fetch(PAGE_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: '__ajax=true&action=campaigns'
        })
        .then(function (r) { return r.json(); })
        .then(function (d) {
            if (!d.ok) return;
            var wrap = document.getElementById('campaignList');
            if (!d.data.length) {
                wrap.innerHTML = '<p style="font-size:12px;color:var(--txt-sub)">Chưa có chiến dịch nổi bật.</p>';
                return;
            }
            var html = '';
            d.data.forEach(function (c) {
                var pct = Math.min(c.pct, 100);
                var daDat = Math.round(c.quyen / 1000000);
                var mt    = Math.round(c.muctieu / 1000000);
                html +=
                    '<div>' +
                    '<div class="c-item-top">' +
                    '<span class="c-name" title="' + c.ten + '">' + c.ten + '</span>' +
                    '<span class="c-pct">' + pct + '%</span>' +
                    '</div>' +
                    '<div class="progress-bar"><div class="progress-fill" style="width:' + pct + '%"></div></div>' +
                    '<div class="c-item-bot">' +
                    '<span>' + daDat.toLocaleString('vi-VN') + ' tr.đ</span>' +
                    '<span>MĐ: ' + mt.toLocaleString('vi-VN') + ' tr.đ</span>' +
                    '</div>' +
                    '</div>';
            });
            wrap.innerHTML = html;
        });
    }

    // ── 3. Duyệt / Từ chối quyên góp (AJAX) ─────────────────
    window.doAction = function (id, action) {
        var title  = action === 'duyet' ? 'Duyệt giao dịch' : 'Từ chối giao dịch';
        var msg    = action === 'duyet'
            ? 'Xác nhận duyệt giao dịch #' + id + '?'
            : 'Xác nhận từ chối giao dịch #' + id + '?';
        var cls    = action === 'tuchoi' ? 'btn-reject' : '';

        admConfirm({
            title: title, msg: msg, okLabel: title, okClass: cls,
            onOk: function () { sendAction(id, action); }
        });
    };

    function sendAction(id, action) {
        var body = '__ajax=true&action=' + action + '&id=' + id;

        fetch(PAGE_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: body
        })
        .then(function (r) { return r.json(); })
        .then(function (d) {
            if (d.ok) {
                admToast('Thành công', d.msg, 'ok');
                updateRow(id, action);
            } else {
                admToast('Không thể thực hiện', d.msg, 'err');
            }
        })
        .catch(function () {
            admToast('Lỗi kết nối', 'Không thể kết nối máy chủ.', 'err');
        });
    }

    // Cập nhật trạng thái dòng bảng mà không reload trang
    function updateRow(id, action) {
        var row = document.getElementById('row-' + id);
        if (!row) return;
        var cells = row.querySelectorAll('td');
        // Cột trạng thái (index 5)
        if (action === 'duyet') {
            cells[5].innerHTML = '<span class="badge badge-ok">Đã duyệt</span>';
        } else {
            cells[5].innerHTML = '<span class="badge badge-reject">Từ chối</span>';
        }
        // Cột thao tác (index 6): ẩn nút
        cells[6].innerHTML = '<span style="font-size:11px;color:var(--txt-sub)">—</span>';

        // Giảm số chờ duyệt ở stat card
        var statEl = document.getElementById('statChoDuyet');
        if (statEl) {
            var cur = parseInt(statEl.textContent) || 0;
            if (cur > 0) statEl.textContent = cur - 1;
        }
    }

    // ── 4. Xuất CSV ───────────────────────────────────────────
    window.exportCSV = function () {
        if (!chart) return;
        var labels = chart.data.labels;
        var vals   = chart.data.datasets[0].data;
        var rows   = [['Tháng', 'Quyên góp (tr.đ)']];
        labels.forEach(function (l, i) { rows.push([l, vals[i]]); });

        var csv = rows.map(function (r) { return r.join(','); }).join('\n');
        var blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
        var url  = URL.createObjectURL(blob);
        var a    = document.createElement('a');
        a.href = url;
        a.download = 'quyen-gop-<%= DateTime.Now.Year %>.csv';
            document.body.appendChild(a); a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);

            admToast('Đã xuất CSV', 'File được tải về máy của bạn.', 'ok');
        };

        // ── Khởi động ─────────────────────────────────────────────
        fetchChartData();
        fetchCampaigns();

    })();
</script>
</asp:Content>
