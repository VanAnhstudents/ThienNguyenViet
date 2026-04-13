<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    /* ── TongQuan: bo sung ── */
    .s-blue .stat-value  { color: var(--accent); }
    .s-green .stat-value { color: var(--ok); }

    .main-row { display: grid; grid-template-columns: 2fr 1fr; gap: 18px; margin-bottom: 18px; }

    .chart-wrap { position: relative; height: 280px; }

    /* Campaign list */
    .cd-list { list-style: none; }
    .cd-item {
        padding: 12px 0; border-bottom: 1px solid var(--border);
        display: flex; justify-content: space-between; align-items: center;
    }
    .cd-item:last-child { border-bottom: none; }
    .cd-item-name { font-size: 13px; font-weight: 500; flex: 1; margin-right: 10px; }
    .cd-item-pct { font-size: 12px; font-weight: 600; color: var(--accent); white-space: nowrap; }
    .cd-item-bar { width: 100%; margin-top: 6px; }

    /* Donor cell */
    .donor-cell { display: flex; align-items: center; gap: 8px; }
    .donor-av {
        width: 28px; height: 28px; border-radius: 50%;
        background: var(--accent-light); color: var(--accent);
        display: flex; align-items: center; justify-content: center;
        font-size: 10px; font-weight: 700; flex-shrink: 0;
    }
    .donor-name { font-size: 12px; font-weight: 500; }
    .donor-email { font-size: 10px; color: var(--txt-sub); }

    .amount-cell { color: var(--ok); font-weight: 600; font-size: 12px; white-space: nowrap; }

    /* Proof image */
    .proof-wrap {
        margin-top: 6px; border: 1px solid var(--border);
        border-radius: var(--r); padding: 10px;
        display: flex; align-items: center; justify-content: center;
        background: var(--bg); min-height: 60px; font-size: 12px; color: var(--txt-sub);
    }
    .proof-wrap img { max-width: 100%; max-height: 260px; border-radius: var(--r); }

    @media (max-width: 1024px) {
        .main-row { grid-template-columns: 1fr; }
    }
    @media (max-width: 480px) {
        .chart-wrap { height: 200px; }
    }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bảng điều khiển</h1>
    <p>Tổng quan hoạt động hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- 4 The thong ke --%>
    <div class="stat-grid">
        <div class="stat-card s-blue">
            <div class="stat-label">Tong quyen gop</div>
            <div class="stat-value" id="statTongTien"><%= FormatTien(TongTienDaQuyen) %></div>
            <div class="stat-sub">Tinh den hom nay</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Chien dich dang chay</div>
            <div class="stat-value" id="statChienDich"><%= ChienDichDangChay %></div>
            <div class="stat-sub">Dang hoat dong</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Nguoi dung dang ky</div>
            <div class="stat-value" id="statNguoiDung"><%= TongNguoiDung.ToString("N0") %></div>
            <div class="stat-sub">Tai khoan nguoi dung</div>
        </div>
        <div class="stat-card s-green">
            <div class="stat-label">Giao dich cho duyet</div>
            <div class="stat-value" id="statChoDuyet"><%= TongChoXuLy %></div>
            <div class="stat-sub">
                <% if (TongChoXuLy > 0) { %>
                    <span style="color:var(--err)">Can xu ly ngay</span>
                <% } else { %>
                    Khong co giao dich cho
                <% } %>
            </div>
        </div>
    </div>

    <%-- Bieu do + Chien dich tieu bieu --%>
    <div class="main-row">
        <div class="card">
            <div class="card-header">
                <div>
                    <h3>Quyen gop theo thang</h3>
                    <div class="sub">Tong tien (trieu dong) — nam <%= DateTime.Now.Year %></div>
                </div>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQG"></canvas>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                <h3>Chien dich tieu bieu</h3>
            </div>
            <ul class="cd-list" id="cdList">
                <li class="empty-state">Dang tai...</li>
            </ul>
        </div>
    </div>

    <%-- Bang giao dich gan day --%>
    <div class="card">
        <div class="card-header">
            <h3>Giao dich gan day</h3>
            <a href="<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>" class="btn btn-outline btn-sm">Xem tat ca</a>
        </div>
        <table class="tbl">
            <thead>
                <tr>
                    <th>Ma</th>
                    <th>Nguoi quyen gop</th>
                    <th>Chien dich</th>
                    <th>So tien</th>
                    <th>Ngay</th>
                    <th>Trang thai</th>
                    <th></th>
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
            %>
                <tr>
                    <td>#<%= maQG %></td>
                    <td>
                        <div class="donor-cell">
                            <div class="donor-av"><%= Initials(hoTen) %></div>
                            <div>
                                <div class="donor-name"><%= Server.HtmlEncode(hoTen) %></div>
                                <div class="donor-email"><%= Server.HtmlEncode(email) %></div>
                            </div>
                        </div>
                    </td>
                    <td><%= Server.HtmlEncode(tenCD.Length > 40 ? tenCD.Substring(0,40) + "..." : tenCD) %></td>
                    <td class="amount-cell"><%= soTien.ToString("N0") %> d</td>
                    <td><%= ngay %></td>
                    <td><%= BadgeTrangThai(ts) %></td>
                    <td>
                        <button type="button" class="btn btn-outline btn-xs"
                            onclick='openDetail(<%= maQG %>,"<%= Server.HtmlEncode(hoTen).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(email).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(tenCD).Replace("\"","&quot;") %>",<%= soTien %>,"<%= ngay %>",<%= ts %>,<%= anDanh ? "true" : "false" %>,"<%= Server.HtmlEncode(loiNhan).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(anhXN).Replace("\"","&quot;") %>")'>
                            Xem
                        </button>
                    </td>
                </tr>
            <% } } else { %>
                <tr><td colspan="7" class="empty-state">Chua co giao dich nao.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <%-- Modal chi tiet giao dich --%>
    <div class="overlay" id="detailOverlay" onclick="if(event.target===this)closeDetail()">
        <div class="modal">
            <div class="modal-hd">
                <h3>Chi tiet giao dich</h3>
                <button type="button" class="modal-close" onclick="closeDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid">
                    <div class="detail-item">
                        <label>Ma giao dich</label>
                        <span class="detail-val" id="dlId"></span>
                    </div>
                    <div class="detail-item">
                        <label>Ngay tao</label>
                        <span class="detail-val" id="dlNgay"></span>
                    </div>
                    <div class="detail-item">
                        <label>Nguoi quyen gop</label>
                        <span class="detail-val" id="dlNguoi"></span>
                    </div>
                    <div class="detail-item">
                        <label>Email</label>
                        <span class="detail-val" id="dlEmail"></span>
                    </div>
                    <div class="detail-item">
                        <label>Chien dich</label>
                        <span class="detail-val" id="dlCD"></span>
                    </div>
                    <div class="detail-item">
                        <label>So tien</label>
                        <span class="detail-val" id="dlSoTien" style="font-size:15px;font-weight:700;color:var(--ok)"></span>
                    </div>
                    <div class="detail-item">
                        <label>Trang thai</label>
                        <span class="detail-val" id="dlTT"></span>
                    </div>
                    <div class="detail-item">
                        <label>An danh</label>
                        <span class="detail-val" id="dlAnDanh"></span>
                    </div>
                    <div class="detail-item detail-full">
                        <label>Loi nhan</label>
                        <span class="detail-val" id="dlLoiNhan" style="font-style:italic;color:var(--txt-sub)"></span>
                    </div>
                    <div class="detail-item detail-full">
                        <label>Anh xac nhan</label>
                        <div class="proof-wrap" id="dlAnh"></div>
                    </div>
                </div>
            </div>
            <div class="modal-ft" id="detailFt">
                <button type="button" class="btn btn-outline" onclick="closeDetail()">Dong</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    (function () {
        'use strict';
        var PAGE_URL = '<%= ResolveUrl("~/Admin/TongQuan.aspx") %>';
        var chart;

        // Bieu do quyen gop theo thang
        function initChart(data) {
            var labels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
            var tienTrieu = data.tien.map(function (v) { return Math.round(v / 1000000); });
            var ctx = document.getElementById('chartQG').getContext('2d');
            chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Quyen gop (tr.d)',
                        data: tienTrieu,
                        backgroundColor: '#3182CE',
                        borderRadius: 4,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: false, animation: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: { callbacks: { label: function (c) { return ' ' + c.parsed.y.toLocaleString('vi-VN') + ' tr.d'; } } }
                    },
                    scales: {
                        x: { grid: { display: false } },
                        y: { beginAtZero: true, ticks: { callback: function (v) { return v.toLocaleString('vi-VN') + ' tr'; } } }
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
                    initChart({ tien: new Array(12).fill(0), luot: new Array(12).fill(0) });
                });
        }

        // Load chien dich tieu bieu
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
                        list.innerHTML = '<li class="empty-state">Chua co chien dich tieu bieu.</li>';
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

        // Modal chi tiet
        window.openDetail = function (id, nguoi, email, cd, soTien, ngay, tt, anDanh, loiNhan, anhXN) {
            document.getElementById('dlId').textContent = '#' + id;
            document.getElementById('dlNgay').textContent = ngay;
            document.getElementById('dlNguoi').textContent = nguoi;
            document.getElementById('dlEmail').textContent = email || '(khong co)';
            document.getElementById('dlCD').textContent = cd;
            document.getElementById('dlSoTien').textContent = Number(soTien).toLocaleString('vi-VN') + ' d';
            var ttNames = ['Cho duyet', 'Da duyet', 'Tu choi'];
            var ttClasses = ['badge-warn', 'badge-ok', 'badge-err'];
            document.getElementById('dlTT').innerHTML = '<span class="badge ' + (ttClasses[tt] || '') + '">' + (ttNames[tt] || '') + '</span>';
            document.getElementById('dlAnDanh').textContent = anDanh ? 'Co' : 'Khong';
            document.getElementById('dlLoiNhan').textContent = loiNhan || '(khong co loi nhan)';

            var anhEl = document.getElementById('dlAnh');
            if (anhXN) {
                anhEl.innerHTML = '<img src="' + anhXN + '" alt="Anh xac nhan" />';
            } else {
                anhEl.innerHTML = 'Chua co anh xac nhan';
            }
            document.getElementById('detailOverlay').classList.add('show');
        };
        window.closeDetail = function () {
            document.getElementById('detailOverlay').classList.remove('show');
        };

        // Duyet / Tu choi tu TongQuan
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
                        showToast('Thanh cong', d.msg, 'ok');
                        setTimeout(function () { location.reload(); }, 1200);
                    } else {
                        showToast('Loi', d.msg || 'Co loi xay ra', 'err');
                    }
                })
                .catch(function () { showToast('Loi', 'Khong the ket noi server.', 'err'); });
        };

        // Khoi chay
        fetchChartData();
        fetchCampaigns();
    })();
</script>
</asp:Content>
