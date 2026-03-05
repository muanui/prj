<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Quản lý người dùng - BookApp Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <h2 style="font-family:'Playfair Display',serif;margin-bottom:1.5rem">&#128100; Quản
                                        lý người dùng</h2>
                                    <c:if test="${param.msg == 'saved'}">
                                        <div class="alert alert-success auto-hide">&#9989; Cập nhật thành công!</div>
                                    </c:if>
                                    <c:if test="${param.msg == 'deleted'}">
                                        <div class="alert alert-warning auto-hide">&#128465; Đã xóa người dùng!</div>
                                    </c:if>

                                    <div class="card">
                                        <div class="card-body" style="padding:0">
                                            <div class="table-responsive">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Username</th>
                                                            <th>Họ tên</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>Vai trò</th>
                                                            <th>Trạng thái</th>
                                                            <th>Ngày tạo</th>
                                                            <th>Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="u" items="${users}">
                                                            <tr>
                                                                <td>${u.id}</td>
                                                                <td><strong>${u.username}</strong></td>
                                                                <td>${u.fullname}</td>
                                                                <td>${u.email}</td>
                                                                <td>${u.phone}</td>
                                                                <td>
                                                                    <span
                                                                        class="badge ${u.role == 'admin' ? 'badge-primary' : 'badge-info'}">${u.role}</span>
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="badge ${u.active ? 'badge-success' : 'badge-danger'}">
                                                                        ${u.active ? 'Hoạt động' : 'Bị khóa'}
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatDate value="${u.createdAt}"
                                                                        pattern="dd/MM/yyyy" />
                                                                </td>
                                                                <td style="white-space:nowrap">
                                                                    <a href="<%= cp %>/admin/users?action=edit&id=${u.id}"
                                                                        class="btn btn-warning btn-sm">&#9998;</a>
                                                                    <a href="<%= cp %>/admin/users?action=toggle&id=${u.id}"
                                                                        class="btn btn-secondary btn-sm"
                                                                        title="${u.active ? 'Khóa' : 'Mở khóa'}">
                                                                        ${u.active ? '&#128274;' : '&#128275;'}
                                                                    </a>
                                                                    <a href="<%= cp %>/admin/users?action=delete&id=${u.id}"
                                                                        class="btn btn-danger btn-sm"
                                                                        onclick="return confirmDelete('Xóa người dùng này?')">&#128465;</a>
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