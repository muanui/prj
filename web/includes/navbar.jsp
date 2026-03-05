<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Biến cp đã được khai báo ở trang cha (home.jsp, v.v.), không khai báo lại để tránh Duplicate local variable cp
    model.User currentUser = (model.User) session.getAttribute("user");
    dao.CartDAO cartDAO = new dao.CartDAO();
    int cartCount = currentUser != null ? cartDAO.countItems(currentUser.getId()) : 0;
%>
            <nav class="navbar">
                <a href="<%= cp %>/home" class="navbar-brand">&#128218; Book<span>App</span></a>

                <form action="<%= cp %>/home" method="get" class="search-form">
                    <input type="hidden" name="view" value="search" />
                    <input type="text" name="keyword" placeholder="Tìm sách, tác giả..." value="${param.keyword}" />
                    <button type="submit">&#128269;</button>
                </form>

                <div class="navbar-links">
                    <a href="<%= cp %>/home">Trang chủ</a>
                    <a href="<%= cp %>/home?view=search">Tìm kiếm</a>
                    <% if (currentUser !=null && currentUser.isAdmin()) { %>
                        <a href="<%= cp %>/admin/dashboard">Quản trị</a>
                        <% } %>
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
                            <a href="<%= cp %>/login" class="btn-login">Đăng nhập</a>
                            <% } %>
                </div>
            </nav>