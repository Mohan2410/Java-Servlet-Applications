package com.pack1;

//import java.awt.geom.Rectangle2D;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/fs")
public class FactorialServlet extends GenericServlet{
	public void service(ServletRequest req, ServletResponse res) throws IOException, ServletException {
		int number = Integer.parseInt(req.getParameter("num"));
		
		int fact = 1;
		
		for(int i=1;i<=number;i++) {
			fact = fact * i;
		}
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		pw.println("<center><h1>");
		pw.println("The factorial is: "+fact+"<br><br></center>");
		
		RequestDispatcher rd = req.getRequestDispatcher("input.html");
		rd.include(req, res);
	}

}
