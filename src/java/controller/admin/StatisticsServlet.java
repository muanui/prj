package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Calendar;

@WebServlet("/admin/statistics")
public class StatisticsServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int year = Calendar.getInstance().get(Calendar.YEAR);
        try {
            String y = req.getParameter("year");
            if (y != null)
                year = Integer.parseInt(y);
        } catch (NumberFormatException ignored) {
        }

        req.setAttribute("year", year);
        req.setAttribute("summary", orderDAO.orderSummaryStats());
        req.setAttribute("revenueByMonth", orderDAO.revenueByMonth(year));
        req.setAttribute("topBooks", orderDAO.topBooksStats(10));
        req.setAttribute("revenueByCategory", orderDAO.revenueByCategory());
        req.setAttribute("countByStatus", orderDAO.countByStatus());
        req.getRequestDispatcher("/admin/statistics.jsp").forward(req, res);
    }
}
