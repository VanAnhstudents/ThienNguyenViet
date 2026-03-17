-- =============================================
-- HỆ THỐNG QUẢN LÝ THIỆN NGUYỆN VIỆT
-- Mô tả: Dữ liệu mẫu để test giao diện
-- Lưu ý: Chạy file TaoDatabase.sql TRƯỚC
-- =============================================

USE ThienNguyenViet
GO

-- =============================================
-- 1. NGƯỜI DÙNG
-- Mật khẩu gốc: Admin@123  → hash MD5: 0192023a7bbd73250516f069df18b500
-- Mật khẩu gốc: User@123   → hash MD5: 8ded46825e5b0a5c34d1c07451bb7474
-- =============================================

SET IDENTITY_INSERT dbo.NguoiDung ON

INSERT INTO dbo.NguoiDung
    (MaNguoiDung, HoTen,                   Email,                   MatKhau,                            SoDienThoai,    AnhDaiDien,                       VaiTro, TrangThai,  NgayTao)
VALUES
    (1,           N'Admin',                'admin@thiennguyen.vn',  '0192023a7bbd73250516f069df18b500', '0901000001',   '/Content/images/avt-admin.jpg',  1,      1,          '2026-03-17'),
    (2,           N'User',                 'user@thiennguyen.vn',   '8ded46825e5b0a5c34d1c07451bb7474', '0901000002',   '/Content/images/avt-user.jpg',   0,      1,          '2026-03-17'),
    (3,           N'Trần Thị Bình',        'binh.tran@gmail.com',   '8ded46825e5b0a5c34d1c07451bb7474', '0901000003',   NULL,                             0,      1,          '2026-01-10'),
    (4,           N'Lê Hoàng Minh',        'minh.le@gmail.com',     '8ded46825e5b0a5c34d1c07451bb7474', '0901000004',   NULL,                             0,      1,          '2026-01-15'),
    (5,           N'Phạm Thị Thu Hương',   'huong.pham@gmail.com',  '8ded46825e5b0a5c34d1c07451bb7474', '0901000005',   NULL,                             0,      1,          '2026-01-20'),
    (6,           N'Vũ Đức Thắng',         'thang.vu@gmail.com',    '8ded46825e5b0a5c34d1c07451bb7474', '0901000006',   NULL,                             0,      1,          '2026-02-01'),
    (7,           N'Đỗ Thị Lan',           'lan.do@gmail.com',      '8ded46825e5b0a5c34d1c07451bb7474', '0901000007',   NULL,                             0,      1,          '2026-02-10'),
    (8,           N'Hoàng Văn Tú',         'tu.hoang@gmail.com',    '8ded46825e5b0a5c34d1c07451bb7474', '0901000008',   NULL,                             0,      0,          '2026-02-15')   -- tài khoản bị khóa để test
GO

SET IDENTITY_INSERT dbo.NguoiDung OFF
GO

-- =============================================
-- 2. DANH MỤC CHIẾN DỊCH
-- =============================================

SET IDENTITY_INSERT dbo.DanhMucChienDich ON

INSERT INTO dbo.DanhMucChienDich
    (MaDanhMuc, TenDanhMuc,               MoTa,                                      MauSac,    ThuTuHienThi)
VALUES
    (1,         N'Cứu trợ thiên tai',     N'Hỗ trợ đồng bào bị ảnh hưởng thiên tai', '#E53E3E', 1),
    (2,         N'Học bổng & Giáo dục',   N'Hỗ trợ học sinh, sinh viên khó khăn',    '#3182CE', 2),
    (3,         N'Y tế cộng đồng',        N'Hỗ trợ chăm sóc sức khỏe cộng đồng',     '#D69E2E', 3),
    (4,         N'Môi trường & Cây xanh', N'Bảo vệ môi trường và trồng cây xanh',    '#38A169', 4)
GO

SET IDENTITY_INSERT dbo.DanhMucChienDich OFF
GO

-- =============================================
-- 3. CHIẾN DỊCH
-- =============================================

SET IDENTITY_INSERT dbo.ChienDich ON

INSERT INTO dbo.ChienDich
    (MaChienDich, TenChienDich, MaDanhMuc, MoTaNgan, NoiDungChiTiet, AnhBia,
     MucTieu, SoTienDaQuyen, NgayBatDau, NgayKetThuc, TrangThai, NoiBat,
     TenNganHang, SoTaiKhoan, TenChuTaiKhoan, ToChucChuTri, MaNguoiTao, NgayTao)
VALUES
(
    1,
    N'Hỗ trợ đồng bào lũ lụt miền Trung 2026',
    1,
    N'Quyên góp hỗ trợ người dân miền Trung bị ảnh hưởng bởi đợt lũ lịch sử tháng 3/2026.',
    N'<p>Đợt mưa lũ lịch sử tháng 3/2026 đã gây thiệt hại nặng nề tại các tỉnh miền Trung. Hàng nghìn hộ dân mất nhà cửa, hoa màu bị cuốn trôi. Mỗi đóng góp của bạn sẽ được chuyển trực tiếp đến tay người dân vùng lũ.</p>',
    N'/Uploads/ChienDich/lu-lut-mien-trung.jpg',
    500000000, 320000000,
    '2026-03-01', '2026-04-30',
    1, 1,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Chữ Thập Đỏ Việt Nam',
    1, '2026-03-01'
),
(
    2,
    N'Học bổng "Thắp sáng ước mơ" cho học sinh vùng cao',
    2,
    N'Trao học bổng cho 50 học sinh dân tộc thiểu số có hoàn cảnh khó khăn tại các tỉnh miền núi phía Bắc.',
    N'<p>Chương trình học bổng <strong>Thắp sáng ước mơ</strong> hỗ trợ các em học sinh dân tộc thiểu số tại Hà Giang, Cao Bằng, Lào Cai với mức 2 triệu đồng/học sinh/tháng.</p>',
    N'/Uploads/ChienDich/hoc-bong-vung-cao.jpg',
    300000000, 185000000,
    '2026-02-01', '2026-05-31',
    1, 1,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Quỹ Hỗ Trợ Giáo Dục Miền Núi',
    1, '2026-02-01'
),
(
    3,
    N'Phẫu thuật tim miễn phí cho trẻ em nghèo',
    3,
    N'Hỗ trợ chi phí phẫu thuật tim bẩm sinh cho 20 trẻ em có hoàn cảnh khó khăn tại các tỉnh đồng bằng sông Cửu Long.',
    N'<p>Mỗi ca phẫu thuật tim bẩm sinh tốn khoảng 80–120 triệu đồng. Nhiều gia đình không đủ điều kiện tài chính để cứu con em mình. Hãy cùng chúng tôi mang lại cơ hội sống cho các em.</p>',
    N'/Uploads/ChienDich/phau-thuat-tim.png',
    2000000000, 950000000,
    '2026-01-15', '2026-06-30',
    1, 1,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Bệnh Viện Nhi Đồng 1 TP.HCM',
    1, '2026-01-15'
),
(
    4,
    N'Trồng 10.000 cây xanh tại Hà Nội',
    4,
    N'Dự án trồng cây xanh tại các khu vực ven đô Hà Nội nhằm cải thiện chất lượng không khí và môi trường sống.',
    N'<p>Hà Nội đang đối mặt với tình trạng ô nhiễm không khí nghiêm trọng. Dự án trồng 10.000 cây xanh tại các quận ngoại thành sẽ góp phần cải thiện chất lượng môi trường cho người dân thủ đô.</p>',
    N'/Uploads/ChienDich/trong-cay-xanh.jpg',
    150000000, 62000000,
    '2026-03-10', '2026-05-10',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Bảo Tồn Thiên Nhiên Việt',
    1, '2026-03-10'
),
(
    5,
    N'Xây dựng điểm trường cho trẻ em Hà Giang',
    2,
    N'Xây dựng 1 phòng học kiên cố thay thế phòng học tạm bợ đang xuống cấp tại xã Lũng Cú, huyện Đồng Văn, Hà Giang.',
    N'<p>Điểm trường Lũng Cú hiện có 3 phòng học tạm bằng gỗ đã xuống cấp nghiêm trọng, ảnh hưởng đến việc học của 80 em học sinh. Chúng tôi cần xây dựng phòng học kiên cố trước mùa mưa 2026.</p>',
    N'/Uploads/ChienDich/xay-truong-ha-giang.jpg',
    400000000, 400000000,
    '2025-10-01', '2026-02-28',
    3, 0,  -- Đã kết thúc
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Tổ Chức Nhịp Cầu Hoàng Sa',
    1, '2025-10-01'
),
(
    6,
    N'Khám chữa bệnh miễn phí cho người cao tuổi',
    3,
    N'Tổ chức đoàn y tế lưu động khám và cấp thuốc miễn phí cho người cao tuổi tại 5 xã vùng sâu tỉnh Nghệ An.',
    N'<p>Nhiều người cao tuổi tại vùng sâu Nghệ An không có điều kiện đến cơ sở y tế do địa hình khó khăn và chi phí đi lại. Chương trình sẽ đưa bác sĩ về tận nơi khám và cấp thuốc miễn phí.</p>',
    N'/Uploads/ChienDich/kham-benh-mien-phi.jpg',
    80000000, 15000000,
    '2026-03-15', '2026-04-15',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Thầy Thuốc Trẻ Việt Nam',
    1, '2026-03-15'
)
GO

SET IDENTITY_INSERT dbo.ChienDich OFF
GO

-- =============================================
-- 4. ẢNH CHIẾN DỊCH (gallery)
-- =============================================

INSERT INTO dbo.AnhChienDich (MaChienDich, DuongDanAnh, MoTaAnh, ThuTu)
VALUES
    (1, N'/Uploads/ChienDich/lu-lut-1.jpg',      N'Nhà dân bị ngập lụt',         1),
    (1, N'/Uploads/ChienDich/lu-lut-2.jpg',      N'Đoàn cứu trợ tiếp tế',        2),
    (1, N'/Uploads/ChienDich/lu-lut-3.jpg',      N'Trao quà cho bà con',         3),
    (2, N'/Uploads/ChienDich/hoc-sinh-1.jpg',    N'Học sinh nhận học bổng',       1),
    (2, N'/Uploads/ChienDich/hoc-sinh-2.jpg',    N'Lớp học vùng cao',            2),
    (3, N'/Uploads/ChienDich/tim-1.jpg',         N'Bé được phẫu thuật thành công',1),
    (3, N'/Uploads/ChienDich/tim-2.jpg',         N'Đội ngũ bác sĩ phẫu thuật',   2)
GO

-- =============================================
-- 5. CẬP NHẬT TIẾN ĐỘ
-- =============================================

INSERT INTO dbo.CapNhatTienDo (MaChienDich, TieuDe, NoiDung, AnhMinhHoa, MaNguoiDang, NgayDang)
VALUES
(
    1,
    N'Đợt 1: Đã trao 500 phần quà tại Quảng Bình',
    N'Ngày 05/03/2026, đoàn thiện nguyện đã trao 500 phần quà (mỗi phần trị giá 500.000đ) cho các hộ dân bị ảnh hưởng nặng nhất tại huyện Lệ Thủy, Quảng Bình.',
    N'/Uploads/ChienDich/tienDo-lu-1.jpg',
    1, '2026-03-06'
),
(
    1,
    N'Đợt 2: Hỗ trợ sửa chữa 30 căn nhà bị hư hỏng',
    N'Tiếp tục triển khai giai đoạn 2, đoàn đã hỗ trợ vật liệu xây dựng để sửa chữa 30 căn nhà bị hư hỏng do lũ tại Quảng Trị.',
    N'/Uploads/ChienDich/tienDo-lu-2.jpg',
    1, '2026-03-15'
),
(
    2,
    N'Đã xét duyệt và trao 20 suất học bổng đầu tiên',
    N'Ban tổ chức đã hoàn thành xét duyệt và trao 20 suất học bổng đầu tiên cho học sinh tại Hà Giang và Cao Bằng vào ngày 20/02/2026.',
    N'/Uploads/ChienDich/tienDo-hoc-sinh-1.jpg',
    1, '2026-02-21'
)
GO

-- =============================================
-- 6. DANH MỤC TIN TỨC
-- =============================================

SET IDENTITY_INSERT dbo.DanhMucTinTuc ON

INSERT INTO dbo.DanhMucTinTuc 
    (MaDanhMuc, TenDanhMuc,                    ThuTuHienThi)
VALUES
    (1,         N'Hoạt động thiện nguyện',     1),
    (2,         N'Câu chuyện truyền cảm hứng', 2),
    (3,         N'Thông báo',                  3)
GO

SET IDENTITY_INSERT dbo.DanhMucTinTuc OFF
GO

-- =============================================
-- 7. TIN TỨC
-- =============================================

SET IDENTITY_INSERT dbo.TinTuc ON

INSERT INTO dbo.TinTuc
    (MaTinTuc, TieuDe, MaDanhMuc, AnhBia, TomTat, NoiDung, LuotXem, TrangThai, MaNguoiDang, NgayDang)
VALUES
(
    1,
    N'Thiện Nguyện Việt trao 500 phần quà cho bà con miền Trung',
    1,
    N'/Uploads/TinTuc/tin-1.jpg',
    N'Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình để trao tận tay 500 phần quà cho người dân vùng lũ.',
    N'<p>Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình...</p>',
    1240, 1, 1, '2026-03-07'
),
(
    2,
    N'Cậu bé 8 tuổi được cứu sống nhờ ca phẫu thuật tim từ quỹ từ thiện',
    2,
    N'/Uploads/TinTuc/tin-2.png',
    N'Em Nguyễn Văn Khôi (8 tuổi, Cần Thơ) mắc bệnh tim bẩm sinh từ nhỏ. Nhờ sự hỗ trợ của chương trình, em đã được phẫu thuật thành công và hiện đang hồi phục tốt.',
    N'<p>Em Nguyễn Văn Khôi sinh ra đã mang trong mình căn bệnh tim bẩm sinh...</p>',
    3580, 1, 1, '2026-02-20'
),
(
    3,
    N'Thông báo: Mở đăng ký tình nguyện viên đợt 2 năm 2026',
    3,
    N'/Uploads/TinTuc/tin-3.jpg',
    N'Thiện Nguyện Việt mở đăng ký tình nguyện viên cho các chuyến đi thiện nguyện dự kiến diễn ra trong tháng 4 và tháng 5/2026.',
    N'<p>Để đáp ứng nhu cầu ngày càng tăng của các chiến dịch, chúng tôi mở đăng ký tình nguyện viên đợt 2...</p>',
    892, 1, 1, '2026-03-12'
),
(
    4,
    N'10.000 cây xanh sẽ được trồng tại Hà Nội trong tháng 4',
    1,
    N'/Uploads/TinTuc/tin-4.jpg',
    N'Dự án trồng cây xanh do Thiện Nguyện Việt phối hợp với Trung tâm Bảo tồn Thiên nhiên Việt sẽ chính thức khởi động vào ngày 05/04/2026.',
    N'<p>Dự án trồng 10.000 cây xanh tại các quận ngoại thành Hà Nội chính thức khởi động...</p>',
    456, 1, 1, '2026-03-14'
)
GO

SET IDENTITY_INSERT dbo.TinTuc OFF
GO

-- =============================================
-- 8. QUYÊN GÓP
-- =============================================

SET IDENTITY_INSERT dbo.QuyenGop ON

INSERT INTO dbo.QuyenGop
    (MaQuyenGop, MaChienDich, MaNguoiDung, SoTien, LoiNhan, AnDanh,
     AnhXacNhan, TrangThai, MaNguoiDuyet, NgayDuyet, NgayTao)
VALUES
-- Chiến dịch 1: Lũ lụt miền Trung
(1,  1, 2,    500000,     N'Chúc bà con sớm ổn định cuộc sống!', 0, N'/Uploads/XacNhanChuyenKhoan/ck-001.png', 1, 1,    '2026-03-02', '2026-03-02'),
(2,  1, 3,    200000,     N'Mong bà con vượt qua khó khăn.',     0, N'/Uploads/XacNhanChuyenKhoan/ck-002.png', 1, 1,    '2026-03-03', '2026-03-03'),
(3,  1, NULL, 1000000,    NULL,                                  1, N'/Uploads/XacNhanChuyenKhoan/ck-003.png', 1, 1,    '2026-03-04', '2026-03-04'),  -- ẩn danh
(4,  1, 4,    5000000,    N'Một chút tấm lòng gửi đến bà con.',  0, N'/Uploads/XacNhanChuyenKhoan/ck-004.png', 1, 1,    '2026-03-05', '2026-03-05'),
(5,  1, 5,    300000,     N'Cố lên bà con miền Trung!',          0, N'/Uploads/XacNhanChuyenKhoan/ck-005.png', 1, 1,    '2026-03-06', '2026-03-06'),
(6,  1, 6,    200000,     NULL,                                  0, N'/Uploads/XacNhanChuyenKhoan/ck-006.png', 0, NULL, NULL,         '2026-03-16'),  -- chờ duyệt

-- Chiến dịch 2: Học bổng
(7,  2, 2,    500000,     N'Chúc các em học giỏi!',                   0, N'/Uploads/XacNhanChuyenKhoan/ck-007.png', 1, 1, '2026-02-05', '2026-02-05'),
(8,  2, 7,    2000000,    N'Góp một phần nhỏ vì tương lai các em.',   0, N'/Uploads/XacNhanChuyenKhoan/ck-008.png', 1, 1, '2026-02-10', '2026-02-10'),
(9,  2, NULL, 500000,     NULL,                                        1, N'/Uploads/XacNhanChuyenKhoan/ck-009.png', 1, 1, '2026-02-12', '2026-02-12'),  -- ẩn danh

-- Chiến dịch 3: Tim bẩm sinh
(10, 3, 3,    1000000,    N'Cầu chúc các bé mau khỏe!',              0, N'/Uploads/XacNhanChuyenKhoan/ck-010.png', 1, 1, '2026-01-20', '2026-01-20'),
(11, 3, 4,    500000,     N'Mong các bé sớm bình phục.',              0, N'/Uploads/XacNhanChuyenKhoan/ck-011.png', 1, 1, '2026-01-22', '2026-01-22'),
(12, 3, 2,    300000,     NULL,                                        0, N'/Uploads/XacNhanChuyenKhoan/ck-012.png', 2, 1, '2026-01-25', '2026-01-24'),  -- từ chối (trùng)

-- Chiến dịch 6: Khám bệnh miễn phí
(13, 6, 5,    500000,     N'Chúc chương trình thành công!',           0, N'/Uploads/XacNhanChuyenKhoan/ck-013.png', 1, 1, '2026-03-16', '2026-03-16'),
(14, 6, 7,    200000,     NULL,                                        0, N'/Uploads/XacNhanChuyenKhoan/ck-014.png', 0, NULL, NULL,         '2026-03-17')   -- chờ duyệt
GO

SET IDENTITY_INSERT dbo.QuyenGop OFF
GO

-- Cập nhật lý do từ chối cho giao dịch bị từ chối
UPDATE dbo.QuyenGop
SET LyDoTuChoi = N'Ảnh xác nhận chuyển khoản không hợp lệ, trùng với giao dịch đã duyệt.'
WHERE MaQuyenGop = 12
GO

-- =============================================
-- 9. THÔNG BÁO MẪU
-- =============================================

INSERT INTO dbo.ThongBao (MaNguoiDung, TieuDe, NoiDung, DuongDanLienKet, DaDoc, NgayTao)
VALUES
(2, N'Quyên góp của bạn đã được xác nhận',
   N'Khoản quyên góp 500.000đ của bạn cho chiến dịch "Hỗ trợ đồng bào lũ lụt miền Trung 2026" đã được xác nhận thành công.',
   N'/ChiTietChienDich.aspx?id=1', 1, '2026-03-02'),

(2, N'Quyên góp của bạn đã được xác nhận',
   N'Khoản quyên góp 500.000đ của bạn cho chiến dịch "Học bổng Thắp sáng ước mơ" đã được xác nhận thành công.',
   N'/ChiTietChienDich.aspx?id=2', 0, '2026-02-05'),

(3, N'Chiến dịch bạn tham gia đã cập nhật tiến độ',
   N'Chiến dịch "Hỗ trợ đồng bào lũ lụt miền Trung 2026" vừa có cập nhật tiến độ mới. Nhấn để xem chi tiết.',
   N'/ChiTietChienDich.aspx?id=1', 0, '2026-03-16'),

(6, N'Quyên góp của bạn đang chờ xác nhận',
   N'Khoản quyên góp 200.000đ của bạn đang chờ admin xác nhận. Thường mất 1–2 ngày làm việc.',
   N'/LichSuQuyenGop.aspx', 0, '2026-03-16')
GO