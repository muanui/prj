<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <% String cp=request.getContextPath(); %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <title>Tìm kiếm sách - BookApp</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <link rel="stylesheet" href="<%= cp %>/css/style.css" />
                </head>

                <body>
                    <%@ include file="/includes/navbar.jsp" %>

                        <div class="container section">
                            <h1 class="section-title" style="margin-bottom:1.5rem">
                                &#128269; Tìm kiếm sách
                                <c:if test="${not empty keyword}"> – "<em>${keyword}</em>"</c:if>
                            </h1>

                            <!-- FILTER BAR -->
                            <form action="<%= cp %>/home" method="get" class="filter-bar">
                                <input type="hidden" name="view" value="search" />
                                <div class="filter-group" style="flex:2;min-width:200px">
                                    <label>Từ khóa</label>
                                    <input type="text" name="keyword" class="form-control" value="${keyword}"
                                        placeholder="Tên sách, tác giả..." />
                                </div>
                                <div class="filter-group">
                                    <label>Danh mục</label>
                                    <select name="catId" class="form-select">
                                        <option value="0">Tất cả</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${catId==cat.id ? 'selected' : '' }>${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="filter-group">
                                    <label>Giá từ (đ)</label>
                                    <input type="number" name="minPrice" class="form-control" value="${minPrice}"
                                        placeholder="0" min="0" />
                                </div>
                                <div class="filter-group">
                                    <label>Đến (đ)</label>
                                    <input type="number" name="maxPrice" class="form-control" value="${maxPrice}"
                                        placeholder="∞" min="0" />
                                </div>
                                <div class="filter-group">
                                    <label>Sắp xếp</label>
                                    <select name="sort" class="form-select">
                                        <option value="name_asc" ${sort=='name_asc' ? 'selected' :''}>Tên A-Z</option>
                                        <option value="name_desc" ${sort=='name_desc' ? 'selected' :''}>Tên Z-A</option>
                                        <option value="price_asc" ${sort=='price_asc' ? 'selected' :''}>Giá thấp
                                        </option>
                                        <option value="price_desc" ${sort=='price_desc' ? 'selected' :''}>Giá cao
                                        </option>
                                        <option value="newest" ${sort=='newest' ? 'selected' :''}>Mới nhất</option>
                                        <option value="bestseller" ${sort=='bestseller' ? 'selected' :''}>Bán chạy
                                        </option>
                                    </select>
                                </div>
                                <div class="filter-group" style="justify-content:flex-end">
                                    <button type="submit" class="btn btn-primary">&#128269; Tìm</button>
                                </div>
                            </form>

                            <!-- RESULTS META -->
                            <div style="margin-bottom:1rem;color:var(--muted);font-size:0.88rem">
                                Tìm thấy <strong>${total}</strong> kết quả
                                <c:if test="${totalPages > 1}"> – Trang ${page}/${totalPages}</c:if>
                            </div>

                            <!-- BOOK GRID -->
                            <c:choose>
                                <c:when test="${empty books}">
                                    <div class="text-center" style="padding:4rem">
                                        <div style="font-size:4rem">&#128214;</div>
                                        <p style="color:var(--muted);margin-top:1rem">Không tìm thấy sách nào phù hợp.
                                        </p>
                                        <a href="<%= cp %>/home?view=search" class="btn btn-outline mt-2">Xem tất cả
                                            sách</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="book-grid">
                                        <c:forEach var="book" items="${books}">
                                            <div class="book-card animate-in"
                                                onclick="location.href='<%= cp %>/book-detail?id=${book.id}'">
                                                <div class="book-cover">
                                                    <div class="book-cover-placeholder" data-title="${book.title}">
                                                        <span style="font-size:2.5rem">&#128218;</span>
                                                        <span style="margin-top:8px">${book.title}</span>
                                                    </div>
                                                    <c:if test="${book.onSale}">
                                                        <span class="book-badge">Sale</span>
                                                    </c:if>
                                                </div>
                                                <div class="book-info">
                                                    <div class="book-title">${book.title}</div>
                                                    <div class="book-author">${book.author} · ${book.categoryName}</div>
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
                                                                    Thêm giỏ hàng</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="<%= cp %>/login" class="btn-add-cart"
                                                                    style="display:block;text-align:center">&#128274;
                                                                    Đăng nhập</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- PAGINATION -->
                                    <c:if test="${totalPages > 1}">
                                        <div class="pagination">
                                            <c:if test="${page > 1}">
                                                <a class="page-btn"
                                                    href="<%= cp %>/home?view=search&keyword=${keyword}&catId=${catId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${page-1}">‹</a>
                                            </c:if>
                                            <c:forEach begin="1" end="${totalPages}" var="p">
                                                <a class="page-btn ${p==page?'active':''}"
                                                    href="<%= cp %>/home?view=search&keyword=${keyword}&catId=${catId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${p}">${p}</a>
                                            </c:forEach>
                                            <c:if test="${page < totalPages}">
                                                <a class="page-btn"
                                                    href="<%= cp %>/home?view=search&keyword=${keyword}&catId=${catId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${page+1}">›</a>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <script src="<%= cp %>/js/script.js"></script>
                </body>

                </html>