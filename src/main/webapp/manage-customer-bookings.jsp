<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <jsp:include page="header.jsp" />

            <div class="animate-fade-in">

                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <div>
                        <h1><i class="fa-solid fa-users" style="color: var(--secondary-color);"></i> Customer Bookings
                        </h1>
                        <p style="color: var(--text-muted);">Review and confirm booking requests from customers</p>
                    </div>
                </div>

                <c:if test="${param.reserved == 1}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-circle-check"></i> Reservation successfully created and customer notified!
                    </div>
                </c:if>
                <c:if test="${param.cancelled == 1}">
                    <div class="alert alert-error">
                        <i class="fa-solid fa-ban"></i> Booking has been cancelled.
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> ${error}
                    </div>
                </c:if>

                <!-- Pending Bookings (Action Required) -->
                <c:if test="${not empty pendingBookings}">
                    <div class="glass-container"
                        style="margin-bottom: 2rem; border-left: 4px solid var(--accent-color);">
                        <h3 style="color: var(--accent-color); margin-bottom: 1.2rem;">
                            <i class="fa-solid fa-clock"></i> Pending Requests
                            <span
                                style="background: var(--accent-color); color: white; border-radius: 20px; padding: 0.1rem 0.6rem; font-size: 0.8rem; margin-left: 0.5rem;">${pendingBookings.size()}</span>
                        </h3>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Customer</th>
                                        <th>Room</th>
                                        <th>Check-In</th>
                                        <th>Check-Out</th>
                                        <th>Est. Amount</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${pendingBookings}">
                                        <tr>
                                            <td>
                                                <strong>${b.customerName}</strong>
                                                <br><small style="color: var(--text-muted);">
                                                    <i class="fa-solid fa-envelope" style="font-size: 0.7rem;"></i>
                                                    ${b.customerEmail}
                                                    <br><i class="fa-solid fa-phone" style="font-size: 0.7rem;"></i>
                                                    ${b.customerPhone}
                                                </small>
                                            </td>
                                            <td>
                                                <strong>${b.room.roomType}</strong>
                                                <br><small style="color: var(--text-muted);">Room ${b.room.roomNumber} —
                                                    $
                                                    <fmt:formatNumber value="${b.room.pricePerNight}"
                                                        pattern="#,##0.00" />/night
                                                </small>
                                            </td>
                                            <td>
                                                <i class="fa-regular fa-calendar"
                                                    style="color: var(--text-muted); font-size: 0.8rem;"></i>
                                                ${b.checkIn}
                                            </td>
                                            <td>
                                                <i class="fa-solid fa-arrow-right"
                                                    style="color: var(--text-muted); font-size: 0.8rem;"></i>
                                                ${b.checkOut}
                                            </td>
                                            <td>
                                                $
                                                <fmt:formatNumber value="${b.estimatedAmount}" pattern="#,##0.00" />
                                                <small style="color:var(--text-muted)">(${b.nights} nights)</small>
                                            </td>
                                            <td
                                                style="display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
                                                <!-- Confirm / Create Reservation -->
                                                <form
                                                    action="${pageContext.request.contextPath}/customer/reserve-for-customer"
                                                    method="post" style="display: inline; margin: 0;"
                                                    onsubmit="return confirm('Create a reservation for ${b.customerName}?\nRoom: ${b.room.roomType} (${b.room.roomNumber})\n${b.checkIn} → ${b.checkOut}');">
                                                    <input type="hidden" name="bookingId" value="${b.id}">
                                                    <button type="submit" class="btn btn-primary"
                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                                                        <i class="fa-solid fa-calendar-check"></i> Confirm & Reserve
                                                    </button>
                                                </form>
                                                <!-- Cancel booking -->
                                                <form
                                                    action="${pageContext.request.contextPath}/customer/cancel-booking"
                                                    method="post" style="display: inline; margin: 0;"
                                                    onsubmit="return confirm('Cancel this booking request?');">
                                                    <input type="hidden" name="bookingId" value="${b.id}">
                                                    <button type="submit" class="btn btn-danger"
                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                                                        <i class="fa-solid fa-ban"></i> Cancel
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty pendingBookings}">
                    <div class="glass-container"
                        style="margin-bottom: 2rem; border-left: 4px solid var(--accent-color); text-align: center; padding: 2rem;">
                        <i class="fa-solid fa-circle-check"
                            style="font-size: 2rem; color: var(--success-color); margin-bottom: 0.5rem; display: block;"></i>
                        <p style="color: var(--text-muted);">No pending booking requests — all caught up!</p>
                    </div>
                </c:if>

                <!-- All Bookings History -->
                <div class="glass-container table-container">
                    <h3 style="margin-bottom: 1.2rem;">
                        <i class="fa-solid fa-history" style="color: var(--secondary-color);"></i> All Customer Bookings
                    </h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Customer</th>
                                <th>Room</th>
                                <th>Check-In</th>
                                <th>Check-Out</th>
                                <th>Status</th>
                                <th>Reservation #</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty allBookings}">
                                    <c:forEach var="b" items="${allBookings}">
                                        <tr>
                                            <td>
                                                <strong>${b.customerName}</strong>
                                                <br><small style="color: var(--text-muted);">${b.customerEmail}</small>
                                            </td>
                                            <td>${b.room.roomType} (${b.room.roomNumber})</td>
                                            <td>${b.checkIn}</td>
                                            <td>${b.checkOut}</td>
                                            <td>
                                                <span
                                                    class="badge ${b.status == 'Reserved' ? 'badge-success' : (b.status == 'Cancelled' ? 'badge-danger' : 'badge-warning')}">
                                                    ${b.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${not empty b.resNumber}">
                                                    <a href="${pageContext.request.contextPath}/billing?resNumber=${b.resNumber}"
                                                        style="color: var(--secondary-color); text-decoration: none; font-weight: 600;">
                                                        ${b.resNumber}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty b.resNumber}">
                                                    <span style="color: var(--text-muted);">—</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6"
                                            style="text-align: center; padding: 2rem; color: var(--text-muted);">
                                            <i class="fa-solid fa-folder-open"
                                                style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                            No customer bookings yet.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <jsp:include page="footer.jsp" />