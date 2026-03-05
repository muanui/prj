package dao;

import model.Book;
import util.DBContact;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private Book mapRow(ResultSet rs) throws SQLException {
        Book b = new Book();
        b.setId(rs.getInt("id"));
        b.setTitle(rs.getString("title"));
        b.setAuthor(rs.getString("author"));
        b.setCategoryId(rs.getInt("category_id"));
        try {
            b.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {
        }
        b.setPrice(rs.getBigDecimal("price"));
        b.setSalePrice(rs.getBigDecimal("sale_price"));
        b.setStock(rs.getInt("stock"));
        b.setSold(rs.getInt("sold"));
        b.setDescription(rs.getString("description"));
        b.setImage(rs.getString("image"));
        b.setFeatured(rs.getBoolean("featured"));
        b.setActive(rs.getBoolean("active"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        return b;
    }

    private static final String SELECT_WITH_CAT = "SELECT b.*, c.name AS category_name FROM Books b " +
            "LEFT JOIN Categories c ON b.category_id = c.id ";

    public List<Book> getAll() {
        List<Book> list = new ArrayList<>();
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(SELECT_WITH_CAT + "ORDER BY b.id")) {
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Book getById(int id) {
        String sql = SELECT_WITH_CAT + "WHERE b.id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Book> getFeatured(int limit) {
        List<Book> list = new ArrayList<>();
        String sql = SELECT_WITH_CAT
                + "WHERE b.featured=1 AND b.active=1 ORDER BY b.sold DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Book> getNewest(int limit) {
        List<Book> list = new ArrayList<>();
        String sql = SELECT_WITH_CAT
                + "WHERE b.active=1 ORDER BY b.created_at DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Book> getBestsellers(int limit) {
        List<Book> list = new ArrayList<>();
        String sql = SELECT_WITH_CAT + "WHERE b.active=1 ORDER BY b.sold DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Book> getSimilar(int categoryId, int excludeId, int limit) {
        List<Book> list = new ArrayList<>();
        String sql = SELECT_WITH_CAT
                + "WHERE b.category_id=? AND b.id<>? AND b.active=1 ORDER BY b.sold DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, excludeId);
            ps.setInt(3, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Search + filter + sort + paging
     * 
     * @param keyword  full-text search in title/author
     * @param catId    0 = all
     * @param minPrice null = no min
     * @param maxPrice null = no max
     * @param sort     "price_asc","price_desc","name_asc","name_desc","newest","bestseller"
     * @param page     1-based
     * @param pageSize records per page
     */
    public List<Book> search(String keyword, int catId,
            BigDecimal minPrice, BigDecimal maxPrice,
            String sort, int page, int pageSize) {
        List<Book> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.*, c.name AS category_name FROM Books b " +
                        "LEFT JOIN Categories c ON b.category_id=c.id WHERE b.active=1 ");
        List<Object> params = buildWhere(sql, keyword, catId, minPrice, maxPrice);
        appendOrder(sql, sort);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int idx = setParams(ps, params, 1);
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearch(String keyword, int catId, BigDecimal minPrice, BigDecimal maxPrice) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Books b WHERE b.active=1 ");
        List<Object> params = buildWhere(sql, keyword, catId, minPrice, maxPrice);
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql.toString())) {
            setParams(ps, params, 1);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private List<Object> buildWhere(StringBuilder sql, String keyword, int catId,
            BigDecimal minPrice, BigDecimal maxPrice) {
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (b.title LIKE ? OR b.author LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (catId > 0) {
            sql.append("AND b.category_id=? ");
            params.add(catId);
        }
        if (minPrice != null) {
            sql.append("AND b.price>=? ");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append("AND b.price<=? ");
            params.add(maxPrice);
        }
        return params;
    }

    private void appendOrder(StringBuilder sql, String sort) {
        if (sort == null)
            sort = "";
        switch (sort) {
            case "price_asc":
                sql.append("ORDER BY b.price ASC ");
                break;
            case "price_desc":
                sql.append("ORDER BY b.price DESC ");
                break;
            case "name_desc":
                sql.append("ORDER BY b.title DESC ");
                break;
            case "bestseller":
                sql.append("ORDER BY b.sold DESC ");
                break;
            case "newest":
                sql.append("ORDER BY b.created_at DESC ");
                break;
            default:
                sql.append("ORDER BY b.title ASC ");
                break;
        }
    }

    private int setParams(PreparedStatement ps, List<Object> params, int start) throws SQLException {
        int idx = start;
        for (Object p : params) {
            if (p instanceof String)
                ps.setString(idx++, (String) p);
            else if (p instanceof Integer)
                ps.setInt(idx++, (Integer) p);
            else if (p instanceof BigDecimal)
                ps.setBigDecimal(idx++, (BigDecimal) p);
        }
        return idx;
    }

    public boolean insert(Book b) {
        String sql = "INSERT INTO Books(title,author,category_id,price,sale_price,stock,description,image,featured,active) VALUES(?,?,?,?,?,?,?,?,?,1)";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, b.getTitle());
            ps.setString(2, b.getAuthor());
            ps.setInt(3, b.getCategoryId());
            ps.setBigDecimal(4, b.getPrice());
            ps.setBigDecimal(5, b.getSalePrice());
            ps.setInt(6, b.getStock());
            ps.setString(7, b.getDescription());
            ps.setString(8, b.getImage());
            ps.setBoolean(9, b.isFeatured());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Book b) {
        String sql = "UPDATE Books SET title=?,author=?,category_id=?,price=?,sale_price=?,stock=?,description=?,image=?,featured=?,active=? WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, b.getTitle());
            ps.setString(2, b.getAuthor());
            ps.setInt(3, b.getCategoryId());
            ps.setBigDecimal(4, b.getPrice());
            ps.setBigDecimal(5, b.getSalePrice());
            ps.setInt(6, b.getStock());
            ps.setString(7, b.getDescription());
            ps.setString(8, b.getImage());
            ps.setBoolean(9, b.isFeatured());
            ps.setBoolean(10, b.isActive());
            ps.setInt(11, b.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "UPDATE Books SET active=0 WHERE id=?"; // soft delete
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int count() {
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM Books WHERE active=1")) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateSoldCount(int bookId, int qty, Connection conn) throws SQLException {
        String sql = "UPDATE Books SET sold = sold + ?, stock = stock - ? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, qty);
            ps.setInt(3, bookId);
            ps.executeUpdate();
        }
    }
}
