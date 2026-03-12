<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String cp=request.getContextPath(); if (session.getAttribute("user") !=null) { response.sendRedirect(cp + "/home"
        ); return; } %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <title>Đăng nhập - ThuanVaDatShopp</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="<%= cp %>/css/style.css" />
        </head>

        <body>
            <div class="auth-container">
                <div class="auth-box animate-in">
                    <div style="text-align:center;font-size:3rem;margin-bottom:.5rem">&#128218;</div>
                    <h1 class="auth-title">ThuanVaDatShopp</h1>
                    <p class="auth-subtitle">Chào mừng trở lại! Vui lòng đăng nhập.</p>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="alert alert-danger auto-hide">&#9888; ${error}</div>
                        <% } %>
                            <% if (request.getAttribute("success") !=null) { %>
                                <div class="alert alert-success auto-hide">&#9989; ${success}</div>
                                <% } %>

                                    <form action="<%= cp %>/login" method="post">
                                        <div class="form-group">
                                            <label class="form-label">Tên đăng nhập</label>
                                            <input type="text" name="username" class="form-control"
                                                placeholder="Nhập tên đăng nhập" required autofocus />
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">Mật khẩu</label>
                                            <input type="password" name="password" class="form-control"
                                                placeholder="Nhập mật khẩu" required />
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100 btn-lg mt-2">
                                             Đăng nhập
                                        </button>
                                    </form>

                                    <div class="auth-footer">
                                        Chưa có tài khoản? <a href="<%= cp %>/register">Đăng ký ngay</a>
                                    </div>
                                    <div class="auth-footer mt-1">
                                        <a href="<%= cp %>/home">&#8592; Quay về trang chủ</a>
                                    </div>
                </div>
            </div>
            <script src="<%= cp %>/js/script.js"></script>
        </body>

        </html>