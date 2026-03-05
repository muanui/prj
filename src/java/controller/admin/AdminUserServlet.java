package controller.admin;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";
        switch (action) {
            case "edit": {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("editUser", userDAO.getUserById(id));
                req.setAttribute("users", userDAO.getAllUsers());
                req.getRequestDispatcher("/admin/editUser.jsp").forward(req, res);
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("id"));
                User cur = (User) req.getSession().getAttribute("user");
                if (cur.getId() != id)
                    userDAO.deleteUser(id);
                res.sendRedirect(req.getContextPath() + "/admin/users?msg=deleted");
                break;
            }
            case "toggle": {
                int id = Integer.parseInt(req.getParameter("id"));
                User u = userDAO.getUserById(id);
                if (u != null) {
                    u.setActive(!u.isActive());
                    userDAO.updateUser(u);
                }
                res.sendRedirect(req.getContextPath() + "/admin/users");
                break;
            }
            default:
                req.setAttribute("users", userDAO.getAllUsers());
                req.getRequestDispatcher("/admin/users.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(req.getParameter("id"));
        User u = userDAO.getUserById(id);
        if (u != null) {
            u.setFullname(req.getParameter("fullname"));
            u.setEmail(req.getParameter("email"));
            u.setPhone(req.getParameter("phone"));
            u.setAddress(req.getParameter("address"));
            u.setRole(req.getParameter("role"));
            u.setActive("on".equals(req.getParameter("active")));
            userDAO.updateUser(u);
        }
        res.sendRedirect(req.getContextPath() + "/admin/users?msg=saved");
    }
}
