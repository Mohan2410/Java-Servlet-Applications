package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.CustomerBean;
import com.NCartDAO.CustomerRegisterDAO;

@WebServlet("/crs")
public class CustomerRegistrationServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			CustomerBean cb = new CustomerBean();
			cb.setCuname(req.getParameter("cuname"));
			cb.setCpwd(req.getParameter("cpwd"));
			cb.setCfname(req.getParameter("cfname"));
			cb.setClname(req.getParameter("clname"));
			cb.setCaddr(req.getParameter("caddr"));
			cb.setCmailid(req.getParameter("cmailid"));
			cb.setCmobile(req.getParameter("cmobile"));
			
			int rowCount = new CustomerRegisterDAO().checkCustomerRegistration(cb);

			if (rowCount > 0) {
			    HttpSession session = req.getSession();
			    session.setAttribute("cbean", cb);
			    req.setAttribute("msg", "New Customer Added");
			    req.getRequestDispatcher("CustomerHome.jsp").forward(req, res);

			} else {
			    throw new RuntimeException("Customer not added");
			}
	}

}
