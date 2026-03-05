<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Quản lý đơn hàng - BookApp Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <h2 style="font-family:'Playfair Display',serif;margin-bottom:1.5rem">&#128230; Quản
                                        lý đơn hàng</h2>
                                    <c:if test="${param.msg == 'updated'}">
                                        <div class="alert alert-success auto-hide">&#9989; Đã cập nhật trạng thái!</div>
                                    </c:if>

                                    <div class="card">
                                        <div class="card-body" style="padding:0">
                                            <div class="table-responsive">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Khách hàng</th>
                                                            <th>Địa chỉ</th>
                                                            <th>Tổng tiền</th>
                                                            <th>Trạng thái</th>
                                                            <th>Ngày đặt</th>
                                                            <th>Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="ord" items="${orders}">
                                                            <tr>
                                                                <td><strong>#${ord.id}</strong></td>
                                                                <td>${ord.userFullname}</td>
                                                                <td style="max-width:180px">${ord.address}</td>
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
                                                                <td style="white-space:nowrap">
                                                                    <a href="<%= cp %>/admin/orders?action=detail&id=${ord.id}"
                                                                        class="btn btn-secondary btn-sm">&#128065;</a>
                                                                    <!-- Quick status change -->
                                                                    <form action="<%= cp %>/admin/orders" method="post"
                                                                        style="display:inline-flex;gap:4px;align-items:center">
                                                                        <input type="hidden" name="id"
                                                                            value="${ord.id}" />
                                                                        <select name="status" class="form-select"
                                                                            style="padding:4px 8px;font-size:0.8rem;width:auto">
                                                                            <option value="Chờ xử lý"
                                                                                ${ord.status=='Chờ xử lý'
                                                                                ?'selected':''}>Chờ xử lý</option>
                                                                            <option value="Đang giao"
                                                                                ${ord.status=='Đang giao'
                                                                                ?'selected':''}>Đang giao</option>
                                                                            <option value="Hoàn thành"
                                                                                ${ord.status=='Hoàn thành'
                                                                                ?'selected':''}>Hoàn thành</option>
                                                                            <option value="Đã hủy"
                                                                                ${ord.status=='Đã hủy' ?'selected':''}>
                                                                                Đã hủy</option>
                                                                        </select>
                                                                        <button type="submit"
                                                                            class="btn btn-primary btn-sm">&#10004;</button>
                                                                    </form>
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