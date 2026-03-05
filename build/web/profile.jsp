<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <% String cp=request.getContextPath(); model.User u=(model.User)session.getAttribute("user"); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8" />
                        <title>Hồ sơ - BookApp</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                    </head>

                    <body>
                        <%@ include file="/includes/navbar.jsp" %>
                            <div class="container section">
                                <h1 class="section-title" style="margin-bottom:1.5rem">&#128100; Hồ sơ cá nhân</h1>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success auto-hide">&#9989; ${success}</div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger auto-hide">&#9888; ${error}</div>
                                </c:if>

                                <div style="display:grid;grid-template-columns:1fr 1fr;gap:2rem;align-items:start">
                                    <!-- UPDATE PROFILE -->
                                    <div class="card">
                                        <div class="card-header">&#128221; Cập nhật thông tin</div>
                                        <div class="card-body">
                                            <form action="<%= cp %>/profile" method="post">
                                                <input type="hidden" name="action" value="updateProfile" />
                                                <div class="form-group">
                                                    <label class="form-label">Tên đăng nhập</label>
                                                    <input type="text" class="form-control"
                                                        value="<%= u.getUsername() %>" readonly
                                                        style="background:#f5f5f5" />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Họ và tên *</label>
                                                    <input type="text" name="fullname" class="form-control"
                                                        value="<%= u.getFullname() %>" required />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Email *</label>
                                                    <input type="email" name="email" class="form-control"
                                                        value="<%= u.getEmail() %>" required />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Số điện thoại</label>
                                                    <input type="text" name="phone" class="form-control"
                                                        value="<%= u.getPhone() != null ? u.getPhone() : "" %>" />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Địa chỉ</label>
                                                    <input type="text" name="address" class="form-control"
                                                        value="<%= u.getAddress() != null ? u.getAddress() : "" %>" />
                                                </div>
                                                <button type="submit" class="btn btn-primary w-100">&#128190; Lưu thay
                                                    đổi</button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- CHANGE PASSWORD -->
                                    <div class="card">
                                        <div class="card-header">&#128274; Đổi mật khẩu</div>
                                        <div class="card-body">
                                            <form action="<%= cp %>/profile" method="post">
                                                <input type="hidden" name="action" value="changePassword" />
                                                <div class="form-group">
                                                    <label class="form-label">Mật khẩu hiện tại *</label>
                                                    <input type="password" name="oldPassword" class="form-control"
                                                        required />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Mật khẩu mới *</label>
                                                    <input type="password" name="newPassword" class="form-control"
                                                        required />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Xác nhận mật khẩu mới *</label>
                                                    <input type="password" name="confirmPassword" class="form-control"
                                                        required />
                                                </div>
                                                <button type="submit" class="btn btn-secondary w-100">&#128272; Đổi mật
                                                    khẩu</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- ORDER HISTORY -->
                                <div class="card mt-3">
                                    <div class="card-header">&#128197; Lịch sử đặt hàng (${fn:length(orders)} đơn)</div>
                                    <div class="card-body" style="padding:0">
                                        <c:choose>
                                            <c:when test="${empty orders}">
                                                <div class="text-center" style="padding:2rem;color:var(--muted)">Chưa có
                                                    đơn
                                                    hàng nào.</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-responsive">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Ngày đặt</th>
                                                                <th>Địa chỉ</th>
                                                                <th>Tổng tiền</th>
                                                                <th>Trạng thái</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="ord" items="${orders}">
                                                                <tr>
                                                                    <td>#${ord.id}</td>
                                                                    <td>
                                                                        <fmt:formatDate value="${ord.createdAt}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
                                                                    </td>
                                                                    <td>${ord.address}</td>
                                                                    <td style="font-weight:700;color:var(--accent)">
                                                                        <fmt:formatNumber value="${ord.total}"
                                                                            type="number" maxFractionDigits="0" />đ
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${ord.status == 'Hoàn thành'}">
                                                                                <span
                                                                                    class="badge badge-success">${ord.status}</span>
                                                                            </c:when>
                                                                            <c:when test="${ord.status == 'Đã hủy'}">
                                                                                <span
                                                                                    class="badge badge-danger">${ord.status}</span>
                                                                            </c:when>
                                                                            <c:when test="${ord.status == 'Đang giao'}">
                                                                                <span
                                                                                    class="badge badge-info">${ord.status}</span>
                                                                            </c:when>
                                                                            <c:otherwise><span
                                                                                    class="badge badge-warning">${ord.status}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <script src="<%= cp %>/js/script.js"></script>
                    </body>

                    </html>