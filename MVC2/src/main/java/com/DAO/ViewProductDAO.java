package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.bean.ProductBean;

public class ViewProductDAO {
	public ArrayList<ProductBean> getProductData(){
		ArrayList<ProductBean> al = new ArrayList<ProductBean>();	
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement viewData = con.prepareStatement("select * from product");
			ResultSet rs = viewData.executeQuery();
			
			while(rs.next()) {
				ProductBean pb = new ProductBean();
				pb.setPcode(rs.getString(1));
				pb.setPname(rs.getString(2));
				pb.setPcompany(rs.getString(3));
				pb.setPprice(rs.getString(4));
				pb.setPqty(rs.getString(5));
				
				al.add(pb);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return al;
	}
}
