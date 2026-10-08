package com.DAO;

import java.lang.annotation.Retention;
import java.sql.Connection;
import java.sql.PreparedStatement;

//import javax.servlet.annotation.WebServlet;
import javax.swing.plaf.InsetsUIResource;

import com.bean.UserBean;

public class UserRegistrationDAO {
	public int insertUserData(UserBean ub) {
		int rowCount = 0;
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement insusrdata = con.prepareStatement("insert into registration values(?,?,?,?,?,?)");
			
			insusrdata.setString(1, ub.getUname());
			insusrdata.setString(2,ub.getPwd());
			insusrdata.setString(3, ub.getFname());
			insusrdata.setString(4, ub.getLname());
			insusrdata.setString(5, ub.getMailid());
			insusrdata.setString(6, ub.getPhone());
			
			rowCount = insusrdata.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}
	
}
