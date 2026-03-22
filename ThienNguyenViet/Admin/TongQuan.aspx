<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Stat Cards Grid */
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: var(--admin-card);
            border-radius: var(--r-card);
            border: 0.5px solid var(--admin-vien);
            padding: 18px 20px;
        }

        .stat-card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .stat-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--admin-chu-phu);
            text-transform: uppercase;
            letter-spacing: .04em;
            margin-bottom: 6px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--admin-chu-chinh);
            line-height: 1;
        }

        .stat-icon {
            width: 38px; height: 38px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .stat-sub {
            font-size: 11px;
            color: var(--admin-chu-phu);
        }
        .stat-sub .up   { color: var(--admin-thanh-cong); font-weight: 600; }
        .stat-sub .down { color: var(--admin-loi);        font-weight: 600; }

        .stat-xanh .stat-icon { background: var(--stat-xanh-nen); color: var(--stat-xanh-vien); }
        .stat-cam  .stat-icon { background: var(--stat-cam-nen);  color: var(--stat-cam-vien);  }
        .stat-tim  .stat-icon { background: var(--stat-tim-nen);  color: var(--stat-tim-vien);  }
        .stat-la   .stat-icon { background: #C6F6D5; color: var(--admin-thanh-cong); }

        /* Main row: chart + campaign aside */
        .main-row {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 16px;
            margin-bottom: 20px;
        }

        /* Chart */
        .chart-wrap { position: relative; height: 240px; }

        /* Card header */
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }
        .card-header h3 { font-size: 14px; font-weight: 600; }
        .card-header .card-sub { font-size: 11px; color: var(--admin-chu-phu); margin-top: 2px; }

        /* Campaign progress */
        .campaign-list { display: flex; flex-direction: column; gap: 14px; }

        .campaign-item-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }
        .campaign-item-top .c-name {
            font-size: 12px; font-weight: 500;
            color: var(--admin-chu-chinh);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
            max-width: 190px;
        }
        .campaign-item-top .c-pct {
            font-size: 11px; font-weight: 600;
            color: var(--stat-xanh-vien);
        }

        .progress-bar {
            height: 5px;
            background: var(--admin-vien);
            border-radius: 99px;
            overflow: hidden;
        }
        .progress-bar-fill {
            height: 100%;
            border-radius: 99px;
            background: linear-gradient(90deg, var(--stat-xanh-vien), var(--admin-accent));
        }

        .campaign-item-bot {
            display: flex;
            justify-content: space-between;
            margin-top: 4px;
        }
        .campaign-item-bot span { font-size: 10px; color: var(--admin-chu-phu); }

        /* Summary mini-cards */
        .summary-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .summary-card {
            background: var(--admin-card);
            border-radius: var(--r-card);
            border: 0.5px solid var(--admin-vien);
            padding: 16px 18px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .summary-icon {
            width: 42px; height: 42px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; flex-shrink: 0;
        }

        .summary-info strong {
            display: block;
            font-size: 16px; font-weight: 700;
            color: var(--admin-chu-chinh);
        }
        .summary-info span { font-size: 11px; color: var(--admin-chu-phu); }

        /* Table extras */
        .donor-cell  { display: flex; align-items: center; gap: 8px; }
        .donor-av    {
            width: 28px; height: 28px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 11px; font-weight: 700; flex-shrink: 0;
        }
        .donor-name  { font-size: 12px; font-weight: 500; }
        .donor-email { font-size: 11px; color: var(--admin-chu-phu); }

        .amount-pos { color: var(--admin-thanh-cong); font-weight: 600; }

        .table-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 12px;
            border-top: 1px solid var(--admin-vien);
            margin-top: 4px;
        }
        .table-footer span { font-size: 12px; color: var(--admin-chu-phu); }
        .table-footer a    {
            font-size: 12px;
            color: var(--stat-xanh-vien);
            font-weight: 500;
            text-decoration: none;
        }
        .table-footer a:hover { text-decoration: underline; }

        /* Outline button */
        .btn-outline {
            font-size: 11px; padding: 5px 12px;
            border-radius: var(--r-nut);
            background: transparent;
            border: 1px solid var(--admin-vien);
            color: var(--admin-chu-phu);
            cursor: pointer;
            font-family: var(--font);
            transition: all .15s;
        }
        .btn-outline:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- 4 Thẻ thống kê --%>
    <div class="stat-grid">

        <div class="stat-card stat-xanh">
            <div class="stat-card-top">
                <div>
                    <div class="stat-label">Tổng quyên góp</div>
                    <div class="stat-value">1,24 tỷ</div>
                </div>
                <div class="stat-icon">💵</div>
            </div>
            <div class="stat-sub">
                <span class="up">▲ 12,5%</span> so với tháng trước
            </div>
        </div>

        <div class="stat-card stat-cam">
            <div class="stat-card-top">
                <div>
                    <div class="stat-label">Chiến dịch đang chạy</div>
                    <div class="stat-value">18</div>
                </div>
                <div class="stat-icon">🎯</div>
            </div>
            <div class="stat-sub">
                <span class="up">▲ 3</span> chiến dịch mới tháng này
            </div>
        </div>

        <div class="stat-card stat-tim">
            <div class="stat-card-top">
                <div>
                    <div class="stat-label">Người dùng đăng ký</div>
                    <div class="stat-value">3.482</div>
                </div>
                <div class="stat-icon">👥</div>
            </div>
            <div class="stat-sub">
                <span class="up">▲ 8,2%</span> so với tháng trước
            </div>
        </div>

        <div class="stat-card stat-la">
            <div class="stat-card-top">
                <div>
                    <div class="stat-label">Giao dịch chờ duyệt</div>
                    <div class="stat-value">27</div>
                </div>
                <div class="stat-icon">⏳</div>
            </div>
            <div class="stat-sub">
                <span class="down">▼ 5</span> so với hôm qua
            </div>
        </div>

    </div><%-- /stat-grid --%>

    <%-- Biểu đồ + Chiến dịch tiêu biểu --%>
    <div class="main-row">

        <%-- Biểu đồ quyên góp theo tháng --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Quyên góp theo tháng</h3>
                    <div class="card-sub">Tổng số tiền (triệu đồng) — năm 2024</div>
                </div>
                <button class="btn-outline">Xuất CSV</button>
            </div>
            <div class="chart-wrap">
                <canvas id="chartQuyenGop"></canvas>
            </div>
        </div>

        <%-- Chiến dịch tiêu biểu --%>
        <div class="admin-card">
            <div class="card-header">
                <div>
                    <h3>Chiến dịch tiêu biểu</h3>
                    <div class="card-sub">Tiến độ theo mục tiêu</div>
                </div>
            </div>
            <div class="campaign-list" id="campaignList"></div>
        </div>

    </div><%-- /main-row --%>

    <%-- 3 Summary mini-cards --%>
    <div class="summary-row">
        <div class="summary-card">
            <div class="summary-icon" style="background:var(--stat-xanh-nen)">💳</div>
            <div class="summary-info">
                <strong>247</strong>
                <span>Giao dịch trong tháng 6</span>
            </div>
        </div>
        <div class="summary-card">
            <div class="summary-icon" style="background:var(--stat-cam-nen)">✅</div>
            <div class="summary-info">
                <strong>220</strong>
                <span>Giao dịch đã được duyệt</span>
            </div>
        </div>
        <div class="summary-card">
            <div class="summary-icon" style="background:var(--stat-tim-nen)">🏆</div>
            <div class="summary-info">
                <strong>5</strong>
                <span>Chiến dịch hoàn thành mục tiêu</span>
            </div>
        </div>
    </div>

    <%-- Bảng giao dịch gần đây --%>
    <div class="admin-card">
        <div class="card-header">
            <div>
                <h3>Giao dịch quyên góp gần đây</h3>
                <div class="card-sub">10 giao dịch mới nhất cần xử lý</div>
            </div>
            <button class="btn-outline"
                    onclick="location.href='<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>'">
                Xem tất cả →
            </button>
        </div>

        <table class="admin-table">
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
            <tbody id="transactionBody"></tbody>
        </table>

        <div class="table-footer">
            <span>Hiển thị 10 / 247 giao dịch</span>
            <a href="<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>">
                Xem toàn bộ lịch sử →
            </a>
        </div>
    </div>

</asp:Content>

<%-- ── Script riêng của trang TongQuan ────────────────────────── --%>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <%-- Chart.js CDN --%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <script>
        /* ── Mock data: chiến dịch nổi bật ──────────────────── */
        var campaigns = [
            { name: 'Hỗ trợ bão lũ miền Trung', current: 820000000, goal: 1000000000 },
            { name: 'Học bổng trẻ em vùng cao', current: 310000000, goal: 500000000 },
            { name: 'Trồng 10.000 cây xanh', current: 450000000, goal: 600000000 },
            { name: 'Phẫu thuật tim miễn phí', current: 175000000, goal: 400000000 },
            { name: 'Nước sạch Tây Nguyên', current: 220000000, goal: 350000000 }
        ];

        var barColors = ['#3182CE', '#805AD5', '#38A169', '#D69E2E', '#E53E3E'];

        (function renderCampaigns() {
            var el = document.getElementById('campaignList');
            campaigns.forEach(function (c, i) {
                var pct = Math.round(c.current / c.goal * 100);
                el.innerHTML +=
                    '<div class="campaign-item">' +
                    '<div class="campaign-item-top">' +
                    '<span class="c-name">' + c.name + '</span>' +
                    '<span class="c-pct">' + pct + '%</span>' +
                    '</div>' +
                    '<div class="progress-bar">' +
                    '<div class="progress-bar-fill" style="width:' + pct + '%;background:' + barColors[i % barColors.length] + '"></div>' +
                    '</div>' +
                    '<div class="campaign-item-bot">' +
                    '<span>' + (c.current / 1000000).toLocaleString('vi-VN') + ' tr</span>' +
                    '<span>/ ' + (c.goal / 1000000).toLocaleString('vi-VN') + ' tr</span>' +
                    '</div>' +
                    '</div>';
            });
        })();

        /* ── Mock data: giao dịch gần đây ───────────────────── */
        var donors = [
            { name: 'Trần Minh Khôi', email: 'khoi.tm@gmail.com', anDanh: false, color: '#2B6CB0', bg: '#EBF8FF' },
            { name: 'Lê Thị Hoa', email: 'hoa.lt@yahoo.com', anDanh: false, color: '#805AD5', bg: '#E9D8FD' },
            { name: 'Nguyễn Hải Đăng', email: 'dang.nh@gmail.com', anDanh: true, color: '#276749', bg: '#C6F6D5' },
            { name: 'Phạm Thu Hà', email: 'ha.pt@outlook.com', anDanh: false, color: '#C05621', bg: '#FEEBC8' },
            { name: 'Võ Văn Bình', email: 'binh.vv@gmail.com', anDanh: true, color: '#C53030', bg: '#FED7D7' },
            { name: 'Đặng Thị Lan', email: 'lan.dt@gmail.com', anDanh: false, color: '#319795', bg: '#E6FFFA' },
            { name: 'Bùi Quốc Toản', email: 'toan.bq@gmail.com', anDanh: false, color: '#2B6CB0', bg: '#BEE3F8' },
            { name: 'Hoàng Mỹ Linh', email: 'linh.hm@gmail.com', anDanh: false, color: '#B7791F', bg: '#FEEBC8' },
            { name: 'Trịnh Văn Nam', email: 'nam.tv@gmail.com', anDanh: false, color: '#276749', bg: '#C6F6D5' },
            { name: 'Cao Thanh Tú', email: 'tu.ct@gmail.com', anDanh: true, color: '#553C9A', bg: '#E9D8FD' }
        ];

        var cdNames = [
            'Hỗ trợ bão lũ miền Trung',
            'Học bổng trẻ em vùng cao',
            'Phẫu thuật tim miễn phí',
            'Trồng 10.000 cây xanh',
            'Nước sạch Tây Nguyên'
        ];

        var amounts = [500000, 1000000, 2000000, 300000, 1500000,
            750000, 3000000, 250000, 5000000, 800000];

        /* 0=chờ duyệt, 1=đã duyệt, 2=từ chối */
        var statusMap = [0, 0, 0, 1, 1, 1, 1, 1, 1, 2];

        function randomDate() {
            var d = new Date(2024, 5, Math.floor(Math.random() * 28) + 1);
            return d.toLocaleDateString('vi-VN');
        }

        function renderTable() {
            var tbody = document.getElementById('transactionBody');
            donors.forEach(function (d, i) {
                var initials = d.name.split(' ').slice(-2).map(function (n) { return n[0]; }).join('');

                // ── Áp dụng logic ẩn danh ──────────────────────────────────
                var displayName = d.anDanh ? 'Ẩn danh' : d.name;
                var displayEmail = d.anDanh ? '—' : d.email;
                var displayInit = d.anDanh ? '?' : initials;
                var displayBg = d.anDanh ? '#EDF2F7' : d.bg;
                var displayColor = d.anDanh ? '#718096' : d.color;

                var cd = cdNames[i % cdNames.length];
                var amt = amounts[i].toLocaleString('vi-VN') + ' đ';
                var st = statusMap[i];
                var badge, actions;

                if (st === 0) {
                    badge = '<span class="badge-admin badge-cho-duyet">Chờ duyệt</span>';
                    actions = '<button class="btn-duyet" onclick="duyet(this,\'' + displayName + '\')">Duyệt</button> ' +
                        '<button class="btn-xoa"   onclick="tuChoi(this,\'' + displayName + '\')">Từ chối</button>';
                } else if (st === 1) {
                    badge = '<span class="badge-admin badge-thanh-cong">Đã duyệt</span>';
                    actions = '<button class="btn-sua">Xem</button>';
                } else {
                    badge = '<span class="badge-admin badge-tu-choi">Từ chối</span>';
                    actions = '<button class="btn-sua">Xem</button>';
                }

                tbody.innerHTML +=
                    '<tr>' +
                    '<td><code style="font-size:11px;color:var(--admin-chu-phu)">#' + (1000 + i) + '</code></td>' +
                    '<td>' +
                    '<div class="donor-cell">' +
                    '<div class="donor-av" style="color:' + displayColor + ';background:' + displayBg + '">' + displayInit + '</div>' +
                    '<div>' +
                    '<div class="donor-name">' + displayName + '</div>' +
                    '<div class="donor-email">' + displayEmail + '</div>' +
                    '</div>' +
                    '</div>' +
                    '</td>' +
                    '<td style="font-size:12px;max-width:150px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">' + cd + '</td>' +
                    '<td class="amount-pos">' + amt + '</td>' +
                    '<td style="font-size:12px;color:var(--admin-chu-phu)">' + randomDate() + '</td>' +
                    '<td>' + badge + '</td>' +
                    '<td style="white-space:nowrap">' + actions + '</td>' +
                    '</tr>';
            });
        }

        renderTable();

        /* Duyệt / Từ chối inline */
        function duyet(btn, name) {
            if (confirm('Duyệt giao dịch của ' + name + '?')) {
                var row = btn.closest('tr');
                row.querySelector('.badge-admin').outerHTML = '<span class="badge-admin badge-thanh-cong">Đã duyệt</span>';
                btn.closest('td').innerHTML = '<button class="btn-sua">Xem</button>';
            }
        }
        function tuChoi(btn, name) {
            if (confirm('Từ chối giao dịch của ' + name + '?')) {
                var row = btn.closest('tr');
                row.querySelector('.badge-admin').outerHTML = '<span class="badge-admin badge-tu-choi">Từ chối</span>';
                btn.closest('td').innerHTML = '<button class="btn-sua">Xem</button>';
            }
        }

        /* ── Chart.js: quyên góp theo tháng ─────────────────── */
        (function renderChart() {
            var ctx = document.getElementById('chartQuyenGop').getContext('2d');
            var labels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
            var data = [42000000, 58000000, 67000000, 71000000, 95000000, 124000000,
                88000000, 103000000, 116000000, 98000000, 145000000, 132000000];

            var gradient = ctx.createLinearGradient(0, 0, 0, 240);
            gradient.addColorStop(0, 'rgba(99,179,237,.35)');
            gradient.addColorStop(1, 'rgba(99,179,237,0)');

            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Quyên góp (triệu đồng)',
                        data: data,
                        fill: true,
                        backgroundColor: gradient,
                        borderColor: '#3182CE',
                        borderWidth: 2.5,
                        pointBackgroundColor: '#3182CE',
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#1A365D',
                            titleColor: '#90CDF4',
                            bodyColor: '#fff',
                            padding: 10,
                            callbacks: {
                                label: function (ctx) {
                                    return ' ' + (ctx.parsed.y / 1000000).toLocaleString('vi-VN') + ' triệu đồng';
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: { font: { family: "'Be Vietnam Pro'", size: 11 }, color: '#718096' }
                        },
                        y: {
                            grid: { color: '#EDF2F7' },
                            border: { dash: [4, 4] },
                            ticks: {
                                font: { family: "'Be Vietnam Pro'", size: 11 },
                                color: '#718096',
                                callback: function (v) { return (v / 1000000) + ' tr'; }
                            }
                        }
                    }
                }
            });
        })();
    </script>
</asp:Content>
