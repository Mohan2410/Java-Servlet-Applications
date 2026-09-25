package com.pack1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/productServlet")
public class ProductServlet extends GenericServlet{
	@Override
	public void service(ServletRequest req, ServletResponse res)throws IOException {
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		String p_name = req.getParameter("pname");
		String p_id = req.getParameter("pid");
		int p_quantity = Integer.parseInt(req.getParameter("pqnty"));
		double p_price = Double.parseDouble(req.getParameter("price"));
		
		System.out.println("Product Name: "+p_name);
		System.out.println("p_id"+p_id);
		System.out.println("Product Quality: "+p_quantity);
		System.out.println("Product Price: "+p_price);
		
		if(p_quantity <= 5) {
			p_price = p_price + p_price*0.1;
		}
		pw.println("<center><br><br>");
		pw.println("***PRODUCT DETAILS***"+"<br><br>");
		pw.println("Product Name: "+p_name+"<br><br>");
		pw.println("Product Id: "+p_id+"<br><br>");
		pw.println("Product Quantity: "+p_quantity+"<br><br>");
		pw.println("Product Price: "+p_price+"<br><br>");
		
	}

}
