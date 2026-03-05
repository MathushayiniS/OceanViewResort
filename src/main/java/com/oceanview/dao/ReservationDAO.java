package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean addReservation(Reservation res) throws SQLException {
        boolean rowInserted = false;
        String query = "INSERT INTO reservations (res_number, guest_name, guest_address, guest_phone, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = DBConnection.getInstance().getConnection();
        // Disabling auto-commit if you wanted a transaction, but we will rely on DB
        // trigger for overlap checks
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, res.getResNumber());
        stmt.setString(2, res.getGuestName());
        stmt.setString(3, res.getGuestAddress());
        stmt.setString(4, res.getGuestPhone());
        stmt.setInt(5, res.getRoomId());
        stmt.setDate(6, Date.valueOf(res.getCheckIn()));
        stmt.setDate(7, Date.valueOf(res.getCheckOut()));
        stmt.setString(8, "Confirmed");

        rowInserted = stmt.executeUpdate() > 0;
        return rowInserted;
    }

    public Reservation getReservationByNumber(String resNumber) {
        Reservation res = null;
        String query = "SELECT res.*, r.room_number, r.room_type, r.price_per_night FROM reservations res " +
                "JOIN rooms r ON res.room_id = r.id WHERE res.res_number = ?";

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, resNumber);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                res = new Reservation(
                        rs.getInt("id"),
                        rs.getString("res_number"),
                        rs.getString("guest_name"),
                        rs.getString("guest_address"),
                        rs.getString("guest_phone"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));

                Room room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                res.setRoom(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return res;
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String query = "SELECT res.*, r.room_number, r.room_type, r.price_per_night FROM reservations res JOIN rooms r ON res.room_id = r.id ORDER BY res.check_in DESC";

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Reservation res = new Reservation(
                        rs.getInt("id"),
                        rs.getString("res_number"),
                        rs.getString("guest_name"),
                        rs.getString("guest_address"),
                        rs.getString("guest_phone"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));

                Room room = new Room();
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                res.setRoom(room);

                reservations.add(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }

    public boolean deleteReservation(String resNumber) {
        String query = "DELETE FROM reservations WHERE res_number = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, resNumber);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
