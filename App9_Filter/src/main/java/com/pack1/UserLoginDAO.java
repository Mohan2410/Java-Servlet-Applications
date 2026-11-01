package com.pack1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserLoginDAO {
	
	public UserBean retriveData(String uname, String upwd) {
		
		UserBean ub = null;
		
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement pstmt = con.prepareStatement("select * from registration where username = ? and password = ?");
			pstmt.setString(1, uname);
			pstmt.setString(2, upwd);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				ub = new UserBean();
				ub.setUname(rs.getString(1));
				ub.setUpwd(rs.getString(2));
				ub.setUfname(rs.getString(3));
				ub.setUlname(rs.getString(4));
				ub.setUmailid(rs.getString(5));
				ub.setUpnone(rs.getString(6));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ub;
	}

}
