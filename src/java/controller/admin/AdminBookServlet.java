package controller.admin;

import dao.BookDAO;
import dao.CategoryDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/books")
public class AdminBookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();
    private final CategoryDAO catDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        switch (action) {
            case "edit": {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("book", bookDAO.getById(id));
                req.setAttribute("categories", catDAO.getAll());
                req.getRequestDispatcher("/admin/editBook.jsp").forward(req, res);
                break;
            }
            case "add": {
                req.setAttribute("book", new Book());
                req.setAttribute("categories", catDAO.getAll());
                req.getRequestDispatcher("/admin/editBook.jsp").forward(req, res);
                break;
            }
            case "delete": {
                int id = Integer.parseInt(req.getParameter("id"));
                bookDAO.delete(id);
                res.sendRedirect(req.getContextPath() + "/admin/books?msg=deleted");
                break;
            }
            default:
                req.setAttribute("books", bookDAO.getAll());
                req.getRequestDispatcher("/admin/books.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        Book b = new Book();

        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty())
            b.setId(Integer.parseInt(idStr));
        b.setTitle(req.getParameter("title"));
        b.setAuthor(req.getParameter("author"));
        b.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        b.setPrice(new BigDecimal(req.getParameter("price")));
        String sp = req.getParameter("salePrice");
        b.setSalePrice((sp != null && !sp.isEmpty()) ? new BigDecimal(sp) : null);
        b.setStock(Integer.parseInt(req.getParameter("stock")));
        b.setDescription(req.getParameter("description"));
        String img = req.getParameter("image");
        b.setImage((img != null && !img.isEmpty()) ? img : "default.jpg");
        b.setFeatured("on".equals(req.getParameter("featured")));
        b.setActive(!"edit".equals(action) || "on".equals(req.getParameter("active")));

        if ("add".equals(action)) {
            bookDAO.insert(b);
        } else {
            bookDAO.update(b);
        }
        res.sendRedirect(req.getContextPath() + "/admin/books?msg=saved");
    }
}
