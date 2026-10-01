package com.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ViewEmpDAO;
import com.bean.EmpBean;

@WebServlet("/view")
public class ViewEmployeeServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException {
		ArrayList<EmpBean> al = new ViewEmpDAO().getEmpData();
		
		req.setAttribute("data",al);
		
		req.getRequestDispatcher("ViewEmployee.jsp").forward(req, res);
	}

}
