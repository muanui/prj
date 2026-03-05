<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Chi tiết đơn hàng - BookApp Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <div style="display:flex;align-items:center;gap:1rem;margin-bottom:1.5rem">
                                        <a href="<%= cp %>/admin/orders" class="btn btn-outline btn-sm">&#8592; Quay
                                            lại</a>
                                        <h2 style="font-family:'Playfair Display',serif">Chi tiết đơn hàng #${order.id}
                                        </h2>
                                    </div>

                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:2rem;margin-bottom:2rem">
                                        <div class="card">
                                            <div class="card-header">Thông tin đơn</div>
                                            <div class="card-body">
                                                <p><strong>Khách hàng:</strong> ${order.userFullname}</p>
                                                <p><strong>Địa chỉ:</strong> ${order.address}</p>
                                                <p><strong>Ghi chú:</strong> ${order.note}</p>
                                                <p><strong>Ngày đặt:</strong>
                                                    <fmt:formatDate value="${order.createdAt}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </p>
                                                <p><strong>Trạng thái:</strong>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'Hoàn thành'}"><span
                                                                class="badge badge-success">${order.status}</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Đã hủy'}"><span
                                                                class="badge badge-danger">${order.status}</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Đang giao'}"><span
                                                                class="badge badge-info">${order.status}</span></c:when>
                                                        <c:otherwise><span
                                                                class="badge badge-warning">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p><strong>Tổng tiền:</strong>
                                                    <span style="color:var(--accent);font-weight:800;font-size:1.1rem">
                                                        <fmt:formatNumber value="${order.total}" type="number"
                                                            maxFractionDigits="0" />đ
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header">Cập nhật trạng thái</div>
                                            <div class="card-body">
                                                <form action="<%= cp %>/admin/orders" method="post">
                                                    <input type="hidden" name="id" value="${order.id}" />
                                                    <div class="form-group">
                                                        <label class="form-label">Trạng thái mới</label>
                                                        <select name="status" class="form-select">
                                                            <option value="Chờ xử lý" ${order.status=='Chờ xử lý'
                                                                ?'selected':''}>Chờ xử lý</option>
                                                            <option value="Đang giao" ${order.status=='Đang giao'
                                                                ?'selected':''}>Đang giao</option>
                                                            <option value="Hoàn thành" ${order.status=='Hoàn thành'
                                                                ?'selected':''}>Hoàn thành</option>
                                                            <option value="Đã hủy" ${order.status=='Đã hủy'
                                                                ?'selected':''}>Đã hủy</option>
                                                        </select>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">&#128190; Cập
                                                        nhật</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card">
                                        <div class="card-header">Danh sách sản phẩm</div>
                                        <div class="card-body" style="padding:0">
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>Sách</th>
                                                        <th>Đơn giá</th>
                                                        <th>SL</th>
                                                        <th>Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="d" items="${order.details}">
                                                        <tr>
                                                            <td>${d.bookTitle}</td>
                                                            <td>
                                                                <fmt:formatNumber value="${d.price}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </td>
                                                            <td>${d.quantity}</td>
                                                            <td style="font-weight:700;color:var(--accent)">
                                                                <fmt:formatNumber value="${d.subtotal}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </main>
                        </div>
                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>