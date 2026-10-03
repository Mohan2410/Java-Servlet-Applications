package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bean.EmpBean;

public class AddEmpDAO {
	public int insertEmpData(EmpBean eb) {
		int rowCount = 0;
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement insdata = con.prepareStatement("insert into employee values(?,?,?,?,?)");
			
			insdata.setString(1,eb.getEmpid());
			insdata.setString(2, eb.getEmpfname());
			insdata.setString(3, eb.getEmplname());
			insdata.setInt(4, eb.getEsal());
			insdata.setString(5, eb.getEaddr());
			
			rowCount = insdata.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
