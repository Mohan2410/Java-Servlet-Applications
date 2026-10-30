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
public class AdminLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String aname = req.getParameter("aname");
		String apwd = req.getParameter("apwd");

		String trimmedAname = aname != null ? aname.trim() : "";

		if (trimmedAname.isEmpty() || apwd == null || apwd.isEmpty()) {
			req.setAttribute("errorMessage", "Please provide both admin username and password.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		AdminBean abean = new AdminLoginDAO().checkAdminLogin(trimmedAname, apwd);

		if (abean == null) {
			req.setAttribute("errorMessage", "Invalid administrator credentials. Access denied.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("abean", abean);
			req.getRequestDispatcher("AdminHome.jsp").forward(req, res);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("AdminLogin.jsp");
	}
}
