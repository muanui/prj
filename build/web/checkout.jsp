<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); model.User u=(model.User)session.getAttribute("user"); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Thanh toán - BookApp</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="container section">
                            <h1 class="section-title" style="margin-bottom:1.5rem">&#128179; Thanh toán</h1>
                            <div style="display:grid;grid-template-columns:1fr 380px;gap:2rem;align-items:start">
                                <!-- ORDER FORM -->
                                <div class="card">
                                    <div class="card-header">Thông tin giao hàng</div>
                                    <div class="card-body">
                                        <form action="<%= cp %>/checkout" method="post">
                                            <div class="form-group">
                                                <label class="form-label">Họ và tên</label>
                                                <input type="text" class="form-control" value="<%= u.getFullname() %>"
                                                    readonly />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Địa chỉ giao hàng *</label>
                                                <input type="text" name="address" class="form-control"
                                                    value="<%= u.getAddress() != null ? u.getAddress() : "" %>"
                                                    placeholder="Nhập địa chỉ giao hàng" required />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Ghi chú</label>
                                                <textarea name="note" class="form-control" rows="3"
                                                    placeholder="Ghi chú cho người giao hàng..."></textarea>
                                            </div>
                                            <div class="alert alert-info">
                                                &#128179; Phương thức thanh toán: <strong>Thanh toán khi nhận hàng
                                                    (COD)</strong>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-lg w-100">
                                                &#9989; Xác nhận đặt hàng
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <!-- ITEMS SUMMARY -->
                                <div class="order-summary">
                                    <h3 style="font-weight:700;margin-bottom:1.2rem">Đơn hàng của bạn</h3>
                                    <c:forEach var="item" items="${cartItems}">
                                        <div class="row" style="align-items:center">
                                            <span style="flex:1">${item.bookTitle} × ${item.quantity}</span>
                                            <span>
                                                <fmt:formatNumber value="${item.subtotal}" type="number"
                                                    maxFractionDigits="0" />đ
                                            </span>
                                        </div>
                                    </c:forEach>
                                    <div class="row total">
                                        <span>Tổng cộng:</span>
                                        <span style="color:var(--accent)">
                                            <fmt:formatNumber value="${cartTotal}" type="number"
                                                maxFractionDigits="0" />đ
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>