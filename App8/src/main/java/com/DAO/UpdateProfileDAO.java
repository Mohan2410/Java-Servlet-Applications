package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bean.UserBean;

public class UpdateProfileDAO {
	public int updateProfile(UserBean ub) {
		int rowCount = 0;
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement pstms = con.prepareStatement("update registration set FIRSTNAME=?, LASTNAME=?,MAILID=?,PHONE=? where USERNAME=?");
			pstms.setString(1, ub.getFname());
			pstms.setString(2, ub.getLname());
			pstms.setString(3, ub.getMailid());
			pstms.setString(4, ub.getPhone());
			pstms.setString(5, ub.getUname());
			
			rowCount = pstms.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
