-- =============================================
-- Cập nhật cột image cho các cuốn sách
-- Chạy script này trong SQL Server Management Studio
-- =============================================

USE BookApp;
GO

-- Map tên file ảnh với tiêu đề sách (theo LIKE để khớp linh hoạt)
UPDATE Books SET image = 'atomic-habits.jpg'         WHERE title LIKE N'%Atomic Habits%';
UPDATE Books SET image = '7-thoi-quen.jpg'            WHERE title LIKE N'%7 Thói Quen%';
UPDATE Books SET image = 'nghi-giau-lam-giau.jpg'     WHERE title LIKE N'%Nghĩ Giàu Làm Giàu%';
UPDATE Books SET image = 'mat-biec.jpg'               WHERE title LIKE N'%Mắt Biếc%';
UPDATE Books SET image = 'luoc-su-loai-nguoi.jpg'     WHERE title LIKE N'%Lược Sử Loài Người%';
UPDATE Books SET image = 'dac-nhan-tam.jpg'           WHERE title LIKE N'%Đắc Nhân Tâm%';
UPDATE Books SET image = 'chi-pheo.jpg'               WHERE title LIKE N'%Chí Phèo%';
UPDATE Books SET image = 'canh-dong-bat-tan.jpg'      WHERE title LIKE N'%Cánh Đồng Bất Tận%';
UPDATE Books SET image = 'nha-gia-kim.jpg'            WHERE title LIKE N'%Nhà Giả Kim%';
UPDATE Books SET image = 'hoa-vang.jpg'               WHERE title LIKE N'%Hoa Vàng%' OR title LIKE N'%Hoa Vàng Trên Cỏ Xanh%';
UPDATE Books SET image = 'ban-ve-tu-do.jpg'           WHERE title LIKE N'%Bàn Về Tự Do%' OR title LIKE N'%Về Tự Do%';
UPDATE Books SET image = 'trai-hoa-do.jpg'            WHERE title LIKE N'%Trại Hoa Đỏ%';
UPDATE Books SET image = 'nguoi-trong-coi.jpg'        WHERE title LIKE N'%Người Trong Cõi%' OR title LIKE N'%Người Trong Cõi Nhớ%';
UPDATE Books SET image = 'chuyen-tinh-new-york.jpg'   WHERE title LIKE N'%Chuyện Tình New York%' OR title LIKE N'%New York%';
UPDATE Books SET image = 'tau-toc-hanh.jpg'           WHERE title LIKE N'%Tàu Tốc Hành%';
UPDATE Books SET image = 'nguoi-ve-tu-sao-hoa.jpg'   WHERE title LIKE N'%Người Về Từ Sao Hỏa%' OR title LIKE N'%Sao Hỏa%';
UPDATE Books SET image = 'nick-vujicic.jpg'           WHERE title LIKE N'%Nick%' OR title LIKE N'%Cuộc Sống Không Giới Hạn%';
UPDATE Books SET image = 'elon-musk.jpg'              WHERE title LIKE N'%Elon Musk%';
UPDATE Books SET image = 'steve-jobs.jpg'             WHERE title LIKE N'%Steve Jobs%';
UPDATE Books SET image = 'walden.jpg'                 WHERE title LIKE N'%Walden%';
UPDATE Books SET image = '1984.jpg'                   WHERE title LIKE N'%1984%';
UPDATE Books SET image = 'dune.jpg'                   WHERE title LIKE N'%Dune%';
UPDATE Books SET image = 'it-stephen-king.jpg'        WHERE title LIKE N'%It%' AND author LIKE N'%Stephen King%';
UPDATE Books SET image = 'the-shining.jpg'            WHERE title LIKE N'%The Shining%' OR title LIKE N'%Ngọn Đèn%';
UPDATE Books SET image = 'sherlock-holmes.jpg'        WHERE title LIKE N'%Sherlock%';
UPDATE Books SET image = 'co-gai-mat-tich.jpg'        WHERE title LIKE N'%Cô Gái Mất Tích%' OR title LIKE N'%Gone Girl%';
UPDATE Books SET image = 'o-henry.jpg'                WHERE author LIKE N'%O. Henry%' OR title LIKE N'%O Henry%';
UPDATE Books SET image = 'khao-luan-chinh-phu.jpg'    WHERE title LIKE N'%Khảo Luận%' OR title LIKE N'%Chính Phủ%';
UPDATE Books SET image = 'lich-su-the-gioi-co-dai.jpg' WHERE title LIKE N'%Lịch Sử Thế Giới%' OR title LIKE N'%Thế Giới Cổ Đại%';
UPDATE Books SET image = 'viet-nam-su-luoc.jpg'       WHERE title LIKE N'%Việt Nam Sử Lược%' OR title LIKE N'%Sử Lược%';

-- Kiểm tra kết quả
SELECT id, title, image FROM Books ORDER BY id;
GO
