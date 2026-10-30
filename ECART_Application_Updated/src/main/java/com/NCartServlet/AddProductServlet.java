package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.ProductBean;
import com.NCartDAO.AddProductDAO;

@WebServlet("/pls")
public class AddProductServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("abean") == null) {
			req.setAttribute("errorMessage", "Admin session expired. Please sign in again.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		String pCode = req.getParameter("pCode");
		String pName = req.getParameter("pName");
		String pComp = req.getParameter("pComp");
		String pPrice = req.getParameter("pPrice");
		String pQty = req.getParameter("pQty");

		if (pCode == null || pCode.trim().isEmpty() || pName == null || pName.trim().isEmpty() ||
				pComp == null || pComp.trim().isEmpty() || pPrice == null || pPrice.trim().isEmpty() ||
				pQty == null || pQty.trim().isEmpty()) {
			req.setAttribute("msg", "All product fields are required.");
			req.getRequestDispatcher("AddProduct.jsp").forward(req, res);
			return;
		}

		ProductBean pb = new ProductBean();
		pb.setpCode(pCode.trim());
		pb.setpName(pName.trim());
		pb.setpComp(pComp.trim());
		pb.setpPrice(pPrice.trim());
		pb.setpQty(pQty.trim());

		int rowCount = new AddProductDAO().addProduct(pb);

		if (rowCount > 0) {
			req.setAttribute("msg", "Product added successfully to catalog!");
		} else {
			req.setAttribute("msg", "Product could not be added. Product code might already exist or database is unavailable.");
		}
		req.getRequestDispatcher("AddProduct.jsp").forward(req, res);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("AddProduct.html");
	}
}
