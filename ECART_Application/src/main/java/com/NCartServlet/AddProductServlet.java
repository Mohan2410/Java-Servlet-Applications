package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.ranges.RangeException;

import com.NCart.Bean.ProductBean;
import com.NCartDAO.AddProductDAO;

@WebServlet("/pls")
public class AddProductServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session == null) {
			req.getRequestDispatcher("AdminLogin.html").forward(req, res);
		}else {
			ProductBean pb = new ProductBean();
			pb.setpCode(req.getParameter("pCode"));
			pb.setpName(req.getParameter("pName"));
			pb.setpComp(req.getParameter("pComp"));
			pb.setpPrice(req.getParameter("pPrice"));
			pb.setpQty(req.getParameter("pQty"));
			
			int rowCount = new AddProductDAO().addProduct(pb);
			
			if(rowCount > 0) {
				req.setAttribute("msg", "Product Data Inserted!");
				req.getRequestDispatcher("AddProduct.jsp").forward(req, res);
			}else {
				throw new RuntimeException("Product not inserted");
			}
		}
	}

}
