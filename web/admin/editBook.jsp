<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String cp=request.getContextPath(); model.Book book=(model.Book) request.getAttribute("book"); boolean
            isEdit=book!=null && book.getId()>0; %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>
                    <%= isEdit ? "Sửa" : "Thêm" %> sách - BookApp Admin
                </title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                <style>
                    .img-preview-wrap {
                        position: relative;
                        display: inline-block;
                        border-radius: 8px;
                        overflow: hidden;
                        border: 2px dashed var(--border);
                        min-width: 120px;
                        min-height: 160px;
                        background: #f5f5f7;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    #imgPreview {
                        max-width: 180px;
                        max-height: 220px;
                        display: block;
                        border-radius: 6px;
                        object-fit: cover;
                    }

                    .img-placeholder-icon {
                        font-size: 3rem;
                        color: var(--muted);
                    }

                    .upload-label {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        cursor: pointer;
                        padding: 9px 18px;
                        border-radius: 8px;
                        border: 2px solid var(--accent);
                        color: var(--accent);
                        font-weight: 600;
                        font-size: 0.875rem;
                        transition: all 0.3s ease;
                        background: transparent;
                    }

                    .upload-label:hover {
                        background: var(--accent);
                        color: #fff;
                    }

                    #imageFile {
                        display: none;
                    }
                </style>
            </head>

            <body>
                <%@ include file="/includes/navbar.jsp" %>
                    <div class="admin-layout">
                        <%@ include file="/admin/sidebar.jsp" %>
                            <main class="admin-content">
                                <div style="display:flex;align-items:center;gap:1rem;margin-bottom:1.5rem">
                                    <a href="<%= cp %>/admin/books" class="btn btn-outline btn-sm">&#8592; Quay lại</a>
                                    <h2 style="font-family:'Playfair Display',serif">
                                        ${book.id > 0 ? 'Sửa sách' : 'Thêm sách mới'}
                                    </h2>
                                </div>

                                <div class="card" style="max-width:750px">
                                    <div class="card-body">
                                        <form action="<%= cp %>/admin/books" method="post"
                                            enctype="multipart/form-data">
                                            <input type="hidden" name="action"
                                                value="${book.id > 0 ? 'edit' : 'add'}" />
                                            <c:if test="${book.id > 0}">
                                                <input type="hidden" name="id" value="${book.id}" />
                                            </c:if>
                                            <!-- Giữ ảnh cũ nếu không upload mới -->
                                            <input type="hidden" name="existingImage" value="${book.image}" />

                                            <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem">

                                                <div class="form-group" style="grid-column:1/-1">
                                                    <label class="form-label">Tiêu đề *</label>
                                                    <input type="text" name="title" class="form-control"
                                                        value="${book.title}" required />
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Tác giả *</label>
                                                    <input type="text" name="author" class="form-control"
                                                        value="${book.author}" required />
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Danh mục *</label>
                                                    <select name="categoryId" class="form-select" required>
                                                        <c:forEach var="cat" items="${categories}">
                                                            <option value="${cat.id}" ${book.categoryId==cat.id
                                                                ? 'selected' : '' }>${cat.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Giá gốc (đ) *</label>
                                                    <input type="number" name="price" class="form-control"
                                                        value="${book.price}" required min="0" />
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Giá khuyến mãi (đ)</label>
                                                    <input type="number" name="salePrice" class="form-control"
                                                        value="${book.salePrice}" min="0" />
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Số lượng tồn *</label>
                                                    <input type="number" name="stock" class="form-control"
                                                        value="${book.stock}" required min="0" />
                                                </div>

                                                <!-- ===== ẢNH BÌA ===== -->
                                                <div class="form-group" style="grid-column:1/-1">
                                                    <label class="form-label">&#128247; Ảnh bìa sách</label>
                                                    <div
                                                        style="display:flex;align-items:flex-start;gap:1.5rem;flex-wrap:wrap">
                                                        <!-- Preview -->
                                                        <div class="img-preview-wrap">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${not empty book.image and book.image != 'default.jpg'}">
                                                                    <img id="imgPreview"
                                                                        src="<%= cp %>/images/books/${book.image}"
                                                                        alt="Ảnh bìa"
                                                                        onerror="this.style.display='none';document.getElementById('imgIcon').style.display='block'" />
                                                                    <span id="imgIcon" class="img-placeholder-icon"
                                                                        style="display:none">&#128218;</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img id="imgPreview" style="display:none"
                                                                        alt="Preview" />
                                                                    <span id="imgIcon"
                                                                        class="img-placeholder-icon">&#128218;</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <!-- Upload button -->
                                                        <div
                                                            style="display:flex;flex-direction:column;gap:0.75rem;justify-content:center">
                                                            <label class="upload-label" for="imageFile">
                                                                &#128196; Chọn ảnh (JPG/PNG/WEBP)
                                                            </label>
                                                            <input type="file" id="imageFile" name="imageFile"
                                                                accept="image/jpeg,image/png,image/webp,image/gif" />
                                                            <span style="font-size:0.8rem;color:var(--muted)">Tối đa 5
                                                                MB. Để trống → giữ ảnh cũ.</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group" style="grid-column:1/-1">
                                                    <label class="form-label">Mô tả</label>
                                                    <textarea name="description" class="form-control"
                                                        rows="4">${book.description}</textarea>
                                                </div>

                                                <div class="form-group form-check">
                                                    <input type="checkbox" name="featured" id="featured" ${book.featured
                                                        ? 'checked' : '' } />
                                                    <label for="featured" class="form-label"
                                                        style="margin-bottom:0">&#11088; Sách nổi bật</label>
                                                </div>

                                                <c:if test="${book.id > 0}">
                                                    <div class="form-group form-check">
                                                        <input type="checkbox" name="active" id="active" ${book.active
                                                            ? 'checked' : '' } />
                                                        <label for="active" class="form-label"
                                                            style="margin-bottom:0">&#9989; Hiển thị</label>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <div style="display:flex;gap:1rem;margin-top:1rem">
                                                <button type="submit" class="btn btn-primary">&#128190; Lưu
                                                    sách</button>
                                                <a href="<%= cp %>/admin/books" class="btn btn-outline">Hủy</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </main>
                    </div>

                    <script src="<%= cp %>/js/script.js"></script>
                    <script>
                        // Preview ảnh ngay khi chọn file
                        document.getElementById('imageFile').addEventListener('change', function () {
                            const file = this.files[0];
                            if (!file) return;
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                const img = document.getElementById('imgPreview');
                                const icon = document.getElementById('imgIcon');
                                img.src = e.target.result;
                                img.style.display = 'block';
                                if (icon) icon.style.display = 'none';
                            };
                            reader.readAsDataURL(file);
                        });
                    </script>
            </body>

            </html>