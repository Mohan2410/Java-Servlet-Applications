package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.AddProductDAO;
import com.bean.ProductBean;

@WebServlet("/aps")
public class AddProductServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ProductBean pb = new ProductBean();
		
		pb.setPcode(req.getParameter("pcode"));
		pb.setPname(req.getParameter("pname"));
		pb.setPcompany(req.getParameter("pcompany"));
		pb.setPprice(req.getParameter("pprice"));
		pb.setPqty(req.getParameter("pqty"));
		
		int rowCount = new AddProductDAO().insertProductData(pb);
		if(rowCount <= 0) {
			throw new RuntimeException("Data Not inserted");
		}else {
			req.setAttribute("msg", "Product data Inserted");
			req.getRequestDispatcher("AddProduct.jsp").forward(req, res);
			
		}
	}

}
