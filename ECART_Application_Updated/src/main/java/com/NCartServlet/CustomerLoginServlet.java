package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.CustomerBean;
import com.NCartDAO.CustomerLoginDAO;

@WebServlet("/cls")
public class CustomerLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String cname = req.getParameter("cname");
		String cpwd = req.getParameter("cpwd");

		String trimmedCname = cname != null ? cname.trim() : "";

		// Validation: fields must not be empty
		if (trimmedCname.isEmpty() || cpwd == null || cpwd.isEmpty()) {
			req.setAttribute("errorMessage", "Please enter both username and password.");
			req.setAttribute("enteredUsername", trimmedCname);
			req.getRequestDispatcher("CustomerLogin.jsp").forward(req, res);
			return;
		}

		CustomerBean cbean = new CustomerLoginDAO().checkCustomerLogin(trimmedCname, cpwd);

		if (cbean == null) {
			// Generic message to prevent user enumeration
			req.setAttribute("errorMessage", "Invalid username or password. Please check your credentials and try again.");
			req.setAttribute("enteredUsername", trimmedCname);
			req.getRequestDispatcher("CustomerLogin.jsp").forward(req, res);
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("cbean", cbean);
			req.getRequestDispatcher("CustomerHome.jsp").forward(req, res);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("CustomerLogin.jsp");
	}
}
