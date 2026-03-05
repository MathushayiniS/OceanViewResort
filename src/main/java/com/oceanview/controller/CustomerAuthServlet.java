package com.oceanview.controller;

import com.oceanview.model.Customer;
import com.oceanview.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customer-auth")
public class CustomerAuthServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() {
        customerService = new CustomerService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirmPassword");

            if (!password.equals(confirm)) {
                request.setAttribute("error", "Passwords do not match.");
                request.getRequestDispatcher("/customer-register.jsp").forward(request, response);
                return;
            }

            if (customerService.emailExists(email)) {
                request.setAttribute("error", "Email already registered. Please login or use a different email.");
                request.getRequestDispatcher("/customer-register.jsp").forward(request, response);
                return;
            }

            boolean success = customerService.register(fullName, email, phone, password);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/customer-login.jsp?registered=1");
            } else {
                request.setAttribute("error", "Registration failed due to a system error. Please try again later.");
                request.getRequestDispatcher("/customer-register.jsp").forward(request, response);
            }

        } else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Customer customer = customerService.login(email, password);
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/customer-login.jsp").forward(request, response);
            }

        } else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("customer");
                // If no staff/admin user either, invalidate
                if (session.getAttribute("user") == null) {
                    session.invalidate();
                }
            }
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("customer");
                if (session.getAttribute("user") == null) {
                    session.invalidate();
                }
            }
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
        }
    }
}
