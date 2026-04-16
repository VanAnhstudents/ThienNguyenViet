<%@ Page Title="Quản lý Tin tức" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyTinTuc.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyTinTuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .tt-stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 18px; text-align: center }
    .tt-stat-card {
        background: var(--card); border: 1px solid var(--border);
        border-radius: var(--r-card); padding: 18px 16px;
        transition: box-shadow .2s;
    }
    .tt-stat-card:hover { box-shadow: 0 2px 12px rgba(49,130,206,.08); }
    .tt-stat-card .stat-card-label {
        font-size: 10px; text-transform: uppercase;
        letter-spacing: .04em; font-weight: 600; margin-bottom: 6px;
    }
    .tt-stat-card .stat-card-value { font-size: 22px; font-weight: 700; }
    .page-topbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 14px; flex-wrap: wrap; gap: 8px;
    }
    .tt-title-cell { font-size: 13px; font-weight: 500; max-width: 300px; }
    .tt-thumb {
        width: 48px; height: 36px; border-radius: 4px;
        object-fit: cover; background: var(--bg); border: 1px solid var(--border);
    }
    .tt-views { font-size: 12px; }
    @media (max-width: 768px) { .tt-stats-row { grid-template-columns: repeat(2,1fr); } }
    @media (max-width: 425px) { .tt-stats-row { grid-template-columns: 1fr 1fr; gap: 8px; } }
    @media (max-width: 375px) { .tt-stats-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý tin tức</h1>
    <p>Quản lý bài viết, tin tức trên hệ thống</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- === HIDDEN FIELDS CHO POSTBACK === -->
    <asp:HiddenField ID="hfPage" runat="server" Value="1" />
    <asp:HiddenField ID="hfFilterTT" runat="server" />
    <asp:HiddenField ID="hfFilterDM" runat="server" />
    <asp:HiddenField ID="hfAction" runat="server" />
    <asp:HiddenField ID="hfParam" runat="server" />

    <%-- === PHẦN ĐÃ SỬA: Thống kê render server-side === --%>
    <div class="tt-stats-row">
        <div class="tt-stat-card">
            <div class="stat-card-label">Tổng bài viết</div>
            <div class="stat-card-value"><%= TongBaiViet %></div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Xuất bản</div>
            <div class="stat-card-value"><%= SoXuatBan %></div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Bản nháp</div>
            <div class="stat-card-value"><%= SoBanNhap %></div>
        </div>
        <div class="tt-stat-card">
            <div class="stat-card-label">Tổng lượt xem</div>
            <div class="stat-card-value"><%= FormatLuotXem(TongLuotXem) %></div>
        </div>
    </div>

    <div class="page-topbar">
        <h3>Danh sách bài viết</h3>
        <a href="<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>" class="btn btn-primary">Thêm bài viết</a>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Tìm kiếm + Đặt lại postback === --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="input" placeholder="Tìm kiếm bài viết theo tiêu đề..." />
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm" OnClick="BtnSearch_Click" />
            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-outline" Text="Đặt lại" OnClick="BtnReset_Click" />
        </div>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Bộ lọc postback === --%>
    <div class="filter-bar">
        <div class="filter-group">
            <button type="button" class="filter-btn<%= FilterTT == "" ? " active" : "" %>" onclick="setFilter('tt','')">Tất cả</button>
            <button type="button" class="filter-btn<%= FilterTT == "1" ? " active" : "" %>" onclick="setFilter('tt','1')">Xuất bản</button>
            <button type="button" class="filter-btn<%= FilterTT == "0" ? " active" : "" %>" onclick="setFilter('tt','0')">Bản nháp</button>
        </div>
        <select class="select" style="min-width:140px" onchange="setFilter('dm', this.value)">
            <option value="">Tất cả danh mục</option>
            <% if (DtDanhMuc != null) {
                foreach (System.Data.DataRow dm in DtDanhMuc.Rows) { %>
                <option value="<%= dm["MaDanhMuc"] %>" <%= FilterDM == dm["MaDanhMuc"].ToString() ? "selected" : "" %>><%= Server.HtmlEncode(dm["TenDanhMuc"].ToString()) %></option>
            <% }
            } %>
        </select>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Bảng dữ liệu render server-side === --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Ảnh</th><th>Tiêu đề</th><th>Người đăng</th>
                    <th>Ngày đăng</th><th>Lượt xem</th><th>Trạng thái</th><th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <% if (DtTinTuc != null && DtTinTuc.Rows.Count > 0) {
                foreach (System.Data.DataRow r in DtTinTuc.Rows) {
                    int maTT = Convert.ToInt32(r["MaTinTuc"]);
                    string tieuDe = r["TieuDe"].ToString();
                    string anhBia = r["AnhBia"] == DBNull.Value ? "" : r["AnhBia"].ToString();
                    int luotXem = Convert.ToInt32(r["LuotXem"]);
                    int trangThai = Convert.ToInt32(r["TrangThai"]);
                    string ngayDang = r["NgayDang"].ToString();
                    string nguoiDang = r["NguoiDang"].ToString();

                    string tsLabel = trangThai == 1 ? "Xuất bản" : "Bản nháp";
                    string tsCls = trangThai == 1 ? "badge-ok" : "badge-warn";
            %>
                <tr>
                    <td>
                        <% if (!string.IsNullOrEmpty(anhBia)) { %>
                        <img class="tt-thumb" src="<%= anhBia %>" onerror="this.style.display='none'" />
                        <% } else { %>
                        <div class="tt-thumb" style="display:flex;align-items:center;justify-content:center;font-size:9px;">N/A</div>
                        <% } %>
                    </td>
                    <td><div class="tt-title-cell"><%= Server.HtmlEncode(tieuDe) %></div></td>
                    <td style="font-size:12px"><%= Server.HtmlEncode(nguoiDang) %></td>
                    <td style="font-size:11px;white-space:nowrap"><%= ngayDang %></td>
                    <td class="tt-views"><%= luotXem.ToString("N0") %></td>
                    <td><span class="badge <%= tsCls %>"><%= tsLabel %></span></td>
                    <td>
                        <div style="display:flex;gap:4px">
                            <a href="<%= ResolveUrl("~/Admin/FormTinTuc.aspx") %>?id=<%= maTT %>" class="btn btn-xs btn-outline">Sửa</a>
                            <button type="button" class="btn btn-xs btn-outline" onclick="doAction(<%= maTT %>,'toggle')"><%= trangThai == 1 ? "Ẩn" : "Hiện" %></button>
                            <button type="button" class="btn btn-xs" style="background:var(--err-bg)" onclick="openXoa(<%= maTT %>,'<%= Server.HtmlEncode(tieuDe).Replace("'","\\'") %>')">Xóa</button>
                        </div>
                    </td>
                </tr>
            <% }
            } else { %>
                <tr><td colspan="7" class="empty-state">Không có bài viết nào.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Phân trang server-side === --%>
    <% if (TotalPages > 1) { %>
    <div class="paging">
        <span class="paging-info"><%= TotalItems %> bài viết</span>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage - 1 %>)" <%= CurrentPage <= 1 ? "disabled" : "" %>>Trước</button>
        <% for (int pg = 1; pg <= TotalPages; pg++) { %>
        <button type="button" class="page-btn<%= pg == CurrentPage ? " active" : "" %>" onclick="goPage(<%= pg %>)"><%= pg %></button>
        <% } %>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage + 1 %>)" <%= CurrentPage >= TotalPages ? "disabled" : "" %>>Tiếp</button>
    </div>
    <% } %>

    <%-- Modal xóa --%>
    <div class="overlay" id="modalXoa" onclick="if(event.target===this)closeModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xóa bài viết</h3>
                <button type="button" class="modal-close" onclick="closeModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Bạn có chắc chắn muốn xóa bài viết "<strong id="xoa-title"></strong>"?</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeModal()">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="confirmXoa()">Xóa</button>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';
        var pendingDeleteId = 0;

        // === PHẦN ĐÃ SỬA: Postback thay vì AJAX ===

        window.goPage = function (p) {
            if (p < 1 || p > <%= TotalPages %>) return;
            document.getElementById('<%= hfPage.ClientID %>').value = p;
            document.getElementById('form1').submit();
        };

        window.setFilter = function (type, val) {
            if (type === 'tt') document.getElementById('<%= hfFilterTT.ClientID %>').value = val;
            else if (type === 'dm') document.getElementById('<%= hfFilterDM.ClientID %>').value = val;
            document.getElementById('<%= hfPage.ClientID %>').value = '1';
            document.getElementById('form1').submit();
        };

        window.doAction = function (id, action) {
            document.getElementById('<%= hfAction.ClientID %>').value = action;
            document.getElementById('<%= hfParam.ClientID %>').value = id;
            document.getElementById('form1').submit();
        };

        // Xóa
        window.openXoa = function (id, title) {
            pendingDeleteId = id;
            document.getElementById('xoa-title').textContent = title.length > 50 ? title.substring(0, 50) + '...' : title;
            document.getElementById('modalXoa').classList.add('show');
        };
        window.confirmXoa = function () {
            if (!pendingDeleteId) return;
            document.getElementById('<%= hfAction.ClientID %>').value = 'delete';
            document.getElementById('<%= hfParam.ClientID %>').value = pendingDeleteId;
            document.getElementById('form1').submit();
        };
        window.closeModal = function () {
            document.getElementById('modalXoa').classList.remove('show');
        };
    })();
</script>
</asp:Content>
