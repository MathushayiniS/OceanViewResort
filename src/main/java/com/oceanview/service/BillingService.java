package com.oceanview.service;

import com.oceanview.dao.BillDAO;
import java.math.BigDecimal;
import java.sql.SQLException;

public class BillingService {

    private BillDAO billDAO;

    public BillingService() {
        this.billDAO = new BillDAO();
    }

    public BigDecimal calculateTotalBill(int reservationId) {
        try {
            return billDAO.calculateBill(reservationId);
        } catch (SQLException e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }
}
