package controller;

import dao.CartDAO;
import model.CartItem;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        List<CartItem> items = cartDAO.getByUser(user.getId());
        BigDecimal total = items.stream().map(CartItem::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add);
        req.setAttribute("cartItems", items);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/cart.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");

        switch (action) {
            case "add": {
                int bookId = Integer.parseInt(req.getParameter("bookId"));
                int qty = 1;
                try {
                    qty = Math.max(1, Integer.parseInt(req.getParameter("qty")));
                } catch (NumberFormatException ignored) {
                }
                cartDAO.addToCart(user.getId(), bookId, qty);
                res.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "update": {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                int qty = Integer.parseInt(req.getParameter("qty"));
                if (qty <= 0)
                    cartDAO.removeItem(cartId);
                else
                    cartDAO.updateQuantity(cartId, qty);
                res.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "remove": {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                cartDAO.removeItem(cartId);
                res.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "clear": {
                cartDAO.clearCart(user.getId());
                res.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            default:
                res.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
