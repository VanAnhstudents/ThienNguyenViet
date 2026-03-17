-- =============================================
-- HỆ THỐNG QUẢN LÝ THIỆN NGUYỆN VIỆT
-- Mô tả: Tạo toàn bộ cơ sở dữ liệu cho dự án
-- Ngày tạo: 2026
-- =============================================

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ThienNguyenViet')
BEGIN
    CREATE DATABASE ThienNguyenViet
    COLLATE Vietnamese_CI_AS
END
GO

USE ThienNguyenViet
GO

-- =============================================
-- BẢNG 1: NGƯỜI DÙNG
-- =============================================

CREATE TABLE dbo.NguoiDung (
    MaNguoiDung     INT             IDENTITY(1,1)   NOT NULL,
    HoTen           NVARCHAR(100)                   NOT NULL,
    Email           NVARCHAR(150)                   NOT NULL,
    MatKhau         NVARCHAR(255)                   NOT NULL,   -- lưu dạng hash (MD5)
    SoDienThoai     NVARCHAR(15)                    NULL,
    AnhDaiDien      NVARCHAR(255)                   NULL,       -- đường dẫn file ảnh
    VaiTro          TINYINT                         NOT NULL    -- 0 = Người dùng, 1 = Admin
                    CONSTRAINT DF_NguoiDung_VaiTro DEFAULT 0,
    TrangThai       TINYINT                         NOT NULL    -- 0 = Bị khóa, 1 = Hoạt động
                    CONSTRAINT DF_NguoiDung_TrangThai DEFAULT 1,
    NgayTao         DATETIME                        NOT NULL
                    CONSTRAINT DF_NguoiDung_NgayTao DEFAULT GETDATE(),
    NgayCapNhat     DATETIME                        NULL,

    CONSTRAINT PK_NguoiDung         PRIMARY KEY (MaNguoiDung),
    CONSTRAINT UQ_NguoiDung_Email   UNIQUE      (Email),
    CONSTRAINT CK_NguoiDung_VaiTro  CHECK (VaiTro  IN (0, 1)),
    CONSTRAINT CK_NguoiDung_TrangThai CHECK (TrangThai IN (0, 1))
)
GO

-- =============================================
-- BẢNG 2: DANH MỤC CHIẾN DỊCH
-- =============================================

CREATE TABLE dbo.DanhMucChienDich (
    MaDanhMuc       INT             IDENTITY(1,1)   NOT NULL,
    TenDanhMuc      NVARCHAR(100)                   NOT NULL,
    MoTa            NVARCHAR(255)                   NULL,
    MauSac          NVARCHAR(20)                    NULL,       -- mã màu hex, vd: #E53E3E
    ThuTuHienThi    INT                             NOT NULL
                    CONSTRAINT DF_DanhMucCD_ThuTu DEFAULT 0,

    CONSTRAINT PK_DanhMucChienDich PRIMARY KEY (MaDanhMuc)
)
GO

-- =============================================
-- BẢNG 3: CHIẾN DỊCH
-- =============================================

CREATE TABLE dbo.ChienDich (
    MaChienDich         INT             IDENTITY(1,1)   NOT NULL,
    TenChienDich        NVARCHAR(200)                   NOT NULL,
    MaDanhMuc           INT                             NOT NULL,
    MoTaNgan            NVARCHAR(300)                   NULL,       -- hiện trên card danh sách
    NoiDungChiTiet      NVARCHAR(MAX)                   NULL,       -- HTML rich text
    AnhBia              NVARCHAR(255)                   NULL,       -- ảnh thumbnail chính
    MucTieu             DECIMAL(18, 0)                  NOT NULL    -- số tiền mục tiêu (VNĐ)
                        CONSTRAINT DF_ChienDich_MucTieu DEFAULT 0,
    SoTienDaQuyen       DECIMAL(18, 0)                  NOT NULL    -- tổng tiền đã được duyệt
                        CONSTRAINT DF_ChienDich_SoTienDaQuyen DEFAULT 0,
    NgayBatDau          DATE                            NOT NULL,
    NgayKetThuc         DATE                            NOT NULL,
    TrangThai           TINYINT                         NOT NULL    -- 0=Nháp, 1=Đang chạy, 2=Tạm dừng, 3=Đã kết thúc
                        CONSTRAINT DF_ChienDich_TrangThai DEFAULT 0,
    NoiBat              BIT                             NOT NULL    -- 1 = ghim lên trang chủ
                        CONSTRAINT DF_ChienDich_NoiBat DEFAULT 0,
    TenNganHang         NVARCHAR(100)                   NULL,
    SoTaiKhoan          NVARCHAR(50)                    NULL,
    TenChuTaiKhoan      NVARCHAR(100)                   NULL,
    ToChucChuTri        NVARCHAR(200)                   NULL,
    MaNguoiTao          INT                             NOT NULL,
    NgayTao             DATETIME                        NOT NULL
                        CONSTRAINT DF_ChienDich_NgayTao DEFAULT GETDATE(),
    NgayCapNhat         DATETIME                        NULL,

    CONSTRAINT PK_ChienDich             PRIMARY KEY (MaChienDich),
    CONSTRAINT FK_ChienDich_DanhMuc     FOREIGN KEY (MaDanhMuc)   REFERENCES dbo.DanhMucChienDich (MaDanhMuc),
    CONSTRAINT FK_ChienDich_NguoiTao    FOREIGN KEY (MaNguoiTao)  REFERENCES dbo.NguoiDung        (MaNguoiDung),
    CONSTRAINT CK_ChienDich_TrangThai   CHECK (TrangThai IN (0, 1, 2, 3)),
    CONSTRAINT CK_ChienDich_MucTieu     CHECK (MucTieu >= 0),
    CONSTRAINT CK_ChienDich_NgayHopLe  CHECK (NgayKetThuc > NgayBatDau)
)
GO

-- =============================================
-- BẢNG 4: ẢNH CHIẾN DỊCH (gallery)
-- =============================================

CREATE TABLE dbo.AnhChienDich (
    MaAnh           INT             IDENTITY(1,1)   NOT NULL,
    MaChienDich     INT                             NOT NULL,
    DuongDanAnh     NVARCHAR(255)                   NOT NULL,
    MoTaAnh         NVARCHAR(200)                   NULL,
    ThuTu           INT                             NOT NULL
                    CONSTRAINT DF_AnhChienDich_ThuTu DEFAULT 0,
    NgayTao         DATETIME                        NOT NULL
                    CONSTRAINT DF_AnhChienDich_NgayTao DEFAULT GETDATE(),

    CONSTRAINT PK_AnhChienDich          PRIMARY KEY (MaAnh),
    CONSTRAINT FK_AnhChienDich_ChienDich FOREIGN KEY (MaChienDich) REFERENCES dbo.ChienDich (MaChienDich)
        ON DELETE CASCADE   -- xóa chiến dịch → tự xóa ảnh liên quan
)
GO

-- =============================================
-- BẢNG 5: QUYÊN GÓP
-- =============================================

CREATE TABLE dbo.QuyenGop (
    MaQuyenGop      INT             IDENTITY(1,1)   NOT NULL,
    MaChienDich     INT                             NOT NULL,
    MaNguoiDung     INT                             NULL,       -- NULL nếu quyên góp ẩn danh
    SoTien          DECIMAL(18, 0)                  NOT NULL,
    LoiNhan         NVARCHAR(500)                   NULL,
    AnDanh          BIT                             NOT NULL    -- 1 = ẩn danh
                    CONSTRAINT DF_QuyenGop_AnDanh DEFAULT 0,
    AnhXacNhan      NVARCHAR(255)                   NULL,       -- ảnh chụp màn hình chuyển khoản
    TrangThai       TINYINT                         NOT NULL    -- 0=Chờ duyệt, 1=Đã duyệt, 2=Từ chối
                    CONSTRAINT DF_QuyenGop_TrangThai DEFAULT 0,
    LyDoTuChoi      NVARCHAR(300)                   NULL,       -- lý do nếu từ chối
    MaNguoiDuyet    INT                             NULL,       -- admin duyệt
    NgayDuyet       DATETIME                        NULL,
    NgayTao         DATETIME                        NOT NULL
                    CONSTRAINT DF_QuyenGop_NgayTao DEFAULT GETDATE(),

    CONSTRAINT PK_QuyenGop              PRIMARY KEY (MaQuyenGop),
    CONSTRAINT FK_QuyenGop_ChienDich    FOREIGN KEY (MaChienDich)   REFERENCES dbo.ChienDich  (MaChienDich),
    CONSTRAINT FK_QuyenGop_NguoiDung    FOREIGN KEY (MaNguoiDung)   REFERENCES dbo.NguoiDung  (MaNguoiDung),
    CONSTRAINT FK_QuyenGop_NguoiDuyet   FOREIGN KEY (MaNguoiDuyet)  REFERENCES dbo.NguoiDung  (MaNguoiDung),
    CONSTRAINT CK_QuyenGop_SoTien       CHECK (SoTien > 0),
    CONSTRAINT CK_QuyenGop_TrangThai    CHECK (TrangThai IN (0, 1, 2))
)
GO

-- =============================================
-- BẢNG 6: CẬP NHẬT TIẾN ĐỘ CHIẾN DỊCH
-- =============================================

CREATE TABLE dbo.CapNhatTienDo (
    MaCapNhat       INT             IDENTITY(1,1)   NOT NULL,
    MaChienDich     INT                             NOT NULL,
    TieuDe          NVARCHAR(200)                   NOT NULL,
    NoiDung         NVARCHAR(MAX)                   NOT NULL,
    AnhMinhHoa      NVARCHAR(255)                   NULL,
    MaNguoiDang     INT                             NOT NULL,
    NgayDang        DATETIME                        NOT NULL
                    CONSTRAINT DF_CapNhatTienDo_NgayDang DEFAULT GETDATE(),

    CONSTRAINT PK_CapNhatTienDo             PRIMARY KEY (MaCapNhat),
    CONSTRAINT FK_CapNhatTienDo_ChienDich   FOREIGN KEY (MaChienDich)  REFERENCES dbo.ChienDich (MaChienDich)
        ON DELETE CASCADE,
    CONSTRAINT FK_CapNhatTienDo_NguoiDang   FOREIGN KEY (MaNguoiDang)  REFERENCES dbo.NguoiDung (MaNguoiDung)
)
GO

-- =============================================
-- BẢNG 7: DANH MỤC TIN TỨC
-- =============================================

CREATE TABLE dbo.DanhMucTinTuc (
    MaDanhMuc       INT             IDENTITY(1,1)   NOT NULL,
    TenDanhMuc      NVARCHAR(100)                   NOT NULL,
    ThuTuHienThi    INT                             NOT NULL
                    CONSTRAINT DF_DanhMucTT_ThuTu DEFAULT 0,

    CONSTRAINT PK_DanhMucTinTuc PRIMARY KEY (MaDanhMuc)
)
GO

-- =============================================
-- BẢNG 8: TIN TỨC
-- =============================================

CREATE TABLE dbo.TinTuc (
    MaTinTuc        INT             IDENTITY(1,1)   NOT NULL,
    TieuDe          NVARCHAR(250)                   NOT NULL,
    MaDanhMuc       INT                             NOT NULL,
    AnhBia          NVARCHAR(255)                   NULL,
    TomTat          NVARCHAR(400)                   NULL,       -- mô tả ngắn hiện trên card
    NoiDung         NVARCHAR(MAX)                   NULL,       -- HTML rich text
    LuotXem         INT                             NOT NULL
                    CONSTRAINT DF_TinTuc_LuotXem DEFAULT 0,
    TrangThai       TINYINT                         NOT NULL    -- 0=Nháp, 1=Đã đăng
                    CONSTRAINT DF_TinTuc_TrangThai DEFAULT 0,
    MaNguoiDang     INT                             NOT NULL,
    NgayDang        DATETIME                        NOT NULL
                    CONSTRAINT DF_TinTuc_NgayDang DEFAULT GETDATE(),
    NgayCapNhat     DATETIME                        NULL,

    CONSTRAINT PK_TinTuc                PRIMARY KEY (MaTinTuc),
    CONSTRAINT FK_TinTuc_DanhMuc        FOREIGN KEY (MaDanhMuc)    REFERENCES dbo.DanhMucTinTuc (MaDanhMuc),
    CONSTRAINT FK_TinTuc_NguoiDang      FOREIGN KEY (MaNguoiDang)  REFERENCES dbo.NguoiDung     (MaNguoiDung),
    CONSTRAINT CK_TinTuc_TrangThai      CHECK (TrangThai IN (0, 1)),
    CONSTRAINT CK_TinTuc_LuotXem        CHECK (LuotXem >= 0)
)
GO

-- =============================================
-- BẢNG 9: THÔNG BÁO
-- =============================================

CREATE TABLE dbo.ThongBao (
    MaThongBao      INT             IDENTITY(1,1)   NOT NULL,
    MaNguoiDung     INT                             NOT NULL,
    TieuDe          NVARCHAR(200)                   NOT NULL,
    NoiDung         NVARCHAR(500)                   NOT NULL,
    DuongDanLienKet NVARCHAR(255)                   NULL,       -- link khi click vào thông báo
    DaDoc           BIT                             NOT NULL
                    CONSTRAINT DF_ThongBao_DaDoc DEFAULT 0,
    NgayTao         DATETIME                        NOT NULL
                    CONSTRAINT DF_ThongBao_NgayTao DEFAULT GETDATE(),

    CONSTRAINT PK_ThongBao          PRIMARY KEY (MaThongBao),
    CONSTRAINT FK_ThongBao_NguoiDung FOREIGN KEY (MaNguoiDung) REFERENCES dbo.NguoiDung (MaNguoiDung)
        ON DELETE CASCADE
)
GO

-- =============================================
-- BẢNG 10: LỊCH SỬ ĐĂNG NHẬP
-- =============================================

CREATE TABLE dbo.LichSuDangNhap (
    MaLichSu        INT             IDENTITY(1,1)   NOT NULL,
    MaNguoiDung     INT                             NOT NULL,
    DiaChiIP        NVARCHAR(50)                    NULL,
    ThietBi         NVARCHAR(200)                   NULL,       -- User-Agent trình duyệt
    KetQua          BIT                             NOT NULL    -- 0 = thất bại, 1 = thành công
                    CONSTRAINT DF_LichSuDangNhap_KetQua DEFAULT 1,
    NgayDangNhap    DATETIME                        NOT NULL
                    CONSTRAINT DF_LichSuDangNhap_Ngay DEFAULT GETDATE(),

    CONSTRAINT PK_LichSuDangNhap            PRIMARY KEY (MaLichSu),
    CONSTRAINT FK_LichSuDangNhap_NguoiDung  FOREIGN KEY (MaNguoiDung) REFERENCES dbo.NguoiDung (MaNguoiDung)
        ON DELETE CASCADE
)
GO

-- =============================================
-- TẠO INDEX ĐỂ TĂNG TỐC TRUY VẤN
-- =============================================

-- Tìm kiếm chiến dịch theo tên
CREATE INDEX IDX_ChienDich_TenChienDich     ON dbo.ChienDich    (TenChienDich)
CREATE INDEX IDX_ChienDich_TrangThai        ON dbo.ChienDich    (TrangThai)
CREATE INDEX IDX_ChienDich_MaDanhMuc        ON dbo.ChienDich    (MaDanhMuc)
CREATE INDEX IDX_ChienDich_NoiBat           ON dbo.ChienDich    (NoiBat)
CREATE INDEX IDX_ChienDich_NgayKetThuc      ON dbo.ChienDich    (NgayKetThuc)

-- Tìm quyên góp theo chiến dịch, người dùng, trạng thái
CREATE INDEX IDX_QuyenGop_MaChienDich       ON dbo.QuyenGop     (MaChienDich)
CREATE INDEX IDX_QuyenGop_MaNguoiDung       ON dbo.QuyenGop     (MaNguoiDung)
CREATE INDEX IDX_QuyenGop_TrangThai         ON dbo.QuyenGop     (TrangThai)
CREATE INDEX IDX_QuyenGop_NgayTao           ON dbo.QuyenGop     (NgayTao)

-- Tìm tin tức
CREATE INDEX IDX_TinTuc_TrangThai           ON dbo.TinTuc       (TrangThai)
CREATE INDEX IDX_TinTuc_MaDanhMuc           ON dbo.TinTuc       (MaDanhMuc)
CREATE INDEX IDX_TinTuc_NgayDang            ON dbo.TinTuc       (NgayDang)

-- Thông báo chưa đọc
CREATE INDEX IDX_ThongBao_MaNguoiDung       ON dbo.ThongBao     (MaNguoiDung)
CREATE INDEX IDX_ThongBao_DaDoc             ON dbo.ThongBao     (DaDoc)
GO

-- =============================================
-- TẠO STORED PROCEDURE
-- =============================================

-- SP1: Lấy danh sách chiến dịch (có phân trang, lọc)
CREATE OR ALTER PROCEDURE dbo.SP_LayDanhSachChienDich
    @MaDanhMuc      INT     = NULL,
    @TrangThai      TINYINT = NULL,
    @TuKhoa         NVARCHAR(200) = NULL,
    @SapXepTheo     NVARCHAR(50)  = N'NgayTao',  -- NgayTao | MucTieu | SoTienDaQuyen | NgayKetThuc
    @TrangHienTai   INT = 1,
    @SoDoiMoiTrang  INT = 9
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BatDauTu INT = (@TrangHienTai - 1) * @SoDoiMoiTrang;

    ;WITH ChienDichBase AS
    (
        SELECT
            cd.MaChienDich,
            cd.TenChienDich,
            cd.MoTaNgan,
            cd.AnhBia,
            cd.MucTieu,
            cd.SoTienDaQuyen,
            cd.NgayBatDau,
            cd.NgayKetThuc,
            cd.NgayTao,
            cd.TrangThai,
            cd.NoiBat,
            cd.MaDanhMuc
        FROM dbo.ChienDich cd
        WHERE
            (@MaDanhMuc IS NULL OR cd.MaDanhMuc = @MaDanhMuc)
            AND (@TrangThai IS NULL OR cd.TrangThai = @TrangThai)
            AND (
                @TuKhoa IS NULL 
                OR cd.TenChienDich LIKE N'%' + @TuKhoa + N'%'
            )
    ),
    QuyenGopAgg AS
    (
        SELECT
            qg.MaChienDich,
            COUNT(*) AS SoLuotQuyenGop
        FROM dbo.QuyenGop qg
        WHERE qg.TrangThai = 1
        GROUP BY qg.MaChienDich
    ),
    FinalData AS
    (
        SELECT
            cd.MaChienDich,
            cd.TenChienDich,
            cd.MoTaNgan,
            cd.AnhBia,
            cd.MucTieu,
            cd.SoTienDaQuyen,

            CASE
                WHEN cd.MucTieu = 0 THEN 0
                ELSE CAST(cd.SoTienDaQuyen * 100.0 / cd.MucTieu AS DECIMAL(5,1))
            END AS PhanTramHoanThanh,

            cd.NgayBatDau,
            cd.NgayKetThuc,
            DATEDIFF(DAY, GETDATE(), cd.NgayKetThuc) AS SoNgayCon,

            cd.TrangThai,
            cd.NoiBat,

            dm.TenDanhMuc,
            dm.MauSac AS MauDanhMuc,

            ISNULL(qg.SoLuotQuyenGop, 0) AS SoLuotQuyenGop,

            cd.NgayTao
        FROM ChienDichBase cd
        INNER JOIN dbo.DanhMucChienDich dm 
            ON cd.MaDanhMuc = dm.MaDanhMuc
        LEFT JOIN QuyenGopAgg qg 
            ON cd.MaChienDich = qg.MaChienDich
    )

    SELECT *
    FROM FinalData
    ORDER BY
        CASE WHEN @SapXepTheo = N'NgayKetThuc'   THEN NgayKetThuc END ASC,
        CASE WHEN @SapXepTheo = N'SoTienDaQuyen' THEN SoTienDaQuyen END DESC,
        CASE WHEN @SapXepTheo = N'MucTieu'       THEN MucTieu END DESC,
        CASE WHEN @SapXepTheo = N'NgayTao'       THEN NgayTao END DESC,
        NgayTao DESC -- fallback
    OFFSET @BatDauTu ROWS
    FETCH NEXT @SoDoiMoiTrang ROWS ONLY;
END
GO

-- SP2: Lấy chi tiết 1 chiến dịch
CREATE OR ALTER PROCEDURE dbo.SP_LayChiTietChienDich
    @MaChienDich INT
AS
BEGIN
    SET NOCOUNT ON

    -- Thông tin chính
    SELECT
        cd.MaChienDich,
        cd.TenChienDich,
        cd.MoTaNgan,
        cd.NoiDungChiTiet,
        cd.AnhBia,
        cd.MucTieu,
        cd.SoTienDaQuyen,
        CASE
            WHEN cd.MucTieu = 0 THEN 0
            ELSE CAST(cd.SoTienDaQuyen * 100.0 / cd.MucTieu AS DECIMAL(5,1))
        END                             AS PhanTramHoanThanh,
        cd.NgayBatDau,
        cd.NgayKetThuc,
        DATEDIFF(DAY, GETDATE(), cd.NgayKetThuc) AS SoNgayCon,
        cd.TrangThai,
        cd.TenNganHang,
        cd.SoTaiKhoan,
        cd.TenChuTaiKhoan,
        cd.ToChucChuTri,
        dm.TenDanhMuc,
        dm.MauSac                       AS MauDanhMuc,
        COUNT(qg.MaQuyenGop)            AS TongLuotQuyenGop
    FROM        dbo.ChienDich           cd
    INNER JOIN  dbo.DanhMucChienDich    dm  ON cd.MaDanhMuc   = dm.MaDanhMuc
    LEFT JOIN   dbo.QuyenGop            qg  ON cd.MaChienDich = qg.MaChienDich
                                           AND qg.TrangThai   = 1
    WHERE cd.MaChienDich = @MaChienDich
    GROUP BY
        cd.MaChienDich, cd.TenChienDich, cd.MoTaNgan, cd.NoiDungChiTiet,
        cd.AnhBia, cd.MucTieu, cd.SoTienDaQuyen, cd.NgayBatDau, cd.NgayKetThuc,
        cd.TrangThai, cd.TenNganHang, cd.SoTaiKhoan, cd.TenChuTaiKhoan,
        cd.ToChucChuTri, dm.TenDanhMuc, dm.MauSac

    -- Gallery ảnh
    SELECT DuongDanAnh, MoTaAnh, ThuTu
    FROM   dbo.AnhChienDich
    WHERE  MaChienDich = @MaChienDich
    ORDER BY ThuTu ASC
END
GO

-- SP3: Thêm quyên góp mới
CREATE OR ALTER PROCEDURE dbo.SP_ThemQuyenGop
    @MaChienDich    INT,
    @MaNguoiDung    INT             = NULL,
    @SoTien         DECIMAL(18,0),
    @LoiNhan        NVARCHAR(500)   = NULL,
    @AnDanh         BIT             = 0,
    @AnhXacNhan     NVARCHAR(255)   = NULL,
    @MaQuyenGopMoi  INT             OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    -- Kiểm tra chiến dịch có đang hoạt động không
    IF NOT EXISTS (
        SELECT 1 FROM dbo.ChienDich
        WHERE MaChienDich = @MaChienDich
          AND TrangThai   = 1
          AND NgayKetThuc >= CAST(GETDATE() AS DATE)
    )
    BEGIN
        RAISERROR(N'Chiến dịch không tồn tại hoặc đã kết thúc.', 16, 1)
        RETURN
    END

    INSERT INTO dbo.QuyenGop (
        MaChienDich, MaNguoiDung, SoTien,
        LoiNhan, AnDanh, AnhXacNhan, TrangThai, NgayTao
    )
    VALUES (
        @MaChienDich, @MaNguoiDung, @SoTien,
        @LoiNhan, @AnDanh, @AnhXacNhan, 0, GETDATE()
    )

    SET @MaQuyenGopMoi = SCOPE_IDENTITY()
END
GO

-- SP4: Admin duyệt hoặc từ chối quyên góp
CREATE OR ALTER PROCEDURE dbo.SP_DuyetQuyenGop
    @MaQuyenGop     INT,
    @TrangThai      TINYINT,        -- 1 = Duyệt, 2 = Từ chối
    @MaNguoiDuyet   INT,
    @LyDoTuChoi     NVARCHAR(300) = NULL
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRANSACTION

    BEGIN TRY
        DECLARE @SoTien         DECIMAL(18,0)
        DECLARE @MaChienDich    INT
        DECLARE @TrangThaiCu    TINYINT

        SELECT
            @SoTien      = SoTien,
            @MaChienDich = MaChienDich,
            @TrangThaiCu = TrangThai
        FROM dbo.QuyenGop
        WHERE MaQuyenGop = @MaQuyenGop

        IF @TrangThaiCu <> 0
        BEGIN
            RAISERROR(N'Giao dịch này đã được xử lý rồi.', 16, 1)
            RETURN
        END

        -- Cập nhật trạng thái quyên góp
        UPDATE dbo.QuyenGop
        SET
            TrangThai    = @TrangThai,
            MaNguoiDuyet = @MaNguoiDuyet,
            NgayDuyet    = GETDATE(),
            LyDoTuChoi   = CASE WHEN @TrangThai = 2 THEN @LyDoTuChoi ELSE NULL END
        WHERE MaQuyenGop = @MaQuyenGop

        -- Nếu duyệt thì cộng tiền vào chiến dịch
        IF @TrangThai = 1
        BEGIN
            UPDATE dbo.ChienDich
            SET
                SoTienDaQuyen = SoTienDaQuyen + @SoTien,
                NgayCapNhat   = GETDATE()
            WHERE MaChienDich = @MaChienDich
        END

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO

-- SP5: Đăng ký tài khoản
CREATE OR ALTER PROCEDURE dbo.SP_DangKy
    @HoTen          NVARCHAR(100),
    @Email          NVARCHAR(150),
    @MatKhau        NVARCHAR(255),   -- truyền vào đã hash
    @SoDienThoai    NVARCHAR(15) = NULL,
    @MaNguoiDungMoi INT          OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    IF EXISTS (SELECT 1 FROM dbo.NguoiDung WHERE Email = @Email)
    BEGIN
        RAISERROR(N'Email này đã được sử dụng.', 16, 1)
        RETURN
    END

    INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhau, SoDienThoai, VaiTro, TrangThai, NgayTao)
    VALUES (@HoTen, @Email, @MatKhau, @SoDienThoai, 0, 1, GETDATE())

    SET @MaNguoiDungMoi = SCOPE_IDENTITY()
END
GO

-- SP6: Đăng nhập
CREATE OR ALTER PROCEDURE dbo.SP_DangNhap
    @Email      NVARCHAR(150),
    @MatKhau    NVARCHAR(255)   -- truyền vào đã hash
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        MaNguoiDung,
        HoTen,
        Email,
        AnhDaiDien,
        VaiTro,
        TrangThai
    FROM dbo.NguoiDung
    WHERE Email    = @Email
      AND MatKhau  = @MatKhau
      AND TrangThai = 1  -- chỉ cho đăng nhập nếu chưa bị khóa
END
GO

-- SP7: Lấy lịch sử quyên góp của 1 người dùng
CREATE OR ALTER PROCEDURE dbo.SP_LayLichSuQuyenGop
    @MaNguoiDung    INT,
    @TrangThai      TINYINT = NULL,
    @TrangHienTai   INT     = 1,
    @SoDoiMoiTrang  INT     = 10
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @BatDauTu INT = (@TrangHienTai - 1) * @SoDoiMoiTrang

    SELECT
        qg.MaQuyenGop,
        cd.TenChienDich,
        cd.AnhBia,
        qg.SoTien,
        qg.LoiNhan,
        qg.AnDanh,
        qg.TrangThai,
        qg.NgayTao,
        qg.NgayDuyet,
        qg.LyDoTuChoi
    FROM        dbo.QuyenGop    qg
    INNER JOIN  dbo.ChienDich   cd  ON qg.MaChienDich = cd.MaChienDich
    WHERE qg.MaNguoiDung = @MaNguoiDung
      AND (@TrangThai IS NULL OR qg.TrangThai = @TrangThai)
    ORDER BY qg.NgayTao DESC
    OFFSET @BatDauTu ROWS FETCH NEXT @SoDoiMoiTrang ROWS ONLY
END
GO

-- SP8: Thống kê tổng quan cho Admin Dashboard
CREATE OR ALTER PROCEDURE dbo.SP_ThongKeTongQuan
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        (SELECT COUNT(*)        FROM dbo.ChienDich  WHERE TrangThai = 1)            AS TongChienDichDangChay,
        (SELECT COUNT(*)        FROM dbo.ChienDich)                                 AS TongChienDich,
        (SELECT COUNT(*)        FROM dbo.NguoiDung  WHERE VaiTro = 0)              AS TongNguoiDung,
        (SELECT COUNT(*)        FROM dbo.QuyenGop   WHERE TrangThai = 0)           AS TongChoXuLy,
        (SELECT ISNULL(SUM(SoTien), 0) FROM dbo.QuyenGop WHERE TrangThai = 1)     AS TongTienDaQuyen,
        (SELECT COUNT(*)        FROM dbo.QuyenGop   WHERE TrangThai = 1)           AS TongLuotQuyenGop
END
GO

-- SP9: Thống kê quyên góp theo tháng (cho biểu đồ)
CREATE OR ALTER PROCEDURE dbo.SP_ThongKeQuyenGopTheoThang
    @Nam INT = NULL     -- NULL = năm hiện tại
AS
BEGIN
    SET NOCOUNT ON

    IF @Nam IS NULL SET @Nam = YEAR(GETDATE())

    SELECT
        MONTH(NgayDuyet)                    AS Thang,
        COUNT(*)                            AS SoLuot,
        ISNULL(SUM(SoTien), 0)             AS TongTien
    FROM dbo.QuyenGop
    WHERE TrangThai = 1
      AND YEAR(NgayDuyet) = @Nam
    GROUP BY MONTH(NgayDuyet)
    ORDER BY Thang ASC
END
GO

-- SP10: Top người quyên góp nhiều nhất
CREATE OR ALTER PROCEDURE dbo.SP_TopNguoiQuyenGop
    @SoLuongTop INT = 10
AS
BEGIN
    SET NOCOUNT ON

    SELECT TOP (@SoLuongTop)
        nd.MaNguoiDung,
        nd.HoTen,
        nd.AnhDaiDien,
        COUNT(qg.MaQuyenGop)        AS SoLanQuyen,
        SUM(qg.SoTien)              AS TongTienDaQuyen
    FROM        dbo.QuyenGop    qg
    INNER JOIN  dbo.NguoiDung   nd  ON qg.MaNguoiDung = nd.MaNguoiDung
    WHERE qg.TrangThai  = 1
      AND qg.AnDanh     = 0      -- chỉ hiện người không ẩn danh
    GROUP BY nd.MaNguoiDung, nd.HoTen, nd.AnhDaiDien
    ORDER BY TongTienDaQuyen DESC
END
GO

PRINT N'Tạo database ThienNguyenViet thành công!'
PRINT N'Tổng số bảng : 10'
PRINT N'Tổng số stored procedure: 10'
PRINT N'Tổng số index: 11'