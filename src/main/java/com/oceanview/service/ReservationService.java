package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.util.EmailUtil;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

public class ReservationService {

    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
        this.roomDAO = new RoomDAO();
    }

    public List<Room> getAvailableRooms(String checkIn, String checkOut) {
        return roomDAO.getAvailableRooms(checkIn, checkOut);
    }

    public boolean createReservation(Reservation res) {
        try {
            // Generate unique reservation number
            String resNumber = "RES-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            res.setResNumber(resNumber);

            boolean success = reservationDAO.addReservation(res);

            // Send confirmation email asynchronously if successful
            if (success && res.getGuestAddress() != null && res.getGuestAddress().contains("@")) {
                EmailUtil.sendConfirmationEmail(res.getGuestAddress(), resNumber, res.getGuestName());
            }

            return success;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public Reservation getReservationValidation(String resNumber) {
        return reservationDAO.getReservationByNumber(resNumber);
    }

    public boolean deleteReservation(String resNumber) {
        return reservationDAO.deleteReservation(resNumber);
    }
}
