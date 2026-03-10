package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBContact - Kết nối SQL Server sử dụng Windows Authentication
 * Driver: mssql-jdbc-12.8.1.jre11.jar (không cần sqljdbc_auth.dll)
 */
public class DBContact {

    // Kết nối tới SQL Server qua TCP/IP (tránh dùng named instance để không phụ thuộc SQL Browser)
    private static final String SERVER = "localhost";
    private static final String PORT = "1433"; // nếu bạn cấu hình cổng khác, hãy sửa lại cho đúng
    private static final String DATABASE = "BookApp";

    // Đăng nhập SQL Server bằng tài khoản SQL (không dùng integratedSecurity/NTLM)
    // TODO: thay đổi USERNAME và PASSWORD cho đúng với tài khoản SQL Server của bạn
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123";

    private static final String URL = "jdbc:sqlserver://" + SERVER + ":" + PORT + ";" +
            "databaseName=" + DATABASE + ";" +
            "encrypt=false;" +
            "trustServerCertificate=true;";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("[DBContact] Driver loaded OK");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Không tìm thấy SQL Server JDBC Driver!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Tiện ích đóng kết nối an toàn
    public static void close(AutoCloseable... resources) {
        for (AutoCloseable r : resources) {
            if (r != null) {
                try {
                    r.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}
