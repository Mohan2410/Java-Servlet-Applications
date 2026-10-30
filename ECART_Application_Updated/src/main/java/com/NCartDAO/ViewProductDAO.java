package com.NCartDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.NCart.Bean.ProductBean;

public class ViewProductDAO {

	public ArrayList<ProductBean> retriveProduct() {
		ArrayList<ProductBean> al = new ArrayList<>();
		Connection con = DBConnection.getCon();
		if (con == null) {
			System.err.println("Database connection is null in ViewProductDAO");
			return al;
		}

		String sqlPrimary = "SELECT * FROM product";
		String sqlFallback = "SELECT * FROM product1";

		try {
			al = fetchProducts(con, sqlPrimary);
		} catch (SQLException e) {
			if (e.getErrorCode() == 942 || (e.getMessage() != null && e.getMessage().contains("ORA-00942"))) {
				try {
					al = fetchProducts(con, sqlFallback);
				} catch (Exception e2) {
					System.err.println("Error in fallback table product1: " + e2.getMessage());
					e2.printStackTrace();
				}
			} else {
				System.err.println("SQL error retrieving products: " + e.getMessage());
				e.printStackTrace();
			}
		} catch (Exception e) {
			System.err.println("Unexpected error retrieving products: " + e.getMessage());
			e.printStackTrace();
		}

		return al;
	}

	private ArrayList<ProductBean> fetchProducts(Connection con, String sql) throws SQLException {
		ArrayList<ProductBean> list = new ArrayList<>();
		try (PreparedStatement pstmt = con.prepareStatement(sql);
		     ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				ProductBean pb = new ProductBean();
				pb.setpCode(rs.getString(1));
				pb.setpName(rs.getString(2));
				pb.setpComp(rs.getString(3));
				pb.setpPrice(rs.getString(4));
				pb.setpQty(rs.getString(5));
				list.add(pb);
			}
		}
		return list;
	}
}
