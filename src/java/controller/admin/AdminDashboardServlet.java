package controller.admin;

import dao.BookDAO;
import dao.CategoryDAO;
import dao.OrderDAO;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();
    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final CategoryDAO catDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("totalBooks", bookDAO.count());
        req.setAttribute("totalUsers", userDAO.countUsers());
        req.setAttribute("totalOrders", orderDAO.countOrders());
        req.setAttribute("totalRevenue", orderDAO.totalRevenue());
        req.setAttribute("totalCategories", catDAO.count());
        req.setAttribute("recentOrders",
                orderDAO.getAll().stream().limit(5).collect(java.util.stream.Collectors.toList()));
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
    }
}
