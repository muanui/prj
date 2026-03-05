<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String cp=request.getContextPath(); if (session.getAttribute("user") !=null) { response.sendRedirect(cp + "/home"
        ); return; } %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <title>Đăng ký - BookApp</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="<%= cp %>/css/style.css" />
        </head>

        <body>
            <div class="auth-container">
                <div class="auth-box animate-in" style="max-width:520px">
                    <div style="text-align:center;font-size:2.5rem;margin-bottom:.5rem">&#128218;</div>
                    <h1 class="auth-title">Tạo tài khoản</h1>
                    <p class="auth-subtitle">Tham gia BookApp ngay hôm nay</p>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="alert alert-danger auto-hide">&#9888; ${error}</div>
                        <% } %>

                            <form action="<%= cp %>/register" method="post">
                                <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem">
                                    <div class="form-group">
                                        <label class="form-label">Tên đăng nhập *</label>
                                        <input type="text" name="username" class="form-control"
                                            placeholder="Tối thiểu 3 ký tự" required minlength="3" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Họ và tên *</label>
                                        <input type="text" name="fullname" class="form-control"
                                            placeholder="Nguyễn Văn A" required />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email *</label>
                                    <input type="email" name="email" class="form-control"
                                        placeholder="email@example.com" required />
                                </div>
                                <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem">
                                    <div class="form-group">
                                        <label class="form-label">Mật khẩu *</label>
                                        <input type="password" name="password" class="form-control"
                                            placeholder="Tối thiểu 6 ký tự" required minlength="6" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Xác nhận mật khẩu *</label>
                                        <input type="password" name="confirm" class="form-control"
                                            placeholder="Nhập lại" required />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" placeholder="0901234567" />
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" name="address" class="form-control"
                                        placeholder="Địa chỉ giao hàng" />
                                </div>
                                <button type="submit" class="btn btn-primary w-100 btn-lg mt-1">
                                    &#9989; Đăng ký ngay
                                </button>
                            </form>

                            <div class="auth-footer">
                                Đã có tài khoản? <a href="<%= cp %>/login">Đăng nhập</a>
                            </div>
                </div>
            </div>
            <script src="<%= cp %>/js/script.js"></script>
        </body>

        </html>