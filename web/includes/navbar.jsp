<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% model.User currentUser=(model.User) session.getAttribute("user"); dao.CartDAO cartDAO=new dao.CartDAO(); int
            cartCount=currentUser !=null ? cartDAO.countItems(currentUser.getId()) : 0; %>
            <nav class="navbar">
                <div class="navbar-left">
                    <a href="<%= cp %>/home" class="navbar-brand">&#128218; ThuanVaDat<span>Shopp</span></a>
                    <div class="navbar-links">
                        <a href="<%= cp %>/home">Trang chủ</a>
                        <a href="<%= cp %>/home?view=search">Tìm kiếm</a>
                        <% if (currentUser !=null && currentUser.isAdmin()) { %>
                            <a href="<%= cp %>/admin/dashboard">Quản trị</a>
                            <% } %>
                    </div>
                </div>

                <div class="navbar-right">
                    <% if (currentUser !=null) { %>
                        <a href="<%= cp %>/cart" class="cart-icon" title="Giỏ hàng">
                            &#128722;
                            <% if (cartCount> 0) { %>
                                <span class="cart-badge">
                                    <%= cartCount %>
                                </span>
                                <% } %>
                        </a>
                        <div class="user-menu">
                            <div class="avatar">
                                <%= currentUser.getFullname().substring(0,1).toUpperCase() %>
                            </div>
                            <div class="dropdown-menu">
                                <a href="<%= cp %>/profile">&#128100; Hồ sơ</a>
                                <a href="<%= cp %>/profile">&#128197; Đơn hàng của tôi</a>
                                <% if (currentUser.isAdmin()) { %>
                                    <div class="divider"></div>
                                    <a href="<%= cp %>/admin/dashboard">&#9881; Quản trị</a>
                                    <% } %>
                                        <div class="divider"></div>
                                        <a href="<%= cp %>/logout">&#128682; Đăng xuất</a>
                            </div>
                        </div>
                        <% } else { %>
                            <a href="<%= cp %>/register" class="btn-outline btn-auth">Đăng ký</a>
                            <a href="<%= cp %>/login" class="btn-login">Đăng nhập</a>
                            <% } %>
                </div>
            </nav>