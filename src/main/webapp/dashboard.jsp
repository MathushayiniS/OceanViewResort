<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <jsp:include page="header.jsp" />

            <div class="animate-fade-in">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <div>
                        <h1 style="font-size: 2rem; margin-bottom: 0.5rem;">Admin Dashboard</h1>
                        <p style="color: var(--text-muted);">Overview and analytical reports for Ocean View Resort</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/add-reservation.jsp" class="btn btn-primary"
                        style="display: flex; align-items: center; gap: 0.5rem;">
                        <i class="fa-solid fa-plus"></i> New Reservation
                    </a>
                </div>

                <!-- Snapshot Stats -->
                <div class="grid" style="margin-bottom: 3rem;">
                    <div class="glass-container stat-card">
                        <i class="fa-solid fa-bed"
                            style="font-size: 2rem; color: var(--secondary-color); margin-bottom: 1rem;"></i>
                        <h3>${totalBookings}</h3>
                        <p>Total Bookings</p>
                    </div>

                    <div class="glass-container stat-card" style="border-top-color: var(--success-color);">
                        <i class="fa-solid fa-door-open"
                            style="font-size: 2rem; color: var(--success-color); margin-bottom: 1rem;"></i>
                        <h3>${availableRooms}</h3>
                        <p>Rooms Available Right Now</p>
                    </div>

                    <div class="glass-container stat-card" style="border-top-color: var(--accent-color);">
                        <i class="fa-solid fa-sack-dollar"
                            style="font-size: 2rem; color: var(--accent-color); margin-bottom: 1rem;"></i>
                        <h3>$
                            <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
                        </h3>
                        <p>Estimated Revenue</p>
                    </div>
                </div>

                <!-- Quick Actions & Secondary Info -->
                <div class="grid">
                    <div class="glass-container">
                        <h2
                            style="margin-bottom: 1rem; border-bottom: 1px solid var(--glass-border); padding-bottom: 0.5rem;">
                            <i class="fa-solid fa-bolt"></i> Quick Actions
                        </h2>
                        <ul style="list-style: none; padding: 0;">
                            <li style="margin-bottom: 1rem;">
                                <a href="${pageContext.request.contextPath}/reservation?action=list"
                                    style="color: var(--secondary-color); text-decoration: none; font-weight: 500; display: flex; align-items: center; justify-content: space-between;">
                                    Manage All Reservations <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </li>
                            <li style="margin-bottom: 1rem;">
                                <a href="${pageContext.request.contextPath}/add-reservation.jsp"
                                    style="color: var(--secondary-color); text-decoration: none; font-weight: 500; display: flex; align-items: center; justify-content: space-between;">
                                    Book a Room <i class="fa-solid fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="glass-container"
                        style="background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(12, 74, 110, 0.4));">
                        <h2 style="margin-bottom: 1rem; color: var(--accent-color);">
                            <i class="fa-solid fa-lightbulb"></i> Note
                        </h2>
                        <p style="color: var(--text-muted); line-height: 1.6;">
                            Revenue calculation is estimated based on confirmed static room rates. Ensure all actual
                            check-outs issue a final calculated bill.
                        </p>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />