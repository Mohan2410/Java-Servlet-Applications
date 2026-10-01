package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.bean.EmpBean;

//import oracle.jdbc.driver.parser.util.Array;

public class ViewEmpDAO {
	
	ArrayList<EmpBean> al = new ArrayList<EmpBean>();
	
	public ArrayList<EmpBean> getEmpData(){
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement pstmt = con.prepareStatement("select * from employee");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EmpBean eb = new EmpBean();
				eb.setEmpId(rs.getString(1));
				eb.setEmpFname(rs.getString(2));
				eb.setEmpLname(rs.getString(3));
				eb.setEmpSal(rs.getInt(4));
				eb.setEmpAddr(rs.getString(5));
				
				al.add(eb);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return al;
	}

}
