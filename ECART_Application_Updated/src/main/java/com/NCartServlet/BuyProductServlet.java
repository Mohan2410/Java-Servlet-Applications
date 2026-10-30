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

@WebServlet("/buy")
public class BuyProductServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("cbean") == null) {
			req.setAttribute("errorMessage", "Your session has expired. Please sign in to purchase products.");
			req.getRequestDispatcher("CustomerLogin.jsp").forward(req, res);
			return;
		}

		String pCode = req.getParameter("pcode");
		if (pCode == null || pCode.trim().isEmpty()) {
			req.setAttribute("msg", "Invalid product selection. Please choose a product from the list.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		pCode = pCode.trim();

		@SuppressWarnings("unchecked")
		ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
		if (al == null || al.isEmpty()) {
			// Refresh from database if session list was cleared
			al = new ViewCustomerProductDAO().retriveCustomerProduct();
			session.setAttribute("productList", al);
		}

		ProductBean matchedBean = null;
		if (al != null) {
			for (ProductBean item : al) {
				if (item.getpCode() != null && item.getpCode().equalsIgnoreCase(pCode)) {
					matchedBean = item;
					break;
				}
			}
		}

		if (matchedBean == null) {
			req.setAttribute("msg", "The selected product (Code: " + pCode + ") was not found in the catalog.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		req.setAttribute("productBean", matchedBean);
		req.getRequestDispatcher("BuyProduct.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
