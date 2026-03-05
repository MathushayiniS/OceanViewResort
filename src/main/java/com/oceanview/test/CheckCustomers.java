package com.oceanview.test;

import com.oceanview.util.DBConnection;
import java.sql.*;

public class CheckCustomers {
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT full_name, email FROM customers");
            System.out.println("Existing Customers:");
            while (rs.next()) {
                System.out.println("- " + rs.getString("full_name") + " (" + rs.getString("email") + ")");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
