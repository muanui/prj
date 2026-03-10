package controller.admin;

import dao.BookDAO;
import dao.CategoryDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/admin/books")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class AdminBookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();
    private final CategoryDAO catDAO = new CategoryDAO();

    /** Thư mục lưu ảnh bìa (tương đối so với root của webapp) */
    private static final String IMG_DIR = "images" + File.separator + "books";

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
        b.setFeatured("on".equals(req.getParameter("featured")));
        b.setActive(!"edit".equals(action) || "on".equals(req.getParameter("active")));

        // --- Xử lý upload ảnh bìa ---
        String savedFileName = handleImageUpload(req, b.getId());
        if (savedFileName != null) {
            b.setImage(savedFileName);
        } else {
            // Giữ ảnh cũ nếu không upload file mới
            String existingImg = req.getParameter("existingImage");
            b.setImage((existingImg != null && !existingImg.isEmpty()) ? existingImg : "default.jpg");
        }

        if ("add".equals(action)) {
            bookDAO.insert(b);
        } else {
            bookDAO.update(b);
        }
        res.sendRedirect(req.getContextPath() + "/admin/books?msg=saved");
    }

    /**
     * Lưu file ảnh upload vào web/images/books/.
     * 
     * @return tên file đã lưu (vd: "1741234567890_cover.jpg"), hoặc null nếu không
     *         có file được upload.
     */
    private String handleImageUpload(HttpServletRequest req, int bookId) throws IOException, ServletException {
        Part filePart = req.getPart("imageFile");
        if (filePart == null || filePart.getSize() == 0)
            return null;

        String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (originalName == null || originalName.isEmpty())
            return null;

        // Lấy extension của file
        String ext = "";
        int dotIdx = originalName.lastIndexOf('.');
        if (dotIdx >= 0)
            ext = originalName.substring(dotIdx); // ".jpg", ".png", ...

        // Tên file mới: timestamp + extension
        String newFileName = System.currentTimeMillis() + ext;

        // Thư mục đích: [webapp_root]/images/books/
        String uploadPath = getServletContext().getRealPath("") + File.separator + IMG_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdirs();

        try (InputStream is = filePart.getInputStream()) {
            Files.copy(is, new File(uploadDir, newFileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return newFileName;
    }
}
