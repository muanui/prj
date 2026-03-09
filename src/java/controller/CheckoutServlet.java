package controller;

import dao.CartDAO;
import dao.OrderDAO;
import model.CartItem;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        List<CartItem> items = cartDAO.getByUser(user.getId());
        if (items.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/cart");
            return;
        }
        BigDecimal total = items.stream().map(CartItem::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add);
        req.setAttribute("cartItems", items);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/checkout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty())
            paymentMethod = "COD";

        List<CartItem> items = cartDAO.getByUser(user.getId());
        if (items.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        BigDecimal total = items.stream().map(CartItem::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add);

        String initialStatus;
        switch (paymentMethod) {
            case "BANK":
                initialStatus = "Chờ xác nhận thanh toán";
                break;
            case "WALLET":
                initialStatus = "Chờ xác nhận ví điện tử";
                break;
            default:
                initialStatus = "Chờ xử lý";
        }

        int orderId = orderDAO.createOrder(user.getId(), total, initialStatus, address, note, items);

        if (orderId > 0) {
            cartDAO.clearCart(user.getId());
            req.setAttribute("orderId", orderId);
            req.setAttribute("paymentMethod", paymentMethod);
            req.setAttribute("initialStatus", initialStatus);
            req.getRequestDispatcher("/orderSuccess.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
            // Reload cart items for display
            List<CartItem> itemsRetry = cartDAO.getByUser(user.getId());
            BigDecimal totalRetry = itemsRetry.stream().map(CartItem::getSubtotal).reduce(BigDecimal.ZERO,
                    BigDecimal::add);
            req.setAttribute("cartItems", itemsRetry);
            req.setAttribute("cartTotal", totalRetry);
            req.getRequestDispatcher("/checkout.jsp").forward(req, res);
        }
    }
}
