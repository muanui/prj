package dao;

import model.CartItem;
import model.Order;
import model.OrderDetail;
import util.DBContact;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        try {
            o.setUserFullname(rs.getString("fullname"));
        } catch (SQLException ignored) {
        }
        o.setTotal(rs.getBigDecimal("total"));
        o.setStatus(rs.getString("status"));
        o.setNote(rs.getString("note"));
        o.setAddress(rs.getString("address"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        return o;
    }

    /** Tạo order mới từ giỏ hàng, trả về orderId hoặc -1 nếu lỗi */
    public int createOrder(int userId, BigDecimal total, String address, String note,
            List<CartItem> items) {
        String sqlOrder = "INSERT INTO Orders(user_id,total,status,address,note) VALUES(?,?,N'Chờ xử lý',?,?) ";
        String sqlDetail = "INSERT INTO OrderDetails(order_id,book_id,quantity,price) VALUES(?,?,?,?)";
        Connection conn = null;
        try {
            conn = DBContact.getConnection();
            conn.setAutoCommit(false);

            // Insert order
            int orderId = -1;
            try (PreparedStatement ps = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setBigDecimal(2, total);
                ps.setString(3, address); // note column = address dùng làm note giao hàng
                ps.setString(4, note);
                ps.executeUpdate();
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next())
                    orderId = keys.getInt(1);
            }
            if (orderId < 0) {
                conn.rollback();
                return -1;
            }

            // Insert order details & update stock
            BookDAO bookDAO = new BookDAO();
            try (PreparedStatement ps = conn.prepareStatement(sqlDetail)) {
                for (CartItem ci : items) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, ci.getBookId());
                    ps.setInt(3, ci.getQuantity());
                    ps.setBigDecimal(4, ci.getPrice());
                    ps.addBatch();
                    bookDAO.updateSoldCount(ci.getBookId(), ci.getQuantity(), conn);
                }
                ps.executeBatch();
            }
            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null)
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
        } finally {
            DBContact.close(conn);
        }
        return -1;
    }

    public List<Order> getByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id=? ORDER BY created_at DESC";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.fullname FROM Orders o JOIN Users u ON o.user_id=u.id ORDER BY o.created_at DESC";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getById(int id) {
        String sql = "SELECT o.*, u.fullname FROM Orders o JOIN Users u ON o.user_id=u.id WHERE o.id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = mapRow(rs);
                o.setDetails(getDetailsByOrderId(id));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, b.title AS bookTitle, b.image AS bookImage " +
                "FROM OrderDetails od JOIN Books b ON od.book_id=b.id WHERE od.order_id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setId(rs.getInt("id"));
                od.setOrderId(orderId);
                od.setBookId(rs.getInt("book_id"));
                od.setBookTitle(rs.getString("bookTitle"));
                od.setBookImage(rs.getString("bookImage"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getBigDecimal("price"));
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status=? WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countOrders() {
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM Orders")) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal totalRevenue() {
        String sql = "SELECT ISNULL(SUM(total),0) FROM Orders WHERE status=N'Hoàn thành'";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // ===================== STATISTICS =====================

    /** Doanh thu theo tháng trong năm hiện tại */
    public Map<String, BigDecimal> revenueByMonth(int year) {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = "SELECT MONTH(created_at) AS m, SUM(total) AS rev FROM Orders " +
                "WHERE status=N'Hoàn thành' AND YEAR(created_at)=? GROUP BY MONTH(created_at) ORDER BY m";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                map.put("Tháng " + rs.getInt("m"), rs.getBigDecimal("rev"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    /** Top 5 sách bán chạy nhất */
    public List<Object[]> topBooksStats(int top) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT TOP(?) b.title, SUM(od.quantity) AS qty, SUM(od.quantity*od.price) AS revenue " +
                "FROM OrderDetails od JOIN Books b ON od.book_id=b.id " +
                "JOIN Orders o ON od.order_id=o.id WHERE o.status=N'Hoàn thành' " +
                "GROUP BY b.id, b.title ORDER BY qty DESC";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, top);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(new Object[] { rs.getString("title"), rs.getInt("qty"), rs.getBigDecimal("revenue") });
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Thống kê tổng quan: count, sum, avg, max, min trên Orders */
    public Map<String, Object> orderSummaryStats() {
        Map<String, Object> map = new LinkedHashMap<>();
        String sql = "SELECT COUNT(*) AS cnt, ISNULL(SUM(total),0) AS sumTotal, " +
                "ISNULL(AVG(total),0) AS avgTotal, ISNULL(MAX(total),0) AS maxTotal, " +
                "ISNULL(MIN(total),0) AS minTotal FROM Orders WHERE status=N'Hoàn thành'";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                map.put("Tổng đơn hàng hoàn thành", rs.getInt("cnt"));
                map.put("Tổng doanh thu", rs.getBigDecimal("sumTotal"));
                map.put("Doanh thu trung bình", rs.getBigDecimal("avgTotal"));
                map.put("Đơn hàng lớn nhất", rs.getBigDecimal("maxTotal"));
                map.put("Đơn hàng nhỏ nhất", rs.getBigDecimal("minTotal"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    /** Doanh thu theo danh mục */
    public List<Object[]> revenueByCategory() {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT c.name, SUM(od.quantity*od.price) AS rev FROM OrderDetails od " +
                "JOIN Books b ON od.book_id=b.id JOIN Categories c ON b.category_id=c.id " +
                "JOIN Orders o ON od.order_id=o.id WHERE o.status=N'Hoàn thành' " +
                "GROUP BY c.id, c.name ORDER BY rev DESC";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                list.add(new Object[] { rs.getString("name"), rs.getBigDecimal("rev") });
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Thống kê số lượng đơn theo trạng thái */
    public Map<String, Integer> countByStatus() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT status, COUNT(*) AS cnt FROM Orders GROUP BY status ORDER BY cnt DESC";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                map.put(rs.getString("status"), rs.getInt("cnt"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}
