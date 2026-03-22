<%@ Page Title="Quản lý Quyên góp" Language="C#"
         MasterPageFile="~/Admin.Master" AutoEventWireup="true"
         CodeBehind="QuanLyQuyenGop.aspx.cs"
         Inherits="ThienNguyenViet.Admin.QuanLyQuyenGop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
/* ══════════════════════════════════════════════════════════════
   QUẢN LÝ QUYÊN GÓP — PAGE STYLES
══════════════════════════════════════════════════════════════ */

/* ── Stat cards ─────────────────────────────────────────────── */
.qg-stats-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px;
    margin-bottom: 20px;
}
.qg-stat-card {
    background: var(--admin-card);
    border-radius: var(--r-card);
    border: 0.5px solid var(--admin-vien);
    padding: 16px 18px;
    display: flex;
    align-items: center;
    gap: 14px;
}
.qg-stat-icon {
    width: 40px; height: 40px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 18px; flex-shrink: 0;
}
.qg-stat-info strong {
    display: block;
    font-size: 20px; font-weight: 700;
    color: var(--admin-chu-chinh); line-height: 1.1;
}
.qg-stat-info span { font-size: 11px; color: var(--admin-chu-phu); }

/* ── Tab bar ────────────────────────────────────────────────── */
.tab-bar {
    display: flex;
    align-items: center;
    gap: 4px;
    margin-bottom: 16px;
    background: var(--admin-card);
    border: 0.5px solid var(--admin-vien);
    border-radius: var(--r-card);
    padding: 6px;
}
.tab-btn {
    height: 32px;
    padding: 0 16px;
    border-radius: 6px;
    border: none;
    font-size: 13px;
    font-family: var(--font);
    font-weight: 500;
    cursor: pointer;
    background: transparent;
    color: var(--admin-chu-phu);
    display: flex; align-items: center; gap: 6px;
    transition: all .15s;
    white-space: nowrap;
}
.tab-btn:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }
.tab-btn.active {
    background: #3182CE;
    color: #fff;
}
.tab-count {
    font-size: 10px;
    font-weight: 700;
    min-width: 18px; height: 18px;
    border-radius: 99px;
    display: inline-flex; align-items: center; justify-content: center;
    padding: 0 5px;
}
.tab-btn.active .tab-count { background: rgba(255,255,255,.25); color: #fff; }
.tab-btn:not(.active) .tab-count { background: var(--admin-vien); color: var(--admin-chu-phu); }

/* ── Filter bar ─────────────────────────────────────────────── */
.filter-bar {
    display: flex; align-items: center;
    gap: 10px; flex-wrap: wrap;
    margin-bottom: 16px;
}
.input-search {
    height: 34px; padding: 0 10px;
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); width: 220px; outline: none;
    transition: border-color .15s;
}
.input-search:focus { border-color: #3182CE; }
.select-filter {
    height: 34px; padding: 0 8px;
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font);
    color: var(--admin-chu-chinh); background: #fff; cursor: pointer; outline: none;
}
.btn-primary-sm {
    height: 34px; padding: 0 14px;
    background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
    transition: background .15s;
}
.btn-primary-sm:hover { background: #2B6CB0; }
.btn-outline-sm {
    height: 34px; padding: 0 12px;
    background: transparent; color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); cursor: pointer;
    transition: background .15s;
}
.btn-outline-sm:hover { background: var(--admin-nen); color: var(--admin-chu-chinh); }

/* ── Table ──────────────────────────────────────────────────── */
.section-header {
    display: flex; align-items: center;
    justify-content: space-between; margin-bottom: 14px;
}
.section-title { font-size: 14px; font-weight: 600; }
.section-count { font-size: 12px; color: var(--admin-chu-phu); }

.donor-cell    { display: flex; align-items: center; gap: 8px; }
.donor-av {
    width: 32px; height: 32px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 11px; font-weight: 700; flex-shrink: 0;
}
.donor-name  { font-size: 12px; font-weight: 500; color: var(--admin-chu-chinh); }
.donor-email { font-size: 11px; color: var(--admin-chu-phu); margin-top: 1px; }

.campaign-cell {
    font-size: 12px; font-weight: 500;
    max-width: 180px; overflow: hidden;
    text-overflow: ellipsis; white-space: nowrap;
    color: var(--admin-chu-chinh);
}
.campaign-cat {
    font-size: 10px; color: var(--admin-chu-phu); margin-top: 1px;
}

.amount-pos { color: var(--admin-thanh-cong); font-weight: 600; white-space: nowrap; }
.date-col   { font-size: 12px; color: var(--admin-chu-phu); }

/* Ảnh xác nhận thumbnail */
.thumb-wrap {
    width: 48px; height: 36px;
    border-radius: 4px;
    overflow: hidden;
    border: 1px solid var(--admin-vien);
    background: var(--admin-nen);
    display: flex; align-items: center; justify-content: center;
    cursor: pointer; font-size: 18px;
    transition: opacity .12s;
}
.thumb-wrap:hover { opacity: .8; }
.thumb-wrap img { width: 100%; height: 100%; object-fit: cover; }

/* Action buttons */
.btn-duyet {
    font-size: 11px; padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #C6F6D5; color: #276749;
    border: none; cursor: pointer; font-family: var(--font);
    font-weight: 500; transition: background .12s;
}
.btn-duyet:hover { background: #9AE6B4; }
.btn-tuchoi {
    font-size: 11px; padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #FED7D7; color: #C53030;
    border: none; cursor: pointer; font-family: var(--font);
    font-weight: 500; transition: background .12s;
}
.btn-tuchoi:hover { background: #FEB2B2; }
.btn-view {
    font-size: 11px; padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #EBF8FF; color: #2B6CB0;
    border: none; cursor: pointer; font-family: var(--font);
    transition: background .12s;
}
.btn-view:hover { background: #BEE3F8; }

/* ── Pagination ─────────────────────────────────────────────── */
.pagination-wrap {
    display: flex; align-items: center;
    justify-content: space-between;
    padding-top: 14px;
    border-top: 1px solid var(--admin-vien); margin-top: 4px;
}
.paging-info { font-size: 12px; color: var(--admin-chu-phu); }
.paging-btns { display: flex; align-items: center; gap: 6px; }
.paging-btn {
    font-size: 12px; padding: 4px 10px;
    border-radius: var(--r-nut);
    background: #fff; border: 1px solid var(--admin-vien);
    color: var(--admin-chu-chinh); cursor: pointer; font-family: var(--font);
    transition: background .12s;
}
.paging-btn:hover    { background: var(--admin-nen); }
.paging-btn.active   { background: #3182CE; color: #fff; border-color: #3182CE; }
.paging-btn:disabled { opacity: .4; cursor: default; }

/* ── Alert ──────────────────────────────────────────────────── */
.alert-success { padding: 10px 14px; background: #C6F6D5; color: #276749; border-radius: var(--r-nut); font-size: 13px; margin-bottom: 16px; display: none; }
.alert-error   { padding: 10px 14px; background: #FED7D7; color: #C53030; border-radius: var(--r-nut); font-size: 13px; margin-bottom: 16px; display: none; }

/* ── Empty state ────────────────────────────────────────────── */
.empty-state { text-align: center; padding: 56px 0; color: var(--admin-chu-phu); }
.empty-state .empty-icon { font-size: 40px; margin-bottom: 10px; }
.empty-state p { font-size: 13px; }

/* ══════════════════════════════════════════════════════════════
   MODAL DUYỆT / TỪ CHỐI / XEM CHI TIẾT
══════════════════════════════════════════════════════════════ */
.modal-overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.45); z-index: 999;
    align-items: center; justify-content: center;
}
.modal-overlay.show { display: flex; }

.modal-box {
    background: var(--admin-card); border-radius: 12px;
    width: 460px; max-width: 94vw;
    box-shadow: 0 20px 60px rgba(0,0,0,.22);
    overflow: hidden; animation: modalIn .18s ease;
}
@keyframes modalIn {
    from { opacity:0; transform:translateY(-14px) scale(.97); }
    to   { opacity:1; transform:translateY(0) scale(1); }
}
.modal-box-wide { width: 640px; }

.modal-header {
    padding: 16px 20px 14px;
    border-bottom: 1px solid var(--admin-vien);
    display: flex; align-items: center; justify-content: space-between;
}
.modal-header h3 { font-size: 15px; font-weight: 600; }
.modal-close {
    width: 28px; height: 28px; border-radius: 6px; border: none;
    background: var(--admin-nen); font-size: 15px; cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    color: var(--admin-chu-phu); transition: background .12s;
}
.modal-close:hover { background: #FED7D7; color: #C53030; }

.modal-body  { padding: 20px; }
.modal-footer {
    padding: 14px 20px; border-top: 1px solid var(--admin-vien);
    display: flex; gap: 8px; justify-content: flex-end;
}

/* Detail grid */
.detail-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px;
}
.detail-item label {
    display: block; font-size: 10px; font-weight: 600;
    text-transform: uppercase; letter-spacing: .06em;
    color: var(--admin-chu-phu); margin-bottom: 3px;
}
.detail-item .detail-val { font-size: 13px; font-weight: 500; color: var(--admin-chu-chinh); }
.detail-full { grid-column: 1 / -1; }

.proof-img-wrap {
    width: 100%; height: 200px;
    border: 1px solid var(--admin-vien); border-radius: 6px;
    overflow: hidden; background: var(--admin-nen);
    display: flex; align-items: center; justify-content: center;
    font-size: 48px; color: var(--admin-chu-phu);
}
.proof-img-wrap img { width: 100%; height: 100%; object-fit: contain; }

/* Reject form */
.form-group { margin-bottom: 12px; }
.form-label {
    display: block; font-size: 12px; font-weight: 600;
    color: var(--admin-chu-chinh); margin-bottom: 5px;
}
.form-control {
    width: 100%; padding: 8px 10px;
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); color: var(--admin-chu-chinh);
    outline: none; box-sizing: border-box; resize: vertical;
}
.form-control:focus { border-color: #3182CE; box-shadow: 0 0 0 3px rgba(49,130,206,.1); }

/* Confirm modal */
.confirm-msg { font-size: 14px; color: var(--admin-chu-chinh); margin-bottom: 6px; }
.confirm-sub { font-size: 12px; color: var(--admin-chu-phu); }
.btn-confirm-yes {
    height: 34px; padding: 0 18px;
    background: #3182CE; color: #fff;
    border: none; border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); font-weight: 500; cursor: pointer;
}
.btn-confirm-yes.danger { background: #E53E3E; }
.btn-confirm-yes:hover  { opacity: .88; }
.btn-cancel {
    height: 34px; padding: 0 14px;
    background: var(--admin-nen); color: var(--admin-chu-phu);
    border: 1px solid var(--admin-vien); border-radius: var(--r-nut);
    font-size: 13px; font-family: var(--font); cursor: pointer;
}
.btn-cancel:hover { background: #EDF2F7; }

/* Lý do từ chối hiển thị */
.reject-reason {
    font-size: 11px; color: #C53030;
    background: #FED7D7; border-radius: 4px;
    padding: 2px 8px; display: inline-block; margin-top: 3px;
    max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}

.loi-nhan {
    font-size: 11px; color: var(--admin-chu-phu);
    font-style: italic;
    max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
</style>
</asp:Content>

<asp:Content ID="ContentTopBar" ContentPlaceHolderID="TopBarTitle" runat="server">
    <h1>Quản lý Quyên góp</h1>
    <p>Duyệt và theo dõi toàn bộ giao dịch quyên góp</p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Alerts --%>
    <div id="alertSuccess" class="alert-success"></div>
    <div id="alertError"   class="alert-error"></div>

    <%-- Stat cards --%>
    <div class="qg-stats-row" id="statsRow"></div>

    <%-- Tab lọc nhanh --%>
    <div class="tab-bar" id="tabBar">
        <button class="tab-btn active" data-tab="" onclick="switchTab(this, '')">
            Tất cả <span class="tab-count" id="cnt-all"></span>
        </button>
        <button class="tab-btn" data-tab="0" onclick="switchTab(this, '0')">
            ⏳ Chờ duyệt <span class="tab-count" id="cnt-0"></span>
        </button>
        <button class="tab-btn" data-tab="1" onclick="switchTab(this, '1')">
            ✅ Đã duyệt <span class="tab-count" id="cnt-1"></span>
        </button>
        <button class="tab-btn" data-tab="2" onclick="switchTab(this, '2')">
            ✕ Từ chối <span class="tab-count" id="cnt-2"></span>
        </button>
    </div>

    <%-- Filter --%>
    <div class="filter-bar">
        <input type="text" id="inputSearch" class="input-search"
               placeholder="Tìm theo tên người góp, chiến dịch..." />
        <select id="selChienDich" class="select-filter">
            <option value="">Tất cả chiến dịch</option>
            <option value="1">Lũ lụt miền Trung 2026</option>
            <option value="2">Học bổng Thắp sáng ước mơ</option>
            <option value="3">Phẫu thuật tim miễn phí</option>
            <option value="4">Trồng 10.000 cây xanh</option>
            <option value="5">Xây trường Hà Giang</option>
            <option value="6">Khám bệnh miễn phí</option>
        </select>
        <button class="btn-primary-sm" onclick="applyFilter()">Tìm kiếm</button>
        <button class="btn-outline-sm" onclick="resetFilter()">Đặt lại</button>
    </div>

    <%-- Table --%>
    <div class="admin-card">
        <div class="section-header">
            <span class="section-title">Danh sách giao dịch</span>
            <span class="section-count" id="countLabel"></span>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width:50px">Mã GD</th>
                    <th style="width:20%">Người quyên góp</th>
                    <th style="width:22%">Chiến dịch</th>
                    <th>Số tiền</th>
                    <th>Lời nhắn</th>
                    <th>Ngày</th>
                    <th style="text-align:center">Ảnh XN</th>
                    <th>Trạng thái</th>
                    <th style="text-align:center">Thao tác</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>

        <div id="emptyMsg" class="empty-state" style="display:none">
            <div class="empty-icon">📭</div>
            <p>Không có giao dịch nào phù hợp.</p>
        </div>

        <div class="pagination-wrap" id="pagingWrap">
            <span class="paging-info" id="pagingInfo"></span>
            <div class="paging-btns" id="pagingBtns"></div>
        </div>
    </div>

    <%-- ════ MODAL XEM CHI TIẾT ════ --%>
    <div class="modal-overlay" id="modalDetail" onclick="closeModalOutside(event,'modalDetail')">
        <div class="modal-box modal-box-wide">
            <div class="modal-header">
                <h3>Chi tiết giao dịch</h3>
                <button class="modal-close" onclick="closeModal('modalDetail')">✕</button>
            </div>
            <div class="modal-body">
                <div class="detail-grid">
                    <div class="detail-item"><label>Mã giao dịch</label><span class="detail-val" id="d-ma"></span></div>
                    <div class="detail-item"><label>Ngày tạo</label>    <span class="detail-val" id="d-ngay"></span></div>
                    <div class="detail-item"><label>Người quyên góp</label><span class="detail-val" id="d-nguoi"></span></div>
                    <div class="detail-item"><label>Email</label>        <span class="detail-val" id="d-email"></span></div>
                    <div class="detail-item"><label>Chiến dịch</label>   <span class="detail-val" id="d-cd"></span></div>
                    <div class="detail-item"><label>Số tiền</label>      <span class="detail-val" id="d-sotien" style="color:var(--admin-thanh-cong);font-size:15px;font-weight:700"></span></div>
                    <div class="detail-item"><label>Trạng thái</label>   <span class="detail-val" id="d-tt"></span></div>
                    <div class="detail-item"><label>Ẩn danh</label>      <span class="detail-val" id="d-andanh"></span></div>
                    <div class="detail-item detail-full"><label>Lời nhắn</label><span class="detail-val" id="d-loinhan"></span></div>
                    <div class="detail-item detail-full" id="d-lydo-wrap" style="display:none">
                        <label>Lý do từ chối</label><span class="detail-val" id="d-lydo" style="color:#C53030"></span>
                    </div>
                    <div class="detail-item detail-full">
                        <label>Ảnh xác nhận chuyển khoản</label>
                        <div class="proof-img-wrap" id="d-anhxn"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="detailFooter"></div>
        </div>
    </div>

    <%-- ════ MODAL TỪ CHỐI ════ --%>
    <div class="modal-overlay" id="modalReject" onclick="closeModalOutside(event,'modalReject')">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Từ chối giao dịch</h3>
                <button class="modal-close" onclick="closeModal('modalReject')">✕</button>
            </div>
            <div class="modal-body">
                <div class="confirm-msg">Từ chối giao dịch <strong id="r-ma"></strong>?</div>
                <div class="confirm-sub" style="margin-bottom:14px">Số tiền sẽ <strong>không</strong> được cộng vào chiến dịch.</div>
                <div class="form-group">
                    <label class="form-label">Lý do từ chối <span style="color:#E53E3E">*</span></label>
                    <textarea id="txtLyDo" class="form-control" rows="3"
                              placeholder="VD: Ảnh xác nhận không hợp lệ, trùng giao dịch..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn-confirm-yes danger" onclick="confirmTuChoi()">✕ Xác nhận từ chối</button>
                <button class="btn-cancel" onclick="closeModal('modalReject')">Hủy</button>
            </div>
        </div>
    </div>

    <%-- ════ MODAL DUYỆT ════ --%>
    <div class="modal-overlay" id="modalApprove" onclick="closeModalOutside(event,'modalApprove')">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Duyệt giao dịch</h3>
                <button class="modal-close" onclick="closeModal('modalApprove')">✕</button>
            </div>
            <div class="modal-body">
                <div class="confirm-msg">Duyệt giao dịch <strong id="a-ma"></strong>?</div>
                <div class="confirm-sub" id="a-sub"></div>
            </div>
            <div class="modal-footer">
                <button class="btn-confirm-yes" onclick="confirmDuyet()">✅ Xác nhận duyệt</button>
                <button class="btn-cancel" onclick="closeModal('modalApprove')">Hủy</button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
/* ══════════════════════════════════════════════════════════════
   MOCK DATA — khớp SampleData.sql
══════════════════════════════════════════════════════════════ */

var MOCK_USERS = {
    1: { ten: 'Admin',               email: 'admin@thiennguyen.vn' },
    2: { ten: 'User',                email: 'user@thiennguyen.vn' },
    3: { ten: 'Trần Thị Bình',       email: 'binh.tran@gmail.com' },
    4: { ten: 'Lê Hoàng Minh',       email: 'minh.le@gmail.com' },
    5: { ten: 'Phạm Thị Thu Hương',  email: 'huong.pham@gmail.com' },
    6: { ten: 'Vũ Đức Thắng',        email: 'thang.vu@gmail.com' },
    7: { ten: 'Đỗ Thị Lan',          email: 'lan.do@gmail.com' }
};

var MOCK_CHIEN_DICH = {
    1: { ten: 'Hỗ trợ đồng bào lũ lụt miền Trung 2026', cat: 'Cứu trợ thiên tai',   color: '#E53E3E' },
    2: { ten: 'Học bổng "Thắp sáng ước mơ"',             cat: 'Học bổng & Giáo dục', color: '#3182CE' },
    3: { ten: 'Phẫu thuật tim miễn phí cho trẻ em nghèo', cat: 'Y tế cộng đồng',     color: '#D69E2E' },
    4: { ten: 'Trồng 10.000 cây xanh tại Hà Nội',        cat: 'Môi trường & Cây xanh',color:'#38A169' },
    5: { ten: 'Xây dựng điểm trường cho trẻ em Hà Giang', cat: 'Học bổng & Giáo dục', color:'#3182CE' },
    6: { ten: 'Khám chữa bệnh miễn phí cho người cao tuổi', cat: 'Y tế cộng đồng',  color: '#D69E2E' }
};

/* Tổng tiền mock của các chiến dịch (dùng khi cộng) */
var CD_SO_TIEN = { 1:320000000, 2:185000000, 3:950000000, 4:62000000, 5:400000000, 6:15000000 };

var MOCK_QG = [
    { id:1,  maCD:1, maNguoiDung:2,    soTien:500000,   loiNhan:'Chúc bà con sớm ổn định cuộc sống!', anDanh:false, anhXN:'ck-001.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'02/03/2026', ngayDuyet:'02/03/2026' },
    { id:2,  maCD:1, maNguoiDung:3,    soTien:200000,   loiNhan:'Mong bà con vượt qua khó khăn.',     anDanh:false, anhXN:'ck-002.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'03/03/2026', ngayDuyet:'03/03/2026' },
    { id:3,  maCD:1, maNguoiDung:null, soTien:1000000,  loiNhan:null,                                 anDanh:true,  anhXN:'ck-003.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'04/03/2026', ngayDuyet:'04/03/2026' },
    { id:4,  maCD:1, maNguoiDung:4,    soTien:5000000,  loiNhan:'Một chút tấm lòng gửi đến bà con.',  anDanh:false, anhXN:'ck-004.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'05/03/2026', ngayDuyet:'05/03/2026' },
    { id:5,  maCD:1, maNguoiDung:5,    soTien:300000,   loiNhan:'Cố lên bà con miền Trung!',           anDanh:false, anhXN:'ck-005.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'06/03/2026', ngayDuyet:'06/03/2026' },
    { id:6,  maCD:1, maNguoiDung:6,    soTien:200000,   loiNhan:null,                                 anDanh:false, anhXN:'ck-006.png', trangThai:0, lyDoTuChoi:null,  ngayTao:'16/03/2026', ngayDuyet:null },
    { id:7,  maCD:2, maNguoiDung:2,    soTien:500000,   loiNhan:'Chúc các em học giỏi!',               anDanh:false, anhXN:'ck-007.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'05/02/2026', ngayDuyet:'05/02/2026' },
    { id:8,  maCD:2, maNguoiDung:7,    soTien:2000000,  loiNhan:'Góp một phần nhỏ vì tương lai các em.',anDanh:false,anhXN:'ck-008.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'10/02/2026', ngayDuyet:'10/02/2026' },
    { id:9,  maCD:2, maNguoiDung:null, soTien:500000,   loiNhan:null,                                 anDanh:true,  anhXN:'ck-009.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'12/02/2026', ngayDuyet:'12/02/2026' },
    { id:10, maCD:3, maNguoiDung:3,    soTien:1000000,  loiNhan:'Cầu chúc các bé mau khỏe!',           anDanh:false, anhXN:'ck-010.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'20/01/2026', ngayDuyet:'20/01/2026' },
    { id:11, maCD:3, maNguoiDung:4,    soTien:500000,   loiNhan:'Mong các bé sớm bình phục.',           anDanh:false, anhXN:'ck-011.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'22/01/2026', ngayDuyet:'22/01/2026' },
    { id:12, maCD:3, maNguoiDung:2,    soTien:300000,   loiNhan:null,                                 anDanh:false, anhXN:'ck-012.png', trangThai:2, lyDoTuChoi:'Ảnh xác nhận không hợp lệ, trùng với giao dịch đã duyệt.', ngayTao:'24/01/2026', ngayDuyet:'25/01/2026' },
    { id:13, maCD:6, maNguoiDung:5,    soTien:500000,   loiNhan:'Chúc chương trình thành công!',       anDanh:false, anhXN:'ck-013.png', trangThai:1, lyDoTuChoi:null,  ngayTao:'16/03/2026', ngayDuyet:'16/03/2026' },
    { id:14, maCD:6, maNguoiDung:7,    soTien:200000,   loiNhan:null,                                 anDanh:false, anhXN:'ck-014.png', trangThai:0, lyDoTuChoi:null,  ngayTao:'17/03/2026', ngayDuyet:null }
];

/* ── Helpers ────────────────────────────────────────────────── */
var AV_COLORS = [
    {bg:'#EBF8FF',color:'#2B6CB0'},{bg:'#E9D8FD',color:'#6B46C1'},
    {bg:'#C6F6D5',color:'#276749'},{bg:'#FEEBC8',color:'#C05621'},
    {bg:'#FED7D7',color:'#C53030'},{bg:'#E6FFFA',color:'#285E61'},
    {bg:'#FEFCBF',color:'#744210'},{bg:'#F0FFF4',color:'#22543D'}
];
function avColor(id) { return AV_COLORS[((id||1) - 1) % AV_COLORS.length]; }

function getInitials(name) {
    if (!name) return '?';
    var p = name.trim().split(' ');
    if (p.length === 1) return p[0][0].toUpperCase();
    return (p[p.length-2][0] + p[p.length-1][0]).toUpperCase();
}

function fmtMoney(n) {
    if (!n) return '0 đ';
    if (n >= 1e9) return (n/1e9).toFixed(2).replace(/\.?0+$/,'') + ' tỷ đ';
    if (n >= 1e6) return (n/1e6).toFixed(1).replace(/\.?0+$/,'') + ' tr đ';
    return n.toLocaleString('vi-VN') + ' đ';
}

function trangThaiBadge(ts) {
    var map = {
        0: ['badge-cho-duyet', '⏳ Chờ duyệt'],
        1: ['badge-thanh-cong','✅ Đã duyệt'],
        2: ['badge-tu-choi',   '✕ Từ chối']
    };
    var b = map[ts] || ['badge-nhap','—'];
    return '<span class="badge-admin ' + b[0] + '">' + b[1] + '</span>';
}

/* Lấy tên người dùng (xử lý ẩn danh) */
function getNguoiDung(qg) {
    if (qg.anDanh || !qg.maNguoiDung) return { ten: 'Ẩn danh', email: '—', initials: '?', id: 0 };
    var u = MOCK_USERS[qg.maNguoiDung] || { ten: 'Không rõ', email: '—' };
    return { ten: u.ten, email: u.email, initials: getInitials(u.ten), id: qg.maNguoiDung };
}

/* ══════════════════════════════════════════════════════════════
   RENDER STATS + TAB COUNTS
══════════════════════════════════════════════════════════════ */
function renderStats() {
    var total   = MOCK_QG.length;
    var cho     = MOCK_QG.filter(function(q){ return q.trangThai === 0; }).length;
    var duyet   = MOCK_QG.filter(function(q){ return q.trangThai === 1; }).length;
    var tuChoi  = MOCK_QG.filter(function(q){ return q.trangThai === 2; }).length;
    var tongTien= MOCK_QG.filter(function(q){ return q.trangThai === 1; })
                         .reduce(function(s,q){ return s + q.soTien; }, 0);

    var cards = [
        { icon:'💳', label:'Tổng giao dịch',       value: total,           bg:'var(--stat-xanh-nen)',  color:'var(--stat-xanh-vien)' },
        { icon:'⏳', label:'Chờ duyệt',             value: cho,             bg:'var(--stat-cam-nen)',   color:'var(--stat-cam-vien)' },
        { icon:'✅', label:'Đã duyệt',              value: duyet,           bg:'#C6F6D5',               color:'var(--admin-thanh-cong)' },
        { icon:'💰', label:'Tổng tiền đã duyệt',    value: fmtMoney(tongTien), bg:'var(--stat-tim-nen)', color:'var(--stat-tim-vien)' }
    ];

    var html = '';
    cards.forEach(function(c) {
        html +=
            '<div class="qg-stat-card">' +
            '<div class="qg-stat-icon" style="background:' + c.bg + ';color:' + c.color + '">' + c.icon + '</div>' +
            '<div class="qg-stat-info">' +
            '<strong style="color:' + c.color + '">' + c.value + '</strong>' +
            '<span>' + c.label + '</span>' +
            '</div></div>';
    });
    document.getElementById('statsRow').innerHTML = html;

    // Tab counts
    document.getElementById('cnt-all').textContent = total;
    document.getElementById('cnt-0').textContent   = cho;
    document.getElementById('cnt-1').textContent   = duyet;
    document.getElementById('cnt-2').textContent   = tuChoi;
}

/* ══════════════════════════════════════════════════════════════
   TABLE RENDER + FILTER + PAGINATION
══════════════════════════════════════════════════════════════ */
var PAGE_SIZE    = 8;
var currentPage  = 1;
var activeTab    = '';
var filteredData = MOCK_QG.slice();

function applyAllFilters() {
    var q   = document.getElementById('inputSearch').value.trim().toLowerCase();
    var cdF = document.getElementById('selChienDich').value;

    filteredData = MOCK_QG.filter(function(qg) {
        var nd = getNguoiDung(qg);
        var cd = MOCK_CHIEN_DICH[qg.maCD] || {};

        var matchTab = activeTab === '' || String(qg.trangThai) === activeTab;
        var matchQ   = !q || nd.ten.toLowerCase().includes(q) || (cd.ten||'').toLowerCase().includes(q);
        var matchCD  = !cdF || String(qg.maCD) === cdF;

        return matchTab && matchQ && matchCD;
    });

    currentPage = 1;
    renderTable();
}

function switchTab(btn, tab) {
    document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');
    activeTab = tab;
    applyAllFilters();
}

function applyFilter()  { applyAllFilters(); }
function resetFilter() {
    document.getElementById('inputSearch').value  = '';
    document.getElementById('selChienDich').value = '';
    applyAllFilters();
}

function renderTable() {
    var tbody      = document.getElementById('tableBody');
    var emptyMsg   = document.getElementById('emptyMsg');
    var pagingWrap = document.getElementById('pagingWrap');

    if (filteredData.length === 0) {
        tbody.innerHTML          = '';
        emptyMsg.style.display   = 'block';
        pagingWrap.style.display = 'none';
        document.getElementById('countLabel').textContent = '0 giao dịch';
        return;
    }

    emptyMsg.style.display   = 'none';
    pagingWrap.style.display = 'flex';

    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (currentPage > totalPages) currentPage = totalPages;

    var from = (currentPage - 1) * PAGE_SIZE;
    var to   = Math.min(from + PAGE_SIZE, filteredData.length);
    var page = filteredData.slice(from, to);

    document.getElementById('countLabel').textContent =
        'Hiển thị ' + (from+1) + '–' + to + ' / ' + filteredData.length + ' giao dịch';
    document.getElementById('pagingInfo').textContent =
        'Trang ' + currentPage + ' / ' + totalPages;

    var html = '';
    page.forEach(function(qg) {
        var nd  = getNguoiDung(qg);
        var cd  = MOCK_CHIEN_DICH[qg.maCD] || { ten:'—', cat:'—', color:'#718096' };
        var av  = nd.id ? avColor(nd.id) : {bg:'#EDF2F7', color:'#718096'};
        var hex = cd.color.replace('#','');
        var r=parseInt(hex.substring(0,2),16), g=parseInt(hex.substring(2,4),16), b=parseInt(hex.substring(4,6),16);
        var catBg = 'rgba('+r+','+g+','+b+',.12)';

        // Action buttons
        var actions = '';
        if (qg.trangThai === 0) {
            actions =
                '<button class="btn-duyet"  onclick="openApprove('  + qg.id + ')">✅ Duyệt</button> ' +
                '<button class="btn-tuchoi" onclick="openReject('   + qg.id + ')">✕ Từ chối</button>';
        } else {
            actions = '<button class="btn-view" onclick="openDetail(' + qg.id + ')">👁 Xem</button>';
        }

        // Lý do từ chối (hiện ngắn)
        var lyDoEl = '';
        if (qg.trangThai === 2 && qg.lyDoTuChoi) {
            lyDoEl = '<div class="reject-reason" title="' + qg.lyDoTuChoi + '">' + qg.lyDoTuChoi + '</div>';
        }

        html +=
            '<tr id="qg-row-' + qg.id + '">' +
            '<td><code style="font-size:11px;color:var(--admin-chu-phu)">#' + qg.id + '</code></td>' +
            '<td>' +
                '<div class="donor-cell">' +
                    '<div class="donor-av" style="background:' + av.bg + ';color:' + av.color + '">' + nd.initials + '</div>' +
                    '<div>' +
                        '<div class="donor-name">' + nd.ten + (qg.anDanh ? ' <span style="font-size:10px;color:var(--admin-chu-phu)">(ẩn danh)</span>':'') + '</div>' +
                        '<div class="donor-email">' + nd.email + '</div>' +
                    '</div>' +
                '</div>' +
            '</td>' +
            '<td>' +
                '<div class="campaign-cell" title="' + cd.ten + '">' + cd.ten + '</div>' +
                '<div class="campaign-cat"><span style="font-size:10px;padding:1px 6px;border-radius:3px;font-weight:500;background:'+catBg+';color:'+cd.color+'">'+cd.cat+'</span></div>' +
            '</td>' +
            '<td class="amount-pos">' + fmtMoney(qg.soTien) + '</td>' +
            '<td>' +
                (qg.loiNhan
                    ? '<div class="loi-nhan" title="' + qg.loiNhan + '">"' + qg.loiNhan + '"</div>'
                    : '<span style="color:var(--admin-chu-phu);font-size:11px">—</span>') +
            '</td>' +
            '<td class="date-col">' + qg.ngayTao + '</td>' +
            '<td style="text-align:center">' +
                '<div class="thumb-wrap" onclick="openDetail(' + qg.id + ')" title="Xem ảnh xác nhận">🖼</div>' +
            '</td>' +
            '<td>' + trangThaiBadge(qg.trangThai) + lyDoEl + '</td>' +
            '<td style="text-align:center;white-space:nowrap">' + actions + '</td>' +
            '</tr>';
    });

    tbody.innerHTML = html;
    renderPaging(totalPages);
}

function renderPaging(totalPages) {
    var btns  = document.getElementById('pagingBtns');
    var start = Math.max(1, currentPage - 2);
    var end   = Math.min(totalPages, start + 4);
    start     = Math.max(1, end - 4);

    var html = '<button class="paging-btn" onclick="changePage(' + (currentPage-1) + ')"' +
               (currentPage <= 1 ? ' disabled' : '') + '>← Trước</button>';
    for (var p = start; p <= end; p++) {
        html += '<button class="paging-btn' + (p === currentPage ? ' active':'') +
                '" onclick="changePage(' + p + ')">' + p + '</button>';
    }
    html += '<button class="paging-btn" onclick="changePage(' + (currentPage+1) + ')"' +
            (currentPage >= totalPages ? ' disabled':'') + '>Tiếp →</button>';
    btns.innerHTML = html;
}

function changePage(p) {
    var totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (p < 1 || p > totalPages) return;
    currentPage = p;
    renderTable();
}

document.getElementById('inputSearch').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') applyAllFilters();
});

/* ══════════════════════════════════════════════════════════════
   MODAL DUYỆT
══════════════════════════════════════════════════════════════ */
var pendingApproveId = null;

function openApprove(qgId) {
    var qg = MOCK_QG.find(function(x){ return x.id === qgId; });
    if (!qg) return;
    pendingApproveId = qgId;
    var nd = getNguoiDung(qg);
    var cd = MOCK_CHIEN_DICH[qg.maCD] || { ten:'—' };
    document.getElementById('a-ma').textContent  = '#' + qg.id;
    document.getElementById('a-sub').innerHTML   =
        'Số tiền <strong style="color:var(--admin-thanh-cong)">' + fmtMoney(qg.soTien) + '</strong>' +
        ' từ <strong>' + nd.ten + '</strong> sẽ được cộng vào chiến dịch <strong>' + cd.ten + '</strong>.';
    openModal('modalApprove');
}

function confirmDuyet() {
    var qg = MOCK_QG.find(function(x){ return x.id === pendingApproveId; });
    if (!qg) return;

    qg.trangThai  = 1;
    qg.ngayDuyet  = new Date().toLocaleDateString('vi-VN');
    CD_SO_TIEN[qg.maCD] = (CD_SO_TIEN[qg.maCD] || 0) + qg.soTien;

    closeModal('modalApprove');
    renderStats();
    applyAllFilters();
    showAlert('alertSuccess', '✅ Đã duyệt giao dịch #' + qg.id + ' — ' + fmtMoney(qg.soTien) + ' đã được cộng vào chiến dịch.');
}

/* ══════════════════════════════════════════════════════════════
   MODAL TỪ CHỐI
══════════════════════════════════════════════════════════════ */
var pendingRejectId = null;

function openReject(qgId) {
    pendingRejectId = qgId;
    document.getElementById('r-ma').textContent = '#' + qgId;
    document.getElementById('txtLyDo').value     = '';
    openModal('modalReject');
}

function confirmTuChoi() {
    var lyDo = document.getElementById('txtLyDo').value.trim();
    if (!lyDo) {
        document.getElementById('txtLyDo').style.borderColor = '#E53E3E';
        document.getElementById('txtLyDo').focus();
        return;
    }
    document.getElementById('txtLyDo').style.borderColor = '';

    var qg = MOCK_QG.find(function(x){ return x.id === pendingRejectId; });
    if (!qg) return;

    qg.trangThai   = 2;
    qg.lyDoTuChoi  = lyDo;
    qg.ngayDuyet   = new Date().toLocaleDateString('vi-VN');

    closeModal('modalReject');
    renderStats();
    applyAllFilters();
    showAlert('alertSuccess', '✕ Đã từ chối giao dịch #' + qg.id + '.');
}

/* ══════════════════════════════════════════════════════════════
   MODAL CHI TIẾT
══════════════════════════════════════════════════════════════ */
function openDetail(qgId) {
    var qg = MOCK_QG.find(function(x){ return x.id === qgId; });
    if (!qg) return;

    var nd = getNguoiDung(qg);
    var cd = MOCK_CHIEN_DICH[qg.maCD] || { ten:'—' };

    document.getElementById('d-ma').textContent     = '#' + qg.id;
    document.getElementById('d-ngay').textContent   = qg.ngayTao + (qg.ngayDuyet ? ' (duyệt: ' + qg.ngayDuyet + ')' : '');
    document.getElementById('d-nguoi').textContent  = nd.ten;
    document.getElementById('d-email').textContent  = nd.email;
    document.getElementById('d-cd').textContent     = cd.ten;
    document.getElementById('d-sotien').textContent = fmtMoney(qg.soTien);
    document.getElementById('d-tt').innerHTML       = trangThaiBadge(qg.trangThai);
    document.getElementById('d-andanh').textContent = qg.anDanh ? 'Có (ẩn danh)' : 'Không';
    document.getElementById('d-loinhan').textContent= qg.loiNhan || '—';

    // Lý do từ chối
    var lyDoWrap = document.getElementById('d-lydo-wrap');
    if (qg.trangThai === 2 && qg.lyDoTuChoi) {
        lyDoWrap.style.display           = 'block';
        document.getElementById('d-lydo').textContent = qg.lyDoTuChoi;
    } else {
        lyDoWrap.style.display = 'none';
    }

    // Ảnh xác nhận (mock placeholder)
    document.getElementById('d-anhxn').innerHTML = '🖼';

    // Footer: chờ duyệt → hiện nút hành động
    var footer = document.getElementById('detailFooter');
    if (qg.trangThai === 0) {
        footer.innerHTML =
            '<button class="btn-confirm-yes" onclick="closeModal(\'modalDetail\');openApprove(' + qg.id + ')">✅ Duyệt ngay</button>' +
            '<button class="btn-confirm-yes danger" onclick="closeModal(\'modalDetail\');openReject(' + qg.id + ')">✕ Từ chối</button>' +
            '<button class="btn-cancel" onclick="closeModal(\'modalDetail\')">Đóng</button>';
    } else {
        footer.innerHTML = '<button class="btn-cancel" onclick="closeModal(\'modalDetail\')">Đóng</button>';
    }

    openModal('modalDetail');
}

/* ── Modal helpers ──────────────────────────────────────────── */
function openModal(id) {
    document.getElementById(id).classList.add('show');
    document.body.style.overflow = 'hidden';
}
function closeModal(id) {
    document.getElementById(id).classList.remove('show');
    document.body.style.overflow = '';
}
function closeModalOutside(e, id) {
    if (e.target === document.getElementById(id)) closeModal(id);
}
document.addEventListener('keydown', function(e) {
    if (e.key !== 'Escape') return;
    ['modalDetail','modalReject','modalApprove'].forEach(function(id) {
        document.getElementById(id).classList.remove('show');
    });
    document.body.style.overflow = '';
});

/* ── Alert ──────────────────────────────────────────────────── */
function showAlert(id, msg) {
    var el = document.getElementById(id);
    el.textContent   = msg;
    el.style.display = 'block';
    setTimeout(function() { el.style.display = 'none'; }, 4000);
}

/* ── Init ───────────────────────────────────────────────────── */
renderStats();
applyAllFilters();
</script>
</asp:Content>
