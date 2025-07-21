CREATE TABLE NguoiDung (
    maNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(50) UNIQUE NOT NULL,
    matKhau VARCHAR(255) NOT NULL,
    hoTen NVARCHAR(100) NOT NULL,
    isAdmin BIT DEFAULT 0 -- 0: User, 1: Admin
);

CREATE TABLE SanPham (
    maSanPham INT IDENTITY(1,1) PRIMARY KEY,
    tenSanPham NVARCHAR(200) NOT NULL,
    gia DECIMAL(18,2) NOT NULL,
    hang VARCHAR(100),
    cpu VARCHAR(100),
    ram VARCHAR(50),
    oCung VARCHAR(100),
    manHinh VARCHAR(100),
    moTa NVARCHAR(MAX),
    hinhAnh VARCHAR(255)
);
CREATE TABLE GioHang (
    maNguoiDung INT,
    maSanPham INT,
    soLuong INT,
    PRIMARY KEY (maNguoiDung, maSanPham),
    FOREIGN KEY (maNguoiDung) REFERENCES NguoiDung(maNguoiDung),
    FOREIGN KEY (maSanPham) REFERENCES SanPham(maSanPham)
);
CREATE TABLE DonHang (
    maDonHang INT IDENTITY(1,1) PRIMARY KEY,
    maNguoiDung INT,
    ngayDat DATETIME DEFAULT GETDATE(),
    tongTien DECIMAL(18,2),
    trangThai NVARCHAR(50) DEFAULT N'Chờ xử lý', -- Có thể là: Đã xác nhận, Đang giao, Đã giao
    FOREIGN KEY (maNguoiDung) REFERENCES NguoiDung(maNguoiDung)
);
CREATE TABLE ChiTietDonHang (
    maDonHang INT,
    maSanPham INT,
    soLuong INT,
    donGia DECIMAL(18,2),
    PRIMARY KEY (maDonHang, maSanPham),
    FOREIGN KEY (maDonHang) REFERENCES DonHang(maDonHang),
    FOREIGN KEY (maSanPham) REFERENCES SanPham(maSanPham)
);
CREATE TABLE DanhGia (
    maDanhGia INT IDENTITY(1,1) PRIMARY KEY,
    maSanPham INT,
    maNguoiDung INT,
    soSao INT CHECK (soSao BETWEEN 1 AND 5),
    binhLuan NVARCHAR(MAX),
    ngayDanhGia DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (maSanPham) REFERENCES SanPham(maSanPham),
    FOREIGN KEY (maNguoiDung) REFERENCES NguoiDung(maNguoiDung)
);

-- Admin
INSERT INTO NguoiDung 
VALUES ('admin@gmail.com', '123', N'Hắc Tấn Có', 1);

-- Người dùng thường
INSERT INTO NguoiDung 
VALUES ('nnanh@gmail.com', '123', N'Nguyễn Ngọc Ánh', 0);

INSERT INTO SanPham (tenSanPham, gia, hang, cpu, ram, oCung, manHinh, moTa, hinhAnh)
VALUES 
(N'Asus Vivobook 15', 14990000, 'Asus', 'Intel Core i5-1240P', '8GB', '512GB SSD', '15.6 inch FHD', N'Laptop mỏng nhẹ phù hợp học tập', 'asus_vivobook_15.jpg'),

(N'Dell Inspiron 14', 16990000, 'Dell', 'Intel Core i7-1255U', '16GB', '512GB SSD', '14 inch FHD', N'Hiệu năng mạnh mẽ cho công việc', 'dell_inspiron_14.jpg'),

(N'MacBook Air M1', 21990000, 'Apple', 'Apple M1', '8GB', '256GB SSD', '13.3 inch Retina', N'Hiệu năng tốt, thời lượng pin lâu', 'macbook_air_m1.jpg');
 
INSERT INTO SanPham  VALUES
(N'HP Pavilion 15', 15990000, N'HP', N'Intel Core i5-1135G7', N'8GB', N'512GB SSD', N'15.6 inch FHD', N'Máy tính văn phòng mỏng nhẹ', N'hp_pavilion_15.jpg'),
(N'Acer Aspire 7', 17990000, N'Acer', N'Intel Core i5-12450H', N'8GB', N'512GB SSD', N'15.6 inch FHD 144Hz', N'Dành cho học tập và gaming nhẹ', N'acer_aspire_7.jpg'),
(N'Lenovo Ideapad 3', 12990000, N'Lenovo', N'AMD Ryzen 5 5500U', N'8GB', N'256GB SSD', N'15.6 inch FHD', N'Thiết kế đẹp, giá mềm', N'lenovo_ideapad_3.jpg'),
(N'MSI Modern 14', 15990000, N'MSI', N'Intel Core i5-1155G7', N'8GB', N'512GB SSD', N'14 inch FHD', N'Dành cho sinh viên thiết kế, code', N'msi_modern_14.jpg'),
(N'Asus TUF Gaming F15', 23990000, N'Asus', N'Intel Core i7-11800H', N'16GB', N'512GB SSD', N'15.6 inch FHD 144Hz', N'Laptop gaming mạnh mẽ', N'asus_tuf_f15.jpg'),
(N'Dell Vostro 15', 13990000, N'Dell', N'Intel Core i3-1115G4', N'8GB', N'256GB SSD', N'15.6 inch HD', N'Phù hợp công việc văn phòng', N'dell_vostro_15.jpg'),
(N'Apple MacBook Pro M2', 32990000, N'Apple', N'Apple M2', N'8GB', N'512GB SSD', N'13.6 inch Retina', N'Máy Apple mạnh mẽ cho lập trình và design', N'apple_macbook_pro_m2.jpg'),
(N'Asus Zenbook 14', 21990000, N'Asus', N'Intel Core i5-1240P', N'16GB', N'512GB SSD', N'14 inch OLED', N'Màn hình đẹp, hiệu năng cao', N'asus_zenbook_14.jpg'),
(N'Lenovo Legion 5', 28990000, N'Lenovo', N'AMD Ryzen 7 5800H', N'16GB', N'512GB SSD', N'15.6 inch 165Hz', N'Laptop gaming hiệu suất cao', N'lenovo_legion_5.jpg'),
(N'Acer Swift 3', 16990000, N'Acer', N'Intel Core i5-1235U', N'8GB', N'512GB SSD', N'14 inch FHD', N'Pin trâu, thiết kế mỏng nhẹ', N'acer_swift_3.jpg'),
(N'MSI GF63 Thin', 19990000, N'MSI', N'Intel Core i5-11400H', N'8GB', N'512GB SSD', N'15.6 inch 144Hz', N'Gaming phổ thông giá rẻ', N'msi_gf63_thin.jpg'),
(N'Dell XPS 13', 28990000, N'Dell', N'Intel Core i7-1165G7', N'16GB', N'512GB SSD', N'13.3 inch FHD', N'Laptop cao cấp cho doanh nhân', N'dell_xps_13.jpg'),
(N'HP Envy 13', 22990000, N'HP', N'Intel Core i5-1230U', N'8GB', N'512GB SSD', N'13.3 inch FHD', N'Nhỏ gọn, pin lâu', N'hp_envy_13.jpg'),
(N'Asus ROG Zephyrus G14', 33990000, N'Asus', N'AMD Ryzen 9 5900HS', N'16GB', N'1TB SSD', N'14 inch QHD 120Hz', N'Gaming cao cấp, thiết kế đẹp', N'asus_rog_g14.jpg'),
(N'Apple MacBook Air M2', 26990000, N'Apple', N'Apple M2', N'8GB', N'256GB SSD', N'13.6 inch Retina', N'Mỏng nhẹ, pin lâu', N'macbook_air_m2.jpg'),
(N'Lenovo Yoga Slim 7', 19990000, N'Lenovo', N'Intel Core i5-1240P', N'16GB', N'512GB SSD', N'14 inch OLED', N'Màn OLED, pin trâu', N'lenovo_yoga_slim7.jpg'),
(N'Dell Latitude 3420', 16990000, N'Dell', N'Intel Core i5-1135G7', N'8GB', N'256GB SSD', N'14 inch FHD', N'Phù hợp công việc văn phòng', N'dell_latitude_3420.jpg'),
(N'Acer Nitro 5', 21990000, N'Acer', N'Intel Core i5-12500H', N'8GB', N'512GB SSD', N'15.6 inch FHD 144Hz', N'Laptop gaming phổ thông', N'acer_nitro_5.jpg'),
(N'HP Victus 16', 25990000, N'HP', N'AMD Ryzen 7 5800H', N'16GB', N'512GB SSD', N'16.1 inch 144Hz', N'Gaming hiệu năng mạnh, giá tốt', N'hp_victus_16.jpg');

select * from SanPham
select * from NguoiDung	
select * from GioHang
select * from DonHang
select * from ChiTietDonHang

select COUNT(maNguoiDung) from GioHang
where maNguoiDung = 1

SELECT SanPham.*, GioHang.soLuong
FROM GioHang JOIN SanPham ON SanPham.maSanPham = GioHang.maSanPham
WHERE GioHang.maNguoiDung = 1

SELECT * 
FROM DonHang 
WHERE maNguoiDung = 1 
ORDER BY ngayDat ASC