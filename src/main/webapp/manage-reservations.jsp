<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <jsp:include page="header.jsp" />

            <div class="animate-fade-in">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <div>
                        <h1><i class="fa-solid fa-list-check" style="color: var(--secondary-color);"></i> Manage
                            Reservations</h1>
                        <p style="color: var(--text-muted);">View, search, and generate bills for bookings</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/reservation" method="get"
                        style="display: flex; gap: 0.5rem; align-items: center;">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="resNumber" class="form-control"
                            placeholder="Search by Res Number (e.g. RES-1ABC)" required style="width: 250px;">
                        <button type="submit" class="btn btn-accent"><i class="fa-solid fa-magnifying-glass"></i>
                            Search</button>
                    </form>
                </div>

                <!-- Success Message from Booking or Deleting -->
                <c:if test="${param.success == 1}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-circle-check"></i> Reservation successfully created!
                    </div>
                </c:if>
                <c:if test="${param.deleted == 1}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-trash-can"></i> Reservation successfully deleted!
                    </div>
                </c:if>

                <!-- Search Error -->
                <c:if test="${not empty searchError}">
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> ${searchError}
                    </div>
                </c:if>

                <!-- Display Search Result (Specific) -->
                <c:if test="${not empty searchResult}">
                    <div class="glass-container"
                        style="margin-bottom: 2rem; border-left: 4px solid var(--accent-color);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <h3 style="color: var(--accent-color); margin-bottom: 0.5rem;"><i
                                        class="fa-solid fa-ticket"></i> Search Result: ${searchResult.resNumber}</h3>
                                <p><strong>Guest:</strong> ${searchResult.guestName} | <strong>Phone:</strong>
                                    ${searchResult.guestPhone}</p>
                                <p style="font-size: 0.9rem; color: var(--text-muted); margin-top: 0.3rem;">
                                    <strong>Dates:</strong> ${searchResult.checkIn} to ${searchResult.checkOut} &bull;
                                    <strong>Room:</strong> ${searchResult.room.roomType}
                                    (${searchResult.room.roomNumber})
                                </p>
                            </div>
                            <div style="display: flex; gap: 0.5rem; align-items: center;">
                                <a href="${pageContext.request.contextPath}/billing?resNumber=${searchResult.resNumber}"
                                    class="btn btn-primary">
                                    <i class="fa-solid fa-file-invoice-dollar"></i> Generate Bill
                                </a>
                                <c:if test="${sessionScope.user.role == 'Admin'}">
                                    <form action="${pageContext.request.contextPath}/reservation" method="post"
                                        style="display: inline; margin: 0;"
                                        onsubmit="return confirm('Are you sure you want to completely delete this reservation?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="resNumber" value="${searchResult.resNumber}">
                                        <button type="submit" class="btn btn-danger" style="height: 100%;">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Data Table (All Reservations) -->
                <div class="glass-container table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Res ID</th>
                                <th>Guest Name</th>
                                <th>Room Type</th>
                                <th>Dates</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty reservations}">
                                    <c:forEach var="res" items="${reservations}">
                                        <tr>
                                            <td><strong><a
                                                        href="${pageContext.request.contextPath}/billing?resNumber=${res.resNumber}"
                                                        style="color: var(--secondary-color); text-decoration: none;">${res.resNumber}</a></strong>
                                            </td>
                                            <td>
                                                ${res.guestName}
                                                <br><small style="color: var(--text-muted);"><i
                                                        class="fa-solid fa-phone" style="font-size: 0.7rem;"></i>
                                                    ${res.guestPhone}</small>
                                            </td>
                                            <td>${res.room.roomType} (RM: ${res.room.roomNumber})</td>
                                            <td>
                                                <span style="font-size: 0.85rem;"><i class="fa-regular fa-calendar"
                                                        style="color: var(--text-muted);"></i> In:
                                                    ${res.checkIn}</span><br>
                                                <span style="font-size: 0.85rem;"><i class="fa-solid fa-arrow-right"
                                                        style="color: var(--text-muted);"></i> Out:
                                                    ${res.checkOut}</span>
                                            </td>
                                            <td>
                                                <span
                                                    class="badge ${res.status == 'Confirmed' ? 'badge-success' : (res.status == 'Cancelled' ? 'badge-danger' : 'badge-warning')}">
                                                    ${res.status}
                                                </span>
                                            </td>
                                            <td style="display: flex; gap: 0.5rem; align-items: center;">
                                                <a href="${pageContext.request.contextPath}/billing?resNumber=${res.resNumber}"
                                                    class="btn btn-primary"
                                                    style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                                                    <i class="fa-solid fa-receipt"></i> Bill
                                                </a>
                                                <c:if test="${sessionScope.user.role == 'Admin'}">
                                                    <form action="${pageContext.request.contextPath}/reservation"
                                                        method="post" style="display: inline; margin: 0;"
                                                        onsubmit="return confirm('Are you sure you want to completely delete this reservation?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="resNumber" value="${res.resNumber}">
                                                        <button type="submit" class="btn btn-danger"
                                                            style="padding: 0.4rem 0.8rem; font-size: 0.8rem; height: 100%;">
                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>
                                                    </form>
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
                                            No reservations found in the database.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>

            <jsp:include page="footer.jsp" />