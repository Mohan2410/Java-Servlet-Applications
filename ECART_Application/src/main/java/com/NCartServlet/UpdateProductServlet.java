package com.NCartServlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.AdminBean;
import com.NCart.Bean.ProductBean;
import com.NCartDAO.UpdateProductDAO;

@WebServlet("/update")
public class UpdateProductServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);

		if(session == null) {
			req.getRequestDispatcher("AdminLogin.html").forward(req, res);
		}else {
			String pCode = req.getParameter("pcode");
			ProductBean pb = null;
			ArrayList<ProductBean> al = (ArrayList<ProductBean>)session.getAttribute("productList");
			Iterator<ProductBean> i = al.iterator();
			while(i.hasNext()) {
				pb = i.next();
				if(pCode.equals(pb.getpCode())) {
					break;
				}
			}
			pb.setpPrice(req.getParameter("pPrice"));
			pb.setpQty(req.getParameter("pQty"));
			int rowCount = new UpdateProductDAO().updateProduct(pb);
			if(rowCount > 0) {
				req.setAttribute("msg", "Product Data Updated!!!");
				req.getRequestDispatcher("UpdateProduct.jsp").forward(req, res);
			}
//			}else {
//			    req.setAttribute("msg", "Product Data Not Updated!!!");
//			}
			
		}
	}
}
