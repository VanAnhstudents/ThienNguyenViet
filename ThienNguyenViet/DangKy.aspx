<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="ThienNguyenViet.DangKy" %>

<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dang ky - Thien Nguyen Viet</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="Content/css/style.css" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            font-family: var(--font);
            background: var(--nen-trang);
            min-height: 100vh;
        }

        /* Body căn giữa wrapper theo cả 2 chiều, padding tạo khoảng cách 4 phía */
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
        }

        /* Wrapper bọc 2 panel — flex container thực sự */
        .auth-wrapper {
            display: flex;
            width: 100%;
            max-width: 960px;
            min-height: 600px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, .15);
        }

        /* ── Left panel ─────────────────────────────────────── */
        .panel-left {
            flex: 0 0 380px;
            background: linear-gradient(160deg, #0B2617 0%, #163D27 45%, #225E3B 80%, #2D7A4F 100%);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 44px 44px;
            position: relative;
            overflow: hidden;
        }

            .panel-left::before {
                content: '';
                position: absolute;
                width: 460px;
                height: 460px;
                border-radius: 50%;
                border: 1px solid rgba(255,255,255,.05);
                top: -140px;
                right: -180px;
                pointer-events: none;
            }

            .panel-left::after {
                content: '';
                position: absolute;
                width: 240px;
                height: 240px;
                border-radius: 50%;
                border: 1px solid rgba(255,255,255,.05);
                bottom: -70px;
                left: -70px;
                pointer-events: none;
            }

        .glow {
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(76,175,80,.18) 0%, transparent 70%);
            top: 35%;
            right: 5%;
            pointer-events: none;
        }

        /* Brand */
        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            position: relative;
            z-index: 1;
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            border-radius: 11px;
            background: rgba(255,255,255,.1);
            border: 1px solid rgba(255,255,255,.18);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .brand-name {
            font-family: 'Playfair Display', serif;
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            display: block;
        }

        .brand-sub {
            font-size: 11px;
            color: rgba(255,255,255,.5);
        }

        /* Hero */
        .panel-hero {
            position: relative;
            z-index: 1;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,.08);
            border: 1px solid rgba(255,255,255,.14);
            color: rgba(255,255,255,.8);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .08em;
            padding: 5px 14px;
            border-radius: 99px;
            margin-bottom: 18px;
        }

        .panel-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(24px, 2.5vw, 34px);
            font-weight: 700;
            color: #fff;
            line-height: 1.2;
            margin-bottom: 14px;
        }

            .panel-hero h1 em {
                font-style: italic;
                color: #7EE090;
            }

        .panel-hero p {
            font-size: 13px;
            color: rgba(255,255,255,.6);
            line-height: 1.75;
            max-width: 300px;
            margin-bottom: 20px;
        }

        /* Benefits */
        .benefits {
            list-style: none;
            position: relative;
            z-index: 1;
        }

            .benefits li {
                display: flex;
                align-items: flex-start;
                gap: 10px;
                font-size: 13px;
                color: rgba(255,255,255,.7);
                margin-bottom: 10px;
            }

                .benefits li .chk {
                    width: 20px;
                    height: 20px;
                    border-radius: 50%;
                    background: rgba(76,175,80,.22);
                    border: 1px solid rgba(76,175,80,.4);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 10px;
                    color: #7EE090;
                    flex-shrink: 0;
                    margin-top: 1px;
                }

        /* ── Right panel ─────────────────────────────────────── */
        /* flex:1 + overflow-y:auto cho phép scroll độc lập khi form dài */
        .panel-right {
            flex: 1;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 40px;
            overflow-y: auto;
        }

        /* Form card */
        .form-card {
            width: 100%;
            max-width: 440px;
            animation: fadeUp .55s ease both;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(18px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            font-weight: 700;
            color: var(--chu-chinh);
            margin-bottom: 6px;
        }

        .form-subtitle {
            font-size: 14px;
            color: var(--chu-phu);
            margin-bottom: 20px;
        }

            .form-subtitle a {
                color: var(--mau-chinh);
                font-weight: 600;
                text-decoration: none;
            }

                .form-subtitle a:hover {
                    text-decoration: underline;
                }

        /* Steps */
        .steps {
            display: flex;
            align-items: center;
            margin-bottom: 24px;
        }

        .step {
            display: flex;
            align-items: center;
            gap: 7px;
            font-size: 12px;
            font-weight: 600;
            color: var(--chu-phu);
        }

        .step-dot {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #E2E8F0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
            color: var(--chu-phu);
            flex-shrink: 0;
        }

        .step.active .step-dot {
            background: var(--mau-chinh);
            color: #fff;
        }

        .step.active {
            color: var(--mau-chinh);
        }

        .step-line {
            flex: 1;
            height: 1px;
            background: #E2E8F0;
            margin: 0 8px;
        }

        /* Error */
        .err-box {
            display: none;
            align-items: center;
            gap: 10px;
            background: #FFF5F5;
            border: 1px solid #FED7D7;
            border-left: 3px solid #E53E3E;
            border-radius: 8px;
            padding: 11px 14px;
            margin-bottom: 18px;
            font-size: 13px;
            color: #C53030;
        }

            .err-box.show {
                display: flex;
                animation: shake .4s ease;
            }

        @keyframes shake {
            0%,100% {
                transform: translateX(0)
            }

            25%,75% {
                transform: translateX(-5px)
            }

            50% {
                transform: translateX(5px)
            }
        }

        /* Grid layout */
        .field-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .field {
            margin-bottom: 14px;
        }

        .span-2 {
            grid-column: 1 / -1;
        }

        .field-lbl {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 13px;
            font-weight: 600;
            color: var(--chu-chinh);
            margin-bottom: 6px;
        }

        .field-hint {
            font-size: 11px;
            font-weight: 400;
            color: var(--chu-phu);
        }

        .field-wrap {
            position: relative;
        }

        .field-ico {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            opacity: .4;
            pointer-events: none;
        }

        .field-inp {
            width: 100%;
            height: 44px;
            padding: 0 38px 0 38px;
            border: 1.5px solid #E2E8F0;
            border-radius: 8px;
            font-size: 14px;
            font-family: var(--font);
            color: var(--chu-chinh);
            background: #fff;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

            .field-inp:focus {
                border-color: var(--mau-chinh);
                box-shadow: 0 0 0 3px rgba(45,122,79,.12);
            }

            .field-inp::placeholder {
                color: #A0AEC0;
                font-size: 13px;
            }

            .field-inp.is-ok {
                border-color: #38A169;
            }

            .field-inp.is-err {
                border-color: #E53E3E;
                box-shadow: 0 0 0 3px rgba(229,62,62,.1);
            }

        .toggle-eye {
            position: absolute;
            right: 11px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
            opacity: .35;
            transition: opacity .15s;
            line-height: 1;
        }

            .toggle-eye:hover {
                opacity: .7;
            }

        /* Strength */
        .pwd-bars {
            display: flex;
            gap: 4px;
            margin-top: 5px;
        }

        .pwd-bar {
            flex: 1;
            height: 3px;
            border-radius: 99px;
            background: #E2E8F0;
            transition: background .3s;
        }

            .pwd-bar.s-weak {
                background: #E53E3E;
            }

            .pwd-bar.s-medium {
                background: #D69E2E;
            }

            .pwd-bar.s-strong {
                background: #38A169;
            }

        .pwd-label {
            font-size: 11px;
            color: var(--chu-phu);
            margin-top: 3px;
            text-align: right;
        }

        /* Terms */
        .terms-wrap {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: #EAF5EE;
            border: 1px solid #B7DEC6;
            border-radius: 8px;
            padding: 13px 14px;
            margin-bottom: 18px;
        }

            .terms-wrap input[type="checkbox"] {
                width: 16px;
                height: 16px;
                accent-color: var(--mau-chinh);
                cursor: pointer;
                flex-shrink: 0;
                margin-top: 2px;
            }

        .terms-text {
            font-size: 13px;
            color: var(--chu-than);
            line-height: 1.55;
        }

            .terms-text a {
                color: var(--mau-chinh);
                font-weight: 600;
                text-decoration: none;
            }

                .terms-text a:hover {
                    text-decoration: underline;
                }

        /* Submit */
        .btn-reg {
            width: 100%;
            height: 48px;
            background: linear-gradient(135deg, #2D7A4F, #3D9962);
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            font-family: var(--font);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 14px rgba(45,122,79,.3);
            transition: transform .2s, box-shadow .2s;
        }

            .btn-reg:hover {
                transform: translateY(-2px);
                box-shadow: 0 7px 20px rgba(45,122,79,.4);
            }

            .btn-reg:active {
                transform: translateY(0);
            }

        .form-bottom {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: var(--chu-phu);
        }

            .form-bottom a {
                color: var(--mau-chinh);
                font-weight: 600;
                text-decoration: none;
            }

                .form-bottom a:hover {
                    text-decoration: underline;
                }

        .back-link {
            position: fixed;
            top: 20px;
            right: 28px;
            font-size: 13px;
            color: var(--chu-phu);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 4px;
            transition: color .15s;
            z-index: 100;
        }

            .back-link:hover {
                color: var(--mau-chinh);
            }

        /* ── Responsive ──────────────────────────────────────── */
        @media (max-width: 820px) {
            body {
                padding: 0;
                align-items: flex-start;
            }

            .auth-wrapper {
                flex-direction: column;
                border-radius: 0;
                min-height: 100vh;
                box-shadow: none;
            }

            .panel-left {
                flex: none;
                padding: 28px 24px;
            }

            .panel-hero p, .benefits {
                display: none;
            }

            .panel-hero h1 {
                font-size: 22px;
            }

            .panel-right {
                padding: 32px 20px;
            }

            .field-row {
                grid-template-columns: 1fr;
            }
        }

        /* CSS cho thông báo lỗi dưới ô nhập liệu */
        .field-error-msg {
            display: none; /* Mặc định ẩn */
            color: #E53E3E;
            font-size: 11px;
            margin-top: 4px;
            font-weight: 500;
            animation: fadeIn 0.3s ease;
        }

            /* Hiển thị khi có class .show */
            .field-error-msg.show {
                display: block;
            }

        /* Hiệu ứng mờ dần cho thông báo */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-3px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <a href="TrangChu.aspx" class="back-link">&#8592; Trang ch&#7911;</a>

        <div class="auth-wrapper">

            <%-- LEFT --%>
            <div class="panel-left">
                <div class="glow"></div>

                <a href="TrangChu.aspx" class="brand">
                    <div class="brand-icon">&#127807;</div>
                    <div>
                        <span class="brand-name">Thi&#7879;n Nguy&#7879;n Vi&#7879;t</span>
                        <span class="brand-sub">Chung tay v&#236; c&#7897;ng &#273;&#7891;ng</span>
                    </div>
                </a>

                <div class="panel-hero">
                    <div class="hero-badge">&#129309; Gia nh&#7853;p c&#7897;ng &#273;&#7891;ng</div>
                    <h1>Tr&#7903; th&#224;nh<br />
                        <em>t&#236;nh nguy&#7879;n</em><br />
                        vi&#234;n h&#244;m nay</h1>
                    <p>T&#7841;o t&#224;i kho&#7843;n mi&#7877;n ph&#237; v&#224; b&#7855;t &#273;&#7847;u h&#224;nh tr&#236;nh lan t&#7887;a y&#234;u th&#432;&#417;ng c&#249;ng h&#224;ng ngh&#236;n ng&#432;&#7901;i Vi&#7879;t.</p>
                </div>

                <ul class="benefits">
                    <li><span class="chk">&#10003;</span> Theo d&#245;i ti&#7871;n &#273;&#7897; c&#225;c chi&#7871;n d&#7883;ch b&#7841;n &#7911;ng h&#7897;</li>
                    <li><span class="chk">&#10003;</span> Nh&#7853;n th&#244;ng b&#225;o c&#7853;p nh&#7853;t tr&#7921;c ti&#7871;p</li>
                    <li><span class="chk">&#10003;</span> L&#7883;ch s&#7917; quy&#234;n g&#243;p minh b&#7841;ch, r&#245; r&#224;ng</li>
                    <li><span class="chk">&#10003;</span> K&#7871;t n&#7889;i v&#7899;i c&#7897;ng &#273;&#7891;ng t&#236;nh nguy&#7879;n vi&#234;n</li>
                </ul>
            </div>

            <%-- RIGHT --%>
            <div class="panel-right">
                <div class="form-card">

                    <h1 class="form-title">T&#7841;o t&#224;i kho&#7843;n</h1>
                    <p class="form-subtitle">
                        &#272;&#227; c&#243; t&#224;i kho&#7843;n?
                    <a href="DangNhap.aspx">&#272;&#259;ng nh&#7853;p t&#7841;i &#273;&#226;y &#8594;</a>
                    </p>

                    <div class="steps">
                        <div class="step active">
                            <div class="step-dot">1</div>
                            Th&#244;ng tin
                        </div>
                        <div class="step-line"></div>
                        <div class="step">
                            <div class="step-dot">2</div>
                            B&#7843;o m&#7853;t
                        </div>
                        <div class="step-line"></div>
                        <div class="step">
                            <div class="step-dot">3</div>
                            Ho&#224;n t&#7845;t
                        </div>
                    </div>

                    <div class="err-box <%= lblError.Visible ? "show" : "" %>" id="errBox">
                        <span>&#9888;&#65039;</span>
                        <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
                    </div>

                    <div class="field-row">

                        <%-- Ho ten --%>
                        <div class="field span-2">
                            <div class="field-lbl">
                                H&#7885; v&#224; t&#234;n
                            <span class="field-hint">*B&#7855;t bu&#7897;c</span>
                            </div>
                            <div class="field-wrap">
                                <span class="field-ico">&#128100;</span>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="field-inp" placeholder="Nguyen Van A" />
                            </div>
                            <span id="msgHoTen" class="field-error-msg">Vui lòng nhập họ và tên</span>
                        </div>

                        <%-- Email --%>
                        <div class="field span-2">
                            <div class="field-lbl">Email</div>
                            <div class="field-wrap">
                                <span class="field-ico">&#9993;&#65039;</span>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="email@example.com" />
                            </div>
                            <span id="msgEmail" class="field-error-msg">Email không hợp lệ</span>
                        </div>

                        <%-- So dien thoai --%>
                        <div class="field span-2">
                            <div class="field-lbl">
                                S&#7889; &#273;i&#7879;n tho&#7841;i
                            <span class="field-hint">10 ch&#7919; s&#7889;</span>
                            </div>
                            <div class="field-wrap">
                                <span class="field-ico">&#128241;</span>
                                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="field-inp" placeholder="09xxxxxxxx" />
                                <span id="msgPhone" class="field-error-msg">Số điện thoại không hợp lệ</span>
                            </div>
                        </div>

                        <%-- Mat khau --%>
                        <div class="field">
                            <div class="field-lbl">M&#7853;t kh&#7849;u</div>
                            <div class="field-wrap">
                                <span class="field-ico">&#128274;</span>
                                <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="field-inp"
                                    placeholder="Tối thiểu 6 ký tự"
                                    oninput="onPwdInput(this.value)" />
                                <span id="msgPass" class="field-error-msg">Mật khẩu phải có ít nhất 6 ký tự!</span>
                                <button type="button" class="toggle-eye" onclick="togglePwd('pass')">&#128065;</button>
                            </div>
                            <div class="pwd-bars">
                                <div class="pwd-bar" id="b1"></div>
                                <div class="pwd-bar" id="b2"></div>
                                <div class="pwd-bar" id="b3"></div>
                            </div>
                            <div class="pwd-label" id="pwdLbl"></div>
                        </div>

                        <%-- Xac nhan mat khau --%>
                        <div class="field">
                            <div class="field-lbl">X&#225;c nh&#7853;n m&#7853;t kh&#7849;u</div>
                            <div class="field-wrap">
                                <span class="field-ico">&#128272;</span>
                                <asp:TextBox ID="txtXacNhanMK" runat="server" TextMode="Password" CssClass="field-inp"
                                    placeholder="Nhập lại mật khẩu"
                                    oninput="onConfirmInput(this.value)" />
                                <span id="msgConfirm" class="field-error-msg">Mật khẩu xác nhận không khớp!</span>
                                <button type="button" class="toggle-eye" onclick="togglePwd('confirm')">&#128065;</button>
                            </div>
                        </div>

                    </div>

                    <%-- Terms --%>
                    <div class="terms-wrap">
                        <asp:CheckBox ID="chkDongY" runat="server" />
                        <span class="terms-text">T&#244;i &#273;&#227; &#273;&#7885;c v&#224; &#273;&#7891;ng &#253; v&#7899;i
                        <a href="#" onclick="return false;">&#272;i&#7873;u kho&#7843;n d&#7883;ch v&#7909;</a>
                            v&#224;
                        <a href="#" onclick="return false;">Ch&#237;nh s&#225;ch b&#7843;o m&#7853;t</a>
                            c&#7911;a Thi&#7879;n Nguy&#7879;n Vi&#7879;t.
                        </span>
                    </div>

                    <asp:Button ID="btnDangKy" runat="server"
                        Text="Tạo tài khoản ngay"
                        CssClass="btn-reg"
                        OnClick="btnDangKy_Click"
                        OnClientClick="return validateRegister();" />

                    <div class="form-bottom">
                        &#272;&#227; c&#243; t&#224;i kho&#7843;n?
                    <a href="DangNhap.aspx">&#272;&#259;ng nh&#7853;p</a>
                    </div>

                </div>
            </div>

        </div>
        <%-- /.auth-wrapper --%>
    </form>
    <script>
        var inpPass = document.getElementById('<%= txtMatKhau.ClientID %>');
        var inpConfirm = document.getElementById('<%= txtXacNhanMK.ClientID %>');

        function togglePwd(which) {
            var inp = which === 'pass' ? inpPass : inpConfirm;
            var btn = inp.nextElementSibling;
            var show = inp.type === 'password';
            inp.type = show ? 'text' : 'password';
            btn.textContent = show ? '\uD83D\uDE48' : '\uD83D\uDC41';
        }

        function onPwdInput(v) {
            var b1 = document.getElementById('b1');
            var b2 = document.getElementById('b2');
            var b3 = document.getElementById('b3');
            var lb = document.getElementById('pwdLbl');
            [b1, b2, b3].forEach(function (b) { b.className = 'pwd-bar'; });
            if (!v) { lb.textContent = ''; return; }
            var score = 0;
            if (v.length >= 6) score++;
            if (v.length >= 10) score++;
            if (/[A-Z]/.test(v) || /[0-9]/.test(v) || /[^a-zA-Z0-9]/.test(v)) score++;
            var cls = ['s-weak', 's-medium', 's-strong'][score - 1] || 's-weak';
            var names = ['Yếu', 'Trung bình', 'Mạnh'];
            var clrs = ['#E53E3E', '#D69E2E', '#38A169'];
            for (var i = 0; i < score; i++) document.getElementById('b' + (i + 1)).className = 'pwd-bar ' + cls;
            lb.textContent = names[score - 1] || 'Yếu';
            lb.style.color = clrs[score - 1] || clrs[0];
        }

        function onConfirmInput(v) {
            if (!v) { inpConfirm.className = 'field-inp'; return; }
            inpConfirm.className = 'field-inp ' + (v === inpPass.value ? 'is-ok' : 'is-err');
        }

        function validateRegister() {
            // Lấy giá trị
            var hoten = document.getElementById('<%= txtHoTen.ClientID %>');
            var email = document.getElementById('<%= txtEmail.ClientID %>');
            var phone = document.getElementById('<%= txtSoDienThoai.ClientID %>');
            var pass = inpPass;
            var confirm = inpConfirm;
            var agree = document.getElementById('<%= chkDongY.ClientID %>');

            var emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            var phoneRx = /^(0[3-9])\d{8}$/;
            var isValid = true;

            // Hàm hiển thị/ẩn lỗi
            function toggleError(input, msgId, message, show) {
                var msgSpan = document.getElementById(msgId);
                if (show) {
                    msgSpan.textContent = message;
                    msgSpan.classList.add('show');
                    input.classList.add('is-err');
                    isValid = false;
                } else {
                    msgSpan.classList.remove('show');
                    input.classList.remove('is-err');
                }
            }

            // Kiểm tra từng trường
            toggleError(hoten, 'msgHoTen', 'Họ tên phải có ít nhất 2 ký tự!', hoten.value.trim().length < 2);
            toggleError(email, 'msgEmail', 'Email không hợp lệ!', !emailRx.test(email.value.trim()));
            toggleError(phone, 'msgPhone', 'Số điện thoại không hợp lệ (10 số)!', !phoneRx.test(phone.value.trim()));
            toggleError(pass, 'msgPass', 'Mật khẩu tối thiểu 6 ký tự!', pass.value.length < 6);
            toggleError(confirm, 'msgConfirm', 'Mật khẩu xác nhận không khớp!', confirm.value !== pass.value);

            if (!agree.checked) {
                alert("Bạn phải đồng ý với điều khoản sử dụng!");
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>
