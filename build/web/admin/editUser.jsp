<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String cp=request.getContextPath(); %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>Sửa người dùng - BookApp Admin</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="<%= cp %>/css/style.css" />
            </head>

            <body>
                <%@ include file="/includes/navbar.jsp" %>
                    <div class="admin-layout">
                        <%@ include file="/admin/sidebar.jsp" %>
                            <main class="admin-content">
                                <div style="display:flex;align-items:center;gap:1rem;margin-bottom:1.5rem">
                                    <a href="<%= cp %>/admin/users" class="btn btn-outline btn-sm">&#8592; Quay lại</a>
                                    <h2 style="font-family:'Playfair Display',serif">Sửa người dùng:
                                        ${editUser.username}</h2>
                                </div>
                                <div class="card" style="max-width:600px">
                                    <div class="card-body">
                                        <form action="<%= cp %>/admin/users" method="post">
                                            <input type="hidden" name="id" value="${editUser.id}" />
                                            <div class="form-group">
                                                <label class="form-label">Username</label>
                                                <input type="text" class="form-control" value="${editUser.username}"
                                                    readonly style="background:#f5f5f5" />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Họ và tên *</label>
                                                <input type="text" name="fullname" class="form-control"
                                                    value="${editUser.fullname}" required />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Email *</label>
                                                <input type="email" name="email" class="form-control"
                                                    value="${editUser.email}" required />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Phone</label>
                                                <input type="text" name="phone" class="form-control"
                                                    value="${editUser.phone}" />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Địa chỉ</label>
                                                <input type="text" name="address" class="form-control"
                                                    value="${editUser.address}" />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Vai trò *</label>
                                                <select name="role" class="form-select">
                                                    <option value="customer" ${editUser.role=='customer'
                                                        ?'selected':''}>customer</option>
                                                    <option value="admin" ${editUser.role=='admin' ?'selected':''}>admin
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="form-group form-check">
                                                <input type="checkbox" name="active" id="active" ${editUser.active
                                                    ? 'checked' : '' } />
                                                <label for="active" class="form-label" style="margin-bottom:0">&#9989;
                                                    Hoạt động</label>
                                            </div>
                                            <div style="display:flex;gap:1rem;margin-top:1rem">
                                                <button type="submit" class="btn btn-primary">&#128190; Lưu</button>
                                                <a href="<%= cp %>/admin/users" class="btn btn-outline">Hủy</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </main>
                    </div>
                    <script src="<%= cp %>/js/script.js"></script>
            </body>

            </html>