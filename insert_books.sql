USE BookStoreDB2;

INSERT INTO Books(title,author,category_id,price,sale_price,stock,sold,description,image,featured,active) VALUES
-- Cat 1: Tiểu thuyết (id=1)
(N'Nhà Giả Kim',N'Paulo Coelho',1,89000,75000,100,50,N'Hành trình theo đuổi giấc mơ của chàng trai trẻ Santiago.',N'nha-gia-kim.jpg',1,1),
(N'Đắc Nhân Tâm',N'Dale Carnegie',1,95000,80000,120,80,N'Nghệ thuật giao tiếp và chinh phục lòng người.',N'dac-nhan-tam.jpg',1,1),
(N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh',N'Nguyễn Nhật Ánh',1,75000,65000,90,60,N'Câu chuyện tuổi thơ đầy xúc động ở miền quê Việt Nam.',N'hoa-vang.jpg',1,1),

-- Cat 2: Trinh Thám (id=2)
(N'Vụ Án Mạng Trên Tàu Tốc Hành Phương Đông',N'Agatha Christie',2,120000,99000,80,45,N'Thám tử Poirot điều tra vụ án bí ẩn trên chuyến tàu.',N'tau-toc-hanh.jpg',1,1),
(N'Sherlock Holmes Toàn Tập',N'Arthur Conan Doyle',2,250000,200000,60,30,N'Tuyển tập đầy đủ các vụ án của thám tử lừng danh Sherlock Holmes.',N'sherlock-holmes.jpg',1,1),
(N'Cô Gái Mất Tích',N'Gillian Flynn',2,135000,110000,70,40,N'Câu chuyện ly kỳ về vụ mất tích bí ẩn của Amy Dunne.',N'co-gai-mat-tich.jpg',0,1),

-- Cat 3: Sách Tình cảm (id=3)
(N'Chuyện Tình New York',N'Marc Levy',3,95000,80000,100,70,N'Tình yêu lãng mạn giữa hai người trên đất Mỹ.',N'chuyen-tinh-new-york.jpg',0,1),
(N'Mắt Biếc',N'Nguyễn Nhật Ánh',3,79000,65000,110,90,N'Tình yêu học trò trong sáng, đẹp như mắt biếc.',N'mat-biec.jpg',1,1),
(N'Người Trông Coi Bí Ẩn',N'Nicholas Sparks',3,110000,89000,85,55,N'Câu chuyện tình yêu cảm động và đầy thử thách.',N'nguoi-trong-coi.jpg',0,1),

-- Cat 4: Sách khoa học viễn tưởng (id=4)
(N'Dune - Xứ Cát',N'Frank Herbert',4,199000,165000,60,25,N'Sử thi khoa học viễn tưởng nổi tiếng nhất thế giới.',N'dune.jpg',1,1),
(N'1984',N'George Orwell',4,95000,80000,90,65,N'Xã hội toàn trị của tương lai qua cái nhìn ám ảnh.',N'1984.jpg',1,1),
(N'Người Về Từ Sao Hỏa',N'Andy Weir',4,145000,120000,75,35,N'Phi hành gia một mình sống sót trên sao Hỏa.',N'nguoi-ve-tu-sao-hoa.jpg',0,1),

-- Cat 5: Sách Kinh dị (id=5)
(N'The Shining',N'Stephen King',5,175000,145000,55,20,N'Câu chuyện kinh dị tâm lý rùng rợn tại khách sạn cô lập.',N'the-shining.jpg',1,1),
(N'It',N'Stephen King',5,245000,199000,45,18,N'Gã hề Pennywise ám ảnh cả thị trấn Derry.',N'it-stephen-king.jpg',0,1),
(N'Trại Hoa Đỏ',N'Di Li',5,89000,75000,80,50,N'Tiểu thuyết kinh dị Việt Nam đỉnh cao của tác giả Di Li.',N'trai-hoa-do.jpg',1,1),

-- Cat 6: Self-help (id=6)
(N'7 Thói Quen Hiệu Quả',N'Stephen Covey',6,145000,120000,150,110,N'Bảy thói quen tạo nên những con người thành công.',N'7-thoi-quen.jpg',1,1),
(N'Nghĩ Giàu Làm Giàu',N'Napoleon Hill',6,99000,85000,130,95,N'Bí quyết tư duy của những triệu phú thành công.',N'nghi-giau-lam-giau.jpg',1,1),
(N'Atomic Habits',N'James Clear',6,169000,140000,160,120,N'Xây dựng thói quen tốt và phá vỡ thói quen xấu.',N'atomic-habits.jpg',1,1),

-- Cat 7: Tiểu sử, tự truyện (id=7)
(N'Steve Jobs',N'Walter Isaacson',7,225000,185000,70,40,N'Tiểu sử chính thức của huyền thoại công nghệ Steve Jobs.',N'steve-jobs.jpg',1,1),
(N'Elon Musk',N'Ashlee Vance',7,195000,160000,65,35,N'Hành trình của thiên tài công nghệ thay đổi thế giới.',N'elon-musk.jpg',1,1),
(N'Không Bao Giờ Là Thất Bại',N'Nick Vujicic',7,99000,85000,100,75,N'Tự truyện truyền cảm hứng của người không tay không chân.',N'nick-vujicic.jpg',0,1),

-- Cat 8: Truyện ngắn (id=8)
(N'Chí Phèo và Các Truyện Ngắn',N'Nam Cao',8,65000,55000,120,80,N'Tuyển tập truyện ngắn xuất sắc của Nam Cao.',N'chi-pheo.jpg',1,1),
(N'Tổng Tập Truyện Ngắn O. Henry',N'O. Henry',8,150000,125000,90,55,N'Những truyện ngắn hài hước và đầy bất ngờ của O. Henry.',N'o-henry.jpg',0,1),
(N'Cánh Đồng Bất Tận',N'Nguyễn Ngọc Tư',8,75000,62000,95,70,N'Truyện ngắn đầy xúc cảm về con người miền sông nước Nam Bộ.',N'canh-dong-bat-tan.jpg',1,1),

-- Cat 9: Lịch sử (id=9)
(N'Lược Sử Loài Người',N'Yuval Noah Harari',9,195000,165000,120,85,N'Lịch sử nhân loại từ thời nguyên thủy đến hiện đại.',N'luoc-su-loai-nguoi.jpg',1,1),
(N'Việt Nam Sử Lược',N'Trần Trọng Kim',9,120000,99000,100,60,N'Bộ sử Việt Nam súc tích và đầy đủ nhất từ cổ đại.',N'viet-nam-su-luoc.jpg',1,1),
(N'Lịch Sử Thế Giới Cổ Đại',N'I. M. Diakov',9,145000,120000,80,40,N'Tổng quan lịch sử các nền văn minh cổ đại trên thế giới.',N'lich-su-the-gioi-co-dai.jpg',0,1),

-- Cat 10: Bài luận (id=10)
(N'Bàn Về Tự Do',N'John Stuart Mill',10,89000,75000,70,30,N'Luận điểm nền tảng về tự do cá nhân và xã hội.',N'ban-ve-tu-do.jpg',0,1),
(N'Khảo Luận Về Chính Phủ',N'John Locke',10,99000,80000,65,25,N'Các luận điểm triết học chính trị của John Locke.',N'khao-luan-chinh-phu.jpg',0,1),
(N'Walden - Sống Trong Rừng',N'Henry David Thoreau',10,105000,88000,75,35,N'Bài luận triết học về cuộc sống giản dị và tự nhiên.',N'walden.jpg',1,1);
