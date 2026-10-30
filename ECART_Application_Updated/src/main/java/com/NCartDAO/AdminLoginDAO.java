package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.NCart.Bean.AdminBean;

public class AdminLoginDAO {
	public AdminBean checkAdminLogin(String username, String password) {
		AdminBean abean = null;
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in AdminLoginDAO");
			return null;
		}

		String query = "SELECT uname, pword, fname, lname, addr, mid, phno FROM admin WHERE uname = ? AND pword = ?";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setString(1, username);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					abean = new AdminBean();
					abean.setaUNAME(rs.getString(1));
					abean.setaPWORD(rs.getString(2));
					abean.setaFNAME(rs.getString(3));
					abean.setaLNAME(rs.getString(4));
					abean.setaADDR(rs.getString(5));
					abean.setaMID(rs.getString(6));
					abean.setaPHNO(rs.getString(7));
				}
			}
		} catch (SQLException e) {
			System.err.println("SQL error during admin login: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.err.println("Unexpected error during admin login: " + e.getMessage());
			e.printStackTrace();
		}
		return abean;
	}
}
