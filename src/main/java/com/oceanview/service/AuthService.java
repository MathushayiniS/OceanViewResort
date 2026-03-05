package com.oceanview.service;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

public class AuthService {

    private UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public User login(String username, String password, String role) {
        // In a real application, you would hash the incoming password and compare it
        // For this assignment per DB insertion, we are using plain hash comparison
        return userDAO.authenticate(username, password, role);
    }
}
