<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Quản lý sách - BookApp Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <div
                                        style="display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem">
                                        <h2 style="font-family:'Playfair Display',serif">&#128218; Quản lý sách</h2>
                                        <a href="<%= cp %>/admin/books?action=add" class="btn btn-primary">&#43; Thêm
                                            sách mới</a>
                                    </div>

                                    <c:if test="${param.msg == 'saved'}">
                                        <div class="alert alert-success auto-hide">&#9989; Lưu thành công!</div>
                                    </c:if>
                                    <c:if test="${param.msg == 'deleted'}">
                                        <div class="alert alert-warning auto-hide">&#128465; Đã xóa sách!</div>
                                    </c:if>

                                    <div class="card">
                                        <div class="card-body" style="padding:0">
                                            <div class="table-responsive">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Tiêu đề</th>
                                                            <th>Tác giả</th>
                                                            <th>Danh mục</th>
                                                            <th>Giá</th>
                                                            <th>Giá KM</th>
                                                            <th>Tồn</th>
                                                            <th>Đã bán</th>
                                                            <th>Nổi bật</th>
                                                            <th>Hiện</th>
                                                            <th>Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="book" items="${books}">
                                                            <tr>
                                                                <td>${book.id}</td>
                                                                <td style="max-width:180px;font-weight:600">
                                                                    ${book.title}</td>
                                                                <td>${book.author}</td>
                                                                <td>${book.categoryName}</td>
                                                                <td>
                                                                    <fmt:formatNumber value="${book.price}"
                                                                        type="number" maxFractionDigits="0" />đ
                                                                </td>
                                                                <td>
                                                                    <c:if
                                                                        test="${book.salePrice != null && book.salePrice > 0}">
                                                                        <fmt:formatNumber value="${book.salePrice}"
                                                                            type="number" maxFractionDigits="0" />đ
                                                                    </c:if>
                                                                </td>
                                                                <td>${book.stock}</td>
                                                                <td>${book.sold}</td>
                                                                <td>${book.featured ? '⭐' : '—'}</td>
                                                                <td>
                                                                    <span
                                                                        class="badge ${book.active ? 'badge-success' : 'badge-danger'}">
                                                                        ${book.active ? 'Hiện' : 'Ẩn'}
                                                                    </span>
                                                                </td>
                                                                <td style="white-space:nowrap">
                                                                    <a href="<%= cp %>/admin/books?action=edit&id=${book.id}"
                                                                        class="btn btn-warning btn-sm">&#9998;</a>
                                                                    <a href="<%= cp %>/admin/books?action=delete&id=${book.id}"
                                                                        class="btn btn-danger btn-sm"
                                                                        onclick="return confirmDelete('Xóa sách này?')">&#128465;</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </main>
                        </div>
                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>