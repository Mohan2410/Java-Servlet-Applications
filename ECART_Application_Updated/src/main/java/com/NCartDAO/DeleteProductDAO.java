package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteProductDAO {
	public int deleteProduct(String pCode) {
		int rowCount = 0;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in DeleteProductDAO");
			return 0;
		}

		String query = "DELETE FROM product WHERE pcode = ?";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setString(1, pCode);
			rowCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQL error in deleteProduct: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("Unexpected error in deleteProduct: " + e.getMessage());
			e.printStackTrace();
		}
		return rowCount;
	}
}
