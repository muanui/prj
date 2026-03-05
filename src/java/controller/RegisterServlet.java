package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username").trim();
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm");
        String fullname = req.getParameter("fullname").trim();
        String email = req.getParameter("email").trim();
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        // Validation
        if (!password.equals(confirm)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }
        if (userDAO.usernameExists(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }
        if (userDAO.emailExists(email)) {
            req.setAttribute("error", "Email đã được sử dụng!");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }
        if (username.length() < 3 || password.length() < 6) {
            req.setAttribute("error", "Tên đăng nhập tối thiểu 3 ký tự, mật khẩu tối thiểu 6 ký tự!");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        User u = new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setEmail(email);
        u.setPhone(phone);
        u.setAddress(address);

        if (userDAO.register(u)) {
            req.setAttribute("success", "Đăng ký thành công! Hãy đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại!");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
        }
    }
}
