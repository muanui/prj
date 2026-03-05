package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";
        switch (action) {
            case "detail": {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("order", orderDAO.getById(id));
                req.getRequestDispatcher("/admin/orderDetail.jsp").forward(req, res);
                break;
            }
            default:
                req.setAttribute("orders", orderDAO.getAll());
                req.getRequestDispatcher("/admin/orders.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        orderDAO.updateStatus(id, status);
        res.sendRedirect(req.getContextPath() + "/admin/orders?msg=updated");
    }
}
