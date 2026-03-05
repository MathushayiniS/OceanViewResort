package com.oceanview.dao;

// import com.oceanview.model.Bill;
import com.oceanview.util.DBConnection;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class BillDAO {

    public BigDecimal calculateBill(int reservationId) throws SQLException {
        BigDecimal total = BigDecimal.ZERO;
        String query = "{CALL sp_CalculateBill(?, ?)}";

        Connection conn = DBConnection.getInstance().getConnection();
        CallableStatement stmt = conn.prepareCall(query);
        stmt.setInt(1, reservationId);
        stmt.registerOutParameter(2, Types.DECIMAL);

        stmt.execute();

        total = stmt.getBigDecimal(2);
        return total;
    }
}
