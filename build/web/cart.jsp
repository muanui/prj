<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <% String cp=request.getContextPath(); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8" />
                        <title>Giỏ hàng - BookApp</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                    </head>

                    <body>
                        <%@ include file="/includes/navbar.jsp" %>
                            <div class="container section">
                                <h1 class="section-title" style="margin-bottom:1.5rem">&#128722; Giỏ hàng của bạn</h1>

                                <c:if test="${empty cartItems}">
                                    <div class="text-center" style="padding:4rem">
                                        <div style="font-size:5rem">&#128722;</div>
                                        <p style="color:var(--muted);margin-top:1rem;font-size:1.1rem">Giỏ hàng trống!
                                        </p>
                                        <a href="<%= cp %>/home" class="btn btn-primary mt-2">&#128200; Tiếp tục mua
                                            sắm</a>
                                    </div>
                                </c:if>

                                <c:if test="${not empty cartItems}">
                                    <div class="cart-layout">
                                        <!-- CART ITEMS -->
                                        <div class="card">
                                            <div class="card-header">
                                                &#128722; ${fn:length(cartItems)} sản phẩm
                                                <form action="<%= cp %>/cart" method="post" style="display:inline">
                                                    <input type="hidden" name="action" value="clear" />
                                                    <button type="submit" class="btn btn-danger btn-sm"
                                                        onclick="return confirmDelete('Xóa tất cả sản phẩm?')">&#128465;
                                                        Xóa
                                                        tất cả</button>
                                                </form>
                                            </div>
                                            <div class="card-body" style="padding:0">
                                                <c:forEach var="item" items="${cartItems}">
                                                    <div class="cart-item">
                                                        <div class="book-cover-placeholder"
                                                            data-title="${item.bookTitle}"
                                                            style="width:70px;height:90px;border-radius:6px;font-size:0.7rem;flex-shrink:0">
                                                            <span style="font-size:1.5rem">&#128218;</span>
                                                        </div>
                                                        <div class="cart-item-info">
                                                            <div class="cart-item-title">${item.bookTitle}</div>
                                                            <div class="cart-item-price">
                                                                <fmt:formatNumber value="${item.price}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </div>
                                                        </div>
                                                        <!-- Quantity update form -->
                                                        <form action="<%= cp %>/cart" method="post"
                                                            style="display:flex;align-items:center;gap:8px">
                                                            <input type="hidden" name="action" value="update" />
                                                            <input type="hidden" name="cartId" value="${item.id}" />
                                                            <div class="qty-control">
                                                                <button type="button" class="qty-btn"
                                                                    onclick="changeQty(${item.id},-1)">−</button>
                                                                <input type="number" name="qty" id="qty_${item.id}"
                                                                    value="${item.quantity}" min="1"
                                                                    class="qty-input" />
                                                                <button type="button" class="qty-btn"
                                                                    onclick="changeQty(${item.id},1)">+</button>
                                                            </div>
                                                            <button type="submit" class="btn btn-secondary btn-sm">Cập
                                                                nhật</button>
                                                        </form>
                                                        <!-- Subtotal & remove -->
                                                        <div style="text-align:right;min-width:100px">
                                                            <div style="font-weight:700;color:var(--accent)">
                                                                <fmt:formatNumber value="${item.subtotal}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </div>
                                                            <form action="<%= cp %>/cart" method="post" class="mt-1">
                                                                <input type="hidden" name="action" value="remove" />
                                                                <input type="hidden" name="cartId" value="${item.id}" />
                                                                <button type="submit"
                                                                    class="btn btn-danger btn-sm">&#10006;</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- ORDER SUMMARY -->
                                        <div class="order-summary">
                                            <h3 style="font-weight:700;margin-bottom:1.2rem">Tóm tắt đơn hàng</h3>
                                            <div class="row"><span>Số sản
                                                    phẩm:</span><span>${fn:length(cartItems)}</span>
                                            </div>
                                            <div class="row total">
                                                <span>Tổng cộng:</span>
                                                <span style="color:var(--accent)">
                                                    <fmt:formatNumber value="${cartTotal}" type="number"
                                                        maxFractionDigits="0" />đ
                                                </span>
                                            </div>
                                            <a href="<%= cp %>/checkout" class="btn btn-primary w-100 btn-lg mt-2">
                                                &#128179; Đặt hàng ngay
                                            </a>
                                            <a href="<%= cp %>/home" class="btn btn-outline w-100 mt-1">
                                                &#8592; Tiếp tục mua sắm
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <script src="<%= cp %>/js/script.js"></script>
                    </body>

                    </html>