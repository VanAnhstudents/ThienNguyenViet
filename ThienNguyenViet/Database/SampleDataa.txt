-- =============================================
-- HỆ THỐNG QUẢN LÝ THIỆN NGUYỆN VIỆT
-- Mô tả: Dữ liệu mẫu để test giao diện
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
    (MaNguoiDung, HoTen,                 Email,                  MatKhau,                            SoDienThoai,  AnhDaiDien, VaiTro, TrangThai, NgayTao)
VALUES
    (1,           N'Admin',              'admin@thiennguyen.vn', '0192023a7bbd73250516f069df18b500', '0901000001', NULL,       1,      1,         '2026-03-17'),
    (2,           N'User',               'user@thiennguyen.vn',  '8ded46825e5b0a5c34d1c07451bb7474', '0901000002', NULL,       0,      1,         '2026-03-17'),
    (3,           N'Trần Thị Bình',      'binh.tran@gmail.com',  '8ded46825e5b0a5c34d1c07451bb7474', '0901000003', NULL,       0,      1,         '2026-01-10'),
    (4,           N'Lê Hoàng Minh',      'minh.le@gmail.com',    '8ded46825e5b0a5c34d1c07451bb7474', '0901000004', NULL,       0,      1,         '2026-01-15'),
    (5,           N'Phạm Thị Thu Hương', 'huong.pham@gmail.com', '8ded46825e5b0a5c34d1c07451bb7474', '0901000005', NULL,       0,      1,         '2026-01-20'),
    (6,           N'Vũ Đức Thắng',       'thang.vu@gmail.com',   '8ded46825e5b0a5c34d1c07451bb7474', '0901000006', NULL,       0,      1,         '2026-02-01'),
    (7,           N'Đỗ Thị Lan',         'lan.do@gmail.com',     '8ded46825e5b0a5c34d1c07451bb7474', '0901000007', NULL,       0,      1,         '2026-02-10'),
    (8,           N'Hoàng Văn Tú',       'tu.hoang@gmail.com',   '8ded46825e5b0a5c34d1c07451bb7474', '0901000008', NULL,       0,      0,         '2026-02-15')   -- tài khoản bị khóa để test
GO

-- Sửa Admin
UPDATE dbo.NguoiDung 
SET MatKhau = '0e7517141fb53f21ee439b355b5a1d0a'
WHERE Email = 'admin@thiennguyen.vn';

-- Sửa User
UPDATE dbo.NguoiDung 
SET MatKhau = '448ddd517d3abb70045aea6929f02367'
WHERE Email = 'user@thiennguyen.vn';


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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/f_auto,q_auto/v1774687216/bna_sc-4-2-.jpg_vudrrq.webp',
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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687425/hq720_ljdmer.jpg',
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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687482/ttce4-1-1755862041424840502276_dbtp4b.jpg',
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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687515/TAT09160-JPG-1772696261-2825-1772696449_pqhtr7.jpg',
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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687550/diem_20truong_201_nb75hg.jpg',
    400000000, 400000000,
    '2025-10-01', '2026-02-28',
    3, 0,
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
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687577/_MG_8946-1jpg_1685503315474_bvhro3.jpg',
    80000000, 15000000,
    '2026-03-15', '2026-04-15',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Thầy Thuốc Trẻ Việt Nam',
    1, '2026-03-15'
),
(
    7,
    N'Cứu trợ khẩn cấp sau bão số 5 tại miền Bắc',
    1,
    N'Hỗ trợ lương thực, nước sạch và nhu yếu phẩm cho hơn 2.000 hộ dân bị ảnh hưởng bởi bão số 5 tại Hải Phòng và Quảng Ninh.',
    N'<p>Bão số 5 đổ bộ vào đêm 10/02/2026 gây thiệt hại nặng nề tại Hải Phòng và Quảng Ninh. Hàng nghìn hộ dân thiếu lương thực và nước sạch. Chúng tôi cần khẩn cấp triển khai đoàn cứu trợ trong 48 giờ tới.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687611/93604a4d-9f95-4b11-b0f4-48756c44c239_bmegjv.jpg',
    600000000, 210000000,
    '2026-02-11', '2026-03-31',
    1, 0,
    N'Agribank', N'9876543210', N'Quỹ Thiện Nguyện Việt',
    N'Hội Chữ Thập Đỏ Hải Phòng',
    1, '2026-02-11'
),
(
    8,
    N'Tái thiết nhà ở cho nạn nhân sạt lở đất Quảng Nam',
    1,
    N'Xây dựng 30 căn nhà kiên cố cho các hộ dân mất nhà do sạt lở đất tại huyện Nam Giang, tỉnh Quảng Nam.',
    N'<p>Trận sạt lở đất tháng 1/2026 đã xóa sổ nhiều ngôi nhà tại Nam Giang. Hàng chục gia đình đang sống tạm bợ trong lều bạt giữa mùa mưa. Mỗi căn nhà tình thương cần 70–80 triệu đồng xây dựng.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687654/trai-17243222094641485087370_zczem0.jpg',
    2400000000, 880000000,
    '2026-01-20', '2026-07-20',
    1, 1,
    N'BIDV', N'1122334455', N'Quỹ Thiện Nguyện Việt',
    N'Ủy Ban MTTQ Tỉnh Quảng Nam',
    1, '2026-01-20'
),
(
    9,
    N'Hỗ trợ ngư dân sau thiên tai mất ngư cụ và tàu thuyền',
    1,
    N'Cung cấp ngư cụ và hỗ trợ sửa chữa tàu thuyền cho 150 hộ ngư dân tại Bình Thuận bị thiệt hại do bão.',
    N'<p>Cơn bão cuối năm 2025 đã làm hỏng hơn 80 tàu thuyền của ngư dân Bình Thuận. Không có phương tiện đánh bắt, các gia đình này mất nguồn thu nhập chính. Hỗ trợ của bạn sẽ giúp họ sớm ra khơi trở lại.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687699/ttxvn-bao-so-3_hafwef.jpg',
    900000000, 340000000,
    '2026-01-05', '2026-04-05',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Nghề Cá Bình Thuận',
    1, '2026-01-05'
),
(
    10,
    N'Cứu trợ hạn hán vùng Tây Nguyên 2026',
    1,
    N'Cung cấp nước sạch và hỗ trợ giống cây trồng cho bà con nông dân 3 tỉnh Đắk Lắk, Đắk Nông, Gia Lai bị thiệt hại do hạn hán kéo dài.',
    N'<p>Đợt hạn hán kéo dài từ tháng 11/2025 đã khiến hàng nghìn héc-ta cà phê, tiêu chết khô tại Tây Nguyên. Bà con nông dân cần hỗ trợ khẩn cấp về nước và giống để khôi phục sản xuất.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774710229/nong-dan-bac-tay-nguyen-lo-chong-han-han-mua-kho-2-1955.jpg_p7ktas.webp',
    700000000, 195000000,
    '2026-02-20', '2026-05-20',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Liên minh Hợp tác xã Tây Nguyên',
    1, '2026-02-20'
),
(
    11,
    N'Phục hồi sau lũ quét Sơn La – Điện Biên',
    1,
    N'Hỗ trợ lương thực, thuốc men và vật liệu xây dựng cho hơn 500 hộ dân bị ảnh hưởng bởi trận lũ quét tháng 8/2025 tại Sơn La và Điện Biên.',
    N'<p>Lũ quét tháng 8/2025 đã gây thiệt hại nghiêm trọng tại nhiều bản làng vùng cao. Nhiều tuyến đường vẫn bị chia cắt, việc tiếp cận người dân gặp nhiều khó khăn. Sự đóng góp của bạn sẽ giúp chúng tôi đưa hàng cứu trợ đến tận nơi.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774687978/images3236954_dien_bien3_1754042490927628117431_1754163249881117033038_2025_08_02_32_wa9fjb.jpg',
    450000000, 450000000,
    '2025-08-15', '2025-12-31',
    3, 0,
    N'Vietinbank', N'5566778899', N'Quỹ Thiện Nguyện Việt',
    N'Tỉnh Hội Chữ Thập Đỏ Sơn La',
    1, '2025-08-15'
),
(
    12,
    N'Tặng máy tính bảng cho học sinh nghèo học trực tuyến',
    2,
    N'Trao 200 máy tính bảng và gói data 12 tháng cho học sinh có hoàn cảnh khó khăn tại các tỉnh miền Trung và Tây Nguyên.',
    N'<p>Trong bối cảnh học trực tuyến ngày càng phổ biến, nhiều em học sinh nghèo không có thiết bị để học tập. Mỗi suất hỗ trợ bao gồm 1 máy tính bảng và gói data 12 tháng trị giá 3,5 triệu đồng.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688019/Hoc-Online-1_fcdih8.jpg',
    700000000, 280000000,
    '2026-02-15', '2026-05-15',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Quỹ Vì Tương Lai Việt Nam',
    1, '2026-02-15'
),
(
    13,
    N'Học bổng đại học cho con em gia đình chính sách',
    2,
    N'Trao 30 suất học bổng 20 triệu đồng/năm cho sinh viên là con em gia đình có công với cách mạng, hộ nghèo thi đỗ đại học năm 2026.',
    N'<p>Nhiều em học sinh con nhà nghèo thi đỗ đại học nhưng không có điều kiện theo học. Chương trình học bổng này sẽ đồng hành cùng các em trong suốt 4 năm đại học.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688049/z5049143604190-2ab4ea9cc6f9882448d400ceac0675c8-1682.jpg_dwwajs.webp',
    600000000, 120000000,
    '2026-03-01', '2026-08-31',
    1, 1,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Khuyến Học Việt Nam',
    1, '2026-03-01'
),
(
    14,
    N'Sửa chữa và trang bị lại thư viện trường tiểu học vùng sâu',
    2,
    N'Cải tạo và bổ sung 5.000 đầu sách cho thư viện 10 trường tiểu học tại các huyện nghèo tỉnh Kon Tum.',
    N'<p>Nhiều trường tiểu học vùng sâu Kon Tum chưa có thư viện đúng nghĩa. Các em thiếu sách đọc ngoài giờ học, hạn chế sự phát triển tư duy. Dự án sẽ mang đến 5.000 cuốn sách chất lượng và tủ sách kiên cố.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688095/sl1-1_w8cyfx.jpg',
    200000000, 75000000,
    '2026-03-05', '2026-06-05',
    1, 0,
    N'Agribank', N'9876543210', N'Quỹ Thiện Nguyện Việt',
    N'Sở Giáo Dục & Đào Tạo Kon Tum',
    1, '2026-03-05'
),
(
    15,
    N'Chương trình dạy nghề miễn phí cho thanh niên nông thôn',
    2,
    N'Đào tạo nghề điện dân dụng, hàn và may mặc miễn phí cho 300 thanh niên nông thôn tại Thanh Hóa.',
    N'<p>Hàng nghìn thanh niên nông thôn không có nghề nghiệp ổn định, phải tha phương kiếm sống. Chương trình đào tạo 3 tháng sẽ trang bị kỹ năng nghề nghiệp thiết thực, giúp các em tự lập.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688181/hoctap_utycke.jpg',
    350000000, 130000000,
    '2026-02-01', '2026-07-31',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Dạy Nghề Thanh Hóa',
    1, '2026-02-01'
),
(
    16,
    N'Mái ấm ký túc xá cho học sinh dân tộc cấp 3',
    2,
    N'Xây dựng khu ký túc xá 50 phòng cho học sinh dân tộc thiểu số theo học tại trường THPT nội trú huyện Mường Nhé, Điện Biên.',
    N'<p>Nhiều em học sinh phải đi bộ hàng chục km đến trường mỗi ngày hoặc bỏ học vì không có chỗ ở. Khu ký túc xá mới sẽ tạo điều kiện cho 200 em an tâm học tập.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688244/dantoctongiao.congly.vn-upload-content_img-2021-0820-_nha-truong-to-chuc-cho-hoc-sinh-hoc-bai-on-tap-vao-moi-buoi-toi-tu-19-21-gi_anh_1_hou2y3.jpg',
    3000000000, 1200000000,
    '2025-12-01', '2026-11-30',
    1, 1,
    N'BIDV', N'1122334455', N'Quỹ Thiện Nguyện Việt',
    N'UBND Huyện Mường Nhé',
    1, '2025-12-01'
),
(
    17,
    N'Cặp sách và đồ dùng học tập đầu năm cho trẻ em nghèo',
    2,
    N'Tặng bộ cặp sách, sách giáo khoa và dụng cụ học tập cho 1.000 học sinh tiểu học có hoàn cảnh khó khăn trước thềm năm học 2026–2027.',
    N'<p>Mỗi bộ học liệu trị giá 350.000 đồng sẽ giúp các em đến trường với đầy đủ tâm thế. Chương trình tập trung vào học sinh lớp 1 nhập học lần đầu tại các tỉnh miền núi.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688322/HS1_UTKU_mpdx1h.jpg',
    350000000, 90000000,
    '2026-03-15', '2026-07-15',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Quỹ Bảo Trợ Trẻ Em Việt Nam',
    1, '2026-03-15'
),

-- Danh mục 3: Y tế cộng đồng
(
    18,
    N'Tầm soát ung thư cổ tử cung miễn phí cho phụ nữ nghèo',
    3,
    N'Tổ chức khám và tầm soát ung thư cổ tử cung miễn phí cho 2.000 phụ nữ trong độ tuổi 25–55 tại Nghệ An và Hà Tĩnh.',
    N'<p>Ung thư cổ tử cung là căn bệnh có thể phòng ngừa và chữa khỏi nếu phát hiện sớm. Tuy nhiên, nhiều phụ nữ nghèo không có điều kiện tầm soát định kỳ. Chương trình sẽ mang dịch vụ y tế đến tận địa phương.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688364/ung-thu-1_wneouf.jpg',
    500000000, 220000000,
    '2026-02-10', '2026-05-10',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Bệnh Viện Ung Bướu Nghệ An',
    1, '2026-02-10'
),
(
    19,
    N'Cung cấp xe lăn cho người khuyết tật nghèo',
    3,
    N'Trao tặng 150 xe lăn chất lượng cao cho người khuyết tật có hoàn cảnh khó khăn tại TP.HCM và các tỉnh lân cận.',
    N'<p>Nhiều người khuyết tật phải di chuyển khó khăn hoặc phụ thuộc hoàn toàn vào gia đình vì không có xe lăn phù hợp. Mỗi chiếc xe lăn trị giá 3,5 triệu đồng sẽ mang lại sự độc lập cho người nhận.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688406/Xe-Lan-1_zwrfva.jpg',
    525000000, 315000000,
    '2026-01-10', '2026-04-10',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hội Bảo Trợ Người Khuyết Tật TP.HCM',
    1, '2026-01-10'
),
(
    20,
    N'Hỗ trợ bệnh nhân ung thư giai đoạn cuối',
    3,
    N'Tài trợ thuốc giảm đau, chăm sóc giảm nhẹ và hỗ trợ tâm lý cho 100 bệnh nhân ung thư giai đoạn cuối tại Hà Nội.',
    N'<p>Bệnh nhân ung thư giai đoạn cuối cần sự hỗ trợ toàn diện không chỉ về y tế mà còn về tâm lý và tinh thần. Chương trình sẽ cử đội ngũ tình nguyện viên và bác sĩ đến chăm sóc tại nhà.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688456/87e6848699430dda2892074ebdfb6a291732921948_udo5nu.jpg',
    800000000, 260000000,
    '2026-01-01', '2026-12-31',
    1, 1,
    N'Techcombank', N'3344556677', N'Quỹ Thiện Nguyện Việt',
    N'Bệnh Viện K Hà Nội',
    1, '2026-01-01'
),
(
    21,
    N'Phòng chống suy dinh dưỡng cho trẻ em dưới 5 tuổi',
    3,
    N'Cung cấp gói dinh dưỡng và hướng dẫn nuôi con khoa học cho 500 bà mẹ có con suy dinh dưỡng tại Lai Châu.',
    N'<p>Tỷ lệ suy dinh dưỡng trẻ em tại Lai Châu vẫn ở mức cao. Chương trình sẽ cấp phát gói thực phẩm bổ sung vi chất và tổ chức các buổi tư vấn dinh dưỡng miễn phí hàng tháng.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688504/A3_cwmsjn.jpg',
    250000000, 80000000,
    '2026-03-01', '2026-08-31',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Y Tế Dự Phòng Lai Châu',
    1, '2026-03-01'
),
(
    22,
    N'Mắt sáng cho người nghèo – Phẫu thuật đục thủy tinh thể',
    3,
    N'Hỗ trợ toàn bộ chi phí phẫu thuật đục thủy tinh thể cho 300 bệnh nhân nghèo tại các tỉnh miền núi phía Bắc.',
    N'<p>Đục thủy tinh thể là nguyên nhân gây mù lòa hàng đầu tại Việt Nam, nhưng hoàn toàn có thể chữa được bằng phẫu thuật. Chi phí mỗi ca khoảng 3–5 triệu đồng – quá cao với nhiều bệnh nhân nghèo vùng núi.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688542/z5771709276898_1fcc7b096d1ddfcf76c2798a8a5d108b-e1724745318391_fxem4v.jpg',
    1200000000, 450000000,
    '2025-11-01', '2026-06-30',
    1, 0,
    N'MB Bank', N'7788990011', N'Quỹ Thiện Nguyện Việt',
    N'Bệnh Viện Mắt Trung Ương',
    1, '2025-11-01'
),
(
    23,
    N'Xây dựng trạm y tế xã cho vùng biên giới Lạng Sơn',
    3,
    N'Xây dựng và trang bị đầy đủ thiết bị y tế cho trạm y tế xã Bắc Xa, huyện Đình Lập, Lạng Sơn.',
    N'<p>Xã Bắc Xa hiện chưa có trạm y tế kiên cố, người dân phải đi 40km để khám bệnh. Dự án xây dựng trạm y tế đạt chuẩn và trang bị thiết bị cơ bản sẽ phục vụ hơn 3.000 dân trong xã.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688578/tram-y-te-10013348_pkua3z.jpg',
    1500000000, 600000000,
    '2025-09-01', '2026-08-31',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Sở Y Tế Lạng Sơn',
    1, '2025-09-01'
),

-- Danh mục 4: Môi trường & Cây xanh
(
    24,
    N'Làm sạch bãi biển miền Trung – Hành trình xanh 2026',
    4,
    N'Tổ chức 10 chuyến làm sạch bãi biển tại Đà Nẵng, Quảng Nam và Thừa Thiên Huế, thu gom và xử lý rác thải nhựa.',
    N'<p>Rác thải nhựa đang tàn phá các bãi biển đẹp của miền Trung. Mỗi chuyến đi có 50–100 tình nguyện viên tham gia, cùng thiết bị thu gom và phân loại rác chuyên dụng.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688636/134364704734180213_drhgcm.jpg',
    120000000, 48000000,
    '2026-03-01', '2026-09-30',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Nghiên Cứu Môi Trường Biển',
    1, '2026-03-01'
),
(
    25,
    N'Trồng rừng ngập mặn bảo vệ đê biển Cà Mau',
    4,
    N'Trồng 50.000 cây đước và mắm tại các đoạn đê biển bị sạt lở tại huyện Ngọc Hiển và Năm Căn, tỉnh Cà Mau.',
    N'<p>Đê biển Cà Mau đang bị sạt lở nghiêm trọng do mất rừng ngập mặn. Việc trồng rừng sẽ giúp bảo vệ đê, chống xói mòn và tạo sinh kế cho người dân địa phương thông qua nuôi trồng thủy sản.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688675/de_zp6co5.jpg',
    800000000, 320000000,
    '2026-01-15', '2026-12-31',
    1, 1,
    N'Agribank', N'9876543210', N'Quỹ Thiện Nguyện Việt',
    N'Chi Cục Kiểm Lâm Cà Mau',
    1, '2026-01-15'
),
(
    26,
    N'Nước sạch cho bản làng – Xây bể lọc nước cộng đồng',
    4,
    N'Xây dựng 20 bể lọc nước cộng đồng phục vụ nước sinh hoạt sạch cho hơn 4.000 người dân tại các bản làng xa xôi ở Yên Bái.',
    N'<p>Nhiều bản làng tại Yên Bái đang sử dụng nước khe suối chưa qua xử lý, tiềm ẩn nguy cơ dịch bệnh cao. Mỗi bể lọc phục vụ 200 người và có tuổi thọ trên 20 năm.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688722/9d5a84c6_yrnh6j.jpg',
    400000000, 155000000,
    '2026-02-01', '2026-07-31',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Nước Sạch & VSMTNT Yên Bái',
    1, '2026-02-01'
),
(
    27,
    N'Xử lý rác thải tại các làng nghề truyền thống',
    4,
    N'Hỗ trợ trang thiết bị phân loại và xử lý rác thải cho 15 làng nghề tại Bắc Ninh và Hưng Yên nhằm giảm ô nhiễm môi trường.',
    N'<p>Các làng nghề truyền thống đang đối mặt với ô nhiễm nghiêm trọng từ rác thải sản xuất. Dự án trang bị máy phân loại rác, lò đốt đạt chuẩn và đào tạo nhân lực xử lý môi trường tại chỗ.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688759/129_elbfsg.jpg',
    550000000, 180000000,
    '2026-02-15', '2026-08-15',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Viện Khoa Học Môi Trường Việt Nam',
    1, '2026-02-15'
),
(
    28,
    N'Phủ xanh đồi trọc – Trồng cây tại Kon Tum',
    4,
    N'Trồng 30.000 cây bản địa trên 150 ha đồi trọc tại huyện Đắk Glei, tỉnh Kon Tum nhằm phục hồi hệ sinh thái rừng.',
    N'<p>Nạn phá rừng và khai thác gỗ trái phép đã để lại hàng trăm ha đồi trọc tại Kon Tum. Việc trồng lại rừng bằng cây bản địa sẽ giúp phục hồi hệ sinh thái và chống lũ quét cho vùng hạ lưu.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688799/anh_vi_van_chom_ben_trai_anh_nguoi_di_dau_trong_rung_tren_dat_bac_mau_o_thon_ti_tu_xa_dak_ha_huyen_tu_mo_rong_hxtecj.jpg',
    600000000, 90000000,
    '2026-03-10', '2026-11-10',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Hạt Kiểm Lâm Đắk Glei',
    1, '2026-03-10'
),
(
    29,
    N'Năng lượng mặt trời cho bản vùng cao chưa có điện',
    4,
    N'Lắp đặt 50 bộ pin năng lượng mặt trời cung cấp điện chiếu sáng và sinh hoạt cho 50 hộ gia đình tại bản Piềng Và, Sơn La.',
    N'<p>Bản Piềng Và vẫn chưa có điện lưới quốc gia. Trẻ em học bài dưới ánh đèn dầu, người dân không thể bảo quản thực phẩm. Mỗi bộ pin năng lượng mặt trời trị giá 15 triệu đồng sẽ thay đổi cuộc sống của cả gia đình.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688837/mang-anh-sang-dien-mat-troi-len-vung-cao-1024x533_gwt4vz.jpg',
    750000000, 225000000,
    '2026-01-20', '2026-06-20',
    1, 0,
    N'MB Bank', N'7788990011', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Phát Triển Năng Lượng Bền Vững',
    1, '2026-01-20'
),
(
    30,
    N'Vườn rau sạch học đường – Dinh dưỡng từ thiên nhiên',
    4,
    N'Xây dựng 30 vườn rau thủy canh và hữu cơ tại 30 trường tiểu học vùng nông thôn để cải thiện bữa ăn học đường.',
    N'<p>Bữa ăn bán trú tại nhiều trường vùng nông thôn còn nghèo nàn về dinh dưỡng. Vườn rau học đường không chỉ cung cấp rau xanh tươi mà còn giúp học sinh học về nông nghiệp và yêu thiên nhiên.</p>',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688874/rau-sach-vuon-truong-3.jpg_pvupzj.avif',
    300000000, 60000000,
    '2026-03-20', '2026-09-20',
    1, 0,
    N'Vietcombank', N'1234567890', N'Quỹ Thiện Nguyện Việt',
    N'Trung Tâm Nông Nghiệp Xanh Việt',
    1, '2026-03-20'
)
GO

SET IDENTITY_INSERT dbo.ChienDich OFF
GO

-- =============================================
-- 4. ẢNH CHIẾN DỊCH
-- =============================================

INSERT INTO dbo.AnhChienDich (MaChienDich, DuongDanAnh, MoTaAnh, ThuTu)
VALUES
-- Chiến dịch 1
(1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688926/xot-xa-canh-dan-do-mai-ngoi-chui-len-noc-nha-chay-lu-2305_lczrmc.jpg',      
N'Nhà dân bị ngập lụt', 1),
(1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774688965/cuu-tro-vung-lu-dak-lak-89788087014134974249376_tebkw7.png',      
N'Đoàn cứu trợ tiếp tế', 2),
(1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689087/s1_20251130161451_diughg.webp',      
N'Trao quà cho bà con', 3),
-- Chiến dịch 2
(2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689137/trao-hoc-bong-16674722607292122331172_v7iukv.jpg',    
N'Học sinh nhận học bổng',       1),
(2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689176/kh_C3_B4ng_20kh_C3_AD_pasehu.jpg',    
N'Lớp học vùng cao',             2),
-- Chiến dịch 3
(3, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689233/HMCL-Va-Lo-Thong-Lie-01_sutqyy.jpg',         
N'Bé được phẫu thuật thành công',1),
(3, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689267/692047cd949368cd3182_bghegx.jpg',         
N'Đội ngũ bác sĩ phẫu thuật',    2),
(3, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689303/C4_90o_C3_A0n_20thi_E1_BB_87n_20nguy_E1_BB_87n_20th_C4_83m_20h_E1_BB_8Fi_20c_C3_A1c_20em_20sau_20khi_20di_E1_BB_85n_20ra_20ph_E1_BA_ABu_20thu_E1_BA_ADt_bghnfl.jpg',                                    
N'Gia đình thăm bé sau phẫu thuật',3),
-- Chiến dịch 4
(4, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689350/443501_9e1217fc3ee45f2f43411dce85585bde_iwkwnx.png',                                    
N'Tình nguyện viên trồng cây',   1),
(4, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689386/ndo_tr_a3-2.jpg_ib44ol.avif',                                    
N'Cây xanh đã được trồng',       2),
-- Chiến dịch 5
(5, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689426/truong-hoc-o-tphcm-1760414869_j1wxbj.png',                                    
N'Phòng học cũ xuống cấp',       1),
(5, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689465/MAU-GIAO-BA-CHUC-1_moub43.jpg',                                    
N'Khởi công xây phòng học mới',  2),
(5, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689512/2014929144527708_tvjoqw.jpg',                                    
N'Phòng học hoàn thành',         3),
-- Chiến dịch 6
(6, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689561/589265327_1185597440339408_869036175892582253_n.jpg_qgpkx3.jpg',                                    
N'Đoàn y tế xuất phát',          1),
(6, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689601/news-171939245466548362ac_mibf4n.jpg',                                    
N'Khám bệnh cho người cao tuổi', 2),
-- Chiến dịch 7
(7, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689634/Hn_oxefru.jpg',                                    
N'Hiện trường sau bão',          1),
(7, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689680/dan-vung-lu-mien-trung_jejmss.jpg',                                    
N'Phát lương thực cứu trợ',      2),
(7, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689722/3011--chon-1-17999449759622309734095-59310749477719864170732_dl8paf.webp',                                    
N'Bà con nhận hàng hỗ trợ',      3),
-- Chiến dịch 8
(8, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689722/3011--chon-1-17999449759622309734095-59310749477719864170732_dl8paf.webp',                                    
N'Hiện trường sạt lở',           1),
(8, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689878/16_20250923211425_yt7oi7.jpg',                                    
N'Khởi công xây nhà tình thương',2),
(8, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689932/images2018212_0c2961a1e61854460d09_cqzy1j.jpg',                                    
N'Gia đình nhận nhà mới',        3),
-- Chiến dịch 9
(9, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774689970/t_tttbs9.jpg',                                    
N'Tàu thuyền hư hỏng sau bão',   1),
(9, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690027/tang-ngu-cu-3-1728743688_psxyfe.jpg',                                    
N'Trao ngư cụ cho ngư dân',      2),
-- Chiến dịch 10
(10, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690068/7-1584876188020_yitt6o.jpg',                                   
N'Ruộng đồng khô hạn',          1),
(10, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690103/a4132s3-8621.jpg_h7vp1s.avif',                                   
N'Cung cấp nước sạch',          2),
(10, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690181/2_20-_202021-04-05T085033.642_fgwg7p.jpg',                                   
N'Phát giống cây trồng',        3),
-- Chiến dịch 11
(11, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690181/2_20-_202021-04-05T085033.642_fgwg7p.jpg',                                   
N'Lũ quét tàn phá bản làng',    1),
(11, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690267/1762055951323_trao-qua-3_yujtu3.jpg',                                   
N'Đoàn tiếp tế vùng cô lập',    2),
-- Chiến dịch 12
(12, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690338/ho-tro-may-tinh-bang-16578574001211911958022_ixiqzm.png',                                   
N'Học sinh nhận máy tính bảng', 1),
(12, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690376/media-vov-vn_hoc_online2_gg9aif.jpg',                                   
N'Em học trực tuyến tại nhà',   2),
-- Chiến dịch 13
(13, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690421/359424256_684473943722401_2193265198830045215_n-compressed_ko5q9r.jpg',                                   
N'Lễ trao học bổng đại học',    1),
(13, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690471/hoc-bong-sinh-vien-dai-hoc-kinh-te-tai-chinh-tphcm-2-3106.jpg_r6sof9.webp',                                   
N'Sinh viên nhận học bổng',     2),
(13, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690513/cach-viet-ban-cam-ket-cua-hoc-sinh_1603114812_vity2c.webp',                                   
N'Cam kết học tập tốt',         3),
-- Chiến dịch 14
(14, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690669/Thu-Vien-2_fbqdpm.jpg',                                   
N'Thư viện cũ thiếu sách',      1),
(14, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690727/Untitled-3_enhqrv.jpg',                                   
N'Sách được đóng gói vận chuyển',2),
(14, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690769/van-hoa-doc-dong-hanh-cung-doi-moi-day-hoc3-6428-5755.jpg_acklb6.avif',                                   
N'Học sinh đọc sách mới',       3),
-- Chiến dịch 15
(15, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690805/hoc-nghe-dien-dan-dung-buoi-toi-2-jpeg_gqpnzh.jpg',                                   
N'Lớp học nghề điện',           1),
(15, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690889/cutting-metal-with-plasma-equipment-plant-min_ttxrql.jpg',                                   
N'Học viên thực hành hàn',      2),
-- Chiến dịch 16
(16, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690936/dung-tong-hop.00_01_43_06.still047_1_asbscy.jpg',                                   
N'Khởi công ký túc xá',        1),
(16, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774690936/dung-tong-hop.00_01_43_06.still047_1_asbscy.jpg',                                   
N'Ký túc xá đang xây dựng',    2),
(16, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691028/kinh-nghiem-o-ky-tuc-xa-1024x576_ujca2c.jpg',                                   
N'Học sinh về ở ký túc xá',    3),
-- Chiến dịch 17
(17, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691094/1._cac_suat_qua_tet_duoc_trao_tan_tay_den_nhung_gia_dinh_co_hoan_canh_kho_khan_o_vung_bien_xw7q48.jpg',                                   
N'Cặp sách được đóng gói',     1),
(17, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691133/1-1662423267_zmlsai.jpg',                                   
N'Trao cặp sách cho học sinh',  2),
-- Chiến dịch 18
(18, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691187/pink-day-2_gdl6wi.jpg',                                   
N'Khám tầm soát ung thư',      1),
(18, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691226/tuvan-16348781344811988992639_eg1lsc.jpg',                                   
N'Tư vấn sức khỏe phụ nữ',     2),
(18, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691286/kham-benh_twabey.jpg',                                   
N'Đoàn y tế tại địa phương',   3),
-- Chiến dịch 19
(19, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691405/kiem-dinh-chat-luong-xe-lan-y-te-1_jykgji.jpg',                                   
N'Xe lăn được kiểm tra chất lượng',1),
(19, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691441/tang_xe_lan_20240924153748_20240924163715_fh4ky6.jpg',                                   
N'Trao xe lăn cho người khuyết tật',2),
-- Chiến dịch 20
(20, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691494/271661617788102_lz2tr7.jpg',                                   
N'Bác sĩ chăm sóc tại nhà',    1),
(20, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691533/Tham-van-tam-ly-BN-e1685074592822_xdmkie.jpg',                                   
N'Tình nguyện viên hỗ trợ tâm lý',2),
(20, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691533/Tham-van-tam-ly-BN-e1685074592822_xdmkie.jpg',                                   
N'Phát thuốc giảm đau',        3),
-- Chiến dịch 21
(21, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691610/vn-11134207-820l4-mfxk3pj0rggda5_itf0r2.jpg',                                   
N'Phát gói dinh dưỡng',        1),
(21, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691672/133d1211156t39871l0_hpua0e.jpg',                                   
N'Tư vấn nuôi con khoa học',   2),
-- Chiến dịch 22
(22, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691753/phau-thuat-duc-thuy-tinh-the-3-1536x864_wh4wqp.jpg',                                   
N'Phẫu thuật đục thủy tinh thể',1),
(22, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691885/b1b-1-074634-140824-40_u9cktv.jpg',                                   
N'Bệnh nhân tháo băng sau mổ', 2),
(22, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691927/hien_giac_mac_1_pikiia.jpg',                                   
N'Bệnh nhân nhìn thấy ánh sáng',3),
-- Chiến dịch 23
(23, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774691977/75cf1aa9-2c1d-43cb-8b82-a5a7f881db81.jpg_we2sbz.avif',                                   
N'Nền móng trạm y tế mới',     1),
(23, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692019/tram-y-te-xajpg-1758632792062_dyv8uh.jpg',                                   
N'Trạm y tế đang xây dựng',    2),
-- Chiến dịch 24
(24, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692085/Rac-2_m9whln.jpg',                                   
N'Bãi biển trước khi dọn rác', 1),
(24, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692140/z5733741247272-aa2878c248b54dd8835e6bb71d5a16e3-7654_kjih7e.jpg',                                   
N'Tình nguyện viên thu gom rác',2),
(24, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692231/17171282000412262_sblwi0.jpg',                                   
N'Bãi biển sạch đẹp sau chiến dịch',3),
-- Chiến dịch 25
(25, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692389/trong-2000-cay-duoc-phu-xanh-rung-ngap-man-ven-bien-tai-khanh-hoa-7_qzvcv1.jpg',                                   
N'Trồng cây đước tại đê biển', 1),
(25, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692486/z6645484142527-d987dc60273e438e16702246b2a57930-24174669757638369924725_watpqn.webp',                                   
N'Rừng ngập mặn đang phục hồi',2),
-- Chiến dịch 26
(26, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692558/nguyen-lieu-xay-dung-be-loc-nuoc.jpg_cqyr8h.webp',                                   
N'Bể lọc nước đang xây dựng',  1),
(26, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692609/1-11-_aoiqj3.jpg',                                   
N'Người dân sử dụng nước sạch',2),
(26, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692697/tien-hanh-lap-dat-van-cho-be-loc.jpg_jlzxxk.webp',                                   
N'Bể lọc hoàn thành và hoạt động',3),
-- Chiến dịch 27
(27, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692743/hu_tich_tinh_bac_ninh_chi_dao_khan_1_zrnatz.jpg',                                   
N'Ô nhiễm tại làng nghề',      1),
(27, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692803/buong_20dotPicture1_282_29_yeh0ng.png',                                   
N'Lắp đặt thiết bị xử lý rác', 2),
-- Chiến dịch 28
(28, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774692839/momo-upload-api-230818094842-638279489227977009_wj1bny.jpg',                                   
N'Đồi trọc trước khi trồng cây',1),
(28, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693066/anh-1-4649_ydpezs.jpg',                                   
N'Tình nguyện viên trồng cây', 2),
(28, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693134/Cay-Sau-Bao-So-3-5-01_p7mx2z.jpg',                                   
N'Cây xanh mọc sau 3 tháng',   3),
-- Chiến dịch 29
(29, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693166/z5679124001516_0fb39fbd6df02e601b09d1a7df0ebf4c_20_1_plcinu.jpg',                                   
N'Bản làng chưa có điện',      1),
(29, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693204/dien_nang_luong_mat_troi-1_d7lmg6.jpg',                                   
N'Lắp đặt pin năng lượng mặt trời',2),
(29, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693242/tp-12_pwt8yi.jpg',                                   
N'Gia đình có điện thắp sáng', 3),
-- Chiến dịch 30
(30, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693274/rau-thuy-canh-chon-9-1681034130334482506345_quwsbf.jpg',                                   
N'Vườn rau thủy canh trường học',1),
(30, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693309/1946249251569303713_nugxeg.jpg',                                   
N'Học sinh chăm sóc rau',      2)
GO

-- =============================================
-- 5. CẬP NHẬT TIẾN ĐỘ
-- =============================================

INSERT INTO dbo.CapNhatTienDo (MaChienDich, TieuDe, NoiDung, AnhMinhHoa, MaNguoiDang, NgayDang)
VALUES
-- Chiến dịch 1
(1, N'Đợt 1: Đã trao 500 phần quà tại Quảng Bình',
    N'Ngày 05/03/2026, đoàn thiện nguyện đã trao 500 phần quà (mỗi phần trị giá 500.000đ) cho các hộ dân bị ảnh hưởng nặng nhất tại huyện Lệ Thủy, Quảng Bình.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693481/images1755118_20161122_125359.jpg_111_jgxzjw.jpg', 1, '2026-03-06'),
(1, N'Đợt 2: Hỗ trợ sửa chữa 30 căn nhà bị hư hỏng',
    N'Tiếp tục triển khai giai đoạn 2, đoàn đã hỗ trợ vật liệu xây dựng để sửa chữa 30 căn nhà bị hư hỏng do lũ tại Quảng Trị.',
    N'#', 1, '2026-03-15'),
-- Chiến dịch 2
(2, N'Đã xét duyệt và trao 20 suất học bổng đầu tiên',
    N'Ban tổ chức đã hoàn thành xét duyệt và trao 20 suất học bổng đầu tiên cho học sinh tại Hà Giang và Cao Bằng vào ngày 20/02/2026.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693518/z72502771918900459b516c44b83912016129f556de80f-17638939438891196658710_zysq6e.jpg', 1, '2026-02-21'),
(2, N'Tiếp tục xét duyệt đợt 2 – thêm 15 suất học bổng',
    N'Đợt 2 đang được tiến hành xét duyệt. Dự kiến 15 suất học bổng tiếp theo sẽ được trao vào đầu tháng 4/2026.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693783/THB-6_veyr8a.jpg', 1, '2026-03-10'),
-- Chiến dịch 3
(3, N'Ca phẫu thuật tim thành công đầu tiên',
    N'Bé Nguyễn Văn Khôi (8 tuổi, Cần Thơ) đã được phẫu thuật tim bẩm sinh thành công ngày 25/01/2026. Em đang hồi phục tốt tại bệnh viện.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693926/images2064893_IMG_4561_alupby.jpg', 1, '2026-01-26'),
(3, N'Thêm 4 ca phẫu thuật thành công trong tháng 2',
    N'Tháng 2/2026, chương trình đã hỗ trợ thêm 4 ca phẫu thuật tim bẩm sinh tại Bệnh viện Nhi Đồng 1. Tổng cộng 5/20 ca đã hoàn thành.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774693950/Rsz_Mot_Phut_Mac_Nie_w9hkvx.jpg', 1, '2026-03-01'),
-- Chiến dịch 4
(4, N'Lễ phát động trồng cây – 500 cây đầu tiên được trồng',
    N'Ngày 15/03/2026, lễ phát động chính thức diễn ra tại quận Hoài Đức. 500 cây xanh đầu tiên đã được trồng với sự tham gia của 200 tình nguyện viên.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694203/z7555995217779c120a105f7e2b713e7926ecb94ba9bef_hmpcye.jpg', 1, '2026-03-16'),
-- Chiến dịch 5
(5, N'Khởi công xây dựng phòng học mới',
    N'Ngày 10/10/2025, lễ khởi công chính thức diễn ra tại xã Lũng Cú. Toàn bộ vật liệu xây dựng đã được vận chuyển lên công trình.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694264/640899_640889_img_1072_10531010_11025310_qqlgom.jpg', 1, '2025-10-11'),
-- Chiến dịch 6
(6, N'Đoàn y tế xuất phát – Khám bệnh tại 2 xã đầu tiên',
    N'Ngày 18/03/2026, đoàn y tế gồm 15 bác sĩ và tình nguyện viên đã đến xã Yên Hợp và xã Lĩnh Sơn. Đã khám cho 320 người cao tuổi và cấp phát thuốc miễn phí.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694373/y-te1-17671731870712106336267_xsdstw.jpg', 1, '2026-03-19'),
-- Chiến dịch 7
(7, N'Cứu trợ khẩn cấp đợt 1 – 800 phần quà được trao',
    N'Ngay sau bão đổ bộ, đoàn cứu trợ đã tiếp cận các xã bị ảnh hưởng nặng nhất tại Hải Phòng. 800 phần quà gồm lương thực và nước uống đã được trao tận tay người dân.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694432/ctdvn2_drgboy.jpg', 1, '2026-02-14'),
-- Chiến dịch 8
(8, N'Khởi công 10 căn nhà đầu tiên tại Nam Giang',
    N'Ngày 01/02/2026, lễ khởi công 10 căn nhà tình thương đầu tiên đã diễn ra. Đội xây dựng gồm 30 người đang làm việc khẩn trương để hoàn thành trước mùa mưa.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694509/z6454024149488-3e7beec73aa8fc9a7464f3ca443803ad-4041-2823_wr6kjm.jpg', 1, '2026-02-02'),
-- Chiến dịch 9
(9, N'Trao 50 bộ ngư cụ cho ngư dân Bình Thuận',
    N'Ngày 20/01/2026, đoàn thiện nguyện đã trao 50 bộ ngư cụ (lưới, phao, dây neo) cho 50 hộ ngư dân bị thiệt hại nặng nhất tại huyện Tuy Phong.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694580/20240829_093625_o37grs.webp', 1, '2026-01-21'),
-- Chiến dịch 10
(10, N'Triển khai 5 điểm cấp nước sạch tại Đắk Lắk',
    N'Ngày 25/02/2026, 5 bể chứa nước dung tích 5.000 lít đã được lắp đặt tại các điểm tập trung dân cư ở huyện Krông Bông. Hơn 500 hộ dân đã có nước sạch sinh hoạt.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694610/Z7606330896145_D1f29_kbxr8p.jpg', 1, '2026-02-26'),
-- Chiến dịch 11
(11, N'Đoàn cứu trợ vượt đường khó tiếp cận bản bị cô lập',
    N'Sau 2 ngày di chuyển bằng xuồng và đi bộ, đoàn cứu trợ đã đến được 3 bản bị cô lập hoàn toàn. Lương thực và thuốc men khẩn cấp đã được phân phát.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694679/gui-hang-cuu-tro-1760863560-2874-1760864026_vzb0kk.jpg', 1, '2025-08-20'),
-- Chiến dịch 12
(12, N'Trao 80 máy tính bảng đợt 1 tại Quảng Ngãi',
    N'Ngày 01/03/2026, 80 máy tính bảng cùng gói data đầu tiên đã được trao cho 80 học sinh có hoàn cảnh khó khăn tại huyện Sơn Hà, Quảng Ngãi.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694783/IMG-1972-jpeg-1769494685-6504-1769494927_sbr4pe.jpg', 1, '2026-03-02'),
-- Chiến dịch 13
(13, N'Mở hồ sơ đăng ký học bổng đại học năm 2026',
    N'Chương trình chính thức nhận hồ sơ đăng ký từ ngày 05/03/2026. Đã có hơn 120 hồ sơ nộp về trong tuần đầu tiên.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694847/542753944_1196262112532697_1400971224063564916_n.jpg_pyy6ut.jpg', 1, '2026-03-12'),
-- Chiến dịch 14
(14, N'Vận chuyển 2.000 đầu sách đến Kon Tum',
    N'Ngày 18/03/2026, xe chở sách đã đến được 5 trong số 10 trường được hỗ trợ. Các em học sinh hào hứng chào đón những cuốn sách mới.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694889/3_moazgx.jpg', 1, '2026-03-19'),
-- Chiến dịch 15
(15, N'Khai giảng lớp học nghề điện dân dụng đầu tiên',
    N'Ngày 01/03/2026, lớp học nghề điện dân dụng đầu tiên với 30 học viên đã khai giảng tại Trung tâm dạy nghề huyện Hoằng Hóa, Thanh Hóa.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694925/T10a_zynu62.jpg', 1, '2026-03-02'),
-- Chiến dịch 16
(16, N'Hoàn thành phần móng và khung nhà ký túc xá',
    N'Sau 3 tháng thi công, phần móng và khung thép toàn bộ công trình đã hoàn thành. Dự kiến khu ký túc xá sẽ hoàn thành vào tháng 9/2026.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774694959/DJI_0879_g3l3cv.jpg', 1, '2026-03-05'),
-- Chiến dịch 17
(17, N'Hoàn tất đóng gói 500 bộ học liệu đợt 1',
    N'500 bộ cặp sách và dụng cụ học tập đã được đóng gói và sẵn sàng vận chuyển đến các tỉnh thụ hưởng. Dự kiến trao tặng vào cuối tháng 4/2026.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695006/1-can-bo-thue-tu-van-ho-kinh-doanh-17643801549601269811236_lqaurw.jpg', 1, '2026-03-22'),
-- Chiến dịch 18
(18, N'Hoàn thành khám tầm soát tại 3 xã đầu tiên ở Nghệ An',
    N'Từ ngày 15–20/02/2026, đoàn y tế đã khám tầm soát cho 620 phụ nữ tại 3 xã huyện Quỳnh Lưu, Nghệ An. Phát hiện 12 trường hợp cần theo dõi thêm và đã được tư vấn kịp thời.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695044/base64-17699989651861406443018_jjuqp6.jpg', 1, '2026-02-22'),
-- Chiến dịch 19
(19, N'Trao 50 xe lăn đợt 1 tại TP.HCM',
    N'Ngày 25/01/2026, lễ trao tặng 50 xe lăn đợt 1 đã diễn ra tại Trung tâm Bảo trợ Xã hội. Mỗi người nhận đã được hướng dẫn cách sử dụng và bảo quản xe.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695044/base64-17699989651861406443018_jjuqp6.jpg', 1, '2026-01-26'),
-- Chiến dịch 20
(20, N'Đội chăm sóc tại nhà đã phục vụ 35 bệnh nhân',
    N'Sau 2 tháng triển khai, đội ngũ tình nguyện viên và bác sĩ đã thực hiện hơn 200 lượt thăm khám tại nhà cho 35 bệnh nhân ung thư giai đoạn cuối tại Hà Nội.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695150/benhnn-17677776471121452450776_wx7fa8.jpg', 1, '2026-03-05'),
-- Chiến dịch 21
(21, N'Phát đợt 1 – 150 gói dinh dưỡng cho trẻ suy dinh dưỡng',
    N'Ngày 10/03/2026, 150 gói dinh dưỡng đầu tiên đã được phát cho 150 bà mẹ có con suy dinh dưỡng tại huyện Sìn Hồ, Lai Châu.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695187/image_c8xmol.avif', 1, '2026-03-11'),
-- Chiến dịch 22
(22, N'Hoàn thành 80 ca phẫu thuật đục thủy tinh thể',
    N'Tính đến cuối tháng 02/2026, chương trình đã hỗ trợ 80 ca phẫu thuật thành công. 78 bệnh nhân đã phục hồi thị lực tốt, 2 trường hợp đang được theo dõi thêm.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695217/img2036-1746069747945_xui3tk.jpg', 1, '2026-03-01'),
-- Chiến dịch 23
(23, N'Hoàn thành phần móng trạm y tế',
    N'Sau 2 tháng thi công, phần móng và tường bao của trạm y tế xã Bắc Xa đã hoàn thành. Dự kiến toàn bộ công trình hoàn thành vào tháng 6/2026.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695246/images2033440_z6909834807076_9fd02941117444c6d1aa0b9d5dadae0d_bidr93.jpg', 1, '2026-03-10'),
-- Chiến dịch 24
(24, N'Chuyến đi đầu tiên – Làm sạch bãi biển Mỹ Khê',
    N'Ngày 08/03/2026, 80 tình nguyện viên đã tham gia dọn rác tại bãi biển Mỹ Khê, Đà Nẵng. Thu gom được hơn 2 tấn rác thải, chủ yếu là rác nhựa.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695280/tp-don-ra-bien-da-nang-5-1285_dwau5m.jpg', 1, '2026-03-09'),
-- Chiến dịch 25
(25, N'Trồng 10.000 cây đước đầu tiên tại Ngọc Hiển',
    N'Ngày 20/01/2026, đợt trồng cây đước đầu tiên với sự tham gia của 150 người dân địa phương và tình nguyện viên. 10.000 cây đước đã được trồng trên 20 km đê biển.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695311/H7_yexu56.jpg', 1, '2026-01-21'),
-- Chiến dịch 26
(26, N'Hoàn thành và bàn giao 8 bể lọc nước tại Yên Bái',
    N'Ngày 28/02/2026, 8 bể lọc nước đầu tiên đã được bàn giao cho 8 bản làng tại huyện Mù Cang Chải. Hơn 1.600 người dân đã có nước sạch để sử dụng.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695356/2109_ban-giao-he-thong-loc-tong-gia-dinh-tai-yen-bai-1m3-h_ikiknl.jpg', 1, '2026-03-01'),
-- Chiến dịch 27
(27, N'Lắp đặt thiết bị phân loại rác tại 5 làng nghề đầu tiên',
    N'Từ ngày 20/02–15/03/2026, thiết bị phân loại và xử lý rác đã được lắp đặt tại 5 làng nghề dệt và gốm sứ tại Bắc Ninh. Tập huấn vận hành đang được triển khai.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695402/p1_m3vsov.jpg', 1, '2026-03-16'),
-- Chiến dịch 28
(28, N'Khởi động chiến dịch – 5.000 cây đầu tiên được trồng',
    N'Ngày 20/03/2026, lễ khởi động chính thức tại huyện Đắk Glei. 200 tình nguyện viên đã cùng nhau trồng 5.000 cây bản địa trên 25 ha đồi trọc trong ngày đầu tiên.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695533/Trong-Cay_xqpn9a.jpg', 1, '2026-03-21'),
-- Chiến dịch 29
(29, N'Lắp đặt thành công 20 bộ pin mặt trời đầu tiên',
    N'Ngày 05/02/2026, 20 bộ pin năng lượng mặt trời đầu tiên đã được lắp đặt và bàn giao cho 20 hộ gia đình tại bản Piềng Và. Lần đầu tiên trong lịch sử, bản có điện vào ban đêm.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695566/cong-nhan-lap-dat-he-thong-dien-mat-troi-175332288723019106929_kvgyfu.jpg', 1, '2026-02-06'),
-- Chiến dịch 30
(30, N'Khởi công xây dựng vườn rau tại 10 trường đầu tiên',
    N'Ngày 25/03/2026, công việc xây dựng luống rau thủy canh đã bắt đầu tại 10 trường tiểu học đầu tiên ở Vĩnh Long và Tiền Giang. Học sinh hào hứng tham gia trồng rau cùng thầy cô.',
    N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774695598/Ea4736053212e94cb003_gaaxun.jpg', 1, '2026-03-26')
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
(1, N'Thiện Nguyện Việt trao 500 phần quà cho bà con miền Trung',
    1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704570/thien_nguyen_1_20251128094359_bn5l6r.webp',
    N'Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình để trao tận tay 500 phần quà cho người dân vùng lũ.',
    N'<p>Ngày 05/03/2026, đoàn thiện nguyện gồm 30 thành viên đã lên đường đến Quảng Bình...</p>',
    1240, 1, 1, '2026-03-07'),
(2, N'Cậu bé 8 tuổi được cứu sống nhờ ca phẫu thuật tim từ quỹ từ thiện',
    2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704610/cau-be-co-trai-tim-nam-ngoai-co-the-duoc-phau-thuat-dua-tim-ve-dung-vi-tri-169255075763737702307_rs0s2f.jpg',
    N'Em Nguyễn Văn Khôi (8 tuổi, Cần Thơ) mắc bệnh tim bẩm sinh từ nhỏ. Nhờ sự hỗ trợ của chương trình, em đã được phẫu thuật thành công và hiện đang hồi phục tốt.',
    N'<p>Em Nguyễn Văn Khôi sinh ra đã mang trong mình căn bệnh tim bẩm sinh...</p>',
    3580, 1, 1, '2026-02-20'),
(3, N'Thông báo: Mở đăng ký tình nguyện viên đợt 2 năm 2026',
    3, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704685/5790cbe3-2b9b-4ae7-8df2-1e0ff2888ef9_szltjn.png',
    N'Thiện Nguyện Việt mở đăng ký tình nguyện viên cho các chuyến đi thiện nguyện dự kiến diễn ra trong tháng 4 và tháng 5/2026.',
    N'<p>Để đáp ứng nhu cầu ngày càng tăng của các chiến dịch, chúng tôi mở đăng ký tình nguyện viên đợt 2...</p>',
    892, 1, 1, '2026-03-12'),
(4, N'10.000 cây xanh sẽ được trồng tại Hà Nội trong tháng 4',
    1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704685/5790cbe3-2b9b-4ae7-8df2-1e0ff2888ef9_szltjn.png',
    N'Dự án trồng cây xanh do Thiện Nguyện Việt phối hợp với Trung tâm Bảo tồn Thiên nhiên Việt sẽ chính thức khởi động vào ngày 05/04/2026.',
    N'<p>Dự án trồng 10.000 cây xanh tại các quận ngoại thành Hà Nội chính thức khởi động...</p>',
    456, 1, 1, '2026-03-14'),
(5, N'Ngư dân Bình Thuận vươn khơi trở lại sau khi nhận hỗ trợ ngư cụ',
    2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704749/Ngu-Dan-4_cong4v.jpg',
    N'Sau gần 3 tháng không thể ra khơi vì tàu thuyền và ngư cụ bị bão phá hủy, 50 gia đình ngư dân Bình Thuận đã vươn khơi trở lại nhờ sự hỗ trợ của chương trình.',
    N'<p>Anh Nguyễn Văn Hải, ngư dân 42 tuổi tại Tuy Phong, không giấu được xúc động khi nhận bộ lưới mới từ đoàn thiện nguyện...</p>',
    1870, 1, 1, '2026-01-25'),
(6, N'Trường học mới tại Lũng Cú – Ước mơ đến trường của 80 em nhỏ',
    2, N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/1/19/779647/IMG_9755.jpg',
    N'Phòng học kiên cố mới tại điểm trường Lũng Cú đã chính thức được bàn giao. 80 em học sinh người Mông không còn phải học trong phòng học tạm bợ mưa dột.',
    N'<p>Nhìn những đôi mắt sáng ngời của các em học sinh trong ngày đầu tiên đến lớp mới, cô giáo Nguyễn Thị Hoa không kìm được nước mắt...</p>',
    2340, 1, 1, '2026-03-01'),
(7, N'Thông báo: Báo cáo tài chính quý 1/2026',
    3, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704822/44f85b067ea6f1f8a8b7_dnlnlp.jpg',
    N'Thiện Nguyện Việt công bố báo cáo tài chính quý 1/2026 với tổng số tiền quyên góp đã nhận và giải ngân đến từng chiến dịch.',
    N'<p>Tiếp tục cam kết minh bạch tài chính, Thiện Nguyện Việt công bố báo cáo thu chi chi tiết quý 1/2026...</p>',
    3120, 1, 1, '2026-03-25'),
(8, N'Bà mẹ nghèo và hành trình cứu con thoát khỏi bóng tối ung thư',
    2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704880/tp-don-ra-bien-da-nang-13-3166_zyevzx.jpg',
    N'Chị Trần Thị Mai ở Nghệ An từng tưởng chừng phải buông xuôi khi biết tin con gái mắc ung thư. Nhờ chương trình tầm soát miễn phí, ung thư được phát hiện sớm và điều trị thành công.',
    N'<p>Ngồi trong căn nhà nhỏ ở huyện Quỳnh Lưu, chị Trần Thị Mai nhớ lại cái ngày nhận được giấy xét nghiệm với kết quả dương tính...</p>',
    4250, 1, 1, '2026-02-28'),
(9, N'80 tình nguyện viên dọn sạch 2 tấn rác tại bãi biển Mỹ Khê',
    1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704880/tp-don-ra-bien-da-nang-13-3166_zyevzx.jpg',
    N'Chuyến làm sạch biển đầu tiên trong chuỗi sự kiện "Hành trình xanh 2026" đã diễn ra thành công với sự tham gia của 80 tình nguyện viên đến từ các trường đại học tại Đà Nẵng.',
    N'<p>Sáng sớm ngày 08/03/2026, bãi biển Mỹ Khê đã đón 80 bạn trẻ với găng tay và túi đựng rác cùng quyết tâm làm sạch bờ biển...</p>',
    980, 1, 1, '2026-03-10'),
(10, N'Chàng trai khuyết tật và chiếc xe lăn thay đổi cuộc đời',
    2, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774704901/khuyet-tat-16955843809171547137075_sl8xic.jpg',
    N'Anh Phạm Văn Đức (32 tuổi, TP.HCM) bị tai nạn giao thông năm 2022 khiến đôi chân mất khả năng đi lại. Chiếc xe lăn từ chương trình đã giúp anh tìm lại công việc và niềm tin vào cuộc sống.',
    N'<p>Trước khi nhận chiếc xe lăn, anh Đức gần như không ra khỏi nhà suốt 3 năm liền...</p>',
    5670, 1, 1, '2026-01-30')
GO

SET IDENTITY_INSERT dbo.TinTuc OFF
UPDATE dbo.TinTuc
SET AnhBia = N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774708758/IMG_9755_snwx2d.jpg'
WHERE MaTinTuc = 6;

GO

-- =============================================
-- 8. QUYÊN GÓP
-- =============================================

SET IDENTITY_INSERT dbo.QuyenGop ON

INSERT INTO dbo.QuyenGop
    (MaQuyenGop, MaChienDich, MaNguoiDung, SoTien, LoiNhan, AnDanh,
     AnhXacNhan, TrangThai, MaNguoiDuyet, NgayDuyet, NgayTao)
VALUES
-- *** Chiến dịch 1: Lũ lụt miền Trung ***
(1,  1, 2,    500000,     N'Chúc bà con sớm ổn định cuộc sống!',                 0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-02', '2026-03-02'),
(2,  1, 3,    200000,     N'Mong bà con vượt qua khó khăn.',                     0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705333/2tram_x1raxj.png',   1, 1,    '2026-03-03', '2026-03-03'),
(3,  1, NULL, 1000000,    NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-03-04', '2026-03-04'),
(4,  1, 4,    5000000,    N'Một chút tấm lòng gửi đến bà con.',                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2026-03-05', '2026-03-05'),
(5,  1, 5,    300000,     N'Cố lên bà con miền Trung!',                          0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   1, 1,    '2026-03-06', '2026-03-06'),
(6,  1, 6,    200000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705333/2tram_x1raxj.png',   0, NULL, NULL,         '2026-03-16'),

-- *** Chiến dịch 2: Học bổng ***
(7,  2, 2,    500000,     N'Chúc các em học giỏi!',                              0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-05', '2026-02-05'),
(8,  2, 7,    2000000,    N'Góp một phần nhỏ vì tương lai các em.',              0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2026-02-10', '2026-02-10'),
(9,  2, NULL, 500000,     NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-12', '2026-02-12'),

-- *** Chiến dịch 3: Tim bẩm sinh ***
(10, 3, 3,    1000000,    N'Cầu chúc các bé mau khỏe!',                          0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-01-20', '2026-01-20'),
(11, 3, 4,    500000,     N'Mong các bé sớm bình phục.',                         0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-01-22', '2026-01-22'),
(12, 3, 2,    300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   2, 1,    '2026-01-25', '2026-01-24'),

-- *** Chiến dịch 4: Cây xanh Hà Nội ***
(13, 4, 5,    500000,     N'Hà Nội xanh hơn mỗi ngày!',                          0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-12', '2026-03-12'),
(14, 4, 6,    300000,     N'Chung tay vì môi trường!',                           0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   1, 1,    '2026-03-13', '2026-03-13'),

-- *** Chiến dịch 5: Trường Lũng Cú (đã kết thúc) ***
(15, 5, 3,    2000000,    N'Các em xứng đáng được học trong phòng học tốt hơn!', 0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2025-10-05', '2025-10-05'),
(16, 5, 4,    5000000,    N'Chúc dự án thành công!',                             0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2025-10-10', '2025-10-10'),
(17, 5, NULL, 10000000,   NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705716/10trieu_tczyxo.png', 1, 1,    '2025-10-15', '2025-10-15'),

-- *** Chiến dịch 6: Khám bệnh người cao tuổi ***
(18, 6, 5,    500000,     N'Chúc chương trình thành công!',                      0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-16', '2026-03-16'),
(19, 6, 7,    200000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705333/2tram_x1raxj.png',   0, NULL, NULL,         '2026-03-17'),

-- *** Chiến dịch 7: Bão số 5 ***
(20, 7, 2,    1000000,    N'Hy vọng bà con Hải Phòng sớm khắc phục hậu quả!',    0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-12', '2026-02-12'),
(21, 7, 3,    500000,     N'Góp sức cùng đồng bào vượt bão!',                    0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-13', '2026-02-13'),
(22, 7, NULL, 2000000,    NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2026-02-14', '2026-02-14'),
(23, 7, 6,    300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   0, NULL, NULL,         '2026-03-20'),

-- *** Chiến dịch 8: Nhà tình thương Quảng Nam ***
(24, 8, 4,    10000000,   N'Mong các gia đình sớm có mái nhà mới!',              0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705716/10trieu_tczyxo.png', 1, 1,    '2026-01-25', '2026-01-25'),
(25, 8, 5,    2000000,    N'Một viên gạch nhỏ từ tôi!',                          0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2026-01-28', '2026-01-28'),
(26, 8, NULL, 5000000,    NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2026-02-01', '2026-02-01'),
  
-- *** Chiến dịch 9: Ngư dân Bình Thuận ***
(27, 9, 7,    1000000,    N'Chúc anh em ngư dân bình an ra khơi!',               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-01-08', '2026-01-08'),
(28, 9, 2,    500000,     N'Ủng hộ ngư dân Bình Thuận!',                         0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-01-10', '2026-01-10'),

-- *** Chiến dịch 10: Hạn hán Tây Nguyên ***
(29, 10, 3,   1000000,    N'Cầu mong Tây Nguyên sớm qua mùa hạn!',               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-22', '2026-02-22'),
(30, 10, NULL,500000,     NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-25', '2026-02-25'),

-- *** Chiến dịch 11: Lũ quét Sơn La (đã kết thúc) ***
(31, 11, 4,   3000000,    N'Cùng giúp đỡ bà con vùng cao!',                      0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705721/3trieu_srftfy.png',  1, 1,    '2025-08-18', '2025-08-18'),
(32, 11, 5,   1000000,    N'Tấm lòng từ Hà Nội gửi Sơn La.',                     0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2025-08-20', '2025-08-20'),

-- *** Chiến dịch 12: Máy tính bảng ***
(33, 12, 2,   500000,     N'Chúc các em học tốt!',                               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-18', '2026-02-18'),
(34, 12, 7,   1000000,    N'Hy vọng các em có công cụ học tập tốt!',             0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-20', '2026-02-20'),
(35, 12, 6,   300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   0, NULL, NULL,        '2026-03-18'),

-- *** Chiến dịch 13: Học bổng đại học ***
(36, 13, 3,   2000000,    N'Chúc các em sinh viên thành công!',                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2026-03-05', '2026-03-05'),
(37, 13, 4,   5000000,    N'Tương lai Việt Nam phụ thuộc vào các bạn trẻ!',      0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2026-03-08', '2026-03-08'),

-- *** Chiến dịch 14: Thư viện Kon Tum ***
(38, 14, 5,   500000,     N'Sách là cửa sổ nhìn ra thế giới!',                   0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-08', '2026-03-08'),
(39, 14, 2,   300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   1, 1,    '2026-03-10', '2026-03-10'),

-- *** Chiến dịch 15: Dạy nghề Thanh Hóa ***
(40, 15, 6,   1000000,    N'Chúc các bạn có nghề nghiệp ổn định!',               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-05', '2026-02-05'),
(41, 15, 7,   500000,     N'Ủng hộ thanh niên nông thôn có nghề!',               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-08', '2026-02-08'),

-- *** Chiến dịch 16: Ký túc xá Mường Nhé ***
(42, 16, 2,   5000000,    N'Mong các em học sinh có chỗ ở tốt!',                 0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2025-12-05', '2025-12-05'),
(43, 16, NULL,10000000,   NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705716/10trieu_tczyxo.png', 1, 1,    '2025-12-10', '2025-12-10'),
(44, 16, 3,   2000000,    N'Đầu tư cho giáo dục là đầu tư cho tương lai!',       0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2025-12-15', '2025-12-15'),

-- *** Chiến dịch 17: Cặp sách ***
(45, 17, 4,   500000,     N'Cho con em mình cặp sách mới đến trường!',           0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-18', '2026-03-18'),
(46, 17, 5,   300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   0, NULL, NULL,         '2026-03-20'),

-- *** Chiến dịch 18: Tầm soát ung thư ***
(47, 18, 6,   1000000,    N'Sức khỏe phụ nữ là tài sản quốc gia!',               0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-02-13', '2026-02-13'),
(48, 18, 7,   500000,     N'Phòng bệnh hơn chữa bệnh!',                          0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-02-15', '2026-02-15'),
(49, 18, 2,   200000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705333/2tram_x1raxj.png',   1, 1,    '2026-02-18', '2026-02-18'),

-- *** Chiến dịch 19: Xe lăn ***
(50, 19, 3,   1000000,    N'Mỗi bước đi tự do là một hạnh phúc!',                0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-01-12', '2026-01-12'),
(51, 19, 4,   500000,     N'Chúc các bạn khuyết tật vươn lên!',                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-01-15', '2026-01-15'),

-- *** Chiến dịch 20: Ung thư giai đoạn cuối ***
(52, 20, 5,   2000000,    N'Cầu nguyện cho các bệnh nhân được bình an!',         0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png',  1, 1,    '2026-01-05', '2026-01-05'),
(53, 20, NULL,5000000,    NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705342/5trieu_gaywhg.png',  1, 1,    '2026-01-08', '2026-01-08'),
(54, 20, 6,   1000000,    N'Chút lòng thành gửi đến những người đang bệnh.',     0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png',  1, 1,    '2026-01-12', '2026-01-12'),

-- *** Chiến dịch 21: Dinh dưỡng Lai Châu ***
(55, 21, 7,   500000,     N'Cho trẻ em được khỏe mạnh!',                         0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png',   1, 1,    '2026-03-04', '2026-03-04'),
(56, 21, 2,   300000,     NULL,                                                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705351/3tram_znjgo9.png',   0, NULL, NULL,         '2026-03-15'),

-- *** Chiến dịch 22: Phẫu thuật mắt ***
(57, 22, 3,   1000000,    N'Ánh sáng là quà tặng quý giá nhất!',                 0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png', 1, 1,     '2025-11-05', '2025-11-05'),
(58, 22, 4,   2000000,    N'Ủng hộ để người nghèo được nhìn thấy!',              0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png', 1, 1,     '2025-11-10', '2025-11-10'),
(59, 22, NULL,500000,     NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png', 1, 1,      '2025-11-12', '2025-11-12'),

-- *** Chiến dịch 23: Trạm y tế Lạng Sơn ***
(60, 23, 5,   3000000,    N'Y tế tốt cho vùng biên!',                            0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705721/3trieu_srftfy.png', 1, 1,     '2025-09-05', '2025-09-05'),
(61, 23, 6,   1000000,    N'Chúc công trình hoàn thành đúng tiến độ!',           0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705338/1trieu_vdwzbg.png', 1, 1,     '2025-09-10', '2025-09-10'),
(62, 23, NULL,2000000,    NULL,                                                  1, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705359/2trieu_qayhhy.png', 1, 1,     '2025-09-15', '2025-09-15'),

-- *** Chiến dịch 24: Làm sạch biển ***
(63, 24, 7,   500000,     N'Biển xanh là của chung mọi người!',                  0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705329/5tram_qd0wwd.png', 1, 1,      '2026-03-03', '2026-03-03'),
(64, 24, 2,   200000,     N'Hãy bảo vệ đại dương!',                              0, N'https://res.cloudinary.com/dwzzfzxjh/image/upload/v1774705333/2tram_x1raxj.png', 1, 1,      '2026-03-05', '2026-03-05')
GO

SET IDENTITY_INSERT dbo.QuyenGop OFF
GO