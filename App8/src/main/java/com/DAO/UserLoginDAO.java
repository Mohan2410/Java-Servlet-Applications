package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.bean.UserBean;

public class UserLoginDAO 
{
	public UserBean checkLogin(String username,String password) {
			UserBean ub = null;
		try 
		{
			
			Connection con = DBConnection.getCon();
			PreparedStatement pstmt = con.prepareStatement("select * from registration where username=? and password=?");
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) 
			{
				ub = new UserBean();
				
				ub.setUname(rs.getString(1));
				ub.setPwd(rs.getString(2));
				ub.setFname(rs.getString(3));
				ub.setLname(rs.getString(4));
				ub.setMailid(rs.getString(5));
				ub.setPhone(rs.getString(6));
			}
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}	
		return ub;
	}
	
	
}