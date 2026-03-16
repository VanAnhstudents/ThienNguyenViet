# 🌿 Website Thiện Nguyện Việt

> Dự án môn Lập trình Website — HTML5 · CSS3 · JavaScript

---

## 👥 Thành viên nhóm

| Họ và tên | MSSV | Phụ trách |
|-----------|------|-----------|
| Dương Thùy Linh | 22A1001D0191 | Trang chủ, Giới thiệu, Liên hệ |
| Đinh Thị Trúc | 23A1001D0375 | Danh sách & Chi tiết chiến dịch, Quyên góp |
| Khuất Quang Duy Quý | 20A10010076 | Đăng nhập, Đăng ký, Hồ sơ, Lịch sử, Tin tức |
| Nguyễn Văn Anh | 23A1001D0020 | Toàn bộ trang Quản trị Admin |

---

## 📋 Mô tả dự án

**Thiện Nguyện Việt** là website hỗ trợ các hoạt động từ thiện và quyên góp cộng đồng tại Việt Nam. Website cho phép người dùng xem và tham gia các chiến dịch thiện nguyện thuộc nhiều lĩnh vực như cứu trợ thiên tai, học bổng giáo dục, y tế cộng đồng và môi trường.

**Tính năng chính:**
- Xem danh sách và chi tiết các chiến dịch thiện nguyện đang diễn ra
- Tham gia quyên góp và theo dõi tiến độ từng chiến dịch
- Đăng ký tài khoản, quản lý hồ sơ và lịch sử quyên góp
- Hệ thống quản trị (Admin) để tạo, chỉnh sửa và theo dõi các chiến dịch

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
|------------|-----------|
| Giao diện | HTML5, CSS3, JavaScript |
| Backend | ASP.NET Web Application (.NET Framework 4.x), C# |
| Cơ sở dữ liệu | SQL Server |
| IDE | Visual Studio 2019 / 2022 |

---

## ⚙️ Yêu cầu cài đặt

Trước khi chạy dự án, hãy đảm bảo máy tính đã có:

- **Visual Studio 2019 hoặc 2022** (có workload *ASP.NET and web development*)
- **SQL Server** (phiên bản Express trở lên)
- **SQL Server Management Studio (SSMS)**

---

## 🚀 Hướng dẫn cài đặt & chạy dự án

**Bước 1 — Tải dự án về máy**

```bash
git clone https://github.com/VanAnhstudents/ThienNguyenViet.git
cd ThienNguyenViet
```

**Bước 2 — Tạo cơ sở dữ liệu**

1. Mở **SQL Server Management Studio (SSMS)** và kết nối vào SQL Server
2. Mở file `CoSoDuLieu/TaoDatabase.sql` rồi nhấn **F5** để chạy
3. (Tuỳ chọn) Chạy thêm file `CoSoDuLieu/DuLieuMau.sql` để có dữ liệu thử nghiệm

**Bước 3 — Cấu hình kết nối Database**

Mở file `Web.config`, tìm thẻ `<connectionStrings>` và sửa lại:

```xml
<connectionStrings>
  <add name="ThienNguyenDB"
       connectionString="Data Source=TÊN_SERVER_SQL;Initial Catalog=ThienNguyenViet;Integrated Security=True"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

> Thay `TÊN_SERVER_SQL` bằng tên SQL Server trên máy bạn.  
> Thường gặp: `localhost`, `.\SQLEXPRESS`, `(localdb)\MSSQLLocalDB`

**Bước 4 — Mở và chạy**

1. Mở file `ThienNguyenViet.sln` bằng Visual Studio
2. Nhấn **F5** hoặc nút **▶ IIS Express**
3. Trình duyệt tự mở tại `http://localhost:[port]/`

---

## 📁 Cấu trúc dự án

```
ThienNguyenViet/
│
├── Admin/                          # Trang quản trị (chỉ Admin)
│   ├── TongQuan.aspx               # Dashboard thống kê
│   ├── QuanLyChienDich.aspx        # Danh sách + CRUD chiến dịch
│   ├── FormChienDich.aspx          # Form thêm / sửa chiến dịch
│   ├── QuanLyNguoiDung.aspx        # Quản lý tài khoản
│   ├── QuanLyQuyenGop.aspx         # Duyệt giao dịch quyên góp
│   ├── QuanLyTinTuc.aspx           # CRUD tin tức
│   └── BaoCao.aspx                 # Biểu đồ & xuất báo cáo
│
├── App_Code/                       # Lớp C# dùng chung
│   ├── KetNoiDB.cs                 # Kết nối & truy vấn SQL
│   ├── ChienDichDAO.cs             # Xử lý dữ liệu chiến dịch
│   ├── QuyenGopDAO.cs              # Xử lý dữ liệu quyên góp
│   ├── NguoiDungDAO.cs             # Xử lý dữ liệu người dùng
│   ├── TinTucDAO.cs                # Xử lý dữ liệu tin tức
│   └── PhanQuyenHelper.cs          # Kiểm tra đăng nhập & phân quyền
│
├── Content/                        # CSS, hình ảnh, font chữ
│   ├── css/
│   │   ├── style.css               # CSS trang người dùng
│   │   └── admin.css               # CSS trang admin
│   └── images/
│       ├── logo.png
│       └── chien-dich-mac-dinh.jpg
│
├── Scripts/                        # JavaScript
│   ├── script.js                   # JS trang người dùng
│   └── admin.js                    # JS trang admin
│
├── Database/                       # Script SQL
│   ├── Schema.sql                  # Tạo DB và tất cả bảng
│   └── SampleData.sql              # Dữ liệu mẫu để test
│
├── Uploads/                         # Ảnh do người dùng tải lên (không lưu trên Git)
│   ├── ChienDich/
│   ├── TinTuc/
│   └── XacNhanChuyenKhoan/
│
├── TrangChu.aspx                   # Trang chủ
├── DanhSachChienDich.aspx          # Danh sách chiến dịch
├── ChiTietChienDich.aspx           # Chi tiết một chiến dịch
├── QuyenGop.aspx                   # Trang thực hiện quyên góp
├── DanhSachTinTuc.aspx             # Danh sách tin tức
├── ChiTietTinTuc.aspx              # Nội dung bài viết
├── GioiThieu.aspx                  # Giới thiệu tổ chức
├── LienHe.aspx                     # Form liên hệ
├── DangNhap.aspx                   # Đăng nhập
├── DangKy.aspx                     # Đăng ký tài khoản
├── HoSo.aspx                       # Hồ sơ cá nhân
├── LichSuQuyenGop.aspx             # Lịch sử quyên góp
│
├── Site.Master                     # Master Page người dùng (Header/Footer)
├── Admin.Master                    # Master Page admin (Sidebar)
├── Web.config                      # Cấu hình ứng dụng & kết nối DB
├── Global.asax
├── ThienNguyenViet.sln
├── .gitignore
└── README.md
```

---

## 🔐 Tài khoản mặc định (dữ liệu mẫu)

| Vai trò | Email | Mật khẩu |
|---------|-------|----------|
| Admin | admin@thiennguyen.vn | Admin@123 |
| User | user@thiennguyen.vn | User@123 |

---

## 📬 Liên hệ

Mọi thắc mắc về kỹ thuật hay vấn đề khác, vui lòng liên hệ:

**Nguyễn Văn Anh**
- 📧 [anhnguyenvan280105@gmail.com](mailto:anhnguyenvan280105@gmail.com)
- 📧 [23a1001d0020@students.hou.edu.vn](mailto:23a1001d0020@students.hou.edu.vn)
- 🐛 Hoặc tạo [Issue](https://github.com/VanAnhstudents/ThienNguyenViet/issues) trực tiếp trên GitHub

___

## 📄 Giấy phép

Dự án được thực hiện cho mục đích học tập — môn Lập trình Website.