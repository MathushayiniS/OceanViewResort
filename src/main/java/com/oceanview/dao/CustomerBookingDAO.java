package com.oceanview.dao;

import com.oceanview.model.CustomerBooking;
import com.oceanview.model.Room;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerBookingDAO {

    /** Customer requests a booking (status = Pending) */
    public boolean addBooking(CustomerBooking booking) {
        String query = "INSERT INTO customer_bookings (customer_id, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, 'Pending')";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, booking.getCustomerId());
            stmt.setInt(2, booking.getRoomId());
            stmt.setDate(3, Date.valueOf(booking.getCheckIn()));
            stmt.setDate(4, Date.valueOf(booking.getCheckOut()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Get all bookings for a specific customer (with room join) */
    public List<CustomerBooking> getBookingsByCustomer(int customerId) {
        List<CustomerBooking> list = new ArrayList<>();
        String query = "SELECT cb.*, r.room_number, r.room_type, r.price_per_night, cb.res_number " +
                "FROM customer_bookings cb JOIN rooms r ON cb.room_id = r.id " +
                "WHERE cb.customer_id = ? ORDER BY cb.check_in DESC";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CustomerBooking b = new CustomerBooking(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));
                Room room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                b.setRoom(room);
                b.setResNumber(rs.getString("res_number"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Get ALL pending bookings (for staff/admin) with customer info */
    public List<CustomerBooking> getAllPendingBookings() {
        List<CustomerBooking> list = new ArrayList<>();
        String query = "SELECT cb.*, r.room_number, r.room_type, r.price_per_night, " +
                "c.full_name, c.email, c.phone " +
                "FROM customer_bookings cb " +
                "JOIN rooms r ON cb.room_id = r.id " +
                "JOIN customers c ON cb.customer_id = c.id " +
                "WHERE cb.status = 'Pending' ORDER BY cb.check_in ASC";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                CustomerBooking b = new CustomerBooking(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));
                Room room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                b.setRoom(room);
                b.setCustomerName(rs.getString("full_name"));
                b.setCustomerEmail(rs.getString("email"));
                b.setCustomerPhone(rs.getString("phone"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Get ALL bookings (staff/admin) with customer info */
    public List<CustomerBooking> getAllBookings() {
        List<CustomerBooking> list = new ArrayList<>();
        String query = "SELECT cb.*, r.room_number, r.room_type, r.price_per_night, " +
                "c.full_name, c.email, c.phone, cb.res_number " +
                "FROM customer_bookings cb " +
                "JOIN rooms r ON cb.room_id = r.id " +
                "JOIN customers c ON cb.customer_id = c.id " +
                "ORDER BY cb.check_in DESC";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                CustomerBooking b = new CustomerBooking(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));
                Room room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                b.setRoom(room);
                b.setCustomerName(rs.getString("full_name"));
                b.setCustomerEmail(rs.getString("email"));
                b.setCustomerPhone(rs.getString("phone"));
                b.setResNumber(rs.getString("res_number"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Staff/Admin confirms a booking → updates status and store res_number */
    public boolean confirmBooking(int bookingId, String resNumber) {
        String query = "UPDATE customer_bookings SET status = 'Reserved', res_number = ? WHERE id = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, resNumber);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Cancel a booking */
    public boolean cancelBooking(int bookingId) {
        String query = "UPDATE customer_bookings SET status = 'Cancelled' WHERE id = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Get booking by ID */
    public CustomerBooking getBookingById(int bookingId) {
        String query = "SELECT cb.*, r.room_number, r.room_type, r.price_per_night, " +
                "c.full_name, c.email, c.phone " +
                "FROM customer_bookings cb " +
                "JOIN rooms r ON cb.room_id = r.id " +
                "JOIN customers c ON cb.customer_id = c.id " +
                "WHERE cb.id = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CustomerBooking b = new CustomerBooking(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getInt("room_id"),
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate(),
                        rs.getString("status"));
                Room room = new Room();
                room.setId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getBigDecimal("price_per_night"));
                b.setRoom(room);
                b.setCustomerName(rs.getString("full_name"));
                b.setCustomerEmail(rs.getString("email"));
                b.setCustomerPhone(rs.getString("phone"));
                return b;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
