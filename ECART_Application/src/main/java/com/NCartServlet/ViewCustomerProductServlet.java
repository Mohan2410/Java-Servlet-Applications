package com.NCartServlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.CustomerBean;
import com.NCart.Bean.ProductBean;
import com.NCartDAO.ViewCustomerProductDAO;

@WebServlet("/view")
public class ViewCustomerProductServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session == null) {
			req.getRequestDispatcher("CustomerLogin.html").forward(req, res);
		}else {
			ArrayList<ProductBean> al = new ViewCustomerProductDAO().retriveCustomerProduct();
			session.setAttribute("productList", al);
			req.getRequestDispatcher("ViewCustomerProduct.jsp").forward(req, res);
		}
	}
}