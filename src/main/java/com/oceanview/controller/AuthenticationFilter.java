package com.oceanview.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean isStaffLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isCustomerLoggedIn = (session != null && session.getAttribute("customer") != null);

        // Public resources accessible to everyone (no login required)
        boolean isPublicResource = uri.endsWith("login.jsp") ||
                uri.endsWith("customer-login.jsp") ||
                uri.endsWith("customer-register.jsp") ||
                uri.endsWith("/auth") ||
                uri.endsWith("/customer-auth") ||
                uri.contains("/css/") ||
                uri.contains("/js/") ||
                uri.contains("/images/");

        // Customer portal paths — accessible only to logged-in customers (or staff for
        // management paths)
        boolean isCustomerPortal = uri.contains("/customer/") || uri.contains("/customer-auth");
        // Staff/Admin can access management paths under /customer/
        boolean isStaffCustomerPath = uri.contains("/customer/manage-bookings") ||
                uri.contains("/customer/reserve-for-customer") ||
                uri.contains("/customer/cancel-booking");

        if (isPublicResource) {
            // Always allow public resources
            chain.doFilter(request, response);

        } else if (isCustomerPortal) {
            if (isStaffCustomerPath && isStaffLoggedIn) {
                // Staff/Admin accessing management paths — allow through
                chain.doFilter(request, response);
            } else if (isStaffCustomerPath && !isStaffLoggedIn && isCustomerLoggedIn) {
                // Customer trying to hit a staff-only path (e.g. confirm/cancel)
                // CustomerServlet will handle cancellation for customers too
                chain.doFilter(request, response);
            } else if (!isCustomerLoggedIn) {
                // All other /customer/* require customer session
                res.sendRedirect(req.getContextPath() + "/customer-login.jsp");
            } else {
                chain.doFilter(request, response);
            }

        } else if (!isStaffLoggedIn) {
            // Staff/Admin protected area — redirect to staff login
            res.sendRedirect(req.getContextPath() + "/login.jsp");

        } else {
            // Staff/Admin is logged in — apply RBAC
            com.oceanview.model.User user = (com.oceanview.model.User) session.getAttribute("user");
            boolean isDashboard = uri.endsWith("/dashboard") || uri.endsWith("/dashboard.jsp");

            // RBAC: Deny Staff access to dashboard
            if (isDashboard && !"Admin".equalsIgnoreCase(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/reservation?action=list");
            } else {
                chain.doFilter(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
