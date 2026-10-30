package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.NCart.Bean.ProductBean;

public class UpdateProductServletDAO {

    public int buyProductUpdate(ProductBean pb, int quantity) {
        int rowCount = 0;
        Connection con = DBConnection.getCon();
        if (con == null) {
            System.err.println("Database connection is null in UpdateProductServletDAO");
            return 0;
        }

        String queryPrimary = "UPDATE product SET PQTY = PQTY - ? WHERE PCODE = ? AND PQTY >= ?";
        String queryFallback = "UPDATE product1 SET PQTY = PQTY - ? WHERE PCODE = ? AND PQTY >= ?";

        try {
            rowCount = executeStockUpdate(con, queryPrimary, pb, quantity);
        } catch (SQLException e) {
            if (e.getErrorCode() == 942 || (e.getMessage() != null && e.getMessage().contains("ORA-00942"))) {
                try {
                    rowCount = executeStockUpdate(con, queryFallback, pb, quantity);
                } catch (Exception e2) {
                    e2.printStackTrace();
                }
            } else {
                System.err.println("SQL error updating product stock: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.err.println("Unexpected error updating product stock: " + e.getMessage());
            e.printStackTrace();
        }

        return rowCount;
    }

    private int executeStockUpdate(Connection con, String sql, ProductBean pb, int quantity) throws SQLException {
        int count = 0;
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setString(2, pb.getpCode());
            pstmt.setInt(3, quantity);

            count = pstmt.executeUpdate();

            if (!con.getAutoCommit()) {
                con.commit();
            }
        }
        return count;
    }
}
