<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String cp=request.getContextPath(); %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>Sửa danh mục - BookApp Admin</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="<%= cp %>/css/style.css" />
            </head>

            <body>
                <%@ include file="/includes/navbar.jsp" %>
                    <div class="admin-layout">
                        <%@ include file="/admin/sidebar.jsp" %>
                            <main class="admin-content">
                                <div style="display:flex;align-items:center;gap:1rem;margin-bottom:1.5rem">
                                    <a href="<%= cp %>/admin/categories" class="btn btn-outline btn-sm">&#8592; Quay
                                        lại</a>
                                    <h2 style="font-family:'Playfair Display',serif">${cat.id > 0 ? 'Sửa danh mục' :
                                        'Thêm
                                        danh mục mới'}</h2>
                                </div>
                                <div class="card" style="max-width:500px">
                                    <div class="card-body">
                                        <form action="<%= cp %>/admin/categories" method="post">
                                            <c:if test="${cat.id > 0}"><input type="hidden" name="id"
                                                    value="${cat.id}" />
                                            </c:if>
                                            <div class="form-group">
                                                <label class="form-label">Tên danh mục *</label>
                                                <input type="text" name="name" class="form-control" value="${cat.name}"
                                                    required />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Mô tả</label>
                                                <textarea name="description" class="form-control"
                                                    rows="3">${cat.description}</textarea>
                                            </div>
                                            <div style="display:flex;gap:1rem">
                                                <button type="submit" class="btn btn-primary">&#128190; Lưu</button>
                                                <a href="<%= cp %>/admin/categories" class="btn btn-outline">Hủy</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </main>
                    </div>
                    <script src="<%= cp %>/js/script.js"></script>
            </body>

            </html>