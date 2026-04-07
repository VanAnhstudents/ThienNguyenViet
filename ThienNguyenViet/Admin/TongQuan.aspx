<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ── Stat cards: căn giữa ────────────────────────────── */
.stat-card           { position: relative; overflow: hidden; text-align: center; }
.stat-card-top       { text-align: center; }
.stat-label          { text-align: center; }
.stat-value          { text-align: center; }
.stat-sub            { text-align: center; }

/* ── Summary cards: căn giữa ────────────────────────── */
.summary-card        { text-align: center; }

/* ── Campaign name: không cắt ngang ─────────────────── */
.c-name              { max-width: 240px; white-space: normal; word-break: break-word; font-size: 12px; font-weight: 500; color: var(--txt); }

/* ── Modal chi tiết giao dịch ────────────────────────── */
.tq-overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.35); z-index: 200;
    align-items: center; justify-content: center;
}
.tq-overlay.show { display: flex; }
.tq-modal {
    background: var(--card); border-radius: var(--r-card);
    border: 1px solid var(--border); width: 90%; max-width: 540px;
    max-height: 90vh; overflow-y: auto;
    box-shadow: 0 8px 32px rgba(0,0,0,.15);
}
.tq-modal-hd {
    display: flex; justify-content: space-between; align-items: center;
    padding: 14px 18px; border-bottom: 1px solid var(--border);
}
.tq-modal-hd h3 { font-size: 14px; font-weight: 600; }
.tq-modal-close {
    background: none; border: none; font-size: 18px;
    color: var(--txt-sub); cursor: pointer;
}
.tq-modal-body { padding: 18px; }
.tq-detail-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 12px;
}
.tq-detail-full { grid-column: 1 / -1; }
.tq-detail-item label {
    display: block; font-size: 10px; font-weight: 600;
    color: var(--txt-sub); text-transform: uppercase;
    letter-spacing: .04em; margin-bottom: 3px;
}
.tq-detail-val  { font-size: 13px; color: var(--txt); }
.tq-modal-ft {
    padding: 12px 18px; border-top: 1px solid var(--border);
    display: flex; justify-content: flex-end; gap: 8px;
}
.tq-btn-close {
    padding: 6px 16px; font-size: 12px;
    background: transparent; color: var(--txt-sub);
    border: 1px solid var(--border); border-radius: var(--r);
    cursor: pointer; font-family: var(--font);
}
.tq-btn-close:hover { background: var(--bg); }
.tq-proof-wrap {
    margin-top: 6px; border: 1px solid var(--border); border-radius: var(--r);
    padding: 10px; min-height: 60px;
    display: flex; align-items: center; justify-content: center;
    background: var(--bg); color: var(--txt-sub); font-size: 12px;
}
.tq-proof-wrap img { max-width: 100%; max-height: 240px; border-radius: var(--r); }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Bảng điều khiển</h1>
    <p>Tổng quan hoạt động hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- 4 Thẻ thống kê --%>
    <div class="stat-grid">

        <div class="stat-card s-blue">
            <div class="stat-card-top">
                <div class="stat-label">Tổng quyên góp</div>
                <div class="stat-value" id="statTongTien"><%= FormatTien(TongTienDaQuyen) %></div>
            </div>
            <div class="stat-sub">Tính đến hôm nay</div>
        </div>

        <div class="stat-card s-orange">
            <div class="stat-card-top">
                <div class="stat-label">Chiến dịch đang chạy</div>
                <div class="stat-value" id="statChienDich"><%= ChienDichDangChay %></div>
            </div>
            <div class="stat-sub">Đang hoạt động</div>
        </div>

        <div class="stat-card s-purple">
            <div class="stat-card-top">
                <div class="stat-label">Người dùng đăng ký</div>
                <div class="stat-value" id="statNguoiDung"><%= TongNguoiDung.ToString("N0") %></div>
            </div>
            <div class="stat-sub">Tài khoản người dùng</div>
        </div>

        <div class="stat-card s-green">
            <div class="stat-card-top">
                <div class="stat-label">Giao dịch chờ duyệt</div>
                <div class="stat-value" id="statChoDuyet"><%= TongChoXuLy %></div>
            </div>
            <div class="stat-sub">
                <% if (TongChoXuLy > 0) { %>
                    <span class="down">Cần xử lý ngay</span>
                <% } else { %>
                    Không có giao dịch chờ
                <% } %>
            </div>
        </div>

    </div>

    <%-- Biểu đồ + Chiến dịch tiêu biểu --%>
    <div class="main-row">

        <div class="adm-card">
            <div class="adm-card-hd">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="sub">Tổng tiền (triệu đồng) — năm <%= DateTime.Now.Year %></div>
                </div>
                <button type="button" class="btn-outline" onclick="exportCSV()">Xuất CSV</button>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQG"></canvas>
            </div>
        </div>

        <div class="adm-card">
            <div class="adm-card-hd">
                <div>
                    <h3>Chiến dịch tiêu biểu</h3>
                    <div class="sub">Tiến độ theo mục tiêu</div>
                </div>
            </div>
            <div class="campaign-list" id="campaignList">
                <% for (int i = 0; i < 4; i++) { %>
                <div>
                    <div class="skeleton" style="width:70%;margin-bottom:6px"></div>
                    <div class="skeleton" style="width:100%;height:4px;border-radius:99px"></div>
                </div>
                <% } %>
            </div>
        </div>

    </div>

    <%-- 3 Summary cards --%>
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

    <%-- Bảng giao dịch gần đây --%>
    <div class="adm-card">
        <div class="adm-card-hd">
            <div>
                <h3>Giao dịch quyên góp gần đây</h3>
                <div class="sub">10 giao dịch mới nhất</div>
            </div>
        </div>

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
                       int      ma      = Convert.ToInt32(r["MaQuyenGop"]);
                       string   hoTen   = r["HoTen"].ToString();
                       string   email   = r["Email"]    == DBNull.Value ? "" : r["Email"].ToString();
                       string   chiDich = r["TenChienDich"].ToString();
                       long     soTien  = Convert.ToInt64(r["SoTien"]);
                       int      ts      = Convert.ToInt32(r["TrangThai"]);
                       DateTime ngay    = Convert.ToDateTime(r["NgayTao"]);
                       bool     anDanh  = Convert.ToBoolean(r["AnDanh"]);
                       string   loiNhan = r.Table.Columns.Contains("LoiNhan") && r["LoiNhan"] != DBNull.Value ? r["LoiNhan"].ToString() : "";
                       string   anhXN   = r.Table.Columns.Contains("AnhXacNhan") && r["AnhXacNhan"] != DBNull.Value ? r["AnhXacNhan"].ToString() : "";
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
                    <td class="amount-pos"><%= string.Format("{0:N0}", soTien) %> ₫</td>
                    <td><%= ngay.ToString("dd/MM/yy HH:mm") %></td>
                    <td><%= BadgeTrangThai(ts) %></td>
                    <td style="white-space:nowrap">
                        <% if (ts == 0) { %>
                        <button type="button" class="btn-approve"
                            onclick="doAction(<%= ma %>,'duyet')">Duyệt</button>
                        <button type="button" class="btn-reject"
                            onclick="doAction(<%= ma %>,'tuchoi')">Từ chối</button>
                        <% } %>
                        <button type="button" class="btn-edit"
                            onclick='openDetail(<%= ma %>,"<%= Server.HtmlEncode(hoTen).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(email).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(chiDich).Replace("\"","&quot;") %>",<%= soTien %>,"<%= ngay.ToString("dd/MM/yyyy HH:mm") %>",<%= ts %>,<%= anDanh ? "true" : "false" %>,"<%= Server.HtmlEncode(loiNhan).Replace("\"","&quot;") %>","<%= Server.HtmlEncode(anhXN).Replace("\"","&quot;") %>")'>
                            Xem
                        </button>
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
            <a href="<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>">
                Xem toàn bộ lịch sử →
            </a>
        </div>
    </div>

    <%-- Modal chi tiết giao dịch --%>
    <div class="tq-overlay" id="tqModalOverlay" onclick="closeTqOverlay(event)">
        <div class="tq-modal">
            <div class="tq-modal-hd">
                <h3>Chi tiết giao dịch</h3>
                <button type="button" class="tq-modal-close" onclick="closeTqModal()">✕</button>
            </div>
            <div class="tq-modal-body">
                <div class="tq-detail-grid">
                    <div class="tq-detail-item">
                        <label>Mã giao dịch</label>
                        <span class="tq-detail-val" id="tq-id"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Ngày tạo</label>
                        <span class="tq-detail-val" id="tq-ngay"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Người quyên góp</label>
                        <span class="tq-detail-val" id="tq-nguoi"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Email</label>
                        <span class="tq-detail-val" id="tq-email"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Chiến dịch</label>
                        <span class="tq-detail-val" id="tq-cd"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Số tiền</label>
                        <span class="tq-detail-val" id="tq-sotien" style="font-size:15px;font-weight:700;color:var(--ok)"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Trạng thái</label>
                        <span class="tq-detail-val" id="tq-tt"></span>
                    </div>
                    <div class="tq-detail-item">
                        <label>Ẩn danh</label>
                        <span class="tq-detail-val" id="tq-andanh"></span>
                    </div>
                    <div class="tq-detail-item tq-detail-full">
                        <label>Lời nhắn</label>
                        <span class="tq-detail-val" id="tq-loinhan" style="font-style:italic;color:var(--txt-sub)"></span>
                    </div>
                    <div class="tq-detail-item tq-detail-full">
                        <label>Ảnh xác nhận</label>
                        <div class="tq-proof-wrap" id="tq-anh"></div>
                    </div>
                </div>
            </div>
            <div class="tq-modal-ft" id="tqModalFt">
                <button type="button" class="tq-btn-close" onclick="closeTqModal()">Đóng</button>
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

    /* ── 1. Biểu đồ qua AJAX ─────────────────────────────────── */
    var chart;

    function initChart(data) {
        var labels     = ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'];
        var tienTrieu  = data.tien.map(function (v) { return Math.round(v / 1000000); });

        var ctx = document.getElementById('chartQG').getContext('2d');
        chart   = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{ label: 'Quyên góp (tr.đ)', data: tienTrieu,
                    backgroundColor: '#3182CE', borderRadius: 4, borderSkipped: false }]
            },
            options: {
                responsive: true, maintainAspectRatio: false, animation: false,
                plugins: {
                    legend: { display: false },
                    tooltip: { callbacks: { label: function (ctx) {
                        return ' ' + ctx.parsed.y.toLocaleString('vi-VN') + ' tr.đ';
                    }}}
                },
                scales: {
                    x: { grid: { display: false } },
                    y: { beginAtZero: true,
                         ticks: { callback: function (v) { return v.toLocaleString('vi-VN') + ' tr'; }}}
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

    /* ── 2. Chiến dịch nổi bật ────────────────────────────────── */
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
                var pct  = Math.min(c.pct, 100);
                var daDat = Math.round(c.quyen   / 1000000);
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
                    '</div></div>';
            });
            wrap.innerHTML = html;
        });
    }

    /* ── 3. Duyệt / Từ chối (với confirm dialog) ──────────────── */
    window.doAction = function (id, action) {
        var title = action === 'duyet' ? 'Duyệt giao dịch' : 'Từ chối giao dịch';
        var msg   = action === 'duyet'
            ? 'Xác nhận duyệt giao dịch #' + id + '?'
            : 'Xác nhận từ chối giao dịch #' + id + '?';
        var cls   = action === 'tuchoi' ? 'btn-reject' : '';

        admConfirm({
            title: title, msg: msg, okLabel: title, okClass: cls,
            onOk: function () { sendAction(id, action); }
        });
    };

    function sendAction(id, action) {
        fetch(PAGE_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: '__ajax=true&action=' + action + '&id=' + id
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
        .catch(function () { admToast('Lỗi kết nối', 'Không thể kết nối máy chủ.', 'err'); });
    }

    function updateRow(id, action) {
        var row = document.getElementById('row-' + id);
        if (!row) return;
        var cells = row.querySelectorAll('td');
        if (action === 'duyet') {
            cells[5].innerHTML = '<span class="badge badge-ok">Đã duyệt</span>';
        } else {
            cells[5].innerHTML = '<span class="badge badge-reject">Từ chối</span>';
        }
        // Giữ nút Xem, bỏ Duyệt/Từ chối
        var actCell = cells[6];
        var viewBtn = actCell.querySelector('.btn-edit');
        actCell.innerHTML = '';
        if (viewBtn) actCell.appendChild(viewBtn);

        var statEl = document.getElementById('statChoDuyet');
        if (statEl) {
            var cur = parseInt(statEl.textContent) || 0;
            if (cur > 0) statEl.textContent = cur - 1;
        }
    }

    /* ── 4. Modal chi tiết ───────────────────────────────────── */
    function badgeHtml(ts) {
        var map = {
            0: ['badge badge-wait',   'Chờ duyệt'],
            1: ['badge badge-ok',     'Đã duyệt'],
            2: ['badge badge-reject', 'Từ chối']
        };
        var b = map[ts] || ['badge', '—'];
        return '<span class="' + b[0] + '">' + b[1] + '</span>';
    }

    window.openDetail = function (id, hoTen, email, chiDich, soTien, ngay, ts, anDanh, loiNhan, anhXN) {
        document.getElementById('tq-id').textContent     = '#' + id;
        document.getElementById('tq-ngay').textContent   = ngay;
        document.getElementById('tq-nguoi').textContent  = hoTen;
        document.getElementById('tq-email').textContent  = email || '—';
        document.getElementById('tq-cd').textContent     = chiDich;
        document.getElementById('tq-sotien').textContent = parseInt(soTien).toLocaleString('vi-VN') + ' ₫';
        document.getElementById('tq-tt').innerHTML       = badgeHtml(ts);
        document.getElementById('tq-andanh').textContent = anDanh ? 'Có' : 'Không';
        document.getElementById('tq-loinhan').textContent= loiNhan || '—';

        var anhWrap = document.getElementById('tq-anh');
        anhWrap.innerHTML = anhXN
            ? '<img src="' + anhXN + '" alt="Ảnh xác nhận" />'
            : '<span>Không có ảnh xác nhận</span>';

        var ft = document.getElementById('tqModalFt');
        ft.innerHTML = '';
        if (ts === 0) {
            var btnD = document.createElement('button');
            btnD.type = 'button'; btnD.className = 'btn-approve';
            btnD.style.cssText = 'padding:6px 14px;font-size:12px;border-radius:6px;cursor:pointer;margin-right:4px';
            btnD.textContent = 'Duyệt';
            btnD.onclick = function () { closeTqModal(); doAction(id, 'duyet'); };
            var btnR = document.createElement('button');
            btnR.type = 'button'; btnR.className = 'btn-reject';
            btnR.style.cssText = 'padding:6px 14px;font-size:12px;border-radius:6px;cursor:pointer;margin-right:4px';
            btnR.textContent = 'Từ chối';
            btnR.onclick = function () { closeTqModal(); doAction(id, 'tuchoi'); };
            ft.appendChild(btnD);
            ft.appendChild(btnR);
        }
        var btnClose = document.createElement('button');
        btnClose.type = 'button'; btnClose.className = 'tq-btn-close';
        btnClose.textContent = 'Đóng'; btnClose.onclick = closeTqModal;
        ft.appendChild(btnClose);

        document.getElementById('tqModalOverlay').classList.add('show');
        document.body.style.overflow = 'hidden';
    };

    window.closeTqModal = function () {
        document.getElementById('tqModalOverlay').classList.remove('show');
        document.body.style.overflow = '';
    };
    window.closeTqOverlay = function (e) {
        if (e.target === document.getElementById('tqModalOverlay')) closeTqModal();
    };
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeTqModal();
    });

    /* ── 5. Xuất CSV ─────────────────────────────────────────── */
    window.exportCSV = function () {
        if (!chart) return;
        var labels = chart.data.labels;
        var vals   = chart.data.datasets[0].data;
        var rows   = [['Tháng', 'Quyên góp (tr.đ)']];
        labels.forEach(function (l, i) { rows.push([l, vals[i]]); });
        var csv  = rows.map(function (r) { return r.join(','); }).join('\n');
        var blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
        var url  = URL.createObjectURL(blob);
        var a    = document.createElement('a');
        a.href   = url;
        a.download = 'quyen-gop-<%= DateTime.Now.Year %>.csv';
            document.body.appendChild(a); a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
            admToast('Đã xuất CSV', 'File được tải về máy của bạn.', 'ok');
        };

        /* ── Khởi động ───────────────────────────────────────────── */
        fetchChartData();
        fetchCampaigns();

    })();
</script>
</asp:Content>
