package dao;

import model.User;
import util.DBContact;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setFullname(rs.getString("fullname"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setRole(rs.getString("role"));
        u.setActive(rs.getBoolean("active"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }

    /** Đăng nhập */
    public User login(String username, String password) {
        if (username != null)
            username = username.trim();
        if (password != null)
            password = password.trim();

        // Bỏ điều kiện active=1 để tránh lọc nhầm, chỉ so khớp username + password
        String sql = "SELECT * FROM Users WHERE username=? AND password=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi SQL trong UserDAO.login", e);
        }
        return null;
    }

    /** Đăng ký */
    public boolean register(User u) {
        String sql = "INSERT INTO Users(username,password,fullname,email,phone,address,role) VALUES(?,?,?,?,?,?,'customer')";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getFullname());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM Users WHERE username=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT id FROM Users WHERE email=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExistsExcept(String email, int id) {
        String sql = "SELECT id FROM Users WHERE email=? AND id<>?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, id);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE id=?";
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

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users ORDER BY id";
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

    public boolean updateUser(User u) {
        String sql = "UPDATE Users SET fullname=?,email=?,phone=?,address=?,role=?,active=? WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFullname());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getAddress());
            ps.setString(5, u.getRole());
            ps.setBoolean(6, u.isActive());
            ps.setInt(7, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Cập nhật profile của chính user (không đổi role) */
    public boolean updateProfile(User u) {
        String sql = "UPDATE Users SET fullname=?,email=?,phone=?,address=? WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getFullname());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getAddress());
            ps.setInt(5, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changePassword(int userId, String oldPwd, String newPwd) {
        String sql = "UPDATE Users SET password=? WHERE id=? AND password=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, newPwd);
            ps.setInt(2, userId);
            ps.setString(3, oldPwd);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE id=?";
        try (Connection c = DBContact.getConnection();
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role='customer'";
        try (Connection c = DBContact.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
