<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ page import="java.text.NumberFormat, java.util.Locale" %>
                <% String cp=request.getContextPath(); %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8" />
                        <title>ThuanVaDatShopp</title>
                        <meta name="description" content="BookApp - mua sách online tiện lợi, nhanh chóng." />
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                    </head>

                    <body>
                        <%@ include file="/includes/navbar.jsp" %>

                            <!-- HERO BANNER -->
                            <section class="hero">
                                <!-- Floating books background -->
                                <div class="hero-floating-book hero-floating-book-1">&#128218;</div>
                                <div class="hero-floating-book hero-floating-book-2">&#128218;</div>
                                <div class="hero-floating-book hero-floating-book-3">&#128218;</div>
                                <!-- Floating brand text -->
                                <div class="hero-floating-text hero-floating-text-1">ThuanVaDatShopp</div>
                                <div class="hero-floating-text hero-floating-text-2">ThuanVaDatShopp</div>
                                <div class="hero-floating-text hero-floating-text-3">ThuanVaDatShopp</div>

                                <div class="hero-content">
                                    <div class="hero-badge">&#127942; Được tin dùng bởi hàng triệu độc giả</div>
                                    <h1>Kho Sách Uy Tín<br /><span class="hero-highlight">Số 1 Việt Nam</span></h1>
                                    <p>Hàng ngàn đầu sách hay &mdash; Giao hàng tận nơi &mdash; Giá tốt nhất</p>
                                    <form action="<%= cp %>/home" method="get" class="hero-search">
                                        <input type="hidden" name="view" value="search" />
                                        <span class="hero-search-icon">&#128269;</span>
                                        <input type="text" name="keyword"
                                            placeholder="Tìm sách, tác giả, thể loại..." />
                                        <button type="submit">Tìm ngay</button>
                                    </form>
                                    <div class="hero-stats">
                                        <div class="hero-stat">
                                            <span class="hero-stat-num">10,000+</span>
                                            <span class="hero-stat-label">Đầu sách</span>
                                        </div>
                                        <div class="hero-stat-divider"></div>
                                        <div class="hero-stat">
                                            <span class="hero-stat-num">500+</span>
                                            <span class="hero-stat-label">Tác giả</span>
                                        </div>
                                        <div class="hero-stat-divider"></div>
                                        <div class="hero-stat">
                                            <span class="hero-stat-num">&#9883; Miễn phí</span>
                                            <span class="hero-stat-label">Giao hàng từ 299k</span>
                                        </div>
                                        <div class="hero-stat-divider"></div>
                                        <div class="hero-stat">
                                            <span class="hero-stat-num">&#9733; 4.9/5</span>
                                            <span class="hero-stat-label">Đánh giá</span>
                                        </div>
                                    </div>
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
                                    <div class="carousel-wrapper">
                                        <button class="carousel-btn prev"
                                            onclick="scrollCarousel('featured',-1)">&#8249;</button>
                                        <div class="book-carousel" id="featured">
                                            <c:forEach var="book" items="${featuredBooks}">
                                                <div class="book-card animate-in"
                                                    onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                    <div class="book-cover">
                                                        <c:choose>
                                                            <c:when
                                                                test="${not empty book.image and book.image != 'default.jpg'}">
                                                                <img src="<%= cp %>/images/books/${book.image}"
                                                                    alt="${book.title}" class="book-cover-img"
                                                                    onerror="this.style.display='none';this.nextElementSibling.style.display='flex'" />
                                                                <div class="book-cover-placeholder"
                                                                    style="display:none">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="book-cover-placeholder">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="book-badge">Nổi bật</span>
                                                    </div>
                                                    <div class="book-info">
                                                        <div class="book-title">${book.title}</div>
                                                        <div class="book-author">${book.author}</div>
                                                        <div class="book-price-row">
                                                            <span class="book-price">
                                                                <fmt:formatNumber value="${book.displayPrice}"
                                                                    type="number" maxFractionDigits="0" />đ
                                                            </span>
                                                            <c:if test="${book.onSale}"><span class="book-price-old">
                                                                    <fmt:formatNumber value="${book.price}"
                                                                        type="number" maxFractionDigits="0" />đ
                                                                </span></c:if>
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
                                        <button class="carousel-btn next"
                                            onclick="scrollCarousel('featured',1)">&#8250;</button>
                                    </div>
                                </section>

                                <!-- BESTSELLERS -->
                                <section class="section" style="background:#fff;margin:0 -1.5rem;padding:3rem 1.5rem">
                                    <div class="section-header">
                                        <h2 class="section-title">&#128293; Sách Bán Chạy</h2>
                                        <a href="<%= cp %>/home?view=search&sort=bestseller" class="view-all">Xem tất cả
                                            ›</a>
                                    </div>
                                    <div class="carousel-wrapper">
                                        <button class="carousel-btn prev"
                                            onclick="scrollCarousel('bestseller',-1)">&#8249;</button>
                                        <div class="book-carousel" id="bestseller">
                                            <c:forEach var="book" items="${bestsellerBooks}">
                                                <div class="book-card animate-in"
                                                    onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                    <div class="book-cover">
                                                        <c:choose>
                                                            <c:when
                                                                test="${not empty book.image and book.image != 'default.jpg'}">
                                                                <img src="<%= cp %>/images/books/${book.image}"
                                                                    alt="${book.title}" class="book-cover-img"
                                                                    onerror="this.style.display='none';this.nextElementSibling.style.display='flex'" />
                                                                <div class="book-cover-placeholder"
                                                                    style="display:none">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="book-cover-placeholder">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="book-badge hot">&#128293; Hot</span>
                                                    </div>
                                                    <div class="book-info">
                                                        <div class="book-title">${book.title}</div>
                                                        <div class="book-author">${book.author}</div>
                                                        <div class="book-price-row">
                                                            <span class="book-price">
                                                                <fmt:formatNumber value="${book.displayPrice}"
                                                                    type="number" maxFractionDigits="0" />đ
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
                                        <button class="carousel-btn next"
                                            onclick="scrollCarousel('bestseller',1)">&#8250;</button>
                                    </div>
                                </section>

                                <!-- NEWEST BOOKS -->
                                <section class="section">
                                    <div class="section-header">
                                        <h2 class="section-title">&#127381; Sách Mới Nhất</h2>
                                        <a href="<%= cp %>/home?view=search&sort=newest" class="view-all">Xem tất cả
                                            ›</a>
                                    </div>
                                    <div class="carousel-wrapper">
                                        <button class="carousel-btn prev"
                                            onclick="scrollCarousel('newest',-1)">&#8249;</button>
                                        <div class="book-carousel" id="newest">
                                            <c:forEach var="book" items="${newestBooks}">
                                                <div class="book-card animate-in"
                                                    onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                    <div class="book-cover">
                                                        <c:choose>
                                                            <c:when
                                                                test="${not empty book.image and book.image != 'default.jpg'}">
                                                                <img src="<%= cp %>/images/books/${book.image}"
                                                                    alt="${book.title}" class="book-cover-img"
                                                                    onerror="this.style.display='none';this.nextElementSibling.style.display='flex'" />
                                                                <div class="book-cover-placeholder"
                                                                    style="display:none">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="book-cover-placeholder">
                                                                    <span style="font-size:2.5rem">&#128218;</span>
                                                                    <span style="margin-top:8px">${book.title}</span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="book-badge new">Mới</span>
                                                    </div>
                                                    <div class="book-info">
                                                        <div class="book-title">${book.title}</div>
                                                        <div class="book-author">${book.author}</div>
                                                        <div class="book-price-row">
                                                            <span class="book-price">
                                                                <fmt:formatNumber value="${book.displayPrice}"
                                                                    type="number" maxFractionDigits="0" />đ
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