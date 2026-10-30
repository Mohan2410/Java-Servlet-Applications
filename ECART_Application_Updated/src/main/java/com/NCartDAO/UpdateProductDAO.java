package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.NCart.Bean.ProductBean;

public class UpdateProductDAO {
	public int updateProduct(ProductBean pb) {
		int rowCount = 0;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in UpdateProductDAO");
			return 0;
		}

		String query = "UPDATE product SET price = ?, pqty = ? WHERE pcode = ?";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setString(1, pb.getpPrice());
			pstmt.setString(2, pb.getpQty());
			pstmt.setString(3, pb.getpCode());
			rowCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQL error in updateProduct: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("Unexpected error in updateProduct: " + e.getMessage());
			e.printStackTrace();
		}
		return rowCount;
	}
}
