package com.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ViewProductDAO;
import com.bean.ProductBean;

@WebServlet("/view")
public class ViewProductServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ArrayList<ProductBean> pb = new ViewProductDAO().getProductData();
		
		req.setAttribute("data", pb);
		req.getRequestDispatcher("ViewProduct.jsp").forward(req, res);
	}

}
