USE BookApp;

INSERT INTO Books(title,author,category_id,price,sale_price,stock,sold,description,image,featured,active) VALUES
-- Cat 1: Tiểu thuyết (id=1) – thêm 7
(N'Kỳ Bí Xứ Sương Mù',N'Nguyễn Văn A',1,99000,85000,100,10,N'Tiểu thuyết phiêu lưu tại vùng đất sương mù.',N'ky-bi-xu-suong-mu.jpg',0,1),
(N'Gió Thổi Qua Đồi',N'Lê Thảo',1,89000,76000,90,8,N'Câu chuyện trưởng thành nơi miền núi.',N'gio-thoi-qua-doi.jpg',0,1),
(N'Con Đường Mưa Bay',N'Trần Minh',1,110000,92000,80,6,N'Chuyện tình lãng mạn trong những ngày mưa.',N'con-duong-mua-bay.jpg',0,1),
(N'Biển Gọi Tên Anh',N'Phan Hạ',1,95000,82000,95,7,N'Tiểu thuyết về tuổi trẻ và khát vọng.',N'bien-goi-ten-anh.jpg',0,1),
(N'Người Đếm Sao',N'Hoàng Mai',1,115000,98000,70,5,N'Hành trình tìm lại ước mơ đã quên.',N'nguoi-dem-sao.jpg',0,1),
(N'Bức Thư Không Gửi',N'Đinh Linh',1,87000,74000,85,4,N'Chuyện tình đơn phương day dứt.',N'buc-thu-khong-gui.jpg',0,1),
(N'Mùa Hè Năm Ấy',N'Vũ Tùng',1,99000,86000,90,3,N'Những ký ức tuổi học trò khó quên.',N'mua-he-nam-ay.jpg',0,1),

-- Cat 2: Trinh thám (id=2)
(N'Vết Máu Trên Tuyết Trắng',N'Phạm Bảo',2,125000,105000,80,5,N'Vụ án mạng bí ẩn tại thị trấn miền núi.',N'vet-mau-tren-tuyet-trang.jpg',0,1),
(N'Căn Phòng Khóa Kín',N'Lưu Thanh',2,115000,99000,75,4,N'Một vụ án phòng kín không lối thoát.',N'can-phong-khoa-kin.jpg',0,1),
(N'Đêm Dài 13 Giờ',N'Tô Lan',2,99000,88000,90,6,N'Cuộc điều tra xuyên đêm của thanh tra trẻ.',N'dem-dai-13-gio.jpg',0,1),
(N'Chiếc Đồng Hồ Ngừng Tích Tắc',N'Bùi Khánh',2,108000,93000,85,3,N'Manh mối duy nhất là chiếc đồng hồ chết.',N'chiec-dong-ho-ngung-tich-tac.jpg',0,1),
(N'Bí Mật Tầng Hầm Số 7',N'Đoàn Phúc',2,119000,99000,70,2,N'Hàng loạt vụ mất tích tại khu chung cư cũ.',N'bi-mat-tang-ham-7.jpg',0,1),
(N'Cuộc Gọi Lúc Nửa Đêm',N'Lâm Hà',2,95000,83000,95,4,N'Số điện thoại lạ ám ảnh cả thành phố.',N'cuoc-goi-luc-nua-dem.jpg',0,1),
(N'Hồ Sơ Số 0',N'Ngô Dũng',2,132000,112000,60,1,N'Tập hồ sơ tuyệt mật bị đánh cắp.',N'ho-so-so-0.jpg',0,1),

-- Cat 3: Tình cảm (id=3)
(N'Cafe Đắng Và Em',N'Khánh Vy',3,87000,76000,100,7,N'Chuyện tình nơi quán cafe nhỏ cuối phố.',N'cafe-dang-va-em.jpg',0,1),
(N'Nơi Anh Thuộc Về',N'Lê Hoài',3,99000,87000,95,6,N'Hai con người lạc lối tìm thấy nhau.',N'noi-anh-thuoc-ve.jpg',0,1),
(N'Tình Yêu Trên Mái Nhà',N'Trần Hân',3,91000,79000,90,5,N'Một mối tình nhẹ nhàng giữa thành phố ồn ào.',N'tinh-yeu-tren-mai-nha.jpg',0,1),
(N'Bản Tình Ca Mùa Thu',N'Nguyễn Hạo',3,105000,92000,85,4,N'Những rung động đầu đời dưới tán lá vàng.',N'ban-tinh-ca-mua-thu.jpg',0,1),
(N'Anh Có Nghe Gió Nói',N'Hoài Anh',3,95000,83000,80,3,N'Lời hẹn ước bị quên lãng theo năm tháng.',N'anh-co-nghe-gio-noi.jpg',0,1),
(N'Những Ngày Nắng Nhạt',N'Yến Nhi',3,88000,76000,90,2,N'Tình yêu chậm rãi mà bền bỉ.',N'nhung-ngay-nang-nhat.jpg',0,1),
(N'Trên Ban Công Đêm Hè',N'An Nhiên',3,102000,89000,70,1,N'Các nhân vật gặp nhau nhờ một ban công nhỏ.',N'tren-ban-cong-dem-he.jpg',0,1),

-- Cat 4: Khoa học viễn tưởng (id=4)
(N'Thành Phố Trên Mây',N'Vũ Long',4,135000,115000,80,5,N'Loài người xây thành phố lơ lửng trên bầu trời.',N'thanh-pho-tren-may.jpg',0,1),
(N'Hành Tinh Song Sinh',N'Phạm Hữu',4,145000,120000,75,4,N'Hai hành tinh giống hệt Trái Đất va chạm số phận.',N'hanh-tinh-song-sinh.jpg',0,1),
(N'Cỗ Máy Thời Gian 3 Giờ Sáng',N'Đỗ Vinh',4,129000,109000,90,6,N'Chiếc máy cho phép quay lại đúng 3 giờ sáng hôm trước.',N'co-may-thoi-gian-3-gio-sang.jpg',0,1),
(N'Colony 27',N'Lê Bình',4,155000,130000,70,3,N'Nhóm phi hành gia lạc vào thuộc địa bí ẩn.',N'colony-27.jpg',0,1),
(N'Chiếc Cổng Không Gian',N'Hoàng Lực',4,139000,118000,80,2,N'Một cánh cổng mở ra đa vũ trụ.',N'chiec-cong-khong-gian.jpg',0,1),
(N'Ngày Trái Đất Ngừng Quay',N'Ngọc Diệp',4,142000,120000,65,1,N'Thảm họa vũ trụ buộc loài người thay đổi.',N'ngay-trai-dat-ngung-quay.jpg',0,1),
(N'Nhật Ký Người Máy',N'Thạch An',4,125000,105000,90,4,N'Robot bắt đầu ghi lại cảm xúc đầu tiên.',N'nhat-ky-nguoi-may.jpg',0,1),

-- Cat 5: Kinh dị (id=5)
(N'Ngôi Nhà Cuối Con Dốc',N'Triều Vỹ',5,98000,86000,90,5,N'Căn nhà bỏ hoang với lời nguyền bí ẩn.',N'ngoi-nha-cuoi-con-doc.jpg',0,1),
(N'Tiếng Gọi Từ Giếng Cạn',N'Mai Hân',5,91000,79000,85,4,N'Những âm thanh kỳ lạ vang lên mỗi đêm.',N'tieng-goi-tu-gieng-can.jpg',0,1),
(N'Rạp Chiếu Bóng Bỏ Hoang',N'Phan Dũng',5,102000,89000,80,3,N'Những thước phim chỉ chiếu cho người đã chết.',N'rap-chieu-bong-bo-hoang.jpg',0,1),
(N'Khu Rừng Không Bóng Chim',N'Đặng Phú',5,112000,95000,70,2,N'Không một sinh vật sống dám bước vào khu rừng ấy.',N'khu-rung-khong-bong-chim.jpg',0,1),
(N'Nhật Ký Căn Phòng Số 13',N'Lan Chi',5,99000,87000,75,2,N'Mỗi dòng nhật ký là một cái chết.',N'nhat-ky-can-phong-13.jpg',0,1),
(N'Búp Bê Không Mắt',N'Hoàng My',5,97000,84000,90,3,N'Con búp bê luôn xuất hiện ở nơi xảy ra tai nạn.',N'bup-be-khong-mat.jpg',0,1),
(N'Gương Khuya',N'Tuấn Kiệt',5,93000,82000,85,1,N'Tấm gương cho thấy hình ảnh của một thế giới khác.',N'guong-khuya.jpg',0,1),

-- Cat 6: Self-help (id=6)
(N'Mỗi Ngày Một Bước Nhỏ',N'Ngô Anh',6,99000,85000,120,10,N'Xây dựng thói quen tích cực từng chút một.',N'moi-ngay-mot-buoc-nho.jpg',0,1),
(N'Đánh Thức Nội Lực',N'Phạm Thiên',6,115000,96000,110,8,N'Khám phá sức mạnh bên trong bản thân.',N'danh-thuc-noi-luc.jpg',0,1),
(N'Nghệ Thuật Sống Tối Giản',N'Quỳnh Trang',6,105000,90000,100,6,N'Bỏ bớt gánh nặng vật chất để nhẹ đầu óc.',N'nghe-thuat-song-toi-gian.jpg',0,1),
(N'Tư Duy Tăng Trưởng',N'Đặng Khoa',6,119000,98000,90,5,N'Thay đổi tư duy để phát triển lâu dài.',N'tu-duy-tang-truong.jpg',0,1),
(N'60 Phút Quản Lý Thời Gian',N'Lý Thanh',6,89000,76000,130,7,N'Các kỹ thuật sắp xếp thời gian hiệu quả.',N'60-phut-quan-ly-thoi-gian.jpg',0,1),
(N'Sống Không Hối Tiếc',N'Minh Tâm',6,109000,92000,100,4,N'Nhìn lại quá khứ để sống trọn vẹn hiện tại.',N'song-khong-hoi-tiec.jpg',0,1),
(N'Tập Trung 100%',N'Văn Khôi',6,99000,85000,120,3,N'Cách loại bỏ xao nhãng để đạt mục tiêu.',N'tap-trung-100.jpg',0,1),

-- Cat 7: Tiểu sử, tự truyện (id=7)
(N'Hành Trình Từ Làng Quê',N'Nguyễn Lợi',7,119000,99000,80,5,N'Tự truyện về hành trình lập nghiệp từ con số 0.',N'hanh-trinh-tu-lang-que.jpg',0,1),
(N'Vượt Lên Số Phận',N'Trần Vy',7,115000,96000,75,4,N'Cuộc đời của một người khuyết tật đầy nghị lực.',N'vuot-len-so-phan.jpg',0,1),
(N'Nhật Ký Nhà Sáng Lập',N'Hoàng Lâm',7,132000,112000,70,3,N'Tự sự về những năm tháng khởi nghiệp.',N'nhat-ky-nha-sang-lap.jpg',0,1),
(N'Con Đường Học Giả',N'Lê Đạt',7,108000,93000,65,2,N'Từ học sinh nghèo đến giáo sư đại học.',N'con-duong-hoc-gia.jpg',0,1),
(N'Giữa Hai Thế Giới',N'An Phương',7,102000,89000,80,2,N'Câu chuyện của người Việt di cư.',N'giua-hai-the-gioi.jpg',0,1),
(N'Người Kể Chuyện Biển',N'Hải Đăng',7,98000,86000,90,3,N'Hồi ký của một thủy thủ già.',N'nguoi-ke-chuyen-bien.jpg',0,1),
(N'Từ Thất Bại Đến Thành Công',N'Phong Vũ',7,125000,105000,85,1,N'Nhìn lại những lần thất bại để trưởng thành.',N'tu-that-bai-den-thanh-cong.jpg',0,1),

-- Cat 8: Truyện ngắn (id=8)
(N'Mưa Trên Phố Cũ',N'Thu Ngân',8,89000,76000,100,6,N'Tuyển tập truyện ngắn về ký ức phố xưa.',N'mua-tren-pho-cu.jpg',0,1),
(N'Những Ngày Tháng Chín',N'Đông Hải',8,95000,82000,95,5,N'Chuỗi truyện ngắn về tuổi trẻ và chia ly.',N'nhung-ngay-thang-chin.jpg',0,1),
(N'Bến Đò Không Tên',N'Tấn Phát',8,91000,79000,90,4,N'Những mảnh đời trôi dạt bên bến sông.',N'ben-do-khong-ten.jpg',0,1),
(N'Truông Mây Chiều Gió',N'Bảo Yến',8,88000,75000,85,3,N'Không khí miền Trung trong các truyện ngắn.',N'truong-may-chieu-gio.jpg',0,1),
(N'Ngôi Làng Sau Đồi',N'Hà Sơn',8,92000,80000,80,2,N'Câu chuyện bình dị nơi làng quê.',N'ngoi-lang-sau-doi.jpg',0,1),
(N'Ngã Rẽ Cuối Đường',N'Diệp Anh',8,93000,81000,75,2,N'Những khoảnh khắc thay đổi cuộc đời.',N'nga-re-cuoi-duong.jpg',0,1),
(N'Hoa Nở Trong Đêm',N'Mỹ Linh',8,97000,84000,70,1,N'Những nhân vật tìm thấy ánh sáng trong bóng tối.',N'hoa-no-trong-dem.jpg',0,1),

-- Cat 9: Lịch sử (id=9)
(N'Những Đế Chế Đã Mất',N'Đặng Chiến',9,145000,125000,80,5,N'Lược sử các đế chế từng thống trị thế giới.',N'nhung-de-che-da-mat.jpg',0,1),
(N'Bước Chân Trên Con Đường Tơ Lụa',N'Văn Trí',9,135000,118000,75,4,N'Hành trình thương mại nối Á – Âu.',N'buoc-chan-tren-con-duong-to-lua.jpg',0,1),
(N'Những Trận Chiến Làm Thay Đổi Lịch Sử',N'Hoàng Anh',9,155000,130000,70,3,N'Phân tích các trận đánh bước ngoặt.',N'nhung-tran-chien-lam-thay-doi-lich-su.jpg',0,1),
(N'Lịch Sử Biển Đông',N'Hữu Thịnh',9,139000,120000,65,2,N'Nhìn lại lịch sử khu vực Biển Đông.',N'lich-su-bien-dong.jpg',0,1),
(N'Chân Dung Các Danh Nhân Thế Giới',N'Anh Thư',9,129000,110000,85,3,N'Câu chuyện phía sau những tên tuổi lớn.',N'chan-dung-danh-nhan-the-gioi.jpg',0,1),
(N'Lược Sử Công Nghệ',N'Quốc Bảo',9,142000,122000,80,2,N'Hành trình phát triển của công nghệ nhân loại.',N'luoc-su-cong-nghe.jpg',0,1),
(N'Việt Nam Qua Các Triều Đại',N'Trần Lộc',9,132000,115000,75,1,N'Tổng quan các triều đại Việt Nam.',N'viet-nam-qua-cac-trieu-dai.jpg',0,1),

-- Cat 10: Bài luận (id=10)
(N'Suy Ngẫm Về Tự Do Cá Nhân',N'Lâm Hiếu',10,98000,86000,80,4,N'Các bài luận ngắn về quyền tự do.',N'suy-ngam-ve-tu-do-ca-nhan.jpg',0,1),
(N'Bàn Về Công Lý Xã Hội',N'Phương Nam',10,102000,89000,75,3,N'Những góc nhìn hiện đại về công lý.',N'ban-ve-cong-ly-xa-hoi.jpg',0,1),
(N'Con Người Và Quyền Lực',N'Đoàn Minh',10,112000,95000,70,2,N'Phân tích mối quan hệ giữa con người và quyền lực.',N'con-nguoi-va-quyen-luc.jpg',0,1),
(N'Những Bài Luận Về Đạo Đức',N'Khải Hoàn',10,105000,90000,65,2,N'Câu hỏi đạo đức trong xã hội hiện đại.',N'nhung-bai-luan-ve-dao-duc.jpg',0,1),
(N'Tương Lai Của Nền Dân Chủ',N'Ngọc Sơn',10,115000,96000,60,1,N'Các kịch bản cho thể chế dân chủ trong tương lai.',N'tuong-lai-cua-nen-dan-chu.jpg',0,1),
(N'Bàn Về Sự Hạnh Phúc',N'An Hòa',10,99000,87000,85,2,N'Những suy tư triết học về hạnh phúc.',N'ban-ve-su-hanh-phuc.jpg',0,1),
(N'Tự Do Ngôn Luận Và Trách Nhiệm',N'Phúc Lâm',10,109000,93000,80,1,N'Quan hệ giữa quyền tự do và trách nhiệm xã hội.',N'tu-do-ngon-luan-va-trach-nhiem.jpg',0,1);