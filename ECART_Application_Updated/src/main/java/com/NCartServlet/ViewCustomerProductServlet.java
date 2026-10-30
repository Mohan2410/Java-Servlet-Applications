package com.NCartServlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.ProductBean;
import com.NCartDAO.ViewCustomerProductDAO;

@WebServlet("/view")
public class ViewCustomerProductServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("cbean") == null) {
			req.setAttribute("errorMessage", "Your session has expired or you are not logged in. Please sign in.");
			req.getRequestDispatcher("CustomerLogin.jsp").forward(req, res);
			return;
		}

		ArrayList<ProductBean> al = new ViewCustomerProductDAO().retriveCustomerProduct();
		session.setAttribute("productList", al);
		req.getRequestDispatcher("ViewCustomerProduct.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
