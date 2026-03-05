<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Ocean View Resort</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>

            <c:if test="${not empty sessionScope.user}">
                <nav class="navbar animate-fade-in">
                    <div class="brand">
                        <span><i class="fa-solid fa-water"></i> Ocean View</span>
                        <button class="mobile-menu-btn" id="mobileMenuBtn">
                            <i class="fa-solid fa-bars"></i>
                        </button>
                    </div>
                    <div class="nav-links" id="navLinks">
                        <c:if test="${sessionScope.user.role == 'Admin'}">
                            <a href="${pageContext.request.contextPath}/dashboard"><i
                                    class="fa-solid fa-chart-line"></i> Dashboard</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/add-reservation.jsp"><i
                                class="fa-solid fa-calendar-plus"></i> New Booking</a>
                        <a href="${pageContext.request.contextPath}/reservation?action=list"><i
                                class="fa-solid fa-list-check"></i> Manage</a>
                        <a href="${pageContext.request.contextPath}/customer/manage-bookings"><i
                                class="fa-solid fa-users"></i> Customer Bookings</a>
                        <a href="${pageContext.request.contextPath}/help.jsp"><i class="fa-solid fa-circle-info"></i>
                            Help</a>
                    </div>
                    <div class="nav-user" id="navUser">
                        <span><i class="fa-solid fa-user-circle"></i> ${sessionScope.user.username}
                            (${sessionScope.user.role})</span>
                        <form action="${pageContext.request.contextPath}/auth" method="get" style="display:inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="btn btn-danger"
                                style="padding: 0.4rem 1rem; border-radius:4px;"><i
                                    class="fa-solid fa-right-from-bracket"></i></button>
                        </form>
                    </div>
                </nav>

                <script>
                    document.getElementById('mobileMenuBtn').addEventListener('click', function () {
                        document.getElementById('navLinks').classList.toggle('active');
                        document.getElementById('navUser').classList.toggle('active');

                        // Toggle Icon
                        const icon = this.querySelector('i');
                        if (icon.classList.contains('fa-bars')) {
                            icon.classList.remove('fa-bars');
                            icon.classList.add('fa-xmark');
                        } else {
                            icon.classList.remove('fa-xmark');
                            icon.classList.add('fa-bars');
                        }
                    });
                </script>
            </c:if>

            <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">