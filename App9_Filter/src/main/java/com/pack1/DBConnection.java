package com.pack1;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static Connection con = null;
	static {
		try {
			Class.forName(DBInfo.driver);
			con = DriverManager.getConnection(DBInfo.dburl,DBInfo.dbuname,DBInfo.dbpwd);
			System.out.println("Database connected successfully");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	public static Connection getCon() {
		return con;
	}
}


