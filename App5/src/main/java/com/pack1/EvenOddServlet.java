package com.pack1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/es")
public class EvenOddServlet extends GenericServlet{
	
	public void service(ServletRequest req, ServletResponse res) throws IOException, ServletException {
		int number = Integer.parseInt(req.getParameter("num"));
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		pw.println("<center><h1>");
		
		if(number % 2 == 0) {
			pw.println(number+" is Even Number");
		}else {
			pw.println(number+ " is Odd Number");
		}
		
		pw.println("</center></h1>");
		
		RequestDispatcher rd = req.getRequestDispatcher("input.html");
		rd.include(req,res);
	}

}
