<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Customer Help – Ocean View Resort</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <jsp:include page="customer-header.jsp" />

            <div class="main-content" style="padding: 2rem; max-width: 900px; margin: 0 auto; width: 100%;">
                <div class="animate-fade-in">

                    <div style="text-align: center; margin-bottom: 3rem;">
                        <i class="fa-solid fa-circle-question"
                            style="font-size: 3.5rem; color: #10b981; margin-bottom: 1rem; text-shadow: 0 0 20px rgba(16, 185, 129, 0.4);"></i>
                        <h1
                            style="font-size: 2.8rem; margin-bottom: 0.5rem; background: linear-gradient(to right, #fff, #6ee7b7); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                            Customer Help Center</h1>
                        <p style="color: var(--text-muted); font-size: 1.1rem;">Everything you need to know about your
                            Ocean View experience</p>
                    </div>

                    <div class="grid" style="grid-template-columns: 1fr;">

                        <div class="glass-container"
                            style="margin-bottom: 2rem; border-left: 5px solid #10b981; padding: 2rem;">
                            <h2
                                style="margin-bottom: 1.2rem; color: white; display: flex; align-items: center; gap: 1rem;">
                                <i class="fa-solid fa-door-open" style="color: #10b981;"></i> 1. Booking Your Stay
                            </h2>
                            <p style="color: var(--text-muted); line-height: 1.8; font-size: 1rem;">
                                Planning a visit is simple! Click on <strong>"Book a Room"</strong> in your menu. Choose
                                your arrival and departure dates, and we'll show you our finest available rooms. Select
                                the one that catches your eye and click <em>"Book Request"</em>. Your request will then
                                move to our team for quick confirmation.
                            </p>
                        </div>

                        <div class="glass-container"
                            style="margin-bottom: 2rem; border-left: 5px solid var(--secondary-color); padding: 2rem;">
                            <h2
                                style="margin-bottom: 1.2rem; color: white; display: flex; align-items: center; gap: 1rem;">
                                <i class="fa-solid fa-clock-rotate-left" style="color: var(--secondary-color);"></i> 2.
                                Tracking Status
                            </h2>
                            <p style="color: var(--text-muted); line-height: 1.8; font-size: 1rem;">
                                Stay updated on your request through <strong>"My Bookings"</strong>.
                                <br><br><span
                                    style="background: rgba(245, 158, 11, 0.2); color: #fbbf24; padding: 0.2rem 0.6rem; border-radius: 4px; margin-right: 0.5rem;">Pending</span>
                                Our concierge is currently reviewing your room request.
                                <br><br><span
                                    style="background: rgba(16, 185, 129, 0.2); color: #34d399; padding: 0.2rem 0.6rem; border-radius: 4px; margin-right: 0.5rem;">Reserved</span>
                                Your booking is confirmed! We're excited to welcome you.
                                <br><br><span
                                    style="background: rgba(239, 68, 68, 0.2); color: #f87171; padding: 0.2rem 0.6rem; border-radius: 4px; margin-right: 0.5rem;">Cancelled</span>
                                The booking was unable to be fulfilled or was withdrawn.
                            </p>
                        </div>

                        <div class="glass-container"
                            style="margin-bottom: 2rem; border-left: 5px solid var(--accent-color); padding: 2rem;">
                            <h2
                                style="margin-bottom: 1.2rem; color: white; display: flex; align-items: center; gap: 1rem;">
                                <i class="fa-solid fa-file-invoice-dollar" style="color: var(--accent-color);"></i> 3.
                                Billing & Payments
                            </h2>
                            <p style="color: var(--text-muted); line-height: 1.8; font-size: 1rem;">
                                Transparency is key to a relaxing stay. For any <strong>Reserved</strong> booking,
                                you'll see a <em>"View Bill"</em> button. This calculates your total stay cost using our
                                secure server-side logic (based on room rates and duration). Payments are settled during
                                check-out at the resort lobby.
                            </p>
                        </div>

                        <div class="glass-container"
                            style="margin-bottom: 2rem; border-left: 5px solid #064e3b; padding: 2rem;">
                            <h2
                                style="margin-bottom: 1.2rem; color: white; display: flex; align-items: center; gap: 1rem;">
                                <i class="fa-solid fa-headset" style="color: #6ee7b7;"></i> 4. Concierge Support 24/7
                            </h2>
                            <p style="color: var(--text-muted); line-height: 1.8; font-size: 1rem;">
                                Need something extra? From airport transfers to dinner reservations, we're here to help.
                                <br><br><strong><i class="fa-solid fa-envelope"
                                        style="margin-right: 0.5rem; color: #10b981;"></i> Email:</strong>
                                stay@oceanview.com
                                <br><strong><i class="fa-solid fa-phone"
                                        style="margin-right: 0.5rem; color: #10b981;"></i> Phone:</strong> +1 (555)
                                OCEAN-VIEW
                            </p>
                        </div>

                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />
        </body>

        </html>