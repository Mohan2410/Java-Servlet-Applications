package com.pack1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/ed")
public class EmpServlet extends GenericServlet{
	
	@Override
	public void service(ServletRequest req, ServletResponse res) throws IOException {
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		String emp_name = req.getParameter("ename");
		String emp_id = req.getParameter("empid");
		double emp_sal = Double.parseDouble(req.getParameter("esal"));
		int emp_exp = Integer.parseInt(req.getParameter("exp"));
		
		System.out.println("EmpName: "+emp_name);
		System.out.println("EmpId: "+emp_id);
		System.out.println("EmpSal: "+emp_sal);
		System.out.println("EmpExp: "+emp_exp);
		
		if(emp_exp >= 5) {
			emp_sal = emp_sal + emp_sal*0.1;
		}
		pw.println("<center><br><br>");
		pw.println("EmpName: "+emp_name+"<br><br>");
		pw.println("EmpId: "+emp_id+"<br><br>");
		pw.println("EmpSal: "+emp_sal+"<br><br>");
		pw.println("EmpExp: "+emp_exp+"<br><br>");
		
	}

}
