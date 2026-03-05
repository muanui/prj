<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String cp=request.getContextPath(); %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>Danh mục - BookApp Admin</title>
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
                                    <h2 style="font-family:'Playfair Display',serif">&#128193; Quản lý danh mục</h2>
                                    <a href="<%= cp %>/admin/categories?action=add" class="btn btn-primary">&#43; Thêm
                                        danh mục</a>
                                </div>
                                <c:if test="${param.msg == 'saved'}">
                                    <div class="alert alert-success auto-hide">&#9989; Lưu thành công!</div>
                                </c:if>
                                <c:if test="${param.msg == 'deleted'}">
                                    <div class="alert alert-warning auto-hide">&#128465; Đã xóa!</div>
                                </c:if>

                                <div class="card">
                                    <div class="card-body" style="padding:0">
                                        <div class="table-responsive">
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Tên danh mục</th>
                                                        <th>Mô tả</th>
                                                        <th>Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <tr>
                                                            <td>${cat.id}</td>
                                                            <td><strong>${cat.name}</strong></td>
                                                            <td style="color:var(--muted)">${cat.description}</td>
                                                            <td style="white-space:nowrap">
                                                                <a href="<%= cp %>/admin/categories?action=edit&id=${cat.id}"
                                                                    class="btn btn-warning btn-sm">&#9998;</a>
                                                                <a href="<%= cp %>/admin/categories?action=delete&id=${cat.id}"
                                                                    class="btn btn-danger btn-sm"
                                                                    onclick="return confirmDelete('Xóa danh mục này?')">&#128465;</a>
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