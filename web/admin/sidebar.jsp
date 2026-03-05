<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // cp đã được khai báo ở trang cha (admin *.jsp), không khai báo lại để tránh Duplicate local variable cp
    String path = request.getServletPath();
%>
        <aside class="sidebar">
            <div class="sidebar-brand">&#9881; Admin Panel</div>
            <nav class="sidebar-nav">
                <a href="<%= cp %>/admin/dashboard"
                    class="${pageContext.request.servletPath == '/admin/dashboard' ? 'active' : ''}">
                    <span class="nav-icon">&#128202;</span> Dashboard
                </a>
                <a href="<%= cp %>/admin/books">
                    <span class="nav-icon">&#128218;</span> Quản lý sách
                </a>
                <a href="<%= cp %>/admin/categories">
                    <span class="nav-icon">&#128193;</span> Danh mục
                </a>
                <a href="<%= cp %>/admin/users">
                    <span class="nav-icon">&#128100;</span> Người dùng
                </a>
                <a href="<%= cp %>/admin/orders">
                    <span class="nav-icon">&#128230;</span> Đơn hàng
                </a>
                <a href="<%= cp %>/admin/statistics">
                    <span class="nav-icon">&#128200;</span> Thống kê
                </a>
                <div style="height:1px;background:rgba(255,255,255,0.1);margin:8px 0"></div>
                <a href="<%= cp %>/home">
                    <span class="nav-icon">&#127968;</span> Trang chủ
                </a>
                <a href="<%= cp %>/logout">
                    <span class="nav-icon">&#128682;</span> Đăng xuất
                </a>
            </nav>
        </aside>