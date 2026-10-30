package com.NCartServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCartDAO.DeleteProductDAO;

@WebServlet("/delete")
public class DeleteProductServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("abean") == null) {
			req.setAttribute("errorMessage", "Admin session expired. Please sign in again.");
			req.getRequestDispatcher("AdminLogin.jsp").forward(req, res);
			return;
		}

		String pCode = req.getParameter("pcode");
		if (pCode != null && !pCode.trim().isEmpty()) {
			int rowCount = new DeleteProductDAO().deleteProduct(pCode.trim());
			if (rowCount > 0) {
				req.setAttribute("msg", "Product (" + pCode + ") has been deleted successfully.");
			} else {
				req.setAttribute("msg", "Could not delete product (" + pCode + "). Product may not exist.");
			}
		} else {
			req.setAttribute("msg", "Invalid product code specified for deletion.");
		}
		req.getRequestDispatcher("DeleteProduct.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
