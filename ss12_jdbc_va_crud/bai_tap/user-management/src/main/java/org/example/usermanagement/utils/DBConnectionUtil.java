package org.example.usermanagement.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionUtil {
    private static final String jdbcURL = "jdbc:mysql://localhost:3306/demo?useSSL=false";
    private static final String jdbcUsername = "root";
    private static final String jdbcPassword = "Codegym123@";

    @SuppressWarnings("CallToPrintStackTrace")
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
