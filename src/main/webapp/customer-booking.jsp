<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Book a Room – Ocean View Resort</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    .room-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                        gap: 1.5rem;
                        margin-top: 1.5rem;
                    }

                    .room-card {
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 12px;
                        padding: 1.5rem;
                        transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
                        position: relative;
                        overflow: hidden;
                    }

                    .room-card:hover {
                        transform: translateY(-4px);
                        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.3);
                        border-color: rgba(16, 185, 129, 0.4);
                    }

                    .room-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, #10b981, #059669);
                    }

                    .room-type-badge {
                        display: inline-block;
                        background: rgba(16, 185, 129, 0.15);
                        border: 1px solid rgba(16, 185, 129, 0.3);
                        color: #10b981;
                        padding: 0.2rem 0.8rem;
                        border-radius: 20px;
                        font-size: 0.8rem;
                        font-weight: 600;
                        margin-bottom: 0.8rem;
                    }

                    .room-price {
                        font-size: 1.6rem;
                        font-weight: 700;
                        color: white;
                    }

                    .room-price span {
                        font-size: 0.9rem;
                        color: var(--text-muted);
                        font-weight: 400;
                    }

                    .date-search-form {
                        display: flex;
                        gap: 1rem;
                        align-items: flex-end;
                        flex-wrap: wrap;
                    }

                    .date-search-form .form-group {
                        flex: 1;
                        min-width: 160px;
                        margin-bottom: 0;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/customer-header.jsp" />

                <div class="main-content" style="padding: 2rem; max-width: 1200px; margin: 0 auto; width: 100%;">
                    <div class="animate-fade-in">

                        <div style="margin-bottom: 2rem;">
                            <h1><i class="fa-solid fa-calendar-plus" style="color: #10b981;"></i> Book a Room</h1>
                            <p style="color: var(--text-muted);">Select your travel dates to see available rooms</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">
                                <i class="fa-solid fa-circle-exclamation"></i> ${error}
                            </div>
                        </c:if>

                        <!-- Date Selection Form -->
                        <div class="glass-container" style="margin-bottom: 2rem;">
                            <h3 style="margin-bottom: 1.2rem;"><i class="fa-regular fa-calendar"
                                    style="color: #10b981;"></i> Select Your Dates</h3>
                            <form action="${pageContext.request.contextPath}/customer/book" method="get"
                                class="date-search-form">
                                <div class="form-group">
                                    <label for="checkIn"><i class="fa-solid fa-plane-arrival"></i> Check-In</label>
                                    <input type="date" id="checkIn" name="checkIn" class="form-control" required
                                        value="${checkIn}" min="<%= java.time.LocalDate.now() %>">
                                </div>
                                <div class="form-group">
                                    <label for="checkOut"><i class="fa-solid fa-plane-departure"></i> Check-Out</label>
                                    <input type="date" id="checkOut" name="checkOut" class="form-control" required
                                        value="${checkOut}" min="<%= java.time.LocalDate.now().plusDays(1) %>">
                                </div>
                                <div class="form-group" style="flex: 0;">
                                    <button type="submit" class="btn btn-primary"
                                        style="background: linear-gradient(135deg, #10b981, #059669); white-space: nowrap;">
                                        <i class="fa-solid fa-magnifying-glass"></i> Search Rooms
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Available Rooms -->
                        <c:if test="${not empty availableRooms}">
                            <h3 style="margin-bottom: 0.5rem;">
                                <i class="fa-solid fa-door-open" style="color: #10b981;"></i>
                                Available Rooms for <strong>${checkIn}</strong> → <strong>${checkOut}</strong>
                            </h3>
                            <p style="color: var(--text-muted); margin-bottom: 1rem;">${availableRooms.size()} room(s)
                                found</p>

                            <div class="room-grid">
                                <c:forEach var="room" items="${availableRooms}">
                                    <div class="room-card">
                                        <div class="room-type-badge">${room.roomType}</div>
                                        <h3 style="margin-bottom: 0.5rem;">Room ${room.roomNumber}</h3>
                                        <div class="room-price">
                                            $
                                            <fmt:formatNumber value="${room.pricePerNight}" pattern="#,##0.00" />
                                            <span>/ night</span>
                                        </div>
                                        <div
                                            style="margin: 1rem 0; padding: 0.8rem; background: rgba(255,255,255,0.03); border-radius: 8px; font-size: 0.85rem; color: var(--text-muted);">
                                            <i class="fa-regular fa-calendar" style="color: #10b981;"></i>
                                            ${checkIn} → ${checkOut}
                                        </div>

                                        <form action="${pageContext.request.contextPath}/customer/book" method="post">
                                            <input type="hidden" name="roomId" value="${room.id}">
                                            <input type="hidden" name="checkIn" value="${checkIn}">
                                            <input type="hidden" name="checkOut" value="${checkOut}">
                                            <button type="submit" class="btn btn-primary"
                                                style="width: 100%; background: linear-gradient(135deg, #10b981, #059669);"
                                                onclick="return confirm('Confirm booking for Room ${room.roomNumber} (${room.roomType})?\n${checkIn} → ${checkOut}');">
                                                <i class="fa-solid fa-calendar-check"></i> Request Booking
                                            </button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                        <c:if test="${not empty checkIn and empty availableRooms}">
                            <div class="glass-container" style="text-align: center; padding: 3rem;">
                                <i class="fa-solid fa-bed"
                                    style="font-size: 3rem; color: var(--text-muted); display: block; margin-bottom: 1rem;"></i>
                                <h3 style="color: var(--text-muted);">No rooms available for the selected dates</h3>
                                <p style="color: var(--text-muted);">Please try different dates.</p>
                            </div>
                        </c:if>

                        <c:if test="${empty checkIn}">
                            <div class="glass-container" style="text-align: center; padding: 3rem;">
                                <i class="fa-regular fa-calendar"
                                    style="font-size: 3rem; color: #10b981; display: block; margin-bottom: 1rem; opacity: 0.5;"></i>
                                <p style="color: var(--text-muted);">Select your travel dates above to see available
                                    rooms.</p>
                            </div>
                        </c:if>

                    </div>
                </div>

                <jsp:include page="/footer.jsp" />

                <script>
                    // Ensure check-out is always after check-in
                    document.getElementById('checkIn').addEventListener('change', function () {
                        const checkOut = document.getElementById('checkOut');
                        const nextDay = new Date(this.value);
                        nextDay.setDate(nextDay.getDate() + 1);
                        checkOut.min = nextDay.toISOString().split('T')[0];
                        if (checkOut.value && checkOut.value <= this.value) {
                            checkOut.value = nextDay.toISOString().split('T')[0];
                        }
                    });
                </script>
            </body>

            </html>