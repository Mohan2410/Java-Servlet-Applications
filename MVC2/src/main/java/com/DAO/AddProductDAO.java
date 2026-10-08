package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bean.ProductBean;

public class AddProductDAO {
	public int insertProductData(ProductBean pb) {
		int rowCount = 0;
		try {
			Connection con = DBConnection.getCon();
			PreparedStatement insprodata = con.prepareStatement("insert into product values(?,?,?,?,?)");
			
			insprodata.setString(1,pb.getPcode());
			insprodata.setString(2,pb.getPname());
			insprodata.setString(3, pb.getPcompany());
			insprodata.setString(4, pb.getPprice());
			insprodata.setString(5, pb.getPqty());
			
			
			rowCount = insprodata.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
