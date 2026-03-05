package controller;

import dao.BookDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/book-detail")
public class BookDetailServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        Book book = bookDAO.getById(id);
        if (book == null) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        List<Book> similar = bookDAO.getSimilar(book.getCategoryId(), id, 4);
        req.setAttribute("book", book);
        req.setAttribute("similar", similar);
        req.getRequestDispatcher("/bookDetail.jsp").forward(req, res);
    }
}
