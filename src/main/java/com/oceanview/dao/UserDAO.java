package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User authenticate(String username, String plainPassword, String role) {
        User user = null;
        String query = "SELECT * FROM users WHERE username = ? AND role = ?";

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, role);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String dbHash = rs.getString("password_hash");
                boolean matched = false;

                // Checking if the stored password_hash looks like a BCrypt hash
                if (dbHash.startsWith("$2a$") || dbHash.startsWith("$2y$") || dbHash.startsWith("$2b$")) {
                    matched = org.mindrot.jbcrypt.BCrypt.checkpw(plainPassword, dbHash);
                } else {
                    // Fallback to plain text comparison for legacy database entries
                    matched = dbHash.equals(plainPassword);

                    // Seamlessly upgrade plain text password to BCrypt hash in the Database
                    if (matched) {
                        try {
                            String newHash = org.mindrot.jbcrypt.BCrypt.hashpw(plainPassword,
                                    org.mindrot.jbcrypt.BCrypt.gensalt());
                            PreparedStatement updateStmt = conn
                                    .prepareStatement("UPDATE users SET password_hash = ? WHERE id = ?");
                            updateStmt.setString(1, newHash);
                            updateStmt.setInt(2, rs.getInt("id"));
                            updateStmt.executeUpdate();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
                }

                if (matched) {
                    user = new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password_hash"),
                            rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
