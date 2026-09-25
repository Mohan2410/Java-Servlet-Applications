package com.pack1;

import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/loginServlet")
public class LoginServlet extends GenericServlet{
	
	@Override
	public void service(ServletRequest req, ServletResponse res) throws IOException{
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		String u_name = req.getParameter("uname");
		String pass = req.getParameter("pwd");
		
		System.out.println("UserName: "+u_name);
		System.out.println("Password: "+pass);
		
		if(u_name.equals("mohan24") && pass.equals("java is awesome")) {
			pw.println("Welcome "+u_name);
			pw.println("You did the Task!");
		}else {
			pw.println("Welcome "+u_name);
			pw.println("Invalid Credential!!");
		}
		
		
	}

}
