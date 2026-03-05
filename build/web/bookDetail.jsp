<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>${book.title} - BookApp</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>

                        <div class="container section">
                            <!-- Breadcrumb -->
                            <div style="font-size:0.85rem;color:var(--muted);margin-bottom:1.5rem">
                                <a href="<%= cp %>/home">Trang chủ</a> ›
                                <a href="<%= cp %>/home?view=search&catId=${book.categoryId}">${book.categoryName}</a> ›
                                ${book.title}
                            </div>

                            <!-- BOOK DETAIL -->
                            <div class="book-detail-wrapper">
                                <!-- Cover -->
                                <div class="book-detail-cover">
                                    <div class="book-cover-placeholder" data-title="${book.title}"
                                        style="height:360px;width:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;font-size:0.9rem;font-weight:600;color:#fff;border-radius:var(--radius)">
                                        <span style="font-size:5rem">&#128218;</span>
                                        <span
                                            style="margin-top:12px;padding:0 1rem;text-align:center">${book.title}</span>
                                    </div>
                                </div>

                                <!-- Info -->
                                <div class="book-detail-info card card-body">
                                    <div class="mb-2">
                                        <span class="badge badge-info">${book.categoryName}</span>
                                        <c:if test="${book.onSale}">
                                            <span class="badge badge-danger" style="margin-left:6px">Sale</span>
                                        </c:if>
                                    </div>
                                    <h1 class="title">${book.title}</h1>
                                    <p class="author" style="font-size:1rem">Tác giả: <strong>${book.author}</strong>
                                    </p>

                                    <div class="price-box">
                                        <span class="price-main">
                                            <fmt:formatNumber value="${book.displayPrice}" type="number"
                                                maxFractionDigits="0" />đ
                                        </span>
                                        <c:if test="${book.onSale}">
                                            <span class="price-old">
                                                <fmt:formatNumber value="${book.price}" type="number"
                                                    maxFractionDigits="0" />đ
                                            </span>
                                            <c:set var="discountPct"
                                                value="${(1 - book.displayPrice / book.price) * 100}" />
                                            <span class="discount-tag">
                                                -
                                                <fmt:formatNumber value="${discountPct}" maxFractionDigits="0" />%
                                            </span>
                                        </c:if>
                                    </div>

                                    <div
                                        style="display:flex;gap:2rem;margin:0.8rem 0;font-size:0.88rem;color:var(--muted)">
                                        <span>&#128197; Còn lại: <strong>${book.stock}</strong></span>
                                        <span>&#128202; Đã bán: <strong>${book.sold}</strong></span>
                                    </div>

                                    <hr style="border:none;border-top:1px solid var(--border);margin:1rem 0" />
                                    <p style="font-size:0.92rem;line-height:1.8;color:var(--text)">${book.description}
                                    </p>
                                    <hr style="border:none;border-top:1px solid var(--border);margin:1rem 0" />

                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <form action="<%= cp %>/cart" method="post"
                                                style="display:flex;gap:1rem;align-items:center;flex-wrap:wrap">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="bookId" value="${book.id}" />
                                                <div style="display:flex;align-items:center">
                                                    <label style="font-weight:600;margin-right:8px">Số lượng:</label>
                                                    <input type="number" name="qty" value="1" min="1"
                                                        max="${book.stock}" class="form-control" style="width:70px" />
                                                </div>
                                                <button type="submit" class="btn btn-primary btn-lg">&#128722; Thêm vào
                                                    giỏ hàng</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<%= cp %>/login" class="btn btn-primary btn-lg">&#128274; Đăng nhập
                                                để mua</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- SIMILAR BOOKS -->
                            <c:if test="${not empty similar}">
                                <section class="section">
                                    <div class="section-header">
                                        <h2 class="section-title">&#128218; Sách Tương Tự</h2>
                                    </div>
                                    <div class="book-grid">
                                        <c:forEach var="b" items="${similar}">
                                            <div class="book-card animate-in"
                                                onclick="location.href='<%= cp %>/book-detail?id=${b.id}'">
                                                <div class="book-cover">
                                                    <div class="book-cover-placeholder" data-title="${b.title}">
                                                        <span style="font-size:2.5rem">&#128218;</span>
                                                        <span style="margin-top:8px">${b.title}</span>
                                                    </div>
                                                </div>
                                                <div class="book-info">
                                                    <div class="book-title">${b.title}</div>
                                                    <div class="book-author">${b.author}</div>
                                                    <div class="book-price-row">
                                                        <span class="book-price">
                                                            <fmt:formatNumber value="${b.displayPrice}" type="number"
                                                                maxFractionDigits="0" />đ
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                            </c:if>
                        </div>

                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>