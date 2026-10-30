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
import com.NCartDAO.ViewProductDAO;

@WebServlet("/view1")
public class ViewProductServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("abean") == null) {
			req.setAttribute("errorMessage", "Admin session expired. Please sign in again.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		ArrayList<ProductBean> al = new ViewProductDAO().retriveProduct();
		session.setAttribute("productList", al);
		req.getRequestDispatcher("ViewProduct.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
