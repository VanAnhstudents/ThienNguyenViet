<%@ Page Title="Tổng Quan — Thiện Nguyện Việt" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="TongQuan.aspx.cs"
         Inherits="ThienNguyenViet.Admin.TongQuan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ── Top bar ── */
        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .topbar-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--admin-chu-chinh);
        }
        .topbar-user {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: var(--admin-chu-phu);
        }
        .topbar-user strong {
            color: var(--admin-chu-chinh);
        }
        .topbar-avatar {
            width: 32px; height: 32px;
            border-radius: 20%;
            background: var(--admin-sidebar);
            color: #fff;
            font-size: 12px;
            font-weight: 600;
            display: flex; align-items: center; justify-content: center;
        }

        .avt-admin {
            width: 100%;
            height: 100%;
            border-radius: 20%;
        }

        /* ── Stat cards ── */
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: var(--admin-card);
            border-radius: var(--r-card);
            border: 0.5px solid var(--admin-vien);
            padding: 18px 20px;
            position: relative;
            overflow: hidden;
            transition: box-shadow .15s, transform .15s;
        }
        .stat-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,.08);
            transform: translateY(-2px);
        }
        .stat-card::before {                        
            content: '';
            position: absolute; top: 0; left: 0; right: 0;
            height: 3px;
        }
        .stat-card.blue::before  { background: #3182CE; }
        .stat-card.green::before { background: #38A169; }
        .stat-card.orange::before{ background: #D69E2E; }
        .stat-card.purple::before{ background: #805AD5; }

        .stat-label {
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: .06em;
            color: var(--admin-chu-phu);
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 28px;
            font-weight: 700;
            line-height: 1;
            color: var(--admin-chu-chinh);
        }
        .stat-value.money {
            font-size: 20px;
        }
        .stat-sub {
            margin-top: 6px;
            font-size: 12px;
            color: var(--admin-chu-phu);
        }
        .stat-icon {
            position: absolute; right: 16px; top: 50%;
            transform: translateY(-50%);
            font-size: 32px;
            opacity: .10;
        }

        /* ── Layout 2 cột ── */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            align-items: start;
        }

        /* ── Section tiêu đề ── */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }
        .section-title {
            font-size: 14px;
            font-weight: 600;
            color: var(--admin-chu-chinh);
        }
        .section-link {
            font-size: 12px;
            color: #3182CE;
            text-decoration: none;
        }
        .section-link:hover { text-decoration: underline; }

        /* ── Biểu đồ ── */
        .chart-container {
            position: relative;
            height: 220px;
        }

        /* ── Bộ lọc năm ── */
        .year-select {
            font-size: 12px;
            padding: 4px 8px;
            border: 1px solid var(--admin-vien);
            border-radius: var(--r-nut);
            background: #fff;
            color: var(--admin-chu-chinh);
            cursor: pointer;
        }

        /* ── Badge trạng thái (tái sử dụng từ admin.css) ─── */
        /* đã có: .badge-thanh-cong, .badge-cho-duyet, .badge-tu-choi */

        /* ── Tóm tắt nhanh bên phải ── */
        .quick-stat-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 0.5px solid var(--admin-vien);
        }
        .quick-stat-item:last-child { border-bottom: none; }
        .quick-stat-label { font-size: 13px; color: var(--admin-chu-phu); }
        .quick-stat-value { font-size: 14px; font-weight: 600; color: var(--admin-chu-chinh); }

        /* ── Top campaign mini bars ── */
        .mini-bar-row { margin-bottom: 12px; }
        .mini-bar-label {
            display: flex; justify-content: space-between;
            font-size: 12px; margin-bottom: 4px;
            color: var(--admin-chu-chinh);
        }
        .mini-bar-track {
            height: 6px; border-radius: 3px;
            background: var(--admin-vien);
            overflow: hidden;
        }
        .mini-bar-fill {
            height: 100%; border-radius: 3px;
            background: #3182CE;
            transition: width .6s ease;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Top bar -->
    <div class="topbar">
        <h1 class="topbar-title">Tổng Quan Hệ Thống</h1>
        <div class="topbar-user">
            <div class="topbar-avatar"><img class="avt-admin"  src="/Content/images/avt-admin.jpg"></img></div>
            <span><strong>admin@thiennguyen.vn</strong></span>
        </div>
    </div>

    <!-- 4 Thẻ thống kê -->
    <div class="stat-grid">
        <!-- Chiến dịch đang chạy -->
        <div class="stat-card blue">
            <div class="stat-label">Chiến dịch đang chạy</div>
            <div class="stat-value">
                <asp:Literal ID="ltlChienDichDangChay" runat="server" Text="0" />
            </div>
            <div class="stat-sub">
                Trên tổng <asp:Literal ID="ltlTongChienDich" runat="server" Text="0" /> chiến dịch
            </div>
            <div class="stat-icon">❤</div>
        </div>

        <!-- Người dùng -->
        <div class="stat-card green">
            <div class="stat-label">Người dùng</div>
            <div class="stat-value">
                <asp:Literal ID="ltlTongNguoiDung" runat="server" Text="0" />
            </div>
            <div class="stat-sub">Tài khoản đã đăng ký</div>
            <div class="stat-icon">👥</div>
        </div>

        <!-- Chờ xử lý -->
        <div class="stat-card orange">
            <div class="stat-label">Chờ duyệt quyên góp</div>
            <div class="stat-value">
                <asp:Literal ID="ltlChoXuLy" runat="server" Text="0" />
            </div>
            <div class="stat-sub">Giao dịch cần xác nhận</div>
            <div class="stat-icon">⏳</div>
        </div>

        <!-- Tổng tiền -->
        <div class="stat-card purple">
            <div class="stat-label">Tổng tiền đã quyên góp</div>
            <div class="stat-value money">
                <asp:Literal ID="ltlTongTien" runat="server" Text="0 ₫" />
            </div>
            <div class="stat-sub">
                <asp:Literal ID="ltlTongLuot" runat="server" Text="0" /> lượt đóng góp
            </div>
            <div class="stat-icon">💰</div>
        </div>
    </div>

    <!-- Layout 2 cột: bảng trái + sidebar phải -->
    <div class="dashboard-grid">

        <!-- CỘT TRÁI: bảng + biểu đồ xếp dọc -->
        <div>
            <!-- Bảng quyên góp gần đây -->
            <div class="admin-card">
                <div class="section-header">
                    <span class="section-title">Quyên góp gần đây</span>
                    <a href="/Admin/QuanLyQuyenGop.aspx" class="section-link">Xem tất cả →</a>
                </div>

                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Người quyên góp</th>
                            <th>Chiến dịch</th>
                            <th>Số tiền</th>
                            <th>Thời gian</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptQuyenGop" runat="server"
                                      OnItemDataBound="rptQuyenGop_ItemDataBound">
                            <ItemTemplate>
                                <tr>
                                    <td style="color:var(--admin-chu-phu);font-size:12px;">
                                        #<%# Eval("MaQuyenGop") %>
                                    </td>
                                    <td>
                                        <strong><%# Eval("HoTen") %></strong>
                                        <%# !string.IsNullOrEmpty(Eval("LoiNhan") as string)
                                            ? string.Format("<div style='font-size:11px;color:var(--admin-chu-phu);margin-top:2px;max-width:180px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>\"{0}\"</div>", Eval("LoiNhan"))
                                            : "" %>
                                    </td>
                                    <td style="max-width:200px;white-space:nowrap;
                                               overflow:hidden;text-overflow:ellipsis;">
                                        <%# Eval("TenChienDich") %>
                                    </td>
                                    <td style="font-weight:600;color:#2B6CB0;">
                                        <%# FormatMoney(Eval("SoTien")) %>
                                    </td>
                                    <td style="color:var(--admin-chu-phu);">
                                        <%# FormatDateTime(Eval("NgayTao")) %>
                                    </td>
                                    <td>
                                        <asp:Literal ID="ltlTrangThai" runat="server" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <!-- Thông báo khi không có dữ liệu -->
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
                           style="text-align:center;padding:40px;color:var(--admin-chu-phu);">
                    Chưa có giao dịch nào.
                </asp:Panel>
            </div>

            <!-- Biểu đồ quyên góp theo tháng -->
            <div class="admin-card">
                <div class="section-header">
                    <span class="section-title">Biểu đồ quyên góp theo tháng</span>
                    <select id="selNam" class="year-select" onchange="loadChart(this.value)">
                        <asp:Literal ID="ltlNamOptions" runat="server" />
                    </select>
                </div>
                <div class="chart-container">
                    <canvas id="chartQuyenGop"></canvas>
                </div>
            </div>
        </div>

        <!-- CỘT PHẢI: tóm tắt nhanh -->
        <div>
            <!-- Thống kê nhanh -->
            <div class="admin-card" style="margin-bottom:20px;">
                <div class="section-header">
                    <span class="section-title">Tóm tắt nhanh</span>
                </div>

                <div class="quick-stat-item">
                    <span class="quick-stat-label">Chiến dịch đang chạy</span>
                    <span class="quick-stat-value" style="color:#3182CE;">
                        <asp:Literal ID="ltlQS_DangChay" runat="server" Text="0" />
                    </span>
                </div>
                <div class="quick-stat-item">
                    <span class="quick-stat-label">Chiến dịch đã kết thúc</span>
                    <span class="quick-stat-value">
                        <asp:Literal ID="ltlQS_KetThuc" runat="server" Text="0" />
                    </span>
                </div>
                <div class="quick-stat-item">
                    <span class="quick-stat-label">Quyên góp chờ duyệt</span>
                    <span class="quick-stat-value" style="color:#D69E2E;">
                        <asp:Literal ID="ltlQS_ChoDuyet" runat="server" Text="0" />
                    </span>
                </div>
                <div class="quick-stat-item">
                    <span class="quick-stat-label">Tổng lượt quyên góp</span>
                    <span class="quick-stat-value" style="color:#38A169;">
                        <asp:Literal ID="ltlQS_TongLuot" runat="server" Text="0" />
                    </span>
                </div>
                <div class="quick-stat-item">
                    <span class="quick-stat-label">Ngày cập nhật</span>
                    <span class="quick-stat-value" style="font-size:12px;">
                        <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %>
                    </span>
                </div>
            </div>

            <!-- Liên kết nhanh -->
            <div class="admin-card">
                <div class="section-header">
                    <span class="section-title">Thao tác nhanh</span>
                </div>
                <div style="display:flex;flex-direction:column;gap:8px;">
                    <a href="/Admin/FormChienDich.aspx"
                       style="display:block;padding:10px 14px;border-radius:var(--r-nut);
                              background:#EBF8FF;color:#2B6CB0;text-decoration:none;
                              font-size:13px;font-weight:500;">
                        ＋ Thêm chiến dịch mới
                    </a>
                    <a href="/Admin/QuanLyQuyenGop.aspx?filter=pending"
                       style="display:block;padding:10px 14px;border-radius:var(--r-nut);
                              background:#FEEBC8;color:#C05621;text-decoration:none;
                              font-size:13px;font-weight:500;">
                        ✓ Duyệt quyên góp
                    </a>
                    <a href="/Admin/FormTinTuc.aspx"
                       style="display:block;padding:10px 14px;border-radius:var(--r-nut);
                              background:#C6F6D5;color:#276749;text-decoration:none;
                              font-size:13px;font-weight:500;">
                        📰 Đăng tin tức mới
                    </a>
                    <a href="/Admin/BaoCao.aspx"
                       style="display:block;padding:10px 14px;border-radius:var(--r-nut);
                              background:#E9D8FD;color:#553C9A;text-decoration:none;
                              font-size:13px;font-weight:500;">
                        📊 Xem báo cáo
                    </a>
                </div>
            </div>
        </div>

    </div><!-- /dashboard-grid -->

    <!-- ═══════════════════════════════════════════════════════════
         DỮ LIỆU BIỂU ĐỒ: truyền từ server xuống JS
         JSON được render bởi code-behind vào hidden fields
    ═══════════════════════════════════════════════════════════ -->
    <asp:HiddenField ID="hfChartData" runat="server" />
    <asp:HiddenField ID="hfNamHienTai" runat="server" />

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script>
        // ── Khởi tạo biểu đồ ─────────────────────────────────────
        var chartInstance = null;

        function renderChart(jsonData) {
            var data = JSON.parse(jsonData);
            var labels  = data.map(function(d) { return 'T' + d.Thang; });
            var values  = data.map(function(d) { return d.TongTien / 1e6; }); // đơn vị: triệu đ

            var ctx = document.getElementById('chartQuyenGop').getContext('2d');

            if (chartInstance) chartInstance.destroy();

            chartInstance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Số tiền quyên góp (triệu ₫)',
                        data: values,
                        backgroundColor: 'rgba(49,130,206,0.75)',
                        borderColor:     '#2B6CB0',
                        borderWidth: 1,
                        borderRadius: 4,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: function(ctx) {
                                    return ctx.parsed.y.toFixed(1) + ' triệu ₫';
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(0,0,0,.05)' },
                            ticks: {
                                callback: function(v) { return v + 'tr'; },
                                font: { size: 11 }
                            }
                        },
                        x: {
                            grid: { display: false },
                            ticks: { font: { size: 11 } }
                        }
                    }
                }
            });
        }

        // Render lần đầu khi trang tải
        window.addEventListener('DOMContentLoaded', function () {
            var raw = document.getElementById('<%= hfChartData.ClientID %>').value;
            if (raw) renderChart(raw);
        });

        // Đổi năm → AJAX (Page Method hoặc reload đơn giản)
        function loadChart(nam) {
            window.location.href = '?nam=' + nam;
        }
    </script>

</asp:Content>
