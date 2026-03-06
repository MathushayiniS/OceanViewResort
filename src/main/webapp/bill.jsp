<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <jsp:include page="header.jsp" />

            <div class="animate-fade-in" style="max-width: 800px; margin: 0 auto;">

                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <a href="${pageContext.request.contextPath}/reservation?action=list" class="btn btn-danger"
                        style="border: none;">
                        <i class="fa-solid fa-arrow-left"></i> Back to Reservations
                    </a>
                    <button onclick="window.print()" class="btn btn-primary" style="background: var(--success-color);">
                        <i class="fa-solid fa-print"></i> Print Invoice
                    </button>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${not empty reservation}">
                    <div class="glass-container" style="background: white; color: #1e293b; border-radius: 4px;"
                        id="printable-invoice">

                        <style>
                            @media print {
                                body * {
                                    visibility: hidden;
                                }

                                #printable-invoice,
                                #printable-invoice * {
                                    visibility: visible;
                                }

                                #printable-invoice {
                                    position: absolute;
                                    left: 0;
                                    top: 0;
                                    width: 100%;
                                    box-shadow: none;
                                    border: none;
                                }
                            }
                        </style>

                        <!-- Invoice Header -->
                        <div
                            style="display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 2px solid #e2e8f0; padding-bottom: 1.5rem; margin-bottom: 1.5rem;">
                            <div>
                                <h1
                                    style="color: #0c4a6e; font-family: 'Playfair Display', serif; margin-bottom: 0.5rem;">
                                    <i class="fa-solid fa-water"></i> Ocean View Resort</h1>
                                <p style="color: #64748b; font-size: 0.9rem;">123 Coastal Highway, Beachside, CA
                                    90210<br>contact@oceanviewresort.com | (555) 123-4567</p>
                            </div>
                            <div style="text-align: right;">
                                <h2
                                    style="color: #64748b; text-transform: uppercase; font-size: 1.8rem; margin-bottom: 0.5rem;">
                                    Invoice</h2>
                                <p style="font-weight: 600;">Reservation #: ${reservation.resNumber}</p>
                                <p style="color: #64748b; font-size: 0.9rem;">Date Issued: <%= java.time.LocalDate.now()
                                        %>
                                </p>
                            </div>
                        </div>

                        <!-- Guest & Room Details -->
                        <div style="display: flex; justify-content: space-between; margin-bottom: 2rem;">
                            <div style="max-width: 45%;">
                                <h4
                                    style="color: #94a3b8; text-transform: uppercase; font-size: 0.8rem; margin-bottom: 0.5rem;">
                                    Billed To:</h4>
                                <p style="font-weight: 600; font-size: 1.1rem; margin-bottom: 0.2rem;">
                                    ${reservation.guestName}</p>
                                <p style="color: #475569; font-size: 0.9rem;">Email: ${reservation.guestAddress}</p>
                                <p style="color: #475569; font-size: 0.9rem;">Phone: ${reservation.guestPhone}</p>
                            </div>
                            <div style="max-width: 45%; background: #f8fafc; padding: 1rem; border-radius: 8px;">
                                <h4
                                    style="color: #94a3b8; text-transform: uppercase; font-size: 0.8rem; margin-bottom: 0.5rem;">
                                    Stay Details:</h4>
                                <p style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;"><span
                                        style="color: #64748b;">Check-In:</span> <strong>${reservation.checkIn}</strong>
                                </p>
                                <p style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;"><span
                                        style="color: #64748b;">Check-Out:</span>
                                    <strong>${reservation.checkOut}</strong></p>
                                <p style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;"><span
                                        style="color: #64748b;">Room:</span> <strong>${reservation.room.roomType}
                                        (${reservation.room.roomNumber})</strong></p>
                            </div>
                        </div>

                        <!-- Billing Line Items -->
                        <table style="width: 100%; margin-bottom: 2rem; border-collapse: collapse;">
                            <thead style="background: #f1f5f9;">
                                <tr>
                                    <th
                                        style="padding: 0.8rem; text-align: left; color: #475569; border-bottom: 2px solid #cbd5e1;">
                                        Description</th>
                                    <th
                                        style="padding: 0.8rem; text-align: right; color: #475569; border-bottom: 2px solid #cbd5e1;">
                                        Rate per Night</th>
                                    <th
                                        style="padding: 0.8rem; text-align: right; color: #475569; border-bottom: 2px solid #cbd5e1;">
                                        Nights</th>
                                    <th
                                        style="padding: 0.8rem; text-align: right; color: #475569; border-bottom: 2px solid #cbd5e1;">
                                        Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style="color: #fdfdfd;">
                                    <td style="padding: 1rem 0.8rem; border-bottom: 1px solid #e2e8f0; color: #fdfdfd;">
                                        Accommodations - ${reservation.room.roomType}</td>
                                    <td
                                        style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0; color: #fdfdfd;">
                                        $
                                        <fmt:formatNumber value="${reservation.room.pricePerNight}"
                                            pattern="#,##0.00" />
                                    </td>
                                    <td
                                        style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0;">
                                        <% com.oceanview.model.Reservation r=(com.oceanview.model.Reservation)
                                            request.getAttribute("reservation"); long
                                            nights=java.time.temporal.ChronoUnit.DAYS.between(r.getCheckIn(),
                                            r.getCheckOut()); if (nights <=0) nights=1; out.print(nights); %>
                                    </td>
                                    <td
                                        style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0; font-weight: 500;">
                                        $
                                        <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <!-- Total Calculation -->
                        <div style="display: flex; justify-content: flex-end;">
                            <div style="width: 300px;">
                                <div
                                    style="display: flex; justify-content: space-between; padding: 0.8rem 0; border-bottom: 1px solid #e2e8f0;">
                                    <span style="color: #64748b;">Subtotal:</span>
                                    <span style="font-weight: 500;">$
                                        <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />
                                    </span>
                                </div>
                                <div
                                    style="display: flex; justify-content: space-between; padding: 0.8rem 0; border-bottom: 1px solid #e2e8f0;">
                                    <span style="color: #64748b;">Taxes (Inc.):</span>
                                    <span style="font-weight: 500;">$0.00</span>
                                </div>
                                <div
                                    style="display: flex; justify-content: space-between; padding: 1rem 0; font-size: 1.25rem; font-weight: 700; color: #0f172a;">
                                    <span>Total Due:</span>
                                    <span>$
                                        <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Footer Note -->
                        <div
                            style="margin-top: 3rem; text-align: center; color: #94a3b8; font-size: 0.8rem; padding-top: 1.5rem; border-top: 1px solid #e2e8f0;">
                            <p>Thank you for your business. Please make payments payable to Ocean View Resort.</p>
                        </div>

                    </div>
                </c:if>

            </div>

            <jsp:include page="footer.jsp" />