package com.oceanview.controller;

import com.oceanview.dao.CustomerBookingDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Customer;
import com.oceanview.model.CustomerBooking;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/customer/*")
public class CustomerServlet extends HttpServlet {

    private CustomerBookingDAO bookingDAO;
    private RoomDAO roomDAO;
    private ReservationService reservationService;

    @Override
    public void init() {
        bookingDAO = new CustomerBookingDAO();
        roomDAO = new RoomDAO();
        reservationService = new ReservationService();
    }

    private Customer getLoggedInCustomer(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Customer) session.getAttribute("customer");
        }
        return null;
    }

    private com.oceanview.model.User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (com.oceanview.model.User) session.getAttribute("user");
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null)
            pathInfo = "/dashboard";

        switch (pathInfo) {
            case "/dashboard":
                showCustomerDashboard(request, response);
                break;
            case "/book":
                showBookingForm(request, response);
                break;
            case "/my-bookings":
                showMyBookings(request, response);
                break;
            case "/my-bill":
                showMyBill(request, response);
                break;
            case "/help":
                showHelp(request, response);
                break;
            // Staff/Admin views
            case "/manage-bookings":
                showManageBookings(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null)
            pathInfo = "/";

        switch (pathInfo) {
            case "/book":
                handleBookRoom(request, response);
                break;
            case "/reserve-for-customer":
                handleReserveForCustomer(request, response);
                break;
            case "/cancel-booking":
                handleCancelBooking(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
        }
    }

    // --------------------------------------------------------
    // CUSTOMER VIEWS
    // --------------------------------------------------------

    private void showCustomerDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = getLoggedInCustomer(request);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
            return;
        }
        List<CustomerBooking> bookings = bookingDAO.getBookingsByCustomer(customer.getId());
        for (CustomerBooking b : bookings) {
            calculateBookingStats(b);
        }
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
    }

    private void showBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = getLoggedInCustomer(request);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
            return;
        }
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");
        if (checkIn != null && checkOut != null && !checkIn.isEmpty() && !checkOut.isEmpty()) {
            List<Room> availableRooms = roomDAO.getAvailableRooms(checkIn, checkOut);
            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("checkIn", checkIn);
            request.setAttribute("checkOut", checkOut);
        }
        request.getRequestDispatcher("/customer-booking.jsp").forward(request, response);
    }

    private void showMyBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = getLoggedInCustomer(request);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
            return;
        }
        List<CustomerBooking> bookings = bookingDAO.getBookingsByCustomer(customer.getId());
        for (CustomerBooking b : bookings) {
            calculateBookingStats(b);
        }
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/customer-my-bookings.jsp").forward(request, response);
    }

    private void showMyBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = getLoggedInCustomer(request);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
            return;
        }
        String resNumber = request.getParameter("resNumber");
        if (resNumber != null && !resNumber.isEmpty()) {
            // Verify the reservation belongs to this customer's booking
            List<CustomerBooking> bookings = bookingDAO.getBookingsByCustomer(customer.getId());
            boolean owned = bookings.stream().anyMatch(b -> resNumber.equals(b.getResNumber()));
            if (owned) {
                Reservation reservation = reservationService.getReservationValidation(resNumber);
                if (reservation != null) {
                    long nights = java.time.temporal.ChronoUnit.DAYS.between(
                            reservation.getCheckIn(), reservation.getCheckOut());
                    if (nights <= 0)
                        nights = 1;
                    double totalAmount = nights * reservation.getRoom().getPricePerNight().doubleValue();
                    request.setAttribute("reservation", reservation);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("nights", nights);
                }
            } else {
                request.setAttribute("error", "You do not have access to this bill.");
            }
        }
        request.getRequestDispatcher("/customer-my-bill.jsp").forward(request, response);
    }

    private void showHelp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("DEBUG: Customer Help requested");
        request.getRequestDispatcher("/customer-help.jsp").forward(request, response);
    }

    // --------------------------------------------------------
    // STAFF/ADMIN VIEWS
    // --------------------------------------------------------

    private void showManageBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        com.oceanview.model.User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        List<CustomerBooking> allBookings = bookingDAO.getAllBookings();
        for (CustomerBooking b : allBookings) {
            calculateBookingStats(b);
        }
        List<CustomerBooking> pendingBookings = bookingDAO.getAllPendingBookings();
        for (CustomerBooking b : pendingBookings) {
            calculateBookingStats(b);
        }
        request.setAttribute("allBookings", allBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.getRequestDispatcher("/manage-customer-bookings.jsp").forward(request, response);
    }

    // --------------------------------------------------------
    // POST HANDLERS
    // --------------------------------------------------------

    private void handleBookRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = getLoggedInCustomer(request);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login.jsp");
            return;
        }
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

            CustomerBooking booking = new CustomerBooking();
            booking.setCustomerId(customer.getId());
            booking.setRoomId(roomId);
            booking.setCheckIn(checkIn);
            booking.setCheckOut(checkOut);

            boolean success = bookingDAO.addBooking(booking);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/customer/my-bookings?booked=1");
            } else {
                request.setAttribute("error", "Failed to submit booking. Please try again.");
                showBookingForm(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid inputs. Please check your dates.");
            showBookingForm(request, response);
        }
    }

    private void handleReserveForCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        com.oceanview.model.User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            CustomerBooking booking = bookingDAO.getBookingById(bookingId);

            if (booking == null || !"Pending".equals(booking.getStatus())) {
                request.setAttribute("error", "Booking not found or already processed.");
                showManageBookings(request, response);
                return;
            }

            // Create a formal reservation from the customer booking
            Reservation res = new Reservation();
            res.setGuestName(booking.getCustomerName());
            res.setGuestAddress(booking.getCustomerEmail());
            res.setGuestPhone(booking.getCustomerPhone());
            res.setRoomId(booking.getRoomId());
            res.setCheckIn(booking.getCheckIn());
            res.setCheckOut(booking.getCheckOut());

            boolean resCreated = reservationService.createReservation(res);
            if (resCreated) {
                // Update booking status and link reservation number
                bookingDAO.confirmBooking(bookingId, res.getResNumber());
                response.sendRedirect(request.getContextPath() + "/customer/manage-bookings?reserved=1");
            } else {
                request.setAttribute("error",
                        "Failed to create reservation. Room may be double-booked for those dates.");
                showManageBookings(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing the reservation.");
            showManageBookings(request, response);
        }
    }

    private void handleCancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Both customer and staff can cancel
        HttpSession session = request.getSession(false);
        boolean isCustomer = session != null && session.getAttribute("customer") != null;
        boolean isStaff = session != null && session.getAttribute("user") != null;

        if (!isCustomer && !isStaff) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDAO.cancelBooking(bookingId);

            if (isCustomer) {
                response.sendRedirect(request.getContextPath() + "/customer/my-bookings?cancelled=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/manage-bookings?cancelled=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/dashboard");
        }
    }

    private void calculateBookingStats(CustomerBooking b) {
        if (b.getCheckIn() != null && b.getCheckOut() != null) {
            long nights = java.time.temporal.ChronoUnit.DAYS.between(b.getCheckIn(), b.getCheckOut());
            if (nights <= 0)
                nights = 1;
            b.setNights(nights);
            if (b.getRoom() != null && b.getRoom().getPricePerNight() != null) {
                b.setEstimatedAmount(nights * b.getRoom().getPricePerNight().doubleValue());
            }
        }
    }
}
