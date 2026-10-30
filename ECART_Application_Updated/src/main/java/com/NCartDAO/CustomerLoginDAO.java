package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.NCart.Bean.CustomerBean;

public class CustomerLoginDAO {
	public CustomerBean checkCustomerLogin(String username, String password) {
		CustomerBean cbean = null;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in CustomerLoginDAO");
			return null;
		}

		String sql = "SELECT uname, pword, fname, lname, addr, mid, phno FROM customer1 WHERE uname = ? AND pword = ?";
		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, username);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					cbean = new CustomerBean();
					cbean.setCuname(rs.getString(1));
					cbean.setCpwd(rs.getString(2));
					cbean.setCfname(rs.getString(3));
					cbean.setClname(rs.getString(4));
					cbean.setCaddr(rs.getString(5));
					cbean.setCmailid(rs.getString(6));
					cbean.setCmobile(rs.getString(7));
				}
			}
		} catch (SQLException e) {
			System.err.println("SQL Error during customer login: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("Unexpected error during customer login: " + e.getMessage());
			e.printStackTrace();
		}
		return cbean;
	}
}
