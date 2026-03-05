<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Bill – Ocean View Resort</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            </head>

            <body>
                <jsp:include page="/customer-header.jsp" />

                <div class="main-content" style="padding: 2rem; max-width: 900px; margin: 0 auto; width: 100%;">
                    <div class="animate-fade-in">

                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                            <a href="${pageContext.request.contextPath}/customer/my-bookings" class="btn btn-danger"
                                style="border: none;">
                                <i class="fa-solid fa-arrow-left"></i> Back to My Bookings
                            </a>
                            <c:if test="${not empty reservation}">
                                <button onclick="window.print()" class="btn btn-primary" style="background: #10b981;">
                                    <i class="fa-solid fa-print"></i> Print Invoice
                                </button>
                            </c:if>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">
                                <i class="fa-solid fa-circle-exclamation"></i> ${error}
                            </div>
                        </c:if>

                        <c:if test="${empty reservation and empty error}">
                            <div class="glass-container" style="text-align: center; padding: 3rem;">
                                <i class="fa-solid fa-receipt"
                                    style="font-size: 3rem; opacity: 0.3; display: block; margin-bottom: 1rem;"></i>
                                <p style="color: var(--text-muted);">No bill selected. Go to your <a
                                        href="${pageContext.request.contextPath}/customer/my-bookings"
                                        style="color: #10b981;">bookings</a> and click "View Bill" on a confirmed
                                    reservation.</p>
                            </div>
                        </c:if>

                        <c:if test="${not empty reservation}">
                            <div class="glass-container" style="background: white; color: #1e293b; border-radius: 4px;"
                                id="printable-invoice">

                                <!-- Invoice Header -->
                                <div
                                    style="display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 2px solid #e2e8f0; padding-bottom: 1.5rem; margin-bottom: 1.5rem;">
                                    <div>
                                        <h1
                                            style="color: #065f46; font-family: 'Playfair Display', serif; margin-bottom: 0.5rem;">
                                            <i class="fa-solid fa-water"></i> Ocean View Resort
                                        </h1>
                                        <p style="color: #64748b; font-size: 0.9rem;">123 Coastal Highway, Beachside, CA
                                            90210<br>contact@oceanviewresort.com | (555) 123-4567</p>
                                    </div>
                                    <div style="text-align: right;">
                                        <h2
                                            style="color: #64748b; text-transform: uppercase; font-size: 1.8rem; margin-bottom: 0.5rem;">
                                            Invoice</h2>
                                        <p style="font-weight: 600;">Reservation #: ${reservation.resNumber}</p>
                                        <p style="color: #64748b; font-size: 0.9rem;">Date Issued: <%=
                                                java.time.LocalDate.now() %>
                                        </p>
                                    </div>
                                </div>

                                <!-- Guest & Room Details -->
                                <div
                                    style="display: flex; justify-content: space-between; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem;">
                                    <div style="max-width: 45%;">
                                        <h4
                                            style="color: #94a3b8; text-transform: uppercase; font-size: 0.8rem; margin-bottom: 0.5rem;">
                                            Billed To:</h4>
                                        <p style="font-weight: 600; font-size: 1.1rem; margin-bottom: 0.2rem;">
                                            ${reservation.guestName}</p>
                                        <p style="color: #475569; font-size: 0.9rem;">Email: ${reservation.guestAddress}
                                        </p>
                                        <p style="color: #475569; font-size: 0.9rem;">Phone: ${reservation.guestPhone}
                                        </p>
                                    </div>
                                    <div
                                        style="max-width: 45%; background: #f0fdf4; padding: 1rem; border-radius: 8px; border: 1px solid #bbf7d0;">
                                        <h4
                                            style="color: #065f46; text-transform: uppercase; font-size: 0.8rem; margin-bottom: 0.5rem;">
                                            Stay Details:</h4>
                                        <p
                                            style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;">
                                            <span style="color: #64748b;">Check-In:</span>
                                            <strong>${reservation.checkIn}</strong>
                                        </p>
                                        <p
                                            style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;">
                                            <span style="color: #64748b;">Check-Out:</span>
                                            <strong>${reservation.checkOut}</strong>
                                        </p>
                                        <p
                                            style="display: flex; justify-content: space-between; margin-bottom: 0.3rem;">
                                            <span style="color: #64748b;">Room:</span>
                                            <strong>${reservation.room.roomType}
                                                (${reservation.room.roomNumber})</strong>
                                        </p>
                                        <p style="display: flex; justify-content: space-between;">
                                            <span style="color: #64748b;">Status:</span>
                                            <strong style="color: #059669;">${reservation.status}</strong>
                                        </p>
                                    </div>
                                </div>

                                <!-- Billing Line Items -->
                                <table style="width: 100%; margin-bottom: 2rem; border-collapse: collapse;">
                                    <thead style="background: #f0fdf4;">
                                        <tr>
                                            <th
                                                style="padding: 0.8rem; text-align: left; color: #065f46; border-bottom: 2px solid #bbf7d0;">
                                                Description</th>
                                            <th
                                                style="padding: 0.8rem; text-align: right; color: #065f46; border-bottom: 2px solid #bbf7d0;">
                                                Rate/Night</th>
                                            <th
                                                style="padding: 0.8rem; text-align: right; color: #065f46; border-bottom: 2px solid #bbf7d0;">
                                                Nights</th>
                                            <th
                                                style="padding: 0.8rem; text-align: right; color: #065f46; border-bottom: 2px solid #bbf7d0;">
                                                Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td
                                                style="padding: 1rem 0.8rem; border-bottom: 1px solid #e2e8f0; color: #0f172a;">
                                                Accommodations – ${reservation.room.roomType}
                                            </td>
                                            <td
                                                style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0;">
                                                $
                                                <fmt:formatNumber value="${reservation.room.pricePerNight}"
                                                    pattern="#,##0.00" />
                                            </td>
                                            <td
                                                style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0;">
                                                ${nights}
                                            </td>
                                            <td
                                                style="padding: 1rem 0.8rem; text-align: right; border-bottom: 1px solid #e2e8f0; font-weight: 500;">
                                                $
                                                <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <!-- Total -->
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
                                            style="display: flex; justify-content: space-between; padding: 1rem 0; font-size: 1.25rem; font-weight: 700; color: #065f46;">
                                            <span>Total Due:</span>
                                            <span>$
                                                <fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" />
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Footer -->
                                <div
                                    style="margin-top: 3rem; text-align: center; color: #94a3b8; font-size: 0.8rem; padding-top: 1.5rem; border-top: 1px solid #e2e8f0;">
                                    <p>Thank you for choosing Ocean View Resort. We hope to see you again!</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <jsp:include page="/footer.jsp" />
            </body>

            </html>