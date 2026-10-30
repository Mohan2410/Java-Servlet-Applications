package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.NCart.Bean.ProductBean;

public class UpdateProductServletDAO {

    public int buyProductUpdate(ProductBean pb, int quantity) {

        int rowCount = 0;

        try {
            Connection con = DBConnection.getCon();

            String query = "UPDATE product "
                         + "SET PQTY = PQTY - ? "
                         + "WHERE PCODE = ? AND PQTY >= ?";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setInt(1, quantity);
            pstmt.setString(2, pb.getpCode());
            pstmt.setInt(3, quantity);

            rowCount = pstmt.executeUpdate();

            pstmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowCount;
    }
}