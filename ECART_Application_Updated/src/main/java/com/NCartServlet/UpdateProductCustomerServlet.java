package com.NCartServlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.CustomerBean;
import com.NCart.Bean.ProductBean;
import com.NCartDAO.UpdateProductServletDAO;
import com.NCartDAO.ViewCustomerProductDAO;

@WebServlet("/confirmPurchase")
public class UpdateProductCustomerServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		// Step 1: Check customer session
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("cbean") == null) {
			req.setAttribute("errorMessage", "Your session has expired. Please log in again to complete your purchase.");
			req.getRequestDispatcher("CustomerLogin.jsp").forward(req, res);
			return;
		}

		CustomerBean cb = (CustomerBean) session.getAttribute("cbean");

		// Step 2: Get product code and quantity from the form
		String pCode = req.getParameter("pcode");
		String pQtyStr = req.getParameter("pqty");

		if (pCode == null || pCode.trim().isEmpty() || pQtyStr == null || pQtyStr.trim().isEmpty()) {
			req.setAttribute("msg", "Please select a product and provide a valid quantity.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		pCode = pCode.trim();
		pQtyStr = pQtyStr.trim();

		// Step 3: Convert quantity into a positive integer
		int quantity;
		try {
			quantity = Integer.parseInt(pQtyStr);
		} catch (NumberFormatException e) {
			req.setAttribute("msg", "Invalid quantity format. Please enter a whole number greater than or equal to 1.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		if (quantity <= 0) {
			req.setAttribute("msg", "Purchase quantity must be at least 1.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		// Step 4: Get product list from session or refresh from database
		@SuppressWarnings("unchecked")
		ArrayList<ProductBean> al = (ArrayList<ProductBean>) session.getAttribute("productList");
		if (al == null || al.isEmpty()) {
			al = new ViewCustomerProductDAO().retriveCustomerProduct();
			session.setAttribute("productList", al);
		}

		// Step 5: Find the selected product
		ProductBean pb = null;
		if (al != null) {
			for (ProductBean temp : al) {
				if (pCode.equalsIgnoreCase(temp.getpCode())) {
					pb = temp;
					break;
				}
			}
		}

		if (pb == null) {
			req.setAttribute("msg", "The selected product was not found in the catalog.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		// Step 6: Parse available quantity and price
		int availableQty;
		double price;
		try {
			availableQty = Integer.parseInt(pb.getpQty().trim());
			price = Double.parseDouble(pb.getpPrice().trim());
		} catch (NumberFormatException e) {
			req.setAttribute("msg", "Error processing product details. Please contact store administration.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		if (quantity > availableQty) {
			req.setAttribute("msg", "Insufficient stock available. You requested " + quantity
					+ " unit(s), but only " + availableQty + " unit(s) are in stock.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
			return;
		}

		// Step 7: Calculate total amount
		double totalAmount = price * quantity;

		// Step 8: Update product stock atomically in the database
		UpdateProductServletDAO dao = new UpdateProductServletDAO();
		int rowCount = dao.buyProductUpdate(pb, quantity);

		if (rowCount > 0) {
			// Step 9: Update quantity in the session product list
			int remainingQty = availableQty - quantity;
			pb.setpQty(String.valueOf(remainingQty));

			// Step 10: Forward to OrderConfirmed.jsp
			req.setAttribute("customerBean", cb);
			req.setAttribute("productBean", pb);
			req.setAttribute("quantity", quantity);
			req.setAttribute("totalAmount", totalAmount);

			req.getRequestDispatcher("OrderConfirmed.jsp").forward(req, res);
		} else {
			// Database update returned 0 (stock changed concurrently or item unavailable)
			req.setAttribute("msg", "Purchase failed. The requested stock is no longer available due to concurrent orders. Please try with a smaller quantity.");
			req.getRequestDispatcher("PurchaseResult.jsp").forward(req, res);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("view");
	}
}
