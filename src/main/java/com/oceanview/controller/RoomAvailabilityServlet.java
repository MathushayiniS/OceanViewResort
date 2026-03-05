package com.oceanview.controller;

import com.google.gson.Gson;
import com.oceanview.model.Room;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/rooms/available")
public class RoomAvailabilityServlet extends HttpServlet {

    private ReservationService reservationService;

    @Override
    public void init() {
        reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        if (checkIn != null && checkOut != null && !checkIn.isEmpty() && !checkOut.isEmpty()) {
            List<Room> availableRooms = reservationService.getAvailableRooms(checkIn, checkOut);
            String json = new Gson().toJson(availableRooms);
            out.print(json);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Check-in and check-out dates are required\"}");
        }
        out.flush();
    }
}
