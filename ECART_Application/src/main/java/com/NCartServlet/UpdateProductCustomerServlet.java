
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

@WebServlet("/confirmPurchase")
public class UpdateProductCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("cbean") == null) {
            req.getRequestDispatcher("/CustomerLogin.html").forward(req, res);
        }

        CustomerBean cb =(CustomerBean) session.getAttribute("cbean");
        String pCode = req.getParameter("pcode");
        String pQty = req.getParameter("pqty");

        if (pCode == null || pCode.trim().isEmpty() || pQty == null || pQty.trim().isEmpty()) {
            req.setAttribute("msg", "Please select a product and quantity.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
       }
        int quantity;
        try{
            quantity = Integer.parseInt(pQty);
        }catch(NumberFormatException e) {
            req.setAttribute("msg","Please enter a valid quantity.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }

        if (quantity <= 0) {
            req.setAttribute("msg","Quantity must be greater than zero.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }

        ArrayList<ProductBean> al =(ArrayList<ProductBean>) session.getAttribute("productList");
        if (al == null) {
            req.setAttribute("msg","Product list not found. Please view products again.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }

        ProductBean pb = null;
        for (ProductBean temp : al) {
            if (pCode.equals(temp.getpCode())) {
                pb = temp;
                break;
            }
        }
        if (pb == null) {
            req.setAttribute("msg","Selected product was not found.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }

        int availableQty;
        double price;
        try {
            availableQty = Integer.parseInt(pb.getpQty());
            price = Double.parseDouble(pb.getpPrice());

        } catch (NumberFormatException e) {
            req.setAttribute("msg","Invalid product price or quantity.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }
        if (quantity > availableQty) {
            req.setAttribute("msg","Insufficient product quantity.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
            return;
        }
        double totalAmount = price * quantity;
        UpdateProductServletDAO dao = new UpdateProductServletDAO();
        int rowCount = dao.buyProductUpdate(pb, quantity);
        if (rowCount > 0) {
            pb.setpQty(String.valueOf(availableQty - quantity));

            req.setAttribute("customerBean", cb);
            req.setAttribute("productBean", pb);
            req.setAttribute("quantity", quantity);
            req.setAttribute("totalAmount", totalAmount);

            req.getRequestDispatcher("/OrderConfirmed.jsp").forward(req, res);
        } else {
            req.setAttribute("msg","Purchase failed. The product may be unavailable " + "or its stock may have changed.");
            req.getRequestDispatcher("/PurchaseResult.jsp").forward(req, res);
        }
    }

    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {

        res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        res.setContentType("text/plain");

        res.getWriter().println("Please select a product and submit the purchase form.");
    }
}
