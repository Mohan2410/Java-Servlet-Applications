package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.NCart.Bean.CustomerBean;

public class CustomerRegisterDAO {
	public int checkCustomerRegistration(CustomerBean cb) {
		int rowCount = 0;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in CustomerRegisterDAO");
			return 0;
		}

		String sql = "INSERT INTO customer1 VALUES(?,?,?,?,?,?,?)";
		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, cb.getCuname());
			pstmt.setString(2, cb.getCpwd());
			pstmt.setString(3, cb.getCfname());
			pstmt.setString(4, cb.getClname());
			pstmt.setString(5, cb.getCaddr());
			pstmt.setString(6, cb.getCmailid());
			pstmt.setString(7, cb.getCmobile());

			rowCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQL Error during customer registration: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("Unexpected error during customer registration: " + e.getMessage());
			e.printStackTrace();
		}
		return rowCount;
	}
}
