<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <jsp:include page="header.jsp" />

    <div class="animate-fade-in" style="max-width: 900px; margin: 0 auto;">

        <div style="text-align: center; margin-bottom: 3rem;">
            <i class="fa-solid fa-life-ring"
                style="font-size: 3rem; color: var(--secondary-color); margin-bottom: 1rem;"></i>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">System Help Center</h1>
            <p style="color: var(--text-muted);">A comprehensive guide to using the Ocean View Reservation System</p>
        </div>

        <div class="grid" style="grid-template-columns: 1fr;">

            <div class="glass-container" style="margin-bottom: 1.5rem; border-left: 4px solid var(--primary-color);">
                <h2 style="margin-bottom: 1rem; color: var(--text-main);"><i class="fa-solid fa-lock"></i> 1. Secure
                    Login</h2>
                <p style="color: var(--text-muted); line-height: 1.6;">
                    Access to the system requires an authorized staff or admin account. Enter your exact credentials on
                    the main screen. The system maintains an encrypted <strong>session</strong> that will automatically
                    terminate upon clicking "Logout".
                </p>
            </div>

            <div class="glass-container" style="margin-bottom: 1.5rem; border-left: 4px solid var(--secondary-color);">
                <h2 style="margin-bottom: 1rem; color: var(--text-main);"><i class="fa-solid fa-calendar-plus"></i> 2.
                    Creating New Reservations</h2>
                <p style="color: var(--text-muted); line-height: 1.6;">
                    Navigate to <strong>"New Booking"</strong>. The availability checker requires both Check-In and
                    Check-Out dates selected first. Clicking <em>"Check Now"</em> pings our REST API to find
                    non-overlapping rooms. If an email address is provided during booking, the system leverages
                    <strong>JavaMail</strong> to dispatch a notification to the client anonymously via background
                    threads.
                </p>
            </div>

            <div class="glass-container" style="margin-bottom: 1.5rem; border-left: 4px solid var(--accent-color);">
                <h2 style="margin-bottom: 1rem; color: var(--text-main);"><i class="fa-solid fa-magnifying-glass"></i>
                    3. Searching for Guests</h2>
                <p style="color: var(--text-muted); line-height: 1.6;">
                    Use the <strong>"Manage"</strong> tab to view a holistic list of daily reservations. If looking for
                    a specific guest, input their generated `RES-XXXXXXX` identifier in the search bar. This queries the
                    database leveraging internal Servlets.
                </p>
            </div>

            <div class="glass-container" style="margin-bottom: 1.5rem; border-left: 4px solid var(--success-color);">
                <h2 style="margin-bottom: 1rem; color: var(--text-main);"><i class="fa-solid fa-receipt"></i> 4.
                    Generating Bills & Invoices</h2>
                <p style="color: var(--text-muted); line-height: 1.6;">
                    From the Manage pane or Search Results, click <strong>"Bill"</strong> next to any row. The
                    calculation executes via a <em>MySQL Stored Procedure</em> to calculate days and prices safely. The
                    generated layout converts to a crisp white page when pressing "Print Invoice", specifically
                    optimized for thermal or A4 printers using CSS media queries.
                </p>
            </div>

        </div>
    </div>

    <jsp:include page="footer.jsp" />