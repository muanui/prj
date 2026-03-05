package controller;

import dao.OrderDAO;
import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("orders", orderDAO.getByUser(user.getId()));
        req.getRequestDispatcher("/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");

        if ("updateProfile".equals(action)) {
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            if (userDAO.emailExistsExcept(email, user.getId())) {
                req.setAttribute("error", "Email đã được sử dụng bởi tài khoản khác!");
            } else {
                user.setFullname(fullname);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                if (userDAO.updateProfile(user)) {
                    req.getSession().setAttribute("user", userDAO.getUserById(user.getId()));
                    req.setAttribute("success", "Cập nhật thông tin thành công!");
                } else {
                    req.setAttribute("error", "Cập nhật thất bại!");
                }
            }
        } else if ("changePassword".equals(action)) {
            String oldPwd = req.getParameter("oldPassword");
            String newPwd = req.getParameter("newPassword");
            String cfmPwd = req.getParameter("confirmPassword");

            if (!newPwd.equals(cfmPwd)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            } else if (newPwd.length() < 1) {
                req.setAttribute("error", "Mật khẩu mới không hợp lệ!");
            } else if (userDAO.changePassword(user.getId(), oldPwd, newPwd)) {
                req.setAttribute("success", "Đổi mật khẩu thành công!");
            } else {
                req.setAttribute("error", "Mật khẩu cũ không đúng!");
            }
        }

        req.setAttribute("orders", orderDAO.getByUser(user.getId()));
        req.getRequestDispatcher("/profile.jsp").forward(req, res);
    }
}
