package dao;

import model.CartItem;
import util.DBContact;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private CartItem mapRow(ResultSet rs) throws SQLException {
        CartItem ci = new CartItem();
        ci.setId(rs.getInt("id"));
        ci.setUserId(rs.getInt("user_id"));
        ci.setBookId(rs.getInt("book_id"));
        ci.setBookTitle(rs.getString("title"));
        ci.setBookImage(rs.getString("image"));
        ci.setPrice(rs.getBigDecimal("display_price"));
        ci.setQuantity(rs.getInt("quantity"));
        return ci;
    }

    public List<CartItem> getByUser(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, c.book_id, b.title, b.image, c.quantity, " +
                "CASE WHEN b.sale_price IS NOT NULL AND b.sale_price > 0 THEN b.sale_price ELSE b.price END AS display_price "
                +
                "FROM Cart c JOIN Books b ON c.book_id=b.id WHERE c.user_id=? ORDER BY c.id";
        try (Connection conn = DBContact.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addToCart(int userId, int bookId, int qty) {
        // Nếu đã có thì cộng thêm, chưa có thì insert
        String checkSql = "SELECT id, quantity FROM Cart WHERE user_id=? AND book_id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(checkSql)) {
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt("id");
                int newQty = rs.getInt("quantity") + qty;
                return updateQuantity(cartId, newQty);
            } else {
                String sql = "INSERT INTO Cart(user_id, book_id, quantity) VALUES(?,?,?)";
                try (PreparedStatement ps2 = c.prepareStatement(sql)) {
                    ps2.setInt(1, userId);
                    ps2.setInt(2, bookId);
                    ps2.setInt(3, qty);
                    return ps2.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateQuantity(int cartId, int qty) {
        String sql = "UPDATE Cart SET quantity=? WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeItem(int cartId) {
        String sql = "DELETE FROM Cart WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean clearCart(int userId) {
        String sql = "DELETE FROM Cart WHERE user_id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countItems(int userId) {
        String sql = "SELECT ISNULL(SUM(quantity),0) FROM Cart WHERE user_id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
