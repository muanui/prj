<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String cp=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <title>Đặt hàng thành công - BookApp</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="<%= cp %>/css/style.css" />
        </head>

        <body>
            <%@ include file="/includes/navbar.jsp" %>
                <div class="container section text-center" style="padding:5rem 0">
                    <div style="font-size:5rem">&#127881;</div>
                    <h1 style="font-family:'Playfair Display',serif;color:var(--success);margin:1rem 0">Đặt hàng thành
                        công!</h1>
                    <p style="font-size:1.1rem;color:var(--muted);margin-bottom:2rem">
                        Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là:
                        <strong style="color:var(--accent);font-size:1.3rem"> #${orderId}</strong>
                    </p>
                    <p style="color:var(--muted)">Chúng tôi sẽ liên hệ xác nhận và giao hàng sớm nhất!</p>
                    <div style="display:flex;justify-content:center;gap:1rem;margin-top:2rem;flex-wrap:wrap">
                        <a href="<%= cp %>/profile" class="btn btn-secondary">&#128197; Xem đơn hàng</a>
                        <a href="<%= cp %>/home" class="btn btn-primary">&#128200; Tiếp tục mua sắm</a>
                    </div>
                </div>
                <script src="<%= cp %>/js/script.js"></script>
        </body>

        </html>