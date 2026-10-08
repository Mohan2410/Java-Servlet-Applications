package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.UserRegistrationDAO;
import com.bean.UserBean;


@WebServlet("/reg")
public class UserRegistrationServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		UserBean ub = new UserBean();
		
		ub.setUname(req.getParameter("uname"));
		ub.setPwd(req.getParameter("pwd"));
		ub.setFname(req.getParameter("fname"));
		ub.setLname(req.getParameter("lname"));
		ub.setMailid(req.getParameter("mailid"));
		ub.setPhone(req.getParameter("phone"));
		
		int rowCount = new UserRegistrationDAO().insertUserData(ub);
		if(rowCount == 0) {
			throw new RuntimeException("User Data insertion Failed");
		}else {
			req.setAttribute("msg", "User Registered!!!");
			req.getRequestDispatcher("Register.jsp").forward(req, res);
		}
	}

}
