package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.AdminBean;
import com.NCartDAO.AdminLoginDAO;

@WebServlet("/alog")
public class AdminLoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
		AdminBean abean = new AdminLoginDAO().checkAdminLogin(req.getParameter("aname"), req.getParameter("apwd"));
		
		if(abean == null) {
			req.getRequestDispatcher("AdminLogin.html").forward(req, res);
		}else {
			HttpSession session = req.getSession();
			session.setAttribute("abean", abean);
			req.getRequestDispatcher("AdminHome.jsp").forward(req, res);
		}
	}

}
