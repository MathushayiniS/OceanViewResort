package com.oceanview.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Bill {
    private int id;
    private int reservationId;
    private BigDecimal totalAmount;
    private LocalDateTime issuedDate;

    public Bill() {
    }

    public Bill(int id, int reservationId, BigDecimal totalAmount, LocalDateTime issuedDate) {
        this.id = id;
        this.reservationId = reservationId;
        this.totalAmount = totalAmount;
        this.issuedDate = issuedDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(LocalDateTime issuedDate) {
        this.issuedDate = issuedDate;
    }
}
