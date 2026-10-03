package com.servlet;

import java.awt.Robot;
import java.io.IOException;

import javax.management.RuntimeErrorException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.AddEmpDAO;
import com.bean.EmpBean;

@WebServlet("/aes")
public class AddEmpServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		EmpBean eb = new EmpBean();
		
		eb.setEmpid(req.getParameter("eid"));
		eb.setEmpfname(req.getParameter("efname"));
		eb.setEmplname(req.getParameter("elname"));
		eb.setEsal(Integer.parseInt(req.getParameter("esal")));
		eb.setEaddr(req.getParameter("eaddr"));
		
		int rowCount = new AddEmpDAO().insertEmpData(eb);
		if(rowCount <= 0) {
			throw new RuntimeException("Data Not Inserted");
		}else {
			req.setAttribute("msg", "Employee Data Inserted");
			req.getRequestDispatcher("AddEmployee.jsp").forward(req, res);
//			System.out.println("Data Inserted");
		}
	}

}
