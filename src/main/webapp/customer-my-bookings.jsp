<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Bookings – Ocean View Resort</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <jsp:include page="/customer-header.jsp" />

                <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">
                    <div class="animate-fade-in">

                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                            <div>
                                <h1><i class="fa-solid fa-list-check" style="color: #10b981;"></i> My Bookings &
                                    Reservations</h1>
                                <p style="color: var(--text-muted);">Track all your booking requests and confirmed
                                    reservations</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/customer/book" class="btn btn-primary"
                                style="background: linear-gradient(135deg, #10b981, #059669);">
                                <i class="fa-solid fa-plus"></i> New Booking
                            </a>
                        </div>

                        <c:if test="${param.booked == 1}">
                            <div class="alert alert-success">
                                <i class="fa-solid fa-circle-check"></i> Booking request submitted! Our staff will
                                confirm your reservation shortly.
                            </div>
                        </c:if>
                        <c:if test="${param.cancelled == 1}">
                            <div class="alert alert-error">
                                <i class="fa-solid fa-ban"></i> Booking has been cancelled.
                            </div>
                        </c:if>

                        <div class="glass-container table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Room</th>
                                        <th>Check-In</th>
                                        <th>Check-Out</th>
                                        <th>Nights</th>
                                        <th>Est. Cost</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty bookings}">
                                            <c:forEach var="b" items="${bookings}" varStatus="loop">
                                                <tr>
                                                    <td style="color: var(--text-muted); font-size: 0.85rem;">
                                                        ${loop.count}</td>
                                                    <td>
                                                        <strong>${b.room.roomType}</strong>
                                                        <br><small style="color: var(--text-muted);">Room
                                                            ${b.room.roomNumber}</small>
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
                                                    <td style="text-align: center;">
                                                        ${b.nights}
                                                    </td>
                                                    <td>
                                                        $
                                                        <fmt:formatNumber value="${b.estimatedAmount}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${b.status == 'Reserved' ? 'badge-success' : (b.status == 'Cancelled' ? 'badge-danger' : 'badge-warning')}">
                                                            <c:choose>
                                                                <c:when test="${b.status == 'Pending'}"><i
                                                                        class="fa-solid fa-clock"></i></c:when>
                                                                <c:when test="${b.status == 'Reserved'}"><i
                                                                        class="fa-solid fa-check"></i></c:when>
                                                                <c:otherwise><i class="fa-solid fa-ban"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            ${b.status}
                                                        </span>
                                                        <c:if
                                                            test="${b.status == 'Reserved' and not empty b.resNumber}">
                                                            <br><small
                                                                style="color: var(--text-muted); font-size: 0.75rem;">Ref:
                                                                ${b.resNumber}</small>
                                                        </c:if>
                                                    </td>
                                                    <td
                                                        style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
                                                        <c:if
                                                            test="${b.status == 'Reserved' and not empty b.resNumber}">
                                                            <a href="${pageContext.request.contextPath}/customer/my-bill?resNumber=${b.resNumber}"
                                                                class="btn btn-primary"
                                                                style="padding: 0.35rem 0.8rem; font-size: 0.8rem; background: linear-gradient(135deg, #10b981, #059669);">
                                                                <i class="fa-solid fa-receipt"></i> Bill
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${b.status == 'Pending'}">
                                                            <form
                                                                action="${pageContext.request.contextPath}/customer/cancel-booking"
                                                                method="post" style="display: inline; margin: 0;"
                                                                onsubmit="return confirm('Cancel this booking request?');">
                                                                <input type="hidden" name="bookingId" value="${b.id}">
                                                                <button type="submit" class="btn btn-danger"
                                                                    style="padding: 0.35rem 0.8rem; font-size: 0.8rem;">
                                                                    <i class="fa-solid fa-ban"></i> Cancel
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${b.status == 'Cancelled'}">
                                                            <span
                                                                style="color: var(--text-muted); font-size: 0.8rem;">—</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8"
                                                    style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                                    <i class="fa-solid fa-calendar-xmark"
                                                        style="font-size: 2.5rem; margin-bottom: 1rem; display: block; opacity: 0.4;"></i>
                                                    No bookings yet.
                                                    <a href="${pageContext.request.contextPath}/customer/book"
                                                        style="color: #10b981; margin-left: 0.5rem;">Book your first
                                                        room!</a>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Legend -->
                        <div
                            style="margin-top: 1.5rem; display: flex; gap: 1.5rem; flex-wrap: wrap; color: var(--text-muted); font-size: 0.85rem;">
                            <span><span class="badge badge-warning">Pending</span> Waiting for staff confirmation</span>
                            <span><span class="badge badge-success">Reserved</span> Confirmed by staff — room is
                                booked</span>
                            <span><span class="badge badge-danger">Cancelled</span> Booking was cancelled</span>
                        </div>
                    </div>
                </div>

                <jsp:include page="/footer.jsp" />
            </body>

            </html>