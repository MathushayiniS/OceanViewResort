package com.oceanview.test;

import com.oceanview.util.DBConnection;
import java.sql.*;

public class SetupDatabase {
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            Statement stmt = conn.createStatement();

            System.out.println("Creating tables...");

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS customers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "full_name VARCHAR(100) NOT NULL," +
                    "email VARCHAR(100) UNIQUE NOT NULL," +
                    "phone VARCHAR(20) NOT NULL," +
                    "password_hash VARCHAR(255) NOT NULL," +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP" +
                    ")");
            System.out.println("Table 'customers' created or exists.");

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS customer_bookings (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "customer_id INT NOT NULL," +
                    "room_id INT NOT NULL," +
                    "check_in DATE NOT NULL," +
                    "check_out DATE NOT NULL," +
                    "status ENUM('Pending', 'Reserved', 'Cancelled') DEFAULT 'Pending'," +
                    "res_number VARCHAR(20) NULL," +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP," +
                    "FOREIGN KEY (customer_id) REFERENCES customers(id)," +
                    "FOREIGN KEY (room_id) REFERENCES rooms(id)" +
                    ")");
            System.out.println("Table 'customer_bookings' created or exists.");

            System.out.println("Database setup complete!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
