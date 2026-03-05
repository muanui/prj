<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String cp=request.getContextPath(); model.Book book=(model.Book) request.getAttribute("book"); boolean
            isEdit=book !=null && book.getId()> 0; %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>${isEdit ? 'Sửa' : 'Thêm'} sách - BookApp Admin</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="<%= cp %>/css/style.css" />
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
                                <div class="card" style="max-width:700px">
                                    <div class="card-body">
                                        <form action="<%= cp %>/admin/books" method="post">
                                            <input type="hidden" name="action"
                                                value="${book.id > 0 ? 'edit' : 'add'}" />
                                            <c:if test="${book.id > 0}">
                                                <input type="hidden" name="id" value="${book.id}" />
                                            </c:if>

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
                                                <div class="form-group">
                                                    <label class="form-label">Tên file ảnh</label>
                                                    <input type="text" name="image" class="form-control"
                                                        value="${book.image}" placeholder="default.jpg" />
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
            </body>

            </html>