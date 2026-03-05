package com.oceanview.dao;

import com.oceanview.model.Customer;
import com.oceanview.util.DBConnection;

import java.sql.*;

public class CustomerDAO {

    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO customers (full_name, email, phone, password_hash) VALUES (?, ?, ?, ?)";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getPasswordHash());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer authenticate(String email, String plainPassword) {
        String query = "SELECT * FROM customers WHERE email = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String dbHash = rs.getString("password_hash");
                boolean matched;
                if (dbHash.startsWith("$2a$") || dbHash.startsWith("$2y$") || dbHash.startsWith("$2b$")) {
                    matched = org.mindrot.jbcrypt.BCrypt.checkpw(plainPassword, dbHash);
                } else {
                    matched = dbHash.equals(plainPassword);
                    if (matched) {
                        try {
                            String newHash = org.mindrot.jbcrypt.BCrypt.hashpw(plainPassword,
                                    org.mindrot.jbcrypt.BCrypt.gensalt());
                            PreparedStatement upStmt = conn.prepareStatement(
                                    "UPDATE customers SET password_hash = ? WHERE id = ?");
                            upStmt.setString(1, newHash);
                            upStmt.setInt(2, rs.getInt("id"));
                            upStmt.executeUpdate();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
                }
                if (matched) {
                    return new Customer(
                            rs.getInt("id"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("password_hash"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExists(String email) {
        String query = "SELECT id FROM customers WHERE email = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
