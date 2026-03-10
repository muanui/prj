package controller;

import dao.BookDAO;
import dao.CategoryDAO;
import model.Book;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();
    private final CategoryDAO catDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String view = req.getParameter("view");

        if ("search".equals(view) || req.getParameter("keyword") != null
                || req.getParameter("catId") != null) {
            handleSearch(req, res);
        } else {
            handleHome(req, res);
        }
    }

    private void handleHome(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("featuredBooks", bookDAO.getFeatured(10));
        req.setAttribute("newestBooks", bookDAO.getNewest(10));
        req.setAttribute("bestsellerBooks", bookDAO.getBestsellers(10));
        req.setAttribute("categories", catDAO.getAll());
        req.getRequestDispatcher("/home.jsp").forward(req, res);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String catIdStr = req.getParameter("catId");
        String minPStr = req.getParameter("minPrice");
        String maxPStr = req.getParameter("maxPrice");
        String sort = req.getParameter("sort");
        String pageStr = req.getParameter("page");

        int catId = 0;
        try {
            if (catIdStr != null && !catIdStr.isEmpty())
                catId = Integer.parseInt(catIdStr);
        } catch (NumberFormatException ignored) {
        }

        BigDecimal minPrice = null, maxPrice = null;
        try {
            if (minPStr != null && !minPStr.isEmpty())
                minPrice = new BigDecimal(minPStr);
        } catch (NumberFormatException ignored) {
        }
        try {
            if (maxPStr != null && !maxPStr.isEmpty())
                maxPrice = new BigDecimal(maxPStr);
        } catch (NumberFormatException ignored) {
        }

        int page = 1, pageSize = 12;
        try {
            if (pageStr != null)
                page = Math.max(1, Integer.parseInt(pageStr));
        } catch (NumberFormatException ignored) {
        }

        List<Book> books = bookDAO.search(keyword, catId, minPrice, maxPrice, sort, page, pageSize);
        int total = bookDAO.countSearch(keyword, catId, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        req.setAttribute("books", books);
        req.setAttribute("total", total);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("catId", catId);
        req.setAttribute("minPrice", minPStr);
        req.setAttribute("maxPrice", maxPStr);
        req.setAttribute("sort", sort);
        req.setAttribute("categories", catDAO.getAll());
        req.getRequestDispatcher("/search.jsp").forward(req, res);
    }
}
