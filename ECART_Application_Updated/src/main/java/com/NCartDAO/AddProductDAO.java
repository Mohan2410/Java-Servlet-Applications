package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.NCart.Bean.ProductBean;

public class AddProductDAO {

	/**
	 * Inserts a product into Oracle database.
	 * Returns:
	 *  > 0 : success (number of rows inserted, typically 1)
	 *   -1 : duplicate product code (unique constraint violation)
	 *    0 : insert failed or DB unavailable
	 */
	public int addProduct(ProductBean pb) {
		int rowCount = 0;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in AddProductDAO");
			return 0;
		}

		String query = "INSERT INTO product VALUES(?,?,?,?,?)";
		String queryFallback = "INSERT INTO product1 VALUES(?,?,?,?,?)";

		try {
			rowCount = executeInsert(con, query, pb);
		} catch (SQLException e) {
			if (e.getErrorCode() == 1 || (e.getMessage() != null && e.getMessage().contains("ORA-00001"))) {
				System.err.println("Duplicate product code in AddProductDAO: " + pb.getpCode());
				return -1;
			}
			// If table 'product' doesn't exist (ORA-00942), try fallback to 'product1'
			if (e.getErrorCode() == 942 || (e.getMessage() != null && e.getMessage().contains("ORA-00942"))) {
				try {
					rowCount = executeInsert(con, queryFallback, pb);
				} catch (SQLException e2) {
					if (e2.getErrorCode() == 1 || (e2.getMessage() != null && e2.getMessage().contains("ORA-00001"))) {
						return -1;
					}
					e2.printStackTrace();
				}
			} else {
				System.err.println("SQL error in addProduct: " + e.getMessage());
				e.printStackTrace();
			}
		} catch (Exception e) {
			System.err.println("Unexpected error in addProduct: " + e.getMessage());
			e.printStackTrace();
		}

		return rowCount;
	}

	private int executeInsert(Connection con, String sql, ProductBean pb) throws SQLException {
		int count = 0;
		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, pb.getpCode());
			pstmt.setString(2, pb.getpName());
			pstmt.setString(3, pb.getpComp());
			pstmt.setString(4, pb.getpPrice());
			pstmt.setString(5, pb.getpQty());

			count = pstmt.executeUpdate();

			// Ensure transaction is committed if auto-commit is disabled
			if (!con.getAutoCommit()) {
				con.commit();
			}
		}
		return count;
	}
}
