<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); int
                currentYear=java.util.Calendar.getInstance().get(java.util.Calendar.YEAR); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Thống kê - BookApp Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>
                        <div class="admin-layout">
                            <%@ include file="/admin/sidebar.jsp" %>
                                <main class="admin-content">
                                    <div
                                        style="display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem;flex-wrap:wrap;gap:1rem">
                                        <h2 style="font-family:'Playfair Display',serif">&#128200; Thống kê</h2>
                                        <form action="<%= cp %>/admin/statistics" method="get"
                                            style="display:flex;gap:0.5rem;align-items:center">
                                            <select name="year" class="form-select" style="width:auto">
                                                <c:forEach begin="${year-2}" end="${year}" var="y">
                                                    <option value="${y}" ${y==year?'selected':''}>${y}</option>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="btn btn-primary btn-sm">&#128200; Xem</button>
                                        </form>
                                    </div>

                                    <!-- SUMMARY CARDS (max, min, avg, sum, count) -->
                                    <div class="stat-grid" style="margin-bottom:2rem">
                                        <c:forEach var="entry" items="${summary}">
                                            <div class="stat-card">
                                                <div class="stat-icon" style="background:#fff0f3">&#128202;</div>
                                                <div>
                                                    <div class="stat-label">${entry.key}</div>
                                                    <div class="stat-value" style="font-size:1.1rem">
                                                        <c:choose>
                                                            <c:when test="${entry.key == 'Tổng đơn hàng hoàn thành'}">
                                                                ${entry.value}</c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${entry.value}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:2rem;align-items:start">
                                        <!-- REVENUE BY MONTH -->
                                        <div class="card">
                                            <div class="card-header">&#128197; Doanh thu theo tháng (${year})</div>
                                            <div class="card-body" style="padding:0">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Tháng</th>
                                                            <th>Doanh thu</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${empty revenueByMonth}">
                                                                <tr>
                                                                    <td colspan="2" class="text-center"
                                                                        style="color:var(--muted);padding:1.5rem">Chưa
                                                                        có dữ liệu</td>
                                                                </tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach var="entry" items="${revenueByMonth}">
                                                                    <tr>
                                                                        <td>${entry.key}</td>
                                                                        <td style="font-weight:700;color:var(--accent)">
                                                                            <fmt:formatNumber value="${entry.value}"
                                                                                type="number" maxFractionDigits="0" />đ
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- COUNT BY STATUS -->
                                        <div class="card">
                                            <div class="card-header">&#128230; Đơn theo trạng thái</div>
                                            <div class="card-body" style="padding:0">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Trạng thái</th>
                                                            <th>Số lượng</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="entry" items="${countByStatus}">
                                                            <tr>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${entry.key == 'Hoàn thành'}">
                                                                            <span
                                                                                class="badge badge-success">${entry.key}</span>
                                                                        </c:when>
                                                                        <c:when test="${entry.key == 'Đã hủy'}"><span
                                                                                class="badge badge-danger">${entry.key}</span>
                                                                        </c:when>
                                                                        <c:when test="${entry.key == 'Đang giao'}"><span
                                                                                class="badge badge-info">${entry.key}</span>
                                                                        </c:when>
                                                                        <c:otherwise><span
                                                                                class="badge badge-warning">${entry.key}</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td><strong>${entry.value}</strong></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- REVENUE BY CATEGORY -->
                                        <div class="card">
                                            <div class="card-header">&#128193; Doanh thu theo danh mục</div>
                                            <div class="card-body" style="padding:0">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Danh mục</th>
                                                            <th>Doanh thu</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="row" items="${revenueByCategory}">
                                                            <tr>
                                                                <td>${row[0]}</td>
                                                                <td style="font-weight:700;color:var(--accent)">
                                                                    <fmt:formatNumber value="${row[1]}" type="number"
                                                                        maxFractionDigits="0" />đ
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <!-- TOP BOOKS -->
                                        <div class="card">
                                            <div class="card-header">&#128293; Top 10 sách bán chạy</div>
                                            <div class="card-body" style="padding:0">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Sách</th>
                                                            <th>SL</th>
                                                            <th>Doanh thu</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="row" items="${topBooks}" varStatus="s">
                                                            <tr>
                                                                <td><strong>${s.index + 1}</strong></td>
                                                                <td style="max-width:180px">${row[0]}</td>
                                                                <td>${row[1]}</td>
                                                                <td style="font-weight:700;color:var(--accent)">
                                                                    <fmt:formatNumber value="${row[2]}" type="number"
                                                                        maxFractionDigits="0" />đ
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </main>
                        </div>
                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>