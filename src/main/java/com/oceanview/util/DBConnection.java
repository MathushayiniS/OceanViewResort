package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ocean_view_db";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Update as needed
    
    private static DBConnection instance;
    private Connection connection;
    
    private DBConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException ex) {
            System.err.println("JDBC Driver not found: " + ex.getMessage());
        }
    }
    
    public static DBConnection getInstance() throws SQLException {
        if (instance == null || instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }
    
    public Connection getConnection() {
        return connection;
    }
}
