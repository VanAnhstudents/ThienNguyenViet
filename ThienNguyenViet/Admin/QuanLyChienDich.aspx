<%@ Page Title="Quản lý Chiến dịch" Language="C#"
    MasterPageFile="~/Admin.Master" AutoEventWireup="true"
    CodeBehind="QuanLyChienDich.aspx.cs"
    Inherits="ThienNguyenViet.Admin.QuanLyChienDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .page-topbar {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 14px; flex-wrap: wrap; gap: 8px;
    }
    .page-topbar h3 { font-size: 14px; font-weight: 600; }
    .cd-name { font-size: 13px; font-weight: 600; }
    .cd-sub { font-size: 11px; margin-top: 2px; }
    .cd-dm {
        display: inline-block; font-size: 10px; padding: 2px 7px;
        border-radius: 4px; font-weight: 500;
    }
    .cd-amount { font-weight: 600; font-size: 12px; }
    .cd-date { font-size: 11px; white-space: nowrap; }
    .action-group { display: flex; gap: 4px; }
</style>
</asp:Content>

<asp:Content ID="TopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý chiến dịch</h1>
    <p>Danh sách các chiến dịch quyên góp</p>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- === HIDDEN FIELDS CHO POSTBACK === -->
    <asp:HiddenField ID="hfPage" runat="server" Value="1" />
    <asp:HiddenField ID="hfFilterStatus" runat="server" />
    <asp:HiddenField ID="hfFilterDM" runat="server" />
    <asp:HiddenField ID="hfAction" runat="server" />
    <asp:HiddenField ID="hfParam" runat="server" />

    <div class="page-topbar">
        <h3>Tất cả chiến dịch</h3>
        <a href="<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>" class="btn btn-primary">Thêm chiến dịch</a>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Tìm kiếm dùng asp:TextBox + asp:Button postback === --%>
    <div class="filter-bar">
        <div class="search-bar" style="flex:1">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="input" placeholder="Tìm kiếm chiến dịch theo tên..." />
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm" OnClick="BtnSearch_Click" />
            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-outline" Text="Đặt lại" OnClick="BtnReset_Click" />
        </div>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Bộ lọc dùng postback thay vì AJAX === --%>
    <div class="filter-bar">
        <div class="filter-group" id="filterStatus">
            <button type="button" class="filter-btn<%= FilterStatus == "" ? " active" : "" %>" onclick="setFilter('status','')">Tất cả</button>
            <button type="button" class="filter-btn<%= FilterStatus == "0" ? " active" : "" %>" onclick="setFilter('status','0')">Nháp</button>
            <button type="button" class="filter-btn<%= FilterStatus == "1" ? " active" : "" %>" onclick="setFilter('status','1')">Đang chạy</button>
            <button type="button" class="filter-btn<%= FilterStatus == "2" ? " active" : "" %>" onclick="setFilter('status','2')">Kết thúc</button>
        </div>
        <select class="select" id="filterDanhMuc" style="min-width:140px" onchange="setFilter('dm', this.value)">
            <option value="">Tất cả danh mục</option>
            <% if (DtDanhMuc != null) {
                foreach (System.Data.DataRow dm in DtDanhMuc.Rows) { %>
                <option value="<%= dm["MaDanhMuc"] %>" <%= FilterDanhMuc == dm["MaDanhMuc"].ToString() ? "selected" : "" %>><%= Server.HtmlEncode(dm["TenDanhMuc"].ToString()) %></option>
            <% }
            } %>
        </select>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Bảng dữ liệu render server-side === --%>
    <div class="card" style="padding:0">
        <table class="tbl">
            <thead>
                <tr>
                    <th>Tên chiến dịch</th>
                    <th>Danh mục</th>
                    <th>Mục tiêu</th>
                    <th>Đã quyên</th>
                    <th>Tiến độ</th>
                    <th>Kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <% if (DtChienDich != null && DtChienDich.Rows.Count > 0) {
                foreach (System.Data.DataRow r in DtChienDich.Rows) {
                    int maCD = Convert.ToInt32(r["MaChienDich"]);
                    string tenCD = r["TenChienDich"].ToString();
                    string moTa = r["MoTaNgan"] == DBNull.Value ? "" : r["MoTaNgan"].ToString();
                    long mucTieu = Convert.ToInt64(r["MucTieu"]);
                    long daQuyen = Convert.ToInt64(r["SoTienDaQuyen"]);
                    int pct = mucTieu > 0 ? (int)Math.Min(100, Math.Round((double)daQuyen * 100 / mucTieu)) : 0;
                    string ngayKT = Convert.ToDateTime(r["NgayKetThuc"]).ToString("dd/MM/yyyy");
                    int soNgayCon = Convert.ToInt32(r["SoNgayCon"]);
                    int trangThaiCD = Convert.ToInt32(r["TrangThai"]);
                    bool noiBat = r["NoiBat"] != DBNull.Value && Convert.ToBoolean(r["NoiBat"]);
                    string tenDM = r["TenDanhMuc"].ToString();

                    string tsLabel = new[]{"Nháp","Đang chạy","Kết thúc"}[trangThaiCD < 3 ? trangThaiCD : 0];
                    string tsCls = new[]{"badge-warn","badge-ok","badge-info"}[trangThaiCD < 3 ? trangThaiCD : 0];
            %>
                <tr>
                    <td>
                        <div class="cd-name"><%= Server.HtmlEncode(tenCD) %></div>
                        <div class="cd-sub" style="color:var(--txt-sub)"><%= Server.HtmlEncode(moTa) %></div>
                    </td>
                    <td><span class="cd-dm"><%= Server.HtmlEncode(tenDM) %></span></td>
                    <td class="cd-amount"><%= mucTieu.ToString("N0") %></td>
                    <td class="cd-amount"><%= daQuyen.ToString("N0") %></td>
                    <td style="min-width:100px">
                        <div class="prog-wrap"><div class="prog-fill" style="width:<%= pct %>%"></div></div>
                        <div style="font-size:10px;margin-top:3px"><%= pct %>%</div>
                    </td>
                    <td class="cd-date"><%= ngayKT %><% if(soNgayCon > 0) { %> (<%= soNgayCon %> ngày)<% } %></td>
                    <td>
                        <span class="badge <%= tsCls %>"><%= tsLabel %></span>
                        <% if(noiBat) { %><span class="badge badge-info" style="margin-left:3px">Nổi bật</span><% } %>
                    </td>
                    <td>
                        <div class="action-group">
                            <a href="<%= ResolveUrl("~/Admin/FormChienDich.aspx") %>?id=<%= maCD %>" class="btn btn-outline btn-xs">Sửa</a>
                            <button type="button" class="btn btn-xs" style="background:var(--err-bg);" onclick="openDelete(<%= maCD %>,'<%= Server.HtmlEncode(tenCD).Replace("'","\\'") %>')">Xóa</button>
                        </div>
                    </td>
                </tr>
            <% }
            } else { %>
                <tr><td colspan="8" class="empty-state">Không có chiến dịch nào.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <%-- === PHẦN ĐÃ SỬA: Phân trang server-side === --%>
    <% if (TotalPages > 1) { %>
    <div class="paging">
        <span class="paging-info"><%= TotalItems %> kết quả</span>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage - 1 %>)" <%= CurrentPage <= 1 ? "disabled" : "" %>>Trước</button>
        <% for (int pg = 1; pg <= TotalPages; pg++) { %>
        <button type="button" class="page-btn<%= pg == CurrentPage ? " active" : "" %>" onclick="goPage(<%= pg %>)"><%= pg %></button>
        <% } %>
        <button type="button" class="page-btn" onclick="goPage(<%= CurrentPage + 1 %>)" <%= CurrentPage >= TotalPages ? "disabled" : "" %>>Tiếp</button>
    </div>
    <% } %>

    <%-- Modal xóa --%>
    <div class="overlay" id="deleteOverlay" onclick="if(event.target===this)closeDeleteModal()">
        <div class="modal" style="max-width:400px">
            <div class="modal-hd">
                <h3>Xóa chiến dịch</h3>
                <button type="button" class="modal-close" onclick="closeDeleteModal()">&#10005;</button>
            </div>
            <div class="modal-body">
                <p style="font-size:13px">Bạn có chắc chắn muốn xóa chiến dịch "<strong id="delName"></strong>"?</p>
                <p style="font-size:11px;margin-top:6px">Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-ft">
                <button type="button" class="btn btn-outline" onclick="closeDeleteModal()">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="confirmDelete()">Xóa</button>
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

        // Phân trang
        window.goPage = function (p) {
            if (p < 1 || p > <%= TotalPages %>) return;
            document.getElementById('<%= hfPage.ClientID %>').value = p;
            document.getElementById('form1').submit();
        };

        // Filter
        window.setFilter = function (type, val) {
            if (type === 'status') {
                document.getElementById('<%= hfFilterStatus.ClientID %>').value = val;
            } else if (type === 'dm') {
                document.getElementById('<%= hfFilterDM.ClientID %>').value = val;
            }
            document.getElementById('<%= hfPage.ClientID %>').value = '1';
            document.getElementById('form1').submit();
        };

        // Xóa chiến dịch
        window.openDelete = function (id, name) {
            pendingDeleteId = id;
            document.getElementById('delName').textContent = name;
            document.getElementById('deleteOverlay').classList.add('show');
        };
        window.closeDeleteModal = function () {
            document.getElementById('deleteOverlay').classList.remove('show');
        };
        window.confirmDelete = function () {
            if (!pendingDeleteId) return;
            document.getElementById('<%= hfAction.ClientID %>').value = 'delete';
            document.getElementById('<%= hfParam.ClientID %>').value = pendingDeleteId;
            document.getElementById('form1').submit();
        };
    })();
</script>
</asp:Content>
