package com.oceanview.model;

import java.time.LocalDate;

public class Reservation {
    private int id;
    private String resNumber;
    private String guestName;
    private String guestAddress;
    private String guestPhone;
    private int roomId;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private String status;

    // Joined property
    private Room room;

    public Reservation() {
    }

    public Reservation(int id, String resNumber, String guestName, String guestAddress, String guestPhone,
            int roomId, LocalDate checkIn, LocalDate checkOut, String status) {
        this.id = id;
        this.resNumber = resNumber;
        this.guestName = guestName;
        this.guestAddress = guestAddress;
        this.guestPhone = guestPhone;
        this.roomId = roomId;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getResNumber() {
        return resNumber;
    }

    public void setResNumber(String resNumber) {
        this.resNumber = resNumber;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getGuestAddress() {
        return guestAddress;
    }

    public void setGuestAddress(String guestAddress) {
        this.guestAddress = guestAddress;
    }

    public String getGuestPhone() {
        return guestPhone;
    }

    public void setGuestPhone(String guestPhone) {
        this.guestPhone = guestPhone;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public LocalDate getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(LocalDate checkIn) {
        this.checkIn = checkIn;
    }

    public LocalDate getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(LocalDate checkOut) {
        this.checkOut = checkOut;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
