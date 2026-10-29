
package com.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/StudentRecord";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "kalpeshpatil1208";

    public static Connection getConnection() throws SQLException {
    try {
        // driver name
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new SQLException("MySQL driver not found in classpath", e);
    }
    return DriverManager.getConnection(URL, USERNAME, PASSWORD);
}
    public static void main(String[] args) {

        try (Connection con = getConnection()) {

            System.out.println("MySQL connected successfully!");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}
