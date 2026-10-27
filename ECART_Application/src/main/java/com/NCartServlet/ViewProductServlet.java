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
public class ViewProductServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if(session == null) {
			req.getRequestDispatcher("AdminLogin.html").forward(req, res);
		}else {
			ArrayList<ProductBean> al = new ViewProductDAO().retriveProduct();
			session.setAttribute("productList",al);
			req.getRequestDispatcher("ViewProduct.jsp").forward(req, res);
		}
	}

}
