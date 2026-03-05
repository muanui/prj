-- =============================================
-- BookApp Sample Data
-- Run AFTER database.sql
-- Admin: username=a, password=1
-- =============================================

USE BookApp;
GO

-- =============================================
-- Users  (password stored as plain text for demo)
-- =============================================
INSERT INTO Users (username, password, fullname, email, phone, address, role) VALUES
('a',       '1',          N'Administrator',    'admin@bookapp.com',    '0900000001', N'Hà Nội',         'admin'),
('user1',   'user1',      N'Nguyễn Văn An',    'an@gmail.com',         '0900000002', N'TP.HCM',          'customer'),
('user2',   'user2',      N'Trần Thị Bình',    'binh@gmail.com',       '0900000003', N'Đà Nẵng',         'customer'),
('user3',   'user3',      N'Lê Văn Cường',     'cuong@gmail.com',      '0900000004', N'Cần Thơ',         'customer'),
('user4',   'user4',      N'Phạm Thị Dung',    'dung@gmail.com',       '0900000005', N'Hải Phòng',       'customer');
GO

-- =============================================
-- Categories
-- =============================================
INSERT INTO Categories (name, description) VALUES
(N'Văn học',        N'Tiểu thuyết, truyện ngắn, thơ ca trong và ngoài nước'),
(N'Khoa học',       N'Sách khoa học tự nhiên, kỹ thuật, công nghệ'),
(N'Kinh tế',        N'Kinh doanh, tài chính, marketing, khởi nghiệp'),
(N'Lịch sử',        N'Lịch sử Việt Nam và thế giới'),
(N'Kỹ năng sống',   N'Phát triển bản thân, kỹ năng giao tiếp, tư duy');
GO

-- =============================================
-- Books
-- =============================================
INSERT INTO Books (title, author, category_id, price, sale_price, stock, sold, description, image, featured) VALUES
(N'Dế Mèn Phiêu Lưu Ký',       N'Tô Hoài',             1,  85000,   70000,  150, 320, N'Câu chuyện phiêu lưu của chú dế mèn dũng cảm.',                           'book1.jpg',  1),
(N'Số Đỏ',                       N'Vũ Trọng Phụng',      1,  75000,   60000,  200, 280, N'Tiểu thuyết châm biếm hiện thực xã hội Việt Nam thời Pháp thuộc.',        'book2.jpg',  1),
(N'Tắt Đèn',                     N'Ngô Tất Tố',          1,  65000,   55000,  180, 250, N'Tác phẩm phản ánh cuộc sống khốn khổ của người nông dân.',                'book3.jpg',  0),
(N'Chiến Tranh Và Hòa Bình',    N'Lev Tolstoy',         1, 250000,  200000,   80, 160, N'Bộ tiểu thuyết vĩ đại của văn học Nga về chiến tranh Napoleon.',           'book4.jpg',  1),
(N'Nhà Giả Kim',                 N'Paulo Coelho',         1, 120000,   99000,  300, 520, N'Câu chuyện về hành trình đi tìm kho báu và ý nghĩa cuộc đời.',            'book5.jpg',  1),
(N'Sapiens: Lược Sử Loài Người',N'Yuval Noah Harari',   2, 180000,  150000,  100, 340, N'Lịch sử nhân loại từ thời nguyên thủy đến hiện đại.',                     'book6.jpg',  1),
(N'Vật Lý Vui',                  N'Yakov Perelman',      2,  95000,   80000,  120, 180, N'Giải thích các hiện tượng vật lý thú vị bằng ngôn ngữ đơn giản.',         'book7.jpg',  0),
(N'Thiên Hà Vẫy Gọi',            N'Carl Sagan',          2, 160000,  135000,   90, 200, N'Khám phá vũ trụ bao la qua góc nhìn khoa học và triết học.',               'book8.jpg',  0),
(N'Đắc Nhân Tâm',                N'Dale Carnegie',       3, 110000,   89000,  500, 850, N'Nghệ thuật giao tiếp, thuyết phục và xây dựng các mối quan hệ.',          'book9.jpg',  1),
(N'Nghĩ Giàu Làm Giàu',         N'Napoleon Hill',       3, 130000,  105000,  400, 620, N'Bí quyết tư duy thành công và tạo ra sự giàu có.',                        'book10.jpg', 1),
(N'Khởi Nghiệp Tinh Gọn',       N'Eric Ries',           3, 145000,  120000,  200, 350, N'Phương pháp xây dựng doanh nghiệp khởi nghiệp hiệu quả.',                 'book11.jpg', 0),
(N'Lịch Sử Việt Nam',            N'Nhiều tác giả',       4, 200000,  170000,   70, 130, N'Bộ sách toàn diện về lịch sử dân tộc Việt Nam.',                          'book12.jpg', 0),
(N'Người Lính Già',              N'Ernest Hemingway',    4, 115000,   95000,  110, 170, N'Cuộc chiến của người lính già trong thế chiến thứ nhất.',                  'book13.jpg', 0),
(N'7 Thói Quen Hiệu Quả',       N'Stephen Covey',       5, 155000,  125000,  350, 680, N'Bảy thói quen của người thành đạt và cách xây dựng chúng.',               'book14.jpg', 1),
(N'Tư Duy Nhanh Và Chậm',       N'Daniel Kahneman',     5, 170000,  140000,  160, 290, N'Khám phá hai hệ thống tư duy của con người và ứng dụng thực tế.',         'book15.jpg', 1),
(N'Atomic Habits',               N'James Clear',         5, 165000,  135000,  420, 760, N'Xây dựng thói quen tốt nhỏ dẫn đến thay đổi lớn trong cuộc sống.',       'book16.jpg', 1),
(N'Học Máy Cơ Bản',             N'Vũ Hữu Tiệp',        2, 220000,  185000,   80, 140, N'Giáo trình Machine Learning bằng tiếng Việt toàn diện.',                   'book17.jpg', 0),
(N'Clean Code',                  N'Robert C. Martin',    2, 240000,  199000,  100, 210, N'Cách viết code sạch, dễ đọc và dễ bảo trì.',                              'book18.jpg', 1),
(N'Bố Già Và Cướp Biển',        N'Robert T. Kiyosaki',  3, 135000,  110000,  280, 490, N'Bài học tài chính từ người cha giàu và người cha nghèo.',                  'book19.jpg', 0),
(N'Truyện Kiều',                 N'Nguyễn Du',           1,  80000,   65000,  250, 400, N'Tác phẩm văn học kinh điển của dân tộc Việt Nam.',                        'book20.jpg', 1);
GO

-- =============================================
-- Orders
-- =============================================
INSERT INTO Orders (user_id, total, status, note, address, created_at) VALUES
(2, 319000, N'Hoàn thành', N'Giao giờ hành chính',  N'123 Nguyễn Huệ, TP.HCM',  '2025-11-01'),
(3, 245000, N'Hoàn thành', N'',                       N'456 Lê Lợi, Đà Nẵng',     '2025-11-05'),
(4, 480000, N'Hoàn thành', N'Gói quà giúp',          N'789 Trần Phú, Cần Thơ',   '2025-11-10'),
(2, 199000, N'Đang giao',  N'',                       N'123 Nguyễn Huệ, TP.HCM',  '2025-12-01'),
(5, 350000, N'Hoàn thành', N'',                       N'321 Võ Thị Sáu, Hải Phòng','2025-12-05'),
(3, 125000, N'Đã hủy',     N'Hết hàng',              N'456 Lê Lợi, Đà Nẵng',     '2025-12-10'),
(4, 570000, N'Hoàn thành', N'',                       N'789 Trần Phú, Cần Thơ',   '2026-01-03'),
(2, 440000, N'Chờ xử lý',  N'',                       N'123 Nguyễn Huệ, TP.HCM',  '2026-01-15'),
(5, 265000, N'Hoàn thành', N'',                       N'321 Võ Thị Sáu, Hải Phòng','2026-02-01'),
(3, 385000, N'Đang giao',  N'',                       N'456 Lê Lợi, Đà Nẵng',     '2026-02-20');
GO

-- =============================================
-- OrderDetails
-- =============================================
INSERT INTO OrderDetails (order_id, book_id, quantity, price) VALUES
(1, 1, 2,  70000), (1, 9,  1, 89000), (1, 14, 1, 125000),
(2, 5, 2,  99000), (2, 2,  1, 60000),
(3, 6, 2, 150000), (3, 10, 1, 105000), (3, 16, 1, 135000),
(4, 16, 1, 135000), (4, 15, 1,  64000),
(5, 9, 1,  89000), (5, 11, 1, 120000), (5, 19, 1, 110000),
(6, 3, 1,  55000), (6, 7,  1,  70000),
(7, 4, 1, 200000), (7, 18, 1, 199000), (7, 6, 1, 150000),
(8, 16,2, 135000), (8, 15, 1, 140000),
(9, 14, 1, 125000), (9, 1, 2, 70000),
(10, 9, 1, 89000), (10, 16,1, 135000), (10, 5,1, 99000);
GO

-- Update sold counts
UPDATE Books SET sold = (
    SELECT ISNULL(SUM(od.quantity),0) FROM OrderDetails od
    JOIN Orders o ON od.order_id = o.id
    WHERE od.book_id = Books.id AND o.status = N'Hoàn thành'
);
GO
