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

@WebServlet("/edit")
public class EditProductServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("abean") == null) {
			req.setAttribute("errorMessage", "Admin session expired. Please sign in again.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		String pCode = req.getParameter("pcode");
		ProductBean matchedBean = null;

		@SuppressWarnings("unchecked")
		ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
		if (al == null || al.isEmpty()) {
			al = new ViewProductDAO().retriveProduct();
			session.setAttribute("productList", al);
		}

		if (al != null && pCode != null) {
			for (ProductBean pb : al) {
				if (pCode.equalsIgnoreCase(pb.getpCode())) {
					matchedBean = pb;
					break;
				}
			}
		}

		if (matchedBean != null) {
			req.setAttribute("productBean", matchedBean);
			req.getRequestDispatcher("EditProduct.jsp").forward(req, res);
		} else {
			req.setAttribute("msg", "Product with code " + pCode + " not found.");
			req.getRequestDispatcher("ViewProduct.jsp").forward(req, res);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
