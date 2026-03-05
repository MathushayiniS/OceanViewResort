package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private ReservationService reservationService;

    @Override
    public void init() {
        reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "search":
                searchReservation(request, response);
                break;
            case "list":
            default:
                listReservations(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addReservation(request, response);
        } else if ("delete".equals(action)) {
            deleteReservation(request, response);
        }
    }

    private void deleteReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        javax.servlet.http.HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            com.oceanview.model.User user = (com.oceanview.model.User) session.getAttribute("user");
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                String resNumber = request.getParameter("resNumber");
                boolean deleted = reservationService.deleteReservation(resNumber);
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/reservation?action=list&deleted=1");
                    return;
                } else {
                    request.setAttribute("searchError", "Failed to delete reservation " + resNumber);
                }
            } else {
                request.setAttribute("searchError", "You do not have permission to delete reservations.");
            }
        }
        // Fallback or error re-render list
        listReservations(request, response);
    }

    private void addReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String guestName = request.getParameter("guestName");
            String guestAddress = request.getParameter("guestAddress"); // Treat as email for Notification
            String guestPhone = request.getParameter("guestPhone");
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

            Reservation res = new Reservation();
            res.setGuestName(guestName);
            res.setGuestAddress(guestAddress);
            res.setGuestPhone(guestPhone);
            res.setRoomId(roomId);
            res.setCheckIn(checkIn);
            res.setCheckOut(checkOut);

            boolean success = reservationService.createReservation(res);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/reservation?action=list&success=1");
            } else {
                request.setAttribute("error", "Failed to create reservation. The room might be double-booked.");
                request.getRequestDispatcher("/add-reservation.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid inputs or conflicting dates.");
            request.getRequestDispatcher("/add-reservation.jsp").forward(request, response);
        }
    }

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Reservation> list = reservationService.getAllReservations();
        request.setAttribute("reservations", list);
        request.getRequestDispatcher("/manage-reservations.jsp").forward(request, response);
    }

    private void searchReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resNumber = request.getParameter("resNumber");
        Reservation res = reservationService.getReservationValidation(resNumber);
        if (res != null) {
            request.setAttribute("searchResult", res);
        } else {
            request.setAttribute("searchError", "No reservation found with ID: " + resNumber);
        }
        request.getRequestDispatcher("/manage-reservations.jsp").forward(request, response);
    }
}
