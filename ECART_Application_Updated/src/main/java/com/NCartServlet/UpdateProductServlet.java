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
import com.NCartDAO.UpdateProductDAO;
import com.NCartDAO.ViewProductDAO;

@WebServlet("/update")
public class UpdateProductServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("abean") == null) {
			req.setAttribute("errorMessage", "Admin session expired. Please sign in again.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		String pCode = req.getParameter("pcode");
		String pPrice = req.getParameter("pPrice");
		String pQty = req.getParameter("pQty");

		@SuppressWarnings("unchecked")
		ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
		if (al == null) {
			al = new ViewProductDAO().retriveProduct();
			session.setAttribute("productList", al);
		}

		ProductBean matchedBean = null;
		if (al != null && pCode != null) {
			for (ProductBean pb : al) {
				if (pCode.equalsIgnoreCase(pb.getpCode())) {
					matchedBean = pb;
					break;
				}
			}
		}

		if (matchedBean != null) {
			matchedBean.setpPrice(pPrice);
			matchedBean.setpQty(pQty);

			int rowCount = new UpdateProductDAO().updateProduct(matchedBean);
			if (rowCount > 0) {
				req.setAttribute("msg", "Product " + pCode + " updated successfully!");
				req.getRequestDispatcher("UpdateProduct.jsp").forward(req, res);
			} else {
				req.setAttribute("msg", "Failed to update product details. Database error.");
				req.getRequestDispatcher("UpdateProduct.jsp").forward(req, res);
			}
		} else {
			req.setAttribute("msg", "Product " + pCode + " could not be found.");
			req.getRequestDispatcher("UpdateProduct.jsp").forward(req, res);
		}
	}
}
