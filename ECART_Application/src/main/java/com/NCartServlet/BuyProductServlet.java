package com.NCartServlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.NCart.Bean.ProductBean;
@WebServlet("/buy")
public class BuyProductServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session == null) {
			req.getRequestDispatcher("CustomerLogin.html").forward(req, res);
		}else {
			String pCode = req.getParameter("pcode");
			ProductBean pb = null;
			ArrayList<ProductBean> al = (ArrayList<ProductBean>)session.getAttribute("productList");
			Iterator<ProductBean> i = al.iterator();
			while(i.hasNext()) {
				pb = i.next();
				if(pCode.equals(pb.getpCode())){
					break;
				}
			}
			if(pb == null){
	            req.setAttribute("msg", "Selected product was not found.");
	            req.getRequestDispatcher("CustomerHome.jsp").forward(req, res);
	            return;
	        }
			req.setAttribute("productBean", pb);
			req.getRequestDispatcher("BuyProduct.jsp").forward(req, res);
		}
	}

}
