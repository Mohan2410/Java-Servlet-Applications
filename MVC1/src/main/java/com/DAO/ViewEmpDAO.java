package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.bean.EmpBean;

public class ViewEmpDAO {
	
	
	public ArrayList<EmpBean> getEmpData() {
		ArrayList<EmpBean> al = new ArrayList<EmpBean>();
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement viewData = con.prepareStatement("select * from employee");
			ResultSet rs = viewData.executeQuery();
			
			while(rs.next()) {
				EmpBean eb = new EmpBean();
				eb.setEmpid(rs.getString(1));
				eb.setEmpfname(rs.getString(2));
				eb.setEmplname(rs.getString(3));
				eb.setEsal(rs.getInt(4));
				eb.setEaddr(rs.getString(5));
				
				al.add(eb);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return al;
		
	}

}
