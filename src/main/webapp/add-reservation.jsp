<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <jsp:include page="header.jsp" />

        <div class="animate-fade-in" style="max-width: 800px; margin: 0 auto;">
            <h1 style="margin-bottom: 2rem;"><i class="fa-solid fa-calendar-plus"
                    style="color: var(--secondary-color);"></i> New Reservation</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <div class="glass-container">
                <form id="addReservationForm" action="${pageContext.request.contextPath}/reservation" method="post">
                    <input type="hidden" name="action" value="add">

                    <div class="grid" style="grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <!-- Dates Section -->
                        <div class="form-group">
                            <label for="checkIn"><i class="fa-solid fa-calendar-days"></i> Check-In Date</label>
                            <input type="date" id="checkIn" name="checkIn" class="form-control" required
                                min="<%= java.time.LocalDate.now() %>">
                        </div>

                        <div class="form-group">
                            <label for="checkOut"><i class="fa-solid fa-calendar-days"></i> Check-Out Date</label>
                            <input type="date" id="checkOut" name="checkOut" class="form-control" required
                                min="<%= java.time.LocalDate.now().plusDays(1) %>">
                        </div>
                    </div>

                    <!-- Room Availability (AJAX Trigger) -->
                    <div class="form-group"
                        style="margin-top: 1rem; padding: 1rem; background: rgba(0,0,0,0.2); border-radius: 8px;">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                            <label for="roomId" style="margin: 0;"><i class="fa-solid fa-bed"></i> Available
                                Rooms</label>
                            <button id="btnCheckRooms" class="btn btn-accent"
                                style="padding: 0.4rem 0.8rem; font-size: 0.85rem;">
                                <i class="fa-solid fa-magnifying-glass"></i> Check Now
                            </button>
                        </div>
                        <select id="roomId" name="roomId" class="form-control" required disabled>
                            <option value="">-- Please check availability first --</option>
                        </select>
                        <div id="roomAvailabilityStatus"
                            style="margin-top: 0.5rem; font-size: 0.85rem; font-weight: 500;"></div>
                    </div>

                    <hr style="border-top: 1px solid var(--glass-border); margin: 2rem 0;">
                    <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-user-pen"></i> Guest Information</h3>

                    <div class="form-group">
                        <label for="guestName">Full Name</label>
                        <input type="text" id="guestName" name="guestName" class="form-control" required
                            placeholder="John Doe">
                    </div>

                    <div class="grid" style="grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="guestPhone">Contact Number</label>
                            <input type="tel" id="guestPhone" name="guestPhone" class="form-control" required
                                placeholder="+1 234 567 8900" pattern="[0-9\+\-\s]+">
                        </div>

                        <div class="form-group">
                            <label for="guestAddress">Email Address (for Confirmation Email)</label>
                            <input type="email" id="guestAddress" name="guestAddress" class="form-control" required
                                placeholder="john@example.com">
                        </div>
                    </div>

                    <div style="margin-top: 2rem; display: flex; justify-content: flex-end; gap: 1rem;">
                        <button type="reset" class="btn btn-danger">Reset Fields</button>
                        <button type="submit" class="btn btn-primary" id="btnSubmitRes"><i
                                class="fa-solid fa-check"></i> Confirm Reservation</button>
                    </div>

                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp" />