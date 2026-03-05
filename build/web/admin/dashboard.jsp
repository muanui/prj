<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Admin Dashboard - BookApp</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <h2 style="font-family:'Playfair Display',serif;margin-bottom:1.5rem">&#128202; Tổng
                                        quan hệ thống</h2>

                                    <div class="stat-grid">
                                        <div class="stat-card">
                                            <div class="stat-icon" style="background:#fff0f3">&#128218;</div>
                                            <div>
                                                <div class="stat-value">${totalBooks}</div>
                                                <div class="stat-label">Đầu sách</div>
                                            </div>
                                        </div>
                                        <div class="stat-card" style="border-left-color:#28a745">
                                            <div class="stat-icon" style="background:#f0fff4">&#128100;</div>
                                            <div>
                                                <div class="stat-value">${totalUsers}</div>
                                                <div class="stat-label">Khách hàng</div>
                                            </div>
                                        </div>
                                        <div class="stat-card" style="border-left-color:#ffc107">
                                            <div class="stat-icon" style="background:#fffbf0">&#128230;</div>
                                            <div>
                                                <div class="stat-value">${totalOrders}</div>
                                                <div class="stat-label">Đơn hàng</div>
                                            </div>
                                        </div>
                                        <div class="stat-card" style="border-left-color:#0f3460">
                                            <div class="stat-icon" style="background:#f0f4ff">&#128178;</div>
                                            <div>
                                                <div class="stat-value" style="font-size:1.1rem">
                                                    <fmt:formatNumber value="${totalRevenue}" type="number"
                                                        maxFractionDigits="0" />đ
                                                </div>
                                                <div class="stat-label">Doanh thu</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- RECENT ORDERS -->
                                    <div class="card">
                                        <div class="card-header">
                                            &#128230; Đơn hàng gần đây
                                            <a href="<%= cp %>/admin/orders" class="btn btn-outline btn-sm">Xem tất
                                                cả</a>
                                        </div>
                                        <div class="card-body" style="padding:0">
                                            <div class="table-responsive">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Khách hàng</th>
                                                            <th>Tổng tiền</th>
                                                            <th>Trạng thái</th>
                                                            <th>Ngày</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="ord" items="${recentOrders}">
                                                            <tr>
                                                                <td>#${ord.id}</td>
                                                                <td>${ord.userFullname}</td>
                                                                <td style="font-weight:700;color:var(--accent)">
                                                                    <fmt:formatNumber value="${ord.total}" type="number"
                                                                        maxFractionDigits="0" />đ
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${ord.status == 'Hoàn thành'}">
                                                                            <span
                                                                                class="badge badge-success">${ord.status}</span>
                                                                        </c:when>
                                                                        <c:when test="${ord.status == 'Đã hủy'}"><span
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
                                                                <td>
                                                                    <fmt:formatDate value="${ord.createdAt}"
                                                                        pattern="dd/MM/yyyy" />
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