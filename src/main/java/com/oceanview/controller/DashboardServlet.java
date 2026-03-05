package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Reservation> allRes = reservationDAO.getAllReservations();
        List<Room> allRooms = roomDAO.getAllRooms();

        long totalBookings = allRes.size();

        long availableRooms = allRooms.stream()
                .filter(r -> "Available".equals(r.getStatus()))
                .count();

        // Mock revenue calculation (sum of confirmed room prices per night)
        // In reality, this would use the BillDAO for accurate sum
        BigDecimal totalRevenue = BigDecimal.ZERO;
        for (Reservation res : allRes) {
            if ("Confirmed".equals(res.getStatus()) && res.getRoom() != null) {
                totalRevenue = totalRevenue.add(res.getRoom().getPricePerNight()); // Simple estimate
            }
        }

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
