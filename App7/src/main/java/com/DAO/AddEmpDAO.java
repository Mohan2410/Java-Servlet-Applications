package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bean.EmpBean;

public class AddEmpDAO {
	public int insertEmpData(EmpBean eb) {
		int rowCount = 0;
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement pstmt = con.prepareStatement("insert into employee values(?,?,?,?,?)");
			
			pstmt.setString(1, eb.getEmpId());
			pstmt.setString(2, eb.getEmpFname());
			pstmt.setString(3,eb.getEmpLname());
			pstmt.setInt(4,eb.getEmpSal());
			pstmt.setString(5, eb.getGetAddr());
			
			rowCount = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
