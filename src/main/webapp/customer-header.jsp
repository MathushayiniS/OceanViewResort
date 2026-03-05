<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <nav class="navbar animate-fade-in"
            style="background: linear-gradient(135deg, rgba(6,78,59,0.95) 0%, rgba(8,47,73,0.95) 100%);">
            <div class="brand">
                <span><i class="fa-solid fa-water"></i> Ocean View
                    <span
                        style="font-size: 0.65rem; background: #10b981; color: white; padding: 0.15rem 0.5rem; border-radius: 10px; margin-left: 0.5rem; vertical-align: middle;">CUSTOMER</span>
                </span>
                <button class="mobile-menu-btn" id="custMobileMenuBtn">
                    <i class="fa-solid fa-bars"></i>
                </button>
            </div>
            <div class="nav-links" id="custNavLinks">
                <a href="${pageContext.request.contextPath}/customer/dashboard"><i class="fa-solid fa-house"></i>
                    Dashboard</a>
                <a href="${pageContext.request.contextPath}/customer/book"><i class="fa-solid fa-calendar-plus"></i>
                    Book a Room</a>
                <a href="${pageContext.request.contextPath}/customer/my-bookings"><i class="fa-solid fa-list-ul"></i> My
                    Bookings</a>
                <a href="${pageContext.request.contextPath}/customer/help"><i class="fa-solid fa-circle-question"></i>
                    Help</a>
            </div>
            <div class="nav-user" id="custNavUser">
                <span><i class="fa-solid fa-user-circle"></i> ${sessionScope.customer.fullName}</span>
                <form action="${pageContext.request.contextPath}/customer-auth" method="get" style="display:inline;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-danger" style="padding: 0.4rem 1rem; border-radius:4px;">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </button>
                </form>
            </div>
        </nav>
        <script>
            document.getElementById('custMobileMenuBtn').addEventListener('click', function () {
                document.getElementById('custNavLinks').classList.toggle('active');
                document.getElementById('custNavUser').classList.toggle('active');
                const icon = this.querySelector('i');
                icon.classList.toggle('fa-bars');
                icon.classList.toggle('fa-xmark');
            });
        </script>