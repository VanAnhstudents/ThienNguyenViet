<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyNguoiDung.aspx.cs" Inherits="ThienNguyenViet.Admin.QuanLyNguoiDung" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .nd-stats { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; text-align: center }
    .nd-stat {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .nd-stat:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .nd-stat .stat-card-label {
        font-size: 10px; text-transform: uppercase;
        font-weight: 600; letter-spacing: .03em; margin-bottom: 6px;
    }
    .nd-stat .stat-card-value { font-size: 22px; font-weight: 700; }
    .user-fullname { font-size: 13px; font-weight: 500; }
    .user-email { font-size: 10px; }
    .user-role {
        display: inline-block; font-size: 10px; padding: 2px 8px;
        border-radius: 4px; font-weight: 500;
    }
    .role-admin { background: #E9D8FD; }
    .role-user { background: var(--info-bg); }
    @media (max-width: 768px) { .nd-stats { grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 425px) { .nd-stats { grid-template-columns: 1fr 1fr; gap: 8px; } }
    @media (max-width: 375px) { .nd-stats { grid-template-columns: 1fr; } }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý người dùng</h1>
    <p>Danh sách tài khoản người dùng hệ thống</p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- === HIDDEN FIELDS CHO POSTBACK === -->
    <asp:HiddenField ID="hfPage" runat="server" Value="1" />
    <asp:HiddenField ID="hfFilterTT" runat="server" />
    <asp:HiddenField ID="hfFilterVT" runat="server" />
    <asp:HiddenField ID="hfAction" runat="server" />
    <asp:HiddenField ID="hfParam" runat="server" />

    <div class="nd-stats">
        <div class="nd-stat">
            <div class="stat-card-label">Tổng tài khoản</div>
            <div class="stat-card-value"><%= TongTaiKhoan %></div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Đang hoạt động</div>
            <div class="stat-card-value"><%= NguoiDungHoatDong %></div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Tài khoản bị khóa</div>
            <div class="stat-card-value"><%= TaiKhoanKhoa %></div>
        </div>
        <div class="nd-stat">
            <div class="stat-card-label">Tổng quyên góp</div>
            <div class="stat-card-value"><%= FormatTien(TongQuyenGop) %></div>
        </div>
    </div>

    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="input" placeholder="Tìm kiếm theo tên, email, số điện thoại..." />
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm" OnClick="BtnSearch_Click" />
            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-outline" Text="Đặt lại" OnClick="BtnReset_Click" />
        </div>
    </div>

    <div class="filter-bar">
        <div class="filter-group">
            <button type="button" class="filter-btn<%= FilterTT == "" ? " active" : "" %>" onclick="setFilter('tt','')">Tất cả</button>
            <button type="button" class="filter-btn<%= FilterTT == "1" ? " active" : "" %>" onclick="setFilter('tt','1')">Hoạt động</button>
            <button type="button" class="filter-btn<%= FilterTT == "0" ? " active" : "" %>" onclick="setFilter('tt','0')">Đã khóa</button>
        </div>
        <div class="filter-group">
            <button type="button" class="filter-btn<%= FilterVT == "" ? " active" : "" %>" onclick="setFilter('vt','')">Tất cả vai trò</button>
            <button type="button" class="filter-btn<%= FilterVT == "1" ? " active" : "" %>" onclick="setFilter('vt','1')">Quản trị viên</button>
            <button type="button" class="filter-btn<%= FilterVT == "0" ? " active" : "" %>" onclick="setFilter('vt','0')">Người dùng</button>
        </div>
    </div>

    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Họ tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <% if (DtNguoiDung != null && DtNguoiDung.Rows.Count > 0) {
                foreach (System.Data.DataRow r in DtNguoiDung.Rows) {
                    int maND = Convert.ToInt32(r["MaNguoiDung"]);
                    string hoTen = r["HoTen"].ToString();
                    string email = r["Email"] == DBNull.Value ? "" : r["Email"].ToString();
                    string sdt = r["SoDienThoai"] == DBNull.Value ? "" : r["SoDienThoai"].ToString();
                    int vaiTro = Convert.ToInt32(r["VaiTro"]);
                    int trangThai = Convert.ToInt32(r["TrangThai"]);
                    string ngayTao = r["NgayTao"].ToString();
                    long tongQG = Convert.ToInt64(r["TongQuyenGop"]);

                    string roleCls = vaiTro == 1 ? "role-admin" : "role-user";
                    string roleLabel = vaiTro == 1 ? "Quản trị viên" : "Người dùng";
                    string ttLabel = trangThai == 1 ? "Hoạt động" : "Đã khóa";
                    string ttCls = trangThai == 1 ? "badge-ok" : "badge-err";
            %>
                <tr>
                    <td><div class="user-fullname"><%= Server.HtmlEncode(hoTen) %></div></td>
                    <td style="font-size:12px"><%= Server.HtmlEncode(email) %></td>
                    <td style="font-size:12px"><%= Server.HtmlEncode(sdt) %></td>
                    <td><span class="user-role <%= roleCls %>"><%= roleLabel %></span></td>
                    <td><span class="badge <%= ttCls %>"><%= ttLabel %></span></td>
                    <td style="font-size:11px;white-space:nowrap"><%= ngayTao %></td>
                    <td>
                        <div style="display:flex;gap:4px">
                            <button type="button" class="btn btn-xs btn-outline" onclick="viewDetail(<%= maND %>,'<%= Server.HtmlEncode(hoTen).Replace("'","\\'") %>','<%= Server.HtmlEncode(email).Replace("'","\\'") %>','<%= Server.HtmlEncode(sdt).Replace("'","\\'") %>',<%= vaiTro %>,<%= trangThai %>,'<%= ngayTao %>',<%= tongQG %>)">Xem</button>
                            <% if (vaiTro != 1) { %>
                                <% if (trangThai == 1) { %>
                                <button type="button" class="btn btn-xs" style="background:var(--err-bg);" onclick="doUserAction(<%= maND %>,'lock')">Khóa</button>
                                <% } else { %>
                                <button type="button" class="btn btn-xs btn-success" onclick="doUserAction(<%= maND %>,'unlock')">Mở khóa</button>
                                <% } %>
                            <% } %>
                        </div>
                    </td>
                </tr>
            <% }
            } else { %>
                <tr><td colspan="7" class="empty-state">Không có người dùng nào.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <% if (TotalPages > 1) { %>
    <div class="paging">
        <span class="paging-info"><%= TotalItems %> tài khoản</span>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage - 1 %>)" <%= CurrentPage <= 1 ? "disabled" : "" %>>Trước</button>
        <% for (int pg = 1; pg <= TotalPages; pg++) { %>
        <button type="button" class="page-btn<%= pg == CurrentPage ? " active" : "" %>" onclick="goPage(<%= pg %>)"><%= pg %></button>
        <% } %>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage + 1 %>)" <%= CurrentPage >= TotalPages ? "disabled" : "" %>>Tiếp</button>
    </div>
    <% } %>

    <%-- Modal chi tiết --%>
    <div class="overlay" id="ndDetailOverlay" onclick="if(event.target===this)closeNdDetail()">
        <div class="modal modal-wide">
            <div class="modal-hd">
                <h3>Chi tiết người dùng</h3>
                <button type="button" class="modal-close" onclick="closeNdDetail()">&#10005;</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid" id="ndDetailContent"></div>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeNdDetail()">Đóng</button>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';

        window.goPage = function (p) {
            if (p < 1 || p > <%= TotalPages %>) return;
            document.getElementById('<%= hfPage.ClientID %>').value = p;
            document.getElementById('form1').submit();
        };

        window.setFilter = function (type, val) {
            if (type === 'tt') document.getElementById('<%= hfFilterTT.ClientID %>').value = val;
            else if (type === 'vt') document.getElementById('<%= hfFilterVT.ClientID %>').value = val;
            document.getElementById('<%= hfPage.ClientID %>').value = '1';
            document.getElementById('form1').submit();
        };

        window.doUserAction = function (id, action) {
            var msg = action === 'lock' ? 'Bạn có chắc muốn khóa tài khoản này?' : 'Mở khóa tài khoản này?';
            if (!confirm(msg)) return;
            document.getElementById('<%= hfAction.ClientID %>').value = action;
            document.getElementById('<%= hfParam.ClientID %>').value = id;
            document.getElementById('form1').submit();
        };

        // Modal chi tiết (client-side only)
        window.viewDetail = function (id, hoTen, email, sdt, vaiTro, trangThai, ngayTao, tongQG) {
            var roleLabel = vaiTro === 1 ? 'Quản trị viên' : 'Người dùng';
            var ttLabel = trangThai === 1 ? 'Hoạt động' : 'Đã khóa';
            var html =
                '<div class="detail-item"><label>Mã người dùng</label><span class="detail-val">#' + id + '</span></div>' +
                '<div class="detail-item"><label>Họ tên</label><span class="detail-val">' + esc(hoTen) + '</span></div>' +
                '<div class="detail-item"><label>Email</label><span class="detail-val">' + esc(email || '(không có)') + '</span></div>' +
                '<div class="detail-item"><label>Số điện thoại</label><span class="detail-val">' + esc(sdt || '(không có)') + '</span></div>' +
                '<div class="detail-item"><label>Vai trò</label><span class="detail-val">' + roleLabel + '</span></div>' +
                '<div class="detail-item"><label>Trạng thái</label><span class="detail-val">' + ttLabel + '</span></div>' +
                '<div class="detail-item"><label>Ngày tạo</label><span class="detail-val">' + ngayTao + '</span></div>' +
                '<div class="detail-item"><label>Tổng quyên góp</label><span class="detail-val">' + Number(tongQG).toLocaleString('vi-VN') + ' đ</span></div>';
            document.getElementById('ndDetailContent').innerHTML = html;
            document.getElementById('ndDetailOverlay').classList.add('show');
        };
        window.closeNdDetail = function () {
            document.getElementById('ndDetailOverlay').classList.remove('show');
        };
    })();
</script>

</asp:Content>
