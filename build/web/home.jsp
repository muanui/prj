<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page import="java.text.NumberFormat, java.util.Locale" %>
                <% String cp=request.getContextPath(); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8" />
                        <title>BookApp - Nhà Sách Online</title>
                        <meta name="description" content="BookApp - mua sách online tiện lợi, nhanh chóng." />
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                    </head>

                    <body>
                        <%@ include file="/includes/navbar.jsp" %>

                            <!-- HERO BANNER -->
                            <section class="hero">
                                <div class="hero-content">
                                    <h1>&#128214; Khám Phá Kho Sách</h1>
                                    <p>Hàng ngàn đầu sách hay – Giao hàng tận nơi – Giá tốt nhất</p>
                                    <form action="<%= cp %>/home" method="get" class="hero-search">
                                        <input type="hidden" name="view" value="search" />
                                        <input type="text" name="keyword"
                                            placeholder="Tìm sách, tác giả, thể loại..." />
                                        <button type="submit">Tìm ngay &#128269;</button>
                                    </form>
                                </div>
                            </section>

                            <div class="container">
                                <!-- CATEGORY PILLS -->
                                <div class="section" style="padding-bottom:0">
                                    <div style="display:flex;gap:0.75rem;flex-wrap:wrap">
                                        <a href="<%= cp %>/home?view=search" class="btn btn-outline btn-sm">Tất cả</a>
                                        <c:forEach var="cat" items="${categories}">
                                            <a href="<%= cp %>/home?view=search&catId=${cat.id}"
                                                class="btn btn-outline btn-sm">
                                                ${cat.name}
                                            </a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- FEATURED BOOKS -->
                                <section class="section">
                                    <div class="section-header">
                                        <h2 class="section-title">&#11088; Sách Nổi Bật</h2>
                                        <a href="<%= cp %>/home?view=search&sort=bestseller" class="view-all">Xem tất cả
                                            ›</a>
                                    </div>
                                    <div class="book-grid">
                                        <c:forEach var="book" items="${featuredBooks}">
                                            <div class="book-card animate-in"
                                                onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                <div class="book-cover">
                                                    <div class="book-cover-placeholder" data-title="${book.title}">
                                                        <span style="font-size:2.5rem">&#128218;</span>
                                                        <span style="margin-top:8px">${book.title}</span>
                                                    </div>
                                                    <span class="book-badge">Nổi bật</span>
                                                </div>
                                                <div class="book-info">
                                                    <div class="book-title">${book.title}</div>
                                                    <div class="book-author">${book.author}</div>
                                                    <div class="book-price-row">
                                                        <span class="book-price">
                                                            <fmt:formatNumber value="${book.displayPrice}" type="number"
                                                                maxFractionDigits="0" />đ
                                                        </span>
                                                        <c:if test="${book.onSale}">
                                                            <span class="book-price-old">
                                                                <fmt:formatNumber value="${book.price}" type="number"
                                                                    maxFractionDigits="0" />đ
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                    <form action="<%= cp %>/cart" method="post"
                                                        onclick="event.stopPropagation()">
                                                        <input type="hidden" name="action" value="add" />
                                                        <input type="hidden" name="bookId" value="${book.id}" />
                                                        <input type="hidden" name="qty" value="1" />
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user != null}">
                                                                <button type="submit" class="btn-add-cart">&#128722;
                                                                    Thêm vào giỏ</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="<%= cp %>/login" class="btn-add-cart"
                                                                    style="display:block;text-align:center">&#128274;
                                                                    Đăng nhập để mua</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>

                                <!-- BESTSELLERS -->
                                <section class="section" style="background:#fff;margin:0 -1.5rem;padding:3rem 1.5rem">
                                    <div class="section-header">
                                        <h2 class="section-title">&#128293; Sách Bán Chạy</h2>
                                        <a href="<%= cp %>/home?view=search&sort=bestseller" class="view-all">Xem tất cả
                                            ›</a>
                                    </div>
                                    <div class="book-grid">
                                        <c:forEach var="book" items="${bestsellerBooks}">
                                            <div class="book-card animate-in"
                                                onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                <div class="book-cover">
                                                    <div class="book-cover-placeholder" data-title="${book.title}">
                                                        <span style="font-size:2.5rem">&#128218;</span>
                                                        <span style="margin-top:8px">${book.title}</span>
                                                    </div>
                                                    <span class="book-badge hot">&#128293; Hot</span>
                                                </div>
                                                <div class="book-info">
                                                    <div class="book-title">${book.title}</div>
                                                    <div class="book-author">${book.author}</div>
                                                    <div class="book-price-row">
                                                        <span class="book-price">
                                                            <fmt:formatNumber value="${book.displayPrice}" type="number"
                                                                maxFractionDigits="0" />đ
                                                        </span>
                                                    </div>
                                                    <div style="font-size:0.75rem;color:var(--muted)">Đã bán:
                                                        ${book.sold}</div>
                                                    <form action="<%= cp %>/cart" method="post"
                                                        onclick="event.stopPropagation()">
                                                        <input type="hidden" name="action" value="add" />
                                                        <input type="hidden" name="bookId" value="${book.id}" />
                                                        <input type="hidden" name="qty" value="1" />
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user != null}">
                                                                <button type="submit" class="btn-add-cart">&#128722;
                                                                    Thêm vào giỏ</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="<%= cp %>/login" class="btn-add-cart"
                                                                    style="display:block;text-align:center">&#128274;
                                                                    Đăng nhập để mua</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>

                                <!-- NEWEST BOOKS -->
                                <section class="section">
                                    <div class="section-header">
                                        <h2 class="section-title">&#127381; Sách Mới Nhất</h2>
                                        <a href="<%= cp %>/home?view=search&sort=newest" class="view-all">Xem tất cả
                                            ›</a>
                                    </div>
                                    <div class="book-grid">
                                        <c:forEach var="book" items="${newestBooks}">
                                            <div class="book-card animate-in"
                                                onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                <div class="book-cover">
                                                    <div class="book-cover-placeholder" data-title="${book.title}">
                                                        <span style="font-size:2.5rem">&#128218;</span>
                                                        <span style="margin-top:8px">${book.title}</span>
                                                    </div>
                                                    <span class="book-badge new">Mới</span>
                                                </div>
                                                <div class="book-info">
                                                    <div class="book-title">${book.title}</div>
                                                    <div class="book-author">${book.author}</div>
                                                    <div class="book-price-row">
                                                        <span class="book-price">
                                                            <fmt:formatNumber value="${book.displayPrice}" type="number"
                                                                maxFractionDigits="0" />đ
                                                        </span>
                                                    </div>
                                                    <form action="<%= cp %>/cart" method="post"
                                                        onclick="event.stopPropagation()">
                                                        <input type="hidden" name="action" value="add" />
                                                        <input type="hidden" name="bookId" value="${book.id}" />
                                                        <input type="hidden" name="qty" value="1" />
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user != null}">
                                                                <button type="submit" class="btn-add-cart">&#128722;
                                                                    Thêm vào giỏ</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="<%= cp %>/login" class="btn-add-cart"
                                                                    style="display:block;text-align:center">&#128274;
                                                                    Đăng nhập để mua</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                            </div>

                            <!-- FOOTER -->
                            <footer>
                                <div class="container">
                                    <div class="footer-grid">
                                        <div>
                                            <div class="footer-brand-name">&#128218; BookApp</div>
                                            <p style="font-size:0.85rem;color:rgba(255,255,255,0.6)">Nhà sách online uy
                                                tín – Hàng ngàn đầu sách hay mỗi ngày.</p>
                                        </div>
                                        <div>
                                            <div class="footer-title">Danh mục</div>
                                            <div class="footer-links">
                                                <c:forEach var="cat" items="${categories}">
                                                    <a href="<%= cp %>/home?view=search&catId=${cat.id}">${cat.name}</a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="footer-title">Tài khoản</div>
                                            <div class="footer-links">
                                                <a href="<%= cp %>/login">Đăng nhập</a>
                                                <a href="<%= cp %>/register">Đăng ký</a>
                                                <a href="<%= cp %>/profile">Hồ sơ</a>
                                                <a href="<%= cp %>/cart">Giỏ hàng</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="footer-bottom">© 2026 BookApp. All rights reserved.</div>
                                </div>
                            </footer>
                            <script src="<%= cp %>/js/script.js"></script>
                    </body>

                    </html>