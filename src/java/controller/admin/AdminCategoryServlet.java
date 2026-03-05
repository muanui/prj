package controller.admin;

import dao.CategoryDAO;
import model.Category;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {
    private final CategoryDAO catDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";
        switch (action) {
            case "add":
                req.setAttribute("cat", new Category());
                req.getRequestDispatcher("/admin/editCategory.jsp").forward(req, res);
                break;
            case "edit": {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("cat", catDAO.getById(id));
                req.getRequestDispatcher("/admin/editCategory.jsp").forward(req, res);
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("id"));
                catDAO.delete(id);
                res.sendRedirect(req.getContextPath() + "/admin/categories?msg=deleted");
                break;
            }
            default:
                req.setAttribute("categories", catDAO.getAll());
                req.getRequestDispatcher("/admin/categories.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        Category cat = new Category();
        if (idStr != null && !idStr.isEmpty())
            cat.setId(Integer.parseInt(idStr));
        cat.setName(req.getParameter("name"));
        cat.setDescription(req.getParameter("description"));
        if (cat.getId() == 0)
            catDAO.insert(cat);
        else
            catDAO.update(cat);
        res.sendRedirect(req.getContextPath() + "/admin/categories?msg=saved");
    }
}
