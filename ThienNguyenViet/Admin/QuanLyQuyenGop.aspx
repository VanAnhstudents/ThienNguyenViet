<%@ Page Title="Quản lý Quyên góp" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyQuyenGop.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyQuyenGop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ── Stat cards ──────────────────────────────────────────── */
.qg-stat-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 12px;
    margin-bottom: 18px;
}
.qg-stat-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: var(--r-card);
    padding: 14px 16px;
    display: flex;
    align-items: center;
    gap: 12px;
}
.qg-stat-icon {
    width: 38px; height: 38px;
    border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    font-size: 17px;
    flex-shrink: 0;
}
.qg-stat-info strong {
    display: block;
    font-size: 18px;
    font-weight: 700;
    line-height: 1.1;
}
.qg-stat-info span {
    font-size: 10px;
    color: var(--txt-sub);
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: .03em;
}

/* ── Toolbar ─────────────────────────────────────────────── */
.qg-toolbar {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: var(--r-card);
    padding: 12px 16px;
    margin-bottom: 14px;
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}
.qg-tab-group {
    display: flex;
    gap: 4px;
    margin-right: 4px;
}
.qg-tab {
    padding: 5px 12px;
    border-radius: var(--r);
    border: 1px solid var(--border);
    background: transparent;
    font-family: var(--font);
    font-size: 12px;
    color: var(--txt-sub);
    cursor: pointer;
    transition: all .15s;
    white-space: nowrap;
}
.qg-tab:hover   { background: var(--bg); color: var(--txt); }
.qg-tab.active  { background: var(--accent); color: #fff; border-color: var(--accent); font-weight: 600; }
.qg-tab .cnt {
    display: inline-block;
    margin-left: 5px;
    background: rgba(255,255,255,.25);
    border-radius: 99px;
    padding: 0 6px;
    font-size: 10px;
    font-weight: 700;
}
.qg-tab:not(.active) .cnt {
    background: var(--border);
    color: var(--txt-sub);
}
.qg-divider { width: 1px; height: 24px; background: var(--border); }
.qg-search {
    flex: 1; min-width: 180px; max-width: 280px;
    height: 30px;
    border: 1px solid var(--border);
    border-radius: var(--r);
    padding: 0 10px;
    font-family: var(--font);
    font-size: 12px;
    color: var(--txt);
    background: var(--bg);
}
.qg-search:focus { outline: none; border-color: var(--accent); background: var(--card); }
.qg-select {
    height: 30px;
    border: 1px solid var(--border);
    border-radius: var(--r);
    padding: 0 8px;
    font-family: var(--font);
    font-size: 12px;
    color: var(--txt);
    background: var(--bg);
    cursor: pointer;
}
.qg-select:focus { outline: none; border-color: var(--accent); }
.qg-btn-reset {
    height: 30px; padding: 0 12px;
    background: transparent; color: var(--txt-sub);
    border: 1px solid var(--border); border-radius: var(--r);
    font-family: var(--font); font-size: 12px;
    cursor: pointer;
}
.qg-btn-reset:hover { background: var(--bg); color: var(--txt); }

/* ── Table card ──────────────────────────────────────────── */
.qg-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: var(--r-card);
    overflow: hidden;
}
.qg-card-hd {
    display: flex; justify-content: space-between; align-items: center;
    padding: 13px 18px;
    border-bottom: 1px solid var(--border);
}
.qg-card-hd-title { font-size: 13px; font-weight: 600; }
.qg-count-label   { font-size: 11px; color: var(--txt-sub); }

/* Loading overlay */
.qg-table-wrap { position: relative; min-height: 200px; }
.qg-loading {
    position: absolute; inset: 0;
    background: rgba(255,255,255,.7);
    display: flex; align-items: center; justify-content: center;
    z-index: 10; font-size: 12px; color: var(--txt-sub);
}
.qg-spinner {
    width: 20px; height: 20px;
    border: 2px solid var(--border);
    border-top-color: var(--accent);
    border-radius: 50%;
    animation: spin .6s linear infinite;
    margin-right: 8px;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* Table */
.qg-table { width: 100%; border-collapse: collapse; font-size: 12px; }
.qg-table thead tr { background: var(--thead); }
.qg-table thead th {
    padding: 8px 12px;
    font-size: 10px; font-weight: 600;
    color: var(--txt-sub);
    text-transform: uppercase; letter-spacing: .05em;
    text-align: left;
    border-bottom: 1px solid var(--border);
    white-space: nowrap;
}
.qg-table tbody td {
    padding: 9px 12px;
    border-bottom: 1px solid var(--border);
    vertical-align: middle;
}
.qg-table tbody tr:last-child td { border-bottom: none; }
.qg-table tbody tr:hover { background: var(--accent-light); }

/* Donor cell */
.qg-donor { display: flex; align-items: center; gap: 7px; }
.qg-av {
    width: 28px; height: 28px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 10px; font-weight: 700; flex-shrink: 0;
    background: var(--stat-blue-bg); color: var(--stat-blue);
}
.qg-donor-name  { font-size: 12px; font-weight: 500; }
.qg-donor-email { font-size: 10px; color: var(--txt-sub); }

/* Campaign cell */
.qg-cd-name {
    font-size: 12px; font-weight: 500;
    max-width: 200px; white-space: nowrap;
    overflow: hidden; text-overflow: ellipsis;
}

/* Amount */
.qg-amount { color: var(--ok); font-weight: 600; font-size: 12px; white-space: nowrap; }

/* Lời nhắn */
.qg-msg {
    max-width: 160px; font-size: 11px; color: var(--txt-sub);
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    font-style: italic;
}

/* Reject reason */
.qg-reject-reason {
    max-width: 160px; font-size: 10px; color: var(--err-txt);
    background: var(--err-bg); border-radius: 4px;
    padding: 2px 6px; margin-top: 3px;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

/* Actions */
.qg-actions { display: flex; gap: 4px; flex-wrap: nowrap; }
.qg-btn-approve {
    padding: 3px 9px; font-size: 11px;
    background: var(--ok-bg); color: var(--ok-txt);
    border: none; border-radius: var(--r);
    cursor: pointer; font-family: var(--font); font-weight: 500;
    white-space: nowrap;
}
.qg-btn-approve:hover { background: #9ae6b4; }
.qg-btn-reject {
    padding: 3px 9px; font-size: 11px;
    background: var(--err-bg); color: var(--err-txt);
    border: none; border-radius: var(--r);
    cursor: pointer; font-family: var(--font); font-weight: 500;
    white-space: nowrap;
}
.qg-btn-reject:hover { background: #feb2b2; }
.qg-btn-view {
    padding: 3px 9px; font-size: 11px;
    background: var(--info-bg); color: var(--info-txt);
    border: none; border-radius: var(--r);
    cursor: pointer; font-family: var(--font);
    white-space: nowrap;
}
.qg-btn-view:hover { background: #90cdf4; }

/* Empty state */
.qg-empty {
    padding: 40px 20px; text-align: center;
    color: var(--txt-sub); font-size: 12px;
}
.qg-empty-icon { font-size: 28px; margin-bottom: 8px; }

/* Pagination */
.qg-paging {
    display: flex; justify-content: center; align-items: center;
    gap: 15px;
    padding: 14px 16px;
    border-top: 1px solid var(--border);
    font-size: 13px; color: var(--txt-sub);
}
.qg-paging-btns { display: flex; align-items: center; gap: 6px; }
.qg-page-btn {
    min-width: 38px; height: 38px; padding: 0 12px;
    border: 1px solid var(--border); border-radius: 8px;
    background: var(--card); font-family: var(--font); font-size: 13px;
    font-weight: 500; color: var(--txt); cursor: pointer;
}
.qg-page-btn:hover   { background: var(--bg); border-color: #cbd5e1; }
.qg-page-btn.active  { background: var(--accent); color: #fff; border-color: var(--accent); font-weight: 600; }
.qg-page-btn:disabled{ opacity: .4; cursor: not-allowed; pointer-events: none; }

/* ── Modal ───────────────────────────────────────────────── */
.qg-overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.35); z-index: 200;
    align-items: center; justify-content: center;
}
.qg-overlay.show { display: flex; }
.qg-modal {
    background: var(--card);
    border-radius: var(--r-card);
    border: 1px solid var(--border);
    width: 90%; max-width: 520px;
    max-height: 90vh; overflow-y: auto;
    box-shadow: 0 8px 32px rgba(0,0,0,.15);
}
.qg-modal-wide { max-width: 680px; }
.qg-modal-hd {
    display: flex; justify-content: space-between; align-items: center;
    padding: 14px 18px;
    border-bottom: 1px solid var(--border);
}
.qg-modal-hd h3 { font-size: 14px; font-weight: 600; }
.qg-modal-close {
    background: none; border: none; font-size: 16px;
    color: var(--txt-sub); cursor: pointer; line-height: 1;
    padding: 2px 4px;
}
.qg-modal-close:hover { color: var(--txt); }
.qg-modal-body { padding: 18px; }
.qg-modal-ft {
    padding: 12px 18px;
    border-top: 1px solid var(--border);
    display: flex; justify-content: flex-end; gap: 8px;
}

/* Detail grid */
.qg-detail-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
}
.qg-detail-full { grid-column: 1 / -1; }
.qg-detail-item label {
    display: block; font-size: 10px; font-weight: 600;
    color: var(--txt-sub); text-transform: uppercase;
    letter-spacing: .04em; margin-bottom: 3px;
}
.qg-detail-val { font-size: 13px; color: var(--txt); }

/* Reject modal textarea */
.qg-form-group { margin-bottom: 0; }
.qg-form-label { display: block; font-size: 12px; font-weight: 500; margin-bottom: 6px; }
.qg-textarea {
    width: 100%; padding: 8px 10px;
    border: 1px solid var(--border); border-radius: var(--r);
    font-family: var(--font); font-size: 12px;
    resize: vertical; min-height: 80px;
    color: var(--txt);
}
.qg-textarea:focus { outline: none; border-color: var(--accent); }
.qg-textarea.err  { border-color: var(--err); }

.qg-confirm-msg {
    font-size: 13px; color: var(--txt);
    margin-bottom: 6px;
}
.qg-confirm-sub {
    font-size: 12px; color: var(--txt-sub);
    margin-bottom: 14px;
}

/* Buttons in modal footer */
.qg-btn-yes {
    padding: 7px 16px; font-size: 12px; font-weight: 500;
    background: var(--accent); color: #fff;
    border: none; border-radius: var(--r);
    cursor: pointer; font-family: var(--font);
}
.qg-btn-yes.danger { background: var(--err); }
.qg-btn-yes:hover  { opacity: .9; }
.qg-btn-cancel {
    padding: 6px 14px; font-size: 12px;
    background: transparent; color: var(--txt-sub);
    border: 1px solid var(--border); border-radius: var(--r);
    cursor: pointer; font-family: var(--font);
}
.qg-btn-cancel:hover { background: var(--bg); }

/* Proof image */
.qg-proof-wrap {
    margin-top: 6px;
    border: 1px solid var(--border); border-radius: var(--r);
    padding: 10px; min-height: 80px;
    display: flex; align-items: center; justify-content: center;
    background: var(--bg); color: var(--txt-sub); font-size: 12px;
}
.qg-proof-wrap img {
    max-width: 100%; max-height: 260px;
    border-radius: var(--r); object-fit: contain;
}
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Quyên góp</h1>
    <p>Duyệt và theo dõi toàn bộ giao dịch quyên góp</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- ── Stat Cards ──────────────────────────────────────── --%>
    <div class="qg-stat-grid" id="statGrid">
        <%-- Render từ server-side data --%>
        <div class="qg-stat-card">
            <div class="qg-stat-info">
                <strong id="sc-total" style="color:var(--stat-blue)"><%= TongGiaoDich %></strong>
                <span>Tổng giao dịch</span>
            </div>
        </div>
        <div class="qg-stat-card">
            <div class="qg-stat-info">
                <strong id="sc-wait" style="color:var(--warn)"><%= SoChoDuyet %></strong>
                <span>Chờ duyệt</span>
            </div>
        </div>
        <div class="qg-stat-card">
            <div class="qg-stat-info">
                <strong id="sc-ok" style="color:var(--ok)"><%= SoDaDuyet %></strong>
                <span>Đã duyệt</span>
            </div>
        </div>
        <div class="qg-stat-card">
            <div class="qg-stat-info">
                <strong id="sc-reject" style="color:var(--err)"><%= SoTuChoi %></strong>
                <span>Từ chối</span>
            </div>
        </div>
        <div class="qg-stat-card">
            <div class="qg-stat-info">
                <strong id="sc-money" style="color:var(--stat-purple)"><%= FormatTien(TongTienDaDuyet) %></strong>
                <span>Tổng đã duyệt</span>
            </div>
        </div>
    </div>

    <%-- ── Toolbar: tab + tìm kiếm ────────────────────────── --%>
    <div class="qg-toolbar">
        <div class="qg-tab-group">
            <button type="button" class="qg-tab active" data-tab="" onclick="switchTab(this,'')">
                Tất cả <span class="cnt" id="cnt-all"><%= TongGiaoDich %></span>
            </button>
            <button type="button" class="qg-tab" data-tab="0" onclick="switchTab(this,'0')">
                Chờ duyệt <span class="cnt" id="cnt-0"><%= SoChoDuyet %></span>
            </button>
            <button type="button" class="qg-tab" data-tab="1" onclick="switchTab(this,'1')">
                Đã duyệt <span class="cnt" id="cnt-1"><%= SoDaDuyet %></span>
            </button>
            <button type="button" class="qg-tab" data-tab="2" onclick="switchTab(this,'2')">
                Từ chối <span class="cnt" id="cnt-2"><%= SoTuChoi %></span>
            </button>
        </div>

        <div class="qg-divider"></div>

        <input type="text" id="qgSearch" class="qg-search"
               placeholder="Tìm theo tên, chiến dịch..." />

        <select id="qgChienDich" class="qg-select">
            <option value="">Tất cả chiến dịch</option>
            <% if (DtChienDich != null) {
                   foreach (System.Data.DataRow r in DtChienDich.Rows) { %>
            <option value="<%= r["MaChienDich"] %>"><%= Server.HtmlEncode(r["TenChienDich"].ToString()) %></option>
            <%     }
               } %>
        </select>

        <button type="button" class="qg-btn-reset"  onclick="doReset()">Đặt lại</button>
    </div>

    <%-- ── Bảng dữ liệu ────────────────────────────────────── --%>
    <div class="qg-card">
        <div class="qg-card-hd">
            <span class="qg-card-hd-title">Danh sách giao dịch</span>
            <span class="qg-count-label" id="countLabel"></span>
        </div>

        <div class="qg-table-wrap">
            <%-- Loading spinner --%>
            <div class="qg-loading" id="tblLoading" style="display:none">
                <div class="qg-spinner"></div> Đang tải...
            </div>

            <table class="qg-table">
                <thead>
                    <tr>
                        <th style="width:54px">Mã GD</th>
                        <th style="width:18%">Người quyên góp</th>
                        <th style="width:22%">Chiến dịch</th>
                        <th>Số tiền</th>
                        <th>Lời nhắn</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                        <th style="text-align:center">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="qgTableBody"></tbody>
            </table>

            <div id="qgEmpty" class="qg-empty" style="display:none">
                <p>Không có giao dịch nào phù hợp.</p>
            </div>
        </div>

        <div class="qg-paging" id="qgPaging" style="display:none">
            <span id="qgPagingInfo"></span>
            <div class="qg-paging-btns" id="qgPagingBtns"></div>
        </div>
    </div>

    <%-- ════ MODAL CHI TIẾT ════ --%>
    <div class="qg-overlay" id="modalDetail" onclick="closeOverlay(event,'modalDetail')">
        <div class="qg-modal qg-modal-wide">
            <div class="qg-modal-hd">
                <h3>Chi tiết giao dịch</h3>
                <button type="button" class="qg-modal-close" onclick="closeModal('modalDetail')">✕</button>
            </div>
            <div class="qg-modal-body">
                <div class="qg-detail-grid">
                    <div class="qg-detail-item">
                        <label>Mã giao dịch</label>
                        <span class="qg-detail-val" id="d-id"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Ngày tạo</label>
                        <span class="qg-detail-val" id="d-ngay"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Người quyên góp</label>
                        <span class="qg-detail-val" id="d-nguoi"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Email</label>
                        <span class="qg-detail-val" id="d-email"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Chiến dịch</label>
                        <span class="qg-detail-val" id="d-cd"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Số tiền</label>
                        <span class="qg-detail-val" id="d-sotien"
                              style="font-size:15px;font-weight:700;color:var(--ok)"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Trạng thái</label>
                        <span class="qg-detail-val" id="d-tt"></span>
                    </div>
                    <div class="qg-detail-item">
                        <label>Ẩn danh</label>
                        <span class="qg-detail-val" id="d-andanh"></span>
                    </div>
                    <div class="qg-detail-item qg-detail-full">
                        <label>Lời nhắn</label>
                        <span class="qg-detail-val" id="d-loinhan"
                              style="font-style:italic;color:var(--txt-sub)"></span>
                    </div>
                    <div class="qg-detail-item qg-detail-full" id="d-lydo-row" style="display:none">
                        <label>Lý do từ chối</label>
                        <span class="qg-detail-val" id="d-lydo" style="color:var(--err-txt)"></span>
                    </div>
                    <div class="qg-detail-item qg-detail-full">
                        <label>Ảnh xác nhận chuyển khoản</label>
                        <div class="qg-proof-wrap" id="d-anh"></div>
                    </div>
                </div>
            </div>
            <div class="qg-modal-ft" id="detailFooter"></div>
        </div>
    </div>

    <%-- ════ MODAL DUYỆT ════ --%>
    <div class="qg-overlay" id="modalApprove" onclick="closeOverlay(event,'modalApprove')">
        <div class="qg-modal">
            <div class="qg-modal-hd">
                <h3>Duyệt giao dịch</h3>
                <button type="button" class="qg-modal-close" onclick="closeModal('modalApprove')">✕</button>
            </div>
            <div class="qg-modal-body">
                <div class="qg-confirm-msg">Duyệt giao dịch <strong id="a-id"></strong>?</div>
                <div class="qg-confirm-sub" id="a-sub"></div>
            </div>
            <div class="qg-modal-ft">
                <button type="button" class="qg-btn-yes" onclick="confirmApprove()">Xác nhận duyệt</button>
                <button type="button" class="qg-btn-cancel" onclick="closeModal('modalApprove')">Hủy</button>
            </div>
        </div>
    </div>

    <%-- ════ MODAL TỪ CHỐI ════ --%>
    <div class="qg-overlay" id="modalReject" onclick="closeOverlay(event,'modalReject')">
        <div class="qg-modal">
            <div class="qg-modal-hd">
                <h3>Từ chối giao dịch</h3>
                <button type="button" class="qg-modal-close" onclick="closeModal('modalReject')">✕</button>
            </div>
            <div class="qg-modal-body">
                <div class="qg-confirm-msg">Từ chối giao dịch <strong id="r-id"></strong>?</div>
                <div class="qg-confirm-sub" style="margin-bottom:14px">
                    Số tiền sẽ <strong>không</strong> được cộng vào chiến dịch.
                </div>
                <div class="qg-form-group">
                    <label class="qg-form-label">
                        Lý do từ chối <span style="color:var(--err)">*</span>
                    </label>
                    <textarea id="txtLyDo" class="qg-textarea"
                              placeholder="VD: Ảnh xác nhận không hợp lệ, trùng giao dịch..."></textarea>
                </div>
            </div>
            <div class="qg-modal-ft">
                <button type="button" class="qg-btn-yes danger" onclick="confirmReject()">Xác nhận từ chối</button>
                <button type="button" class="qg-btn-cancel" onclick="closeModal('modalReject')">Hủy</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    (function () {
        'use strict';

        var API = '<%= ResolveUrl("~/Admin/QuanLyQuyenGop.aspx") %>';

    /* ── State ───────────────────────────────────────────────── */
    var state = {
        tab:    '',
        q:      '',
        cd:     '',
        page:   1
    };
    var pendingApproveId = null;
    var pendingRejectId  = null;
    var rows = [];   // cache trang hiện tại để openDetail
    var searchTimeout = null;

    /* ── Helpers ─────────────────────────────────────────────── */
    var AV_COLORS = [
        {bg:'#EBF8FF',c:'#2B6CB0'},{bg:'#E9D8FD',c:'#6B46C1'},
        {bg:'#C6F6D5',c:'#276749'},{bg:'#FEEBC8',c:'#C05621'},
        {bg:'#FED7D7',c:'#C53030'},{bg:'#E6FFFA',c:'#285E61'},
        {bg:'#FEFCBF',c:'#744210'},{bg:'#F0FFF4',c:'#22543D'}
    ];
    function avColor(id) {
        return AV_COLORS[((id || 1) - 1) % AV_COLORS.length];
    }
    function initials(name) {
        if (!name || name === 'Ẩn danh') return '?';
        var p = name.trim().split(' ');
        if (p.length === 1) return p[0][0].toUpperCase();
        return (p[p.length - 2][0] + p[p.length - 1][0]).toUpperCase();
    }
    function fmtMoney(n) {
        if (!n) return '0 đ';
        n = parseInt(n);
        if (n >= 1e9) return (n / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ';
        if (n >= 1e6) return (n / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ';
        return n.toLocaleString('vi-VN') + ' đ';
    }
    function badgeHtml(ts) {
        var map = {
            0: ['badge badge-wait',   'Chờ duyệt'],
            1: ['badge badge-ok',     'Đã duyệt'],
            2: ['badge badge-reject', 'Từ chối']
        };
        var b = map[ts] || ['badge', '—'];
        return '<span class="' + b[0] + '">' + b[1] + '</span>';
    }
    function escHtml(s) {
        if (!s) return '';
        return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')
                .replace(/"/g,'&quot;');
    }

    /* ── Fetch list ──────────────────────────────────────────── */
    function fetchList() {
        showLoading(true);

        var params = new URLSearchParams();
        params.append('__ajax',  'true');
        params.append('action',  'list');
        params.append('tab',     state.tab);
        params.append('q',       state.q);
        params.append('cd',      state.cd);
        params.append('page',    state.page);

        fetch(API, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        })
        .then(function (r) { return r.json(); })
        .then(function (d) {
            showLoading(false);
            if (d.ok) renderTable(d);
            else admToast('Lỗi', d.msg, 'err');
        })
        .catch(function () {
            showLoading(false);
            admToast('Lỗi kết nối', 'Không thể tải dữ liệu.', 'err');
        });
    }

    function showLoading(on) {
        document.getElementById('tblLoading').style.display = on ? 'flex' : 'none';
    }

    /* ── Render table ────────────────────────────────────────── */
    function renderTable(d) {
        rows = d.rows || [];
        var tbody   = document.getElementById('qgTableBody');
        var empty   = document.getElementById('qgEmpty');
        var paging  = document.getElementById('qgPaging');
        var countEl = document.getElementById('countLabel');

        if (!rows.length) {
            tbody.innerHTML  = '';
            empty.style.display  = 'block';
            paging.style.display = 'none';
            countEl.textContent  = '0 giao dịch';
            return;
        }

        empty.style.display  = 'none';
        paging.style.display = 'flex';

        var from = (d.page - 1) * d.pageSize + 1;
        var to   = Math.min(d.page * d.pageSize, d.total);
        countEl.textContent = 'Hiển thị ' + from + '–' + to + ' / ' + d.total + ' giao dịch';

        var html = '';
        rows.forEach(function (r) {
            var avC  = avColor(r.id);
            var inits = initials(r.hoTen);
            var tsInt = parseInt(r.trangThai);

            var lyDoEl = '';
            if (tsInt === 2 && r.lyDo) {
                lyDoEl = '<div class="qg-reject-reason" title="' + escHtml(r.lyDo) + '">' +
                         escHtml(r.lyDo) + '</div>';
            }

            var actions = '';
            if (tsInt === 0) {
                actions =
                    '<button type="button" class="qg-btn-approve" onclick="openApprove(' + r.id + ')">Duyệt</button>' +
                    '<button type="button" class="qg-btn-reject"  onclick="openReject('  + r.id + ')">Từ chối</button>';
            } else {
                actions = '<button type="button" class="qg-btn-view" onclick="openDetail(' + r.id + ')">Xem</button>';
            }

            html +=
                '<tr id="qg-' + r.id + '">' +
                '<td><code style="font-size:11px;color:var(--txt-sub)">#' + r.id + '</code></td>' +
                '<td>' +
                    '<div class="qg-donor">' +
                    '<div class="qg-av" style="background:' + avC.bg + ';color:' + avC.c + '">' + escHtml(inits) + '</div>' +
                    '<div>' +
                    '<div class="qg-donor-name">' + escHtml(r.hoTen) +
                        (r.anDanh ? ' <span style="font-size:10px;color:var(--txt-sub)">(ẩn danh)</span>' : '') +
                    '</div>' +
                    '<div class="qg-donor-email">' + escHtml(r.email || '—') + '</div>' +
                    '</div></div>' +
                '</td>' +
                '<td>' +
                    '<div class="qg-cd-name" title="' + escHtml(r.tenCD) + '">' + escHtml(r.tenCD) + '</div>' +
                '</td>' +
                '<td class="qg-amount">' + fmtMoney(r.soTien) + '</td>' +
                '<td>' +
                    (r.loiNhan
                        ? '<div class="qg-msg" title="' + escHtml(r.loiNhan) + '">"' + escHtml(r.loiNhan) + '"</div>'
                        : '<span style="color:var(--txt-sub);font-size:11px">—</span>') +
                '</td>' +
                '<td style="white-space:nowrap;font-size:11px;color:var(--txt-sub)">' + escHtml(r.ngayTao) + '</td>' +
                '<td>' + badgeHtml(tsInt) + lyDoEl + '</td>' +
                '<td><div class="qg-actions">' + actions + '</div></td>' +
                '</tr>';
        });
        tbody.innerHTML = html;

        renderPaging(d.total, d.pageSize, d.page);
    }

    function renderPaging(total, pageSize, current) {
        var totalPages = Math.ceil(total / pageSize);
        var paging = document.getElementById('qgPaging');
        var info   = document.getElementById('qgPagingInfo');
        var btns   = document.getElementById('qgPagingBtns');

        if (totalPages <= 1) {
            paging.style.display = 'none';
            return;
        }

        paging.style.display = 'flex';
        info.innerHTML = 'Trang <strong>' + current + '</strong> / ' + totalPages;

        btns.innerHTML = '';

        // Nút Trước
        var prev = document.createElement('button');
        prev.type = 'button';
        prev.className = 'qg-page-btn';
        prev.innerHTML = '&laquo; Trước';
        prev.disabled = current === 1;
        prev.onclick = function () { changePage(current - 1); };
        btns.appendChild(prev);

        // Số trang (tối đa 7 nút — theo QuanLyChienDich)
        var maxVisible = 7;
        var start = Math.max(1, current - Math.floor(maxVisible / 2));
        var end   = Math.min(totalPages, start + maxVisible - 1);
        if (end - start < maxVisible - 1) start = Math.max(1, end - maxVisible + 1);

        for (var p = start; p <= end; p++) {
            (function(page) {
                var btn = document.createElement('button');
                btn.type = 'button';
                btn.className = 'qg-page-btn' + (page === current ? ' active' : '');
                btn.textContent = page;
                btn.onclick = function () { changePage(page); };
                btns.appendChild(btn);
            })(p);
        }

        // Nút Sau
        var next = document.createElement('button');
        next.type = 'button';
        next.className = 'qg-page-btn';
        next.innerHTML = 'Sau &raquo;';
        next.disabled = current === totalPages;
        next.onclick = function () { changePage(current + 1); };
        btns.appendChild(next);
    }

    /* ── Tab + filter ────────────────────────────────────────── */
    window.switchTab = function (btn, tab) {
        document.querySelectorAll('.qg-tab').forEach(function (b) { b.classList.remove('active'); });
        btn.classList.add('active');
        state.tab  = tab;
        state.page = 1;
        fetchList();
    };

    window.doReset = function () {
        document.getElementById('qgSearch').value    = '';
        document.getElementById('qgChienDich').value = '';
        state.q    = '';
        state.cd   = '';
        state.page = 1;
        fetchList();
    };

    window.changePage = function (p) {
        state.page = p;
        fetchList();
    };

    /* ── Init events: debounce search + change on select ──────── */
    (function initEvents() {
        var searchEl = document.getElementById('qgSearch');
        var selCD    = document.getElementById('qgChienDich');

        // Debounce 400ms — gõ là lọc, không cần bấm nút
        searchEl.addEventListener('input', function () {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(function () {
                state.q    = searchEl.value.trim();
                state.page = 1;
                fetchList();
            }, 400);
        });
        // Enter tìm ngay
        searchEl.addEventListener('keypress', function (e) {
            if (e.key !== 'Enter') return;
            clearTimeout(searchTimeout);
            state.q    = searchEl.value.trim();
            state.page = 1;
            fetchList();
        });

        // Chọn chiến dịch → lọc ngay (không cần debounce)
        selCD.addEventListener('change', function () {
            state.cd   = selCD.value;
            state.page = 1;
            fetchList();
        });
    })();

    /* ── Modal: Duyệt ────────────────────────────────────────── */
    window.openApprove = function (id) {
        var r = rows.find(function (x) { return x.id === id; });
        if (!r) return;
        pendingApproveId = id;
        document.getElementById('a-id').textContent  = '#' + id;
        document.getElementById('a-sub').innerHTML   =
            'Số tiền <strong style="color:var(--ok)">' + fmtMoney(r.soTien) + '</strong>' +
            ' từ <strong>' + escHtml(r.hoTen) + '</strong>' +
            ' sẽ được cộng vào chiến dịch <strong>' + escHtml(r.tenCD) + '</strong>.';
        openModal('modalApprove');
    };

    window.confirmApprove = function () {
        closeModal('modalApprove');
        postAction('duyet', pendingApproveId, null);
    };

    /* ── Modal: Từ chối ──────────────────────────────────────── */
    window.openReject = function (id) {
        pendingRejectId = id;
        document.getElementById('r-id').textContent = '#' + id;
        document.getElementById('txtLyDo').value    = '';
        document.getElementById('txtLyDo').classList.remove('err');
        openModal('modalReject');
    };

    window.confirmReject = function () {
        var lyDo = document.getElementById('txtLyDo').value.trim();
        if (!lyDo) {
            document.getElementById('txtLyDo').classList.add('err');
            document.getElementById('txtLyDo').focus();
            return;
        }
        document.getElementById('txtLyDo').classList.remove('err');
        closeModal('modalReject');
        postAction('tuchoi', pendingRejectId, lyDo);
    };

    /* ── Modal: Chi tiết ─────────────────────────────────────── */
    window.openDetail = function (id) {
        var r = rows.find(function (x) { return x.id === id; });
        if (!r) return;

        document.getElementById('d-id').textContent     = '#' + r.id;
        document.getElementById('d-ngay').textContent   = r.ngayTao +
            (r.ngayDuyet ? ' · duyệt: ' + r.ngayDuyet : '');
        document.getElementById('d-nguoi').textContent  = r.hoTen;
        document.getElementById('d-email').textContent  = r.email || '—';
        document.getElementById('d-cd').textContent     = r.tenCD;
        document.getElementById('d-sotien').textContent = fmtMoney(r.soTien);
        document.getElementById('d-tt').innerHTML       = badgeHtml(parseInt(r.trangThai));
        document.getElementById('d-andanh').textContent = r.anDanh ? 'Có' : 'Không';
        document.getElementById('d-loinhan').textContent= r.loiNhan || '—';

        var lyDoRow = document.getElementById('d-lydo-row');
        if (parseInt(r.trangThai) === 2 && r.lyDo) {
            lyDoRow.style.display = 'block';
            document.getElementById('d-lydo').textContent = r.lyDo;
        } else {
            lyDoRow.style.display = 'none';
        }

        // Ảnh xác nhận
        var anhWrap = document.getElementById('d-anh');
        if (r.anhXN) {
            anhWrap.innerHTML = '<img src="<%= ResolveUrl("") %>' + escHtml(r.anhXN) + '" alt="Ảnh xác nhận" />';
            } else {
                anhWrap.innerHTML = '<span>Không có ảnh xác nhận</span>';
            }

            // Footer: chờ duyệt → hiện nút
            var footer = document.getElementById('detailFooter');
            if (parseInt(r.trangThai) === 0) {
                footer.innerHTML =
                    '<button type="button" class="qg-btn-yes" onclick="closeModal(\'modalDetail\');openApprove(' + r.id + ')">Duyệt ngay</button>' +
                    '<button type="button" class="qg-btn-yes danger" onclick="closeModal(\'modalDetail\');openReject(' + r.id + ')">Từ chối</button>' +
                    '<button type="button" class="qg-btn-cancel" onclick="closeModal(\'modalDetail\')">Đóng</button>';
            } else {
                footer.innerHTML = '<button type="button" class="qg-btn-cancel" onclick="closeModal(\'modalDetail\')">Đóng</button>';
            }

            openModal('modalDetail');
        };

        /* ── POST action (duyệt/từ chối) ────────────────────────── */
        function postAction(action, id, lyDo) {
            var params = new URLSearchParams();
            params.append('__ajax', 'true');
            params.append('action', action);
            params.append('id', id);
            if (lyDo) params.append('lydo', lyDo);

            fetch(API, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (d.ok) {
                        admToast('Thành công', d.msg, 'ok');
                        // Cập nhật inline row nếu còn trên trang
                        updateRowInline(id, action, lyDo);
                        // Refresh stat cards
                        refreshStats();
                    } else {
                        admToast('Không thể thực hiện', d.msg, 'err');
                    }
                })
                .catch(function () {
                    admToast('Lỗi kết nối', 'Không thể kết nối máy chủ.', 'err');
                });
        }

        function updateRowInline(id, action, lyDo) {
            // Cập nhật cache rows
            var r = rows.find(function (x) { return x.id === id; });
            if (r) {
                r.trangThai = action === 'duyet' ? 1 : 2;
                if (lyDo) r.lyDo = lyDo;
            }
            // Cập nhật DOM
            var row = document.getElementById('qg-' + id);
            if (!row) return;
            var cells = row.querySelectorAll('td');
            var tsNew = action === 'duyet' ? 1 : 2;
            var lyDoEl = '';
            if (tsNew === 2 && lyDo)
                lyDoEl = '<div class="qg-reject-reason">' + escHtml(lyDo) + '</div>';
            // Cột trạng thái (index 6)
            cells[6].innerHTML = badgeHtml(tsNew) + lyDoEl;
            // Cột thao tác (index 7)
            cells[7].innerHTML = '<div class="qg-actions"><button type="button" class="qg-btn-view" onclick="openDetail(' + id + ')">Xem</button></div>';
        }

        /* ── Refresh stat cards sau khi action ──────────────────── */
        function refreshStats() {
            fetch(API, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: '__ajax=true&action=stats'
            })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (!d.ok) return;
                    document.getElementById('sc-total').textContent = d.tongGD;
                    document.getElementById('sc-wait').textContent = d.choDuyet;
                    document.getElementById('sc-ok').textContent = d.daDuyet;
                    document.getElementById('sc-reject').textContent = d.tuChoi;
                    document.getElementById('cnt-all').textContent = d.tongGD;
                    document.getElementById('cnt-0').textContent = d.choDuyet;
                    document.getElementById('cnt-1').textContent = d.daDuyet;
                    document.getElementById('cnt-2').textContent = d.tuChoi;
                    // Format tiền
                    var t = parseInt(d.tongTien);
                    var fmted = t >= 1e9
                        ? (t / 1e9).toFixed(2).replace(/\.?0+$/, '') + ' tỷ đ'
                        : t >= 1e6
                            ? (t / 1e6).toFixed(1).replace(/\.?0+$/, '') + ' tr đ'
                            : t.toLocaleString('vi-VN') + ' đ';
                    document.getElementById('sc-money').textContent = fmted;
                });
        }

        /* ── Modal helpers ───────────────────────────────────────── */
        window.openModal = function (id) {
            document.getElementById(id).classList.add('show');
            document.body.style.overflow = 'hidden';
        };
        window.closeModal = function (id) {
            document.getElementById(id).classList.remove('show');
            document.body.style.overflow = '';
        };
        window.closeOverlay = function (e, id) {
            if (e.target === document.getElementById(id)) closeModal(id);
        };
        document.addEventListener('keydown', function (e) {
            if (e.key !== 'Escape') return;
            ['modalDetail', 'modalApprove', 'modalReject'].forEach(closeModal);
            document.body.style.overflow = '';
        });

        /* ── Init ─────────────────────────────────────────────────── */
        fetchList();

    })();
</script>
</asp:Content>
