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
                                        <%
                                            String phoneSafe = u.getPhone();
                                            if (phoneSafe == null) phoneSafe = "";
                                            String addrSafe = u.getAddress();
                                            if (addrSafe == null) addrSafe = "";
                                        %>
                                        <form action="<%= cp %>/checkout" method="post">
                                            <!-- Họ tên / Email / Số điện thoại -->
                                            <div class="form-group">
                                                <label class="form-label">Họ và tên</label>
                                                <input type="text" class="form-control" value="<%= u.getFullname() %>"
                                                    readonly />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Email</label>
                                                <input type="email" class="form-control" value="<%= u.getEmail() %>"
                                                    readonly />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" value="<%= phoneSafe %>"
                                                    readonly />
                                            </div>

                                            <!-- Tuỳ chọn giao hàng -->
                                            <div class="form-group" style="margin-top:1rem">
                                                <label class="form-check">
                                                    <input type="radio" name="shippingType" value="DELIVERY" checked />
                                                    <span>Giao tận nơi</span>
                                                </label>
                                            </div>

                                            <!-- Địa chỉ chi tiết giống layout mẫu -->
                                            <div class="form-group">
                                                <label class="form-label">Địa chỉ</label>
                                                <input type="text" name="address" class="form-control"
                                                    value="<%= addrSafe %>"
                                                    placeholder="Số nhà, tên đường, tòa nhà..." required />
                                            </div>

                                            <div style="display:grid;grid-template-columns:repeat(2, minmax(0,1fr));gap:0.75rem">
                                                <div class="form-group">
                                                    <label class="form-label">Quốc gia</label>
                                                    <select class="form-select" disabled>
                                                        <option selected>Việt Nam</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Tỉnh / thành</label>
                                                    <input type="text" class="form-control"
                                                        placeholder="VD: Hà Nội, TP.HCM..." />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Quận / huyện</label>
                                                    <input type="text" class="form-control"
                                                        placeholder="VD: Cầu Giấy, Bình Thạnh..." />
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Phường / xã</label>
                                                    <input type="text" class="form-control"
                                                        placeholder="VD: Dịch Vọng Hậu..." />
                                                </div>
                                            </div>

                                            <div class="form-group" style="margin-top:0.5rem">
                                                <label class="form-check">
                                                    <input type="radio" name="shippingType" value="PICKUP" />
                                                    <span>Nhận tại cửa hàng</span>
                                                </label>
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">Ghi chú</label>
                                                <textarea name="note" class="form-control" rows="3"
                                                    placeholder="Ghi chú cho người giao hàng..."></textarea>
                                            </div>

                                            <!-- Bước 1: nút Thanh toán -->
                                            <button type="button" class="btn btn-primary btn-lg w-100"
                                                onclick="showPaymentMethods()">
                                                &#128179; Tiếp tục đến phương thức thanh toán
                                            </button>

                                            <!-- Bước 2: chọn phương thức thanh toán -->
                                            <div id="payment-methods"
                                                style="display:none;margin-top:1.5rem;border-top:1px solid #eee;padding-top:1.2rem">
                                                <h3 style="margin-bottom:0.8rem;font-size:1rem">Chọn phương thức thanh
                                                    toán
                                                </h3>
                                            <div class="form-group">
                                                <label class="form-check">
                                                    <input type="radio" name="paymentMethod" value="COD" checked
                                                        onclick="onPaymentMethodChange('COD')" />
                                                    <span>Thanh toán khi nhận hàng (COD)</span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-check">
                                                    <input type="radio" name="paymentMethod" value="BANK"
                                                        onclick="onPaymentMethodChange('BANK')" />
                                                    <span>Chuyển khoản ngân hàng</span>
                                                </label>
                                            </div>
                                            <div id="bank-info" class="bank-info" style="display:none">
                                                <p><strong>Ngân hàng:</strong> TPBank</p>
                                                <p><strong>Số tài khoản:</strong> 1000 0340 448</p>
                                                <p><strong>Chủ tài khoản:</strong> Nguyễn Tiến Đạt</p>
                                                <div class="bank-qr-wrapper">
                                                    <img src="<%= cp %>/images/tpbank-qr.png"
                                                        alt="QR TPBank - Nguyễn Tiến Đạt" class="bank-qr">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-check">
                                                    <input type="radio" name="paymentMethod" value="WALLET"
                                                        onclick="onPaymentMethodChange('WALLET')" />
                                                    <span>Ví điện tử (Momo, ZaloPay...)</span>
                                                </label>
                                            </div>

                                                <button type="submit" class="btn btn-success btn-lg w-100 mt-2">
                                                    &#9989; Xác nhận đặt hàng
                                                </button>
                                            </div>
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
                        <script>
                            function showPaymentMethods() {
                                var block = document.getElementById('payment-methods');
                                if (block) {
                                    block.style.display = 'block';
                                    block.scrollIntoView({ behavior: 'smooth', block: 'start' });
                                }
                            }

                            function onPaymentMethodChange(method) {
                                var bank = document.getElementById('bank-info');
                                if (!bank) return;
                                bank.style.display = (method === 'BANK') ? 'block' : 'none';
                            }
                        </script>
                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>