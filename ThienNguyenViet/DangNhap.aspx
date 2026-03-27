<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ThienNguyenViet.DangNhap" %>
<!DOCTYPE html>
<html lang="vi" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dang nhap - Thien Nguyen Viet</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="Content/css/style.css" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

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
            max-width: 900px;
            min-height: 560px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, .15);
        }

        /* ── Left panel ─────────────────────────────────────── */
        .panel-left {
            flex: 0 0 400px;
            background: linear-gradient(160deg, #0F2D1A 0%, #1A4D2E 50%, #2D7A4F 100%);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 44px 48px;
            position: relative;
            overflow: hidden;
        }
        .panel-left::before {
            content: '';
            position: absolute;
            width: 500px; height: 500px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,.06);
            top: -160px; right: -200px;
            pointer-events: none;
        }
        .panel-left::after {
            content: '';
            position: absolute;
            width: 260px; height: 260px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,.06);
            bottom: -80px; left: -80px;
            pointer-events: none;
        }
        .glow {
            position: absolute;
            width: 220px; height: 220px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(76,175,80,.2) 0%, transparent 70%);
            top: 32%; right: 8%;
            pointer-events: none;
        }

        /* Brand */
        .brand {
            display: flex; align-items: center; gap: 12px;
            text-decoration: none; position: relative; z-index: 1;
        }
        .brand-icon {
            width: 42px; height: 42px; border-radius: 11px;
            background: rgba(255,255,255,.1);
            border: 1px solid rgba(255,255,255,.2);
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }
        .brand-name {
            font-family: 'Playfair Display', serif;
            font-size: 16px; font-weight: 700; color: #fff; display: block;
        }
        .brand-sub { font-size: 11px; color: rgba(255,255,255,.5); }

        /* Hero */
        .panel-hero { position: relative; z-index: 1; }
        .live-badge {
            display: inline-flex; align-items: center; gap: 7px;
            background: rgba(255,255,255,.08);
            border: 1px solid rgba(255,255,255,.15);
            color: rgba(255,255,255,.8);
            font-size: 11px; font-weight: 600;
            text-transform: uppercase; letter-spacing: .08em;
            padding: 5px 14px; border-radius: 99px; margin-bottom: 20px;
        }
        .live-dot {
            width: 6px; height: 6px; border-radius: 50%;
            background: #4CAF50;
            animation: blink 2s infinite;
        }
        @keyframes blink { 0%,100%{opacity:1} 50%{opacity:.3} }

        .panel-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(26px, 2.8vw, 36px);
            font-weight: 700; color: #fff; line-height: 1.2;
            margin-bottom: 14px;
        }
        .panel-hero h1 em { font-style: italic; color: #7EE090; }
        .panel-hero p {
            font-size: 14px; color: rgba(255,255,255,.62);
            line-height: 1.75; max-width: 320px;
        }

        /* Stats */
        .stats-row { display: flex; gap: 24px; position: relative; z-index: 1; }
        .stat-item { border-top: 1px solid rgba(255,255,255,.14); padding-top: 12px; }
        .stat-num {
            font-family: 'Playfair Display', serif;
            font-size: 21px; font-weight: 700;
            color: #fff; display: block; line-height: 1; margin-bottom: 4px;
        }
        .stat-lbl { font-size: 11px; color: rgba(255,255,255,.48); line-height: 1.4; }

        /* ── Right panel ─────────────────────────────────────── */
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
            max-width: 360px;
            animation: fadeUp .55s ease both;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(18px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 26px; font-weight: 700;
            color: var(--chu-chinh); margin-bottom: 6px;
        }
        .form-subtitle {
            font-size: 14px; color: var(--chu-phu); margin-bottom: 28px;
        }
        .form-subtitle a {
            color: var(--mau-chinh); font-weight: 600; text-decoration: none;
        }
        .form-subtitle a:hover { text-decoration: underline; }

        /* Error box */
        .err-box {
            display: none;
            align-items: center; gap: 10px;
            background: #FFF5F5;
            border: 1px solid #FED7D7;
            border-left: 3px solid #E53E3E;
            border-radius: 8px;
            padding: 11px 14px;
            margin-bottom: 18px;
            font-size: 13px; color: #C53030;
        }
        .err-box.show { display: flex; animation: shake .4s ease; }
        @keyframes shake {
            0%,100%{transform:translateX(0)}
            25%,75%{transform:translateX(-5px)}
            50%{transform:translateX(5px)}
        }

        /* Field */
        .field { margin-bottom: 16px; }
        .field-lbl {
            display: block;
            font-size: 13px; font-weight: 600;
            color: var(--chu-chinh); margin-bottom: 6px;
        }
        .field-wrap { position: relative; }
        .field-ico {
            position: absolute; left: 12px; top: 50%;
            transform: translateY(-50%);
            font-size: 14px; opacity: .4; pointer-events: none;
        }
        .field-inp {
            width: 100%; height: 46px;
            padding: 0 42px 0 40px;
            border: 1.5px solid #E2E8F0;
            border-radius: 8px;
            font-size: 14px; font-family: var(--font);
            color: var(--chu-chinh); background: #fff;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        .field-inp:focus {
            border-color: var(--mau-chinh);
            box-shadow: 0 0 0 3px rgba(45,122,79,.12);
        }
        .field-inp::placeholder { color: #A0AEC0; font-size: 13px; }

        .toggle-eye {
            position: absolute; right: 12px; top: 50%;
            transform: translateY(-50%);
            background: none; border: none;
            cursor: pointer; font-size: 15px;
            opacity: .35; transition: opacity .15s; line-height: 1;
        }
        .toggle-eye:hover { opacity: .7; }

        /* Remember / forgot row */
        .opts-row {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 20px; font-size: 13px;
        }
        .check-wrap {
            display: flex; align-items: center; gap: 7px;
            color: var(--chu-than); cursor: pointer;
        }
        .check-wrap input { accent-color: var(--mau-chinh); width: 15px; height: 15px; }
        .link-forgot { color: var(--mau-chinh); text-decoration: none; font-weight: 600; }
        .link-forgot:hover { text-decoration: underline; }

        /* Login button */
        .btn-login {
            width: 100%; height: 48px;
            background: linear-gradient(135deg, #2D7A4F, #3D9962);
            color: #fff; font-size: 15px; font-weight: 700;
            font-family: var(--font); border: none; border-radius: 8px;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            box-shadow: 0 4px 14px rgba(45,122,79,.3);
            transition: transform .2s, box-shadow .2s;
        }
        .btn-login:hover { transform: translateY(-2px); box-shadow: 0 7px 20px rgba(45,122,79,.4); }
        .btn-login:active { transform: translateY(0); }

        /* Divider */
        .divider {
            display: flex; align-items: center; gap: 10px;
            margin: 20px 0; font-size: 12px; color: var(--chu-phu);
        }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px; background: #E2E8F0;
        }

        /* Demo buttons */
        .demo-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .demo-btn {
            height: 42px; border: 1.5px solid #E2E8F0; border-radius: 8px;
            background: #fff; cursor: pointer; font-family: var(--font);
            font-size: 13px; font-weight: 500; color: var(--chu-than);
            display: flex; align-items: center; justify-content: center; gap: 6px;
            transition: all .18s;
        }
        .demo-btn:hover { border-color: #B7DEC6; background: #EAF5EE; color: var(--mau-chinh); }
        .demo-btn code {
            font-family: 'Courier New', monospace; font-size: 11px; font-weight: 700;
            background: #EAF5EE; color: var(--mau-chinh);
            padding: 2px 5px; border-radius: 4px;
        }

        .form-bottom {
            text-align: center; margin-top: 22px;
            font-size: 13px; color: var(--chu-phu);
        }
        .form-bottom a { color: var(--mau-chinh); font-weight: 600; text-decoration: none; }
        .form-bottom a:hover { text-decoration: underline; }

        .back-link {
            position: fixed; top: 20px; right: 28px;
            font-size: 13px; color: var(--chu-phu);
            text-decoration: none;
            display: flex; align-items: center; gap: 4px;
            transition: color .15s; z-index: 100;
        }
        .back-link:hover { color: var(--mau-chinh); }

        /* ── Responsive ──────────────────────────────────────── */
        @media (max-width: 760px) {
            body { padding: 0; align-items: flex-start; }
            .auth-wrapper {
                flex-direction: column;
                border-radius: 0;
                min-height: 100vh;
                box-shadow: none;
            }
            .panel-left { flex: none; padding: 28px 24px; }
            .stats-row, .panel-hero p { display: none; }
            .panel-hero h1 { font-size: 22px; }
            .panel-right { padding: 32px 20px; }
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
                <div class="live-badge">
                    <span class="live-dot"></span>
                    &#272;ang ho&#7841;t &#273;&#7897;ng
                </div>
                <h1>Ch&#224;o m&#7915;ng<br/>tr&#7903; l&#7841;i <em>b&#7841;n</em> &#128075;</h1>
                <p>M&#7895;i l&#7847;n &#273;&#259;ng nh&#7853;p l&#224; m&#7897;t c&#417; h&#7897;i &#273;&#7875; lan t&#7887;a y&#234;u th&#432;&#417;ng v&#224; t&#7841;o ra s&#7921; thay &#273;&#7893;i cho c&#7897;ng &#273;&#7891;ng.</p>
            </div>

            <div class="stats-row">
                <div class="stat-item">
                    <span class="stat-num">128+</span>
                    <span class="stat-lbl">Chi&#7871;n d&#7883;ch<br/>th&#224;nh c&#244;ng</span>
                </div>
                <div class="stat-item">
                    <span class="stat-num">47K</span>
                    <span class="stat-lbl">T&#236;nh nguy&#7879;n<br/>vi&#234;n</span>
                </div>
                <div class="stat-item">
                    <span class="stat-num">12,4 t&#7927;</span>
                    <span class="stat-lbl">&#272;&#7891;ng quy&#234;n<br/>g&#243;p</span>
                </div>
            </div>
        </div>

        <%-- RIGHT --%>
        <div class="panel-right">
            <div class="form-card">

                <h1 class="form-title">&#272;&#259;ng nh&#7853;p</h1>
                <p class="form-subtitle">
                    Ch&#432;a c&#243; t&#224;i kho&#7843;n?
                    <a href="DangKy.aspx">&#272;&#259;ng k&#253; ngay &#8594;</a>
                </p>

                <div class="err-box <%= lblError.Visible ? "show" : "" %>" id="errBox">
                    <span>&#9888;&#65039;</span>
                    <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
                </div>

                <div class="field">
                    <label class="field-lbl">Email / T&#234;n &#273;&#259;ng nh&#7853;p</label>
                    <div class="field-wrap">
                        <span class="field-ico">&#9993;&#65039;</span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="field-inp" placeholder="admin hoặc user" />
                    </div>
                </div>

                <div class="field">
                    <label class="field-lbl">M&#7853;t kh&#7849;u</label>
                    <div class="field-wrap">
                        <span class="field-ico">&#128274;</span>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="field-inp" placeholder="Nhập mật khẩu..." />
                        <button type="button" class="toggle-eye" id="toggleEye">&#128065;</button>
                    </div>
                </div>

                <div class="opts-row">
                    <label class="check-wrap">
                        <asp:CheckBox ID="chkRemember" runat="server" />
                        Nh&#7899; t&#244;i
                    </label>
                    <asp:HyperLink ID="lnkQuenMK" runat="server" NavigateUrl="#" CssClass="link-forgot">
                        Qu&#234;n m&#7853;t kh&#7849;u?
                    </asp:HyperLink>
                </div>

                <asp:Button ID="btnDangNhap" runat="server"
                    Text="Đăng nhập"
                    CssClass="btn-login"
                    OnClick="btnDangNhap_Click"
                    OnClientClick="return validateLogin();" />

                <div class="divider">T&#224;i kho&#7843;n th&#7917; nghi&#7879;m</div>
                <div class="demo-grid">
                    <button type="button" class="demo-btn" onclick="fillDemo('admin','admin')">
                        &#128081; Admin &nbsp;<code>admin</code>
                    </button>
                    <button type="button" class="demo-btn" onclick="fillDemo('user','user')">
                        &#128100; User &nbsp;<code>user</code>
                    </button>
                </div>

                <div class="form-bottom">
                    Ch&#432;a c&#243; t&#224;i kho&#7843;n?
                    <a href="DangKy.aspx">T&#7841;o t&#224;i kho&#7843;n mi&#7877;n ph&#237;</a>
                </div>

            </div>
        </div>

    </div><%-- /.auth-wrapper --%>

</form>
<script>
    function fillDemo(u, p) {
        document.getElementById('<%= txtEmail.ClientID %>').value = u;
        document.getElementById('<%= txtPassword.ClientID %>').value = p;
    }
    document.getElementById('toggleEye').addEventListener('click', function () {
        var inp = document.getElementById('<%= txtPassword.ClientID %>');
        var show = inp.type === 'password';
        inp.type = show ? 'text' : 'password';
        this.textContent = show ? '\uD83D\uDE48' : '\uD83D\uDC41';
    });
    function validateLogin() {
        var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
        var pass  = document.getElementById('<%= txtPassword.ClientID %>').value;
        var box   = document.getElementById('errBox');
        var lbl   = document.getElementById('<%= lblError.ClientID %>');
        function err(m) { lbl.textContent = m; box.className = 'err-box show'; return false; }
        box.className = 'err-box';
        if (!email) return err('Vui lòng nhập email hoặc tên đăng nhập!');
        if (!pass) return err('Vui lòng nhập mật khẩu!');
        return true;
    }
</script>
</body>
</html>
