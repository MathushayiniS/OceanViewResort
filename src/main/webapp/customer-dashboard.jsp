<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Dashboard – Ocean View Resort</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                .stat-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                    gap: 1.5rem;
                    margin-bottom: 2rem;
                }

                .stat-card {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 12px;
                    padding: 1.5rem;
                    text-align: center;
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .stat-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
                }

                .stat-icon {
                    font-size: 2rem;
                    margin-bottom: 0.5rem;
                }

                .stat-number {
                    font-size: 2rem;
                    font-weight: 700;
                    color: white;
                }

                .stat-label {
                    color: var(--text-muted);
                    font-size: 0.85rem;
                    margin-top: 0.3rem;
                }

                .welcome-banner {
                    background: linear-gradient(135deg, rgba(16, 185, 129, 0.15) 0%, rgba(5, 150, 105, 0.1) 100%);
                    border: 1px solid rgba(16, 185, 129, 0.3);
                    border-radius: 12px;
                    padding: 2rem;
                    margin-bottom: 2rem;
                    display: flex;
                    align-items: center;
                    gap: 1.5rem;
                }

                .welcome-avatar {
                    width: 64px;
                    height: 64px;
                    background: linear-gradient(135deg, #10b981, #059669);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.8rem;
                    color: white;
                    flex-shrink: 0;
                }
            </style>
        </head>

        <body>
            <jsp:include page="/customer-header.jsp" />

            <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">
                <div class="animate-fade-in">

                    <!-- Welcome Banner -->
                    <div class="welcome-banner">
                        <div class="welcome-avatar">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <div>
                            <h2 style="margin-bottom: 0.3rem;">Welcome back, ${sessionScope.customer.fullName}!</h2>
                            <p style="color: var(--text-muted); margin-bottom: 0.5rem;">
                                <i class="fa-solid fa-envelope" style="color: #10b981;"></i>
                                ${sessionScope.customer.email} &bull;
                                <i class="fa-solid fa-phone" style="color: #10b981;"></i> ${sessionScope.customer.phone}
                            </p>
                            <a href="${pageContext.request.contextPath}/customer/book" class="btn btn-primary"
                                style="background: linear-gradient(135deg, #10b981, #059669); padding: 0.5rem 1.2rem; font-size: 0.9rem;">
                                <i class="fa-solid fa-calendar-plus"></i> Book a Room Now
                            </a>
                        </div>
                    </div>

                    <!-- Stats -->
                    <div class="stat-grid">
                        <div class="stat-card">
                            <div class="stat-icon" style="color: #f59e0b;">🕐</div>
                            <div class="stat-number">
                                <c:set var="pendingCount" value="0" />
                                <c:forEach var="b" items="${bookings}">
                                    <c:if test="${b.status == 'Pending'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </div>
                            <div class="stat-label">Pending Bookings</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon" style="color: #10b981;">✅</div>
                            <div class="stat-number">
                                <c:set var="reservedCount" value="0" />
                                <c:forEach var="b" items="${bookings}">
                                    <c:if test="${b.status == 'Reserved'}">
                                        <c:set var="reservedCount" value="${reservedCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${reservedCount}
                            </div>
                            <div class="stat-label">Confirmed Stays</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon" style="color: #ef4444;">❌</div>
                            <div class="stat-number">
                                <c:set var="cancelledCount" value="0" />
                                <c:forEach var="b" items="${bookings}">
                                    <c:if test="${b.status == 'Cancelled'}">
                                        <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${cancelledCount}
                            </div>
                            <div class="stat-label">Cancelled</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon" style="color: #3b82f6;">📋</div>
                            <div class="stat-number">${bookings.size()}</div>
                            <div class="stat-label">Total Bookings</div>
                        </div>
                    </div>

                    <!-- Recent Bookings Preview -->
                    <div class="glass-container">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                            <h3><i class="fa-solid fa-clock-rotate-left" style="color: #10b981;"></i> Recent Bookings
                            </h3>
                            <a href="${pageContext.request.contextPath}/customer/my-bookings" class="btn btn-accent"
                                style="font-size: 0.85rem; padding: 0.4rem 1rem;">
                                View All <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>

                        <c:choose>
                            <c:when test="${not empty bookings}">
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Room</th>
                                                <th>Check-In</th>
                                                <th>Check-Out</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${bookings}" varStatus="loop">
                                                <c:if test="${loop.index < 5}">
                                                    <tr>
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
                                                            <c:if
                                                                test="${b.status == 'Reserved' and not empty b.resNumber}">
                                                                <a href="${pageContext.request.contextPath}/customer/my-bill?resNumber=${b.resNumber}"
                                                                    class="btn btn-primary"
                                                                    style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">
                                                                    <i class="fa-solid fa-receipt"></i> View Bill
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${b.status == 'Pending'}">
                                                                <span
                                                                    style="color: var(--text-muted); font-size: 0.8rem;">Awaiting
                                                                    confirmation</span>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i class="fa-solid fa-calendar-xmark"
                                        style="font-size: 3rem; margin-bottom: 1rem; display: block; color: #10b981; opacity: 0.5;"></i>
                                    <p style="margin-bottom: 1rem;">No bookings yet. Start planning your stay!</p>
                                    <a href="${pageContext.request.contextPath}/customer/book" class="btn btn-primary"
                                        style="background: linear-gradient(135deg, #10b981, #059669);">
                                        <i class="fa-solid fa-calendar-plus"></i> Book Your First Room
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <jsp:include page="/footer.jsp" />
        </body>

        </html>