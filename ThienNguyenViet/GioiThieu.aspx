<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioiThieu.aspx.cs" Inherits="ThienNguyenViet.GioiThieu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .section {
            padding: 60px 0;
        }

        .container {
            width: 1100px;
            margin: 0 auto;
        }

        .text-center {
            text-align: center;
        }

        /* ===== Mission ===== */
        .mission {
            background: var(--mau-chinh-nen);
            border-radius: var(--r-lg);
            padding: 40px;
        }

        /* ===== Grid ===== */
        .grid {
            display: grid;
            gap: 24px;
        }

        .team-grid {
            grid-template-columns: repeat(3, 1fr);
        }

        .partner-grid {
            grid-template-columns: repeat(4, 1fr);
            align-items: center;
        }

        /* ===== Team ===== */
        .team-card {
            text-align: center;
            background: #fff;
            padding: 20px;
            border-radius: var(--r-md);
            border: 1px solid var(--vien);
            transition: transform 0.2s;
        }

        .team-card:hover {
            transform: translateY(-5px);
        }

        .avatar {
            width: 80px;
            height: 80px;
            border-radius: var(--r-pill);
            margin-bottom: 10px;
        }

        /* ===== Timeline ===== */
        .timeline {
            position: relative;
            margin-top: 30px;
            padding-left: 30px;
            border-left: 2px solid var(--mau-chinh);
        }

        .timeline-item {
            margin-bottom: 30px;
            position: relative;
        }

        /* ===== Counter ===== */
        .counter {
            background: var(--mau-chinh);
            border-radius: var(--r-lg);
            color: #fff;
            padding: 40px 20px;
        }

        .counter-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            text-align: center;
        }

        .counter-item h2 {
            color: #fff;
            font-size: 32px;
            margin-bottom: 8px;
        }

        /* ===== Partner ===== */
        .partner-grid img {
            width: 100%;
            filter: grayscale(100%);
            opacity: 0.7;
            transition: .3s;
        }

        .partner-grid img:hover {
            filter: none;
            opacity: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <!-- ===== 1. MISSION ===== -->
    <section class="section">
        <div class="container">
            <div class="mission text-center">
                <h1>Sứ mệnh của chúng tôi</h1>
                <p>
                    Kết nối tấm lòng nhân ái, lan tỏa giá trị cộng đồng và mang đến hy vọng
                    cho những hoàn cảnh khó khăn trên khắp Việt Nam.
                </p>
            </div>
        </div>
    </section>

    <!-- ===== 2. TIMELINE ===== -->
    <section class="section">
        <div class="container">
            <h2 class="text-center">Lịch sử hình thành</h2>

            <div class="timeline">
                <div class="timeline-item">
                    <h3>2020</h3>
                    <p>Thành lập tổ chức Thiện Nguyện Việt.</p>
                </div>

                <div class="timeline-item">
                    <h3>2022</h3>
                    <p>Triển khai hơn 50 chiến dịch thiện nguyện.</p>
                </div>

                <div class="timeline-item">
                    <h3>2024</h3>
                    <p>Đạt 10.000+ nhà hảo tâm tham gia.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== 3. TEAM ===== -->
    <section class="section">
        <div class="container">
            <h2 class="text-center">Đội ngũ</h2>

            <div class="grid team-grid">
                <div class="team-card">
                    <img src="images/team1.jpg" class="avatar" />
                    <h3>Nguyễn Văn A</h3>
                    <p>Founder</p>
                </div>

                <div class="team-card">
                    <img src="images/team2.jpg" class="avatar" />
                    <h3>Trần Thị B</h3>
                    <p>Project Manager</p>
                </div>

                <div class="team-card">
                    <img src="images/team3.jpg" class="avatar" />
                    <h3>Lê Văn C</h3>
                    <p>Marketing</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== 4. COUNTER ===== -->
    <section class="section">
        <div class="container">
            <div class="counter">
                <div class="counter-grid">
                    <div class="counter-item">
                        <h2>100+</h2>
                        <p>Chiến dịch</p>
                    </div>

                    <div class="counter-item">
                        <h2>50.000+</h2>
                        <p>Người ủng hộ</p>
                    </div>

                    <div class="counter-item">
                        <h2>10 Tỷ+</h2>
                        <p>Số tiền quyên góp</p>
                    </div>

                    <div class="counter-item">
                        <h2>63</h2>
                        <p>Tỉnh thành</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== 5. PARTNER ===== -->
    <section class="section">
        <div class="container">
            <h2 class="text-center">Đối tác</h2>

            <div class="grid partner-grid">
                <img src="images/partner1.png" />
                <img src="images/partner2.png" />
                <img src="images/partner3.png" />
                <img src="images/partner4.png" />
            </div>
        </div>
    </section>

</asp:Content>
