package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.BillingService;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private BillingService billingService;
    private ReservationService reservationService;

    @Override
    public void init() {
        billingService = new BillingService();
        reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resNumber = request.getParameter("resNumber");

        if (resNumber != null && !resNumber.isEmpty()) {
            Reservation res = reservationService.getReservationValidation(resNumber);

            if (res != null) {
                // Calculate bill via stored procedure
                BigDecimal totalAmount = billingService.calculateTotalBill(res.getId());

                request.setAttribute("reservation", res);
                request.setAttribute("totalAmount", totalAmount);
            } else {
                request.setAttribute("error", "Reservation not found.");
            }
        }

        request.getRequestDispatcher("/bill.jsp").forward(request, response);
    }
}
