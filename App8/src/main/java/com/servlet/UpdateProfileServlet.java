package com.servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.UpdateProfileDAO;
import com.bean.UserBean;

@WebServlet("/update")
public class UpdateProfileServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Cookie arr[] = req.getCookies();
		String fname = null;
		if(arr == null) {
			req.setAttribute("msg", "Session Expired!");
			req.getRequestDispatcher("Register.jsp").forward(req, res);
		}else {
			ServletContext context = req.getServletContext();
			UserBean ub = (UserBean)context.getAttribute("ubean");
			ub.setFname(req.getParameter("ufname"));
			ub.setLname(req.getParameter("ulname"));
			ub.setMailid(req.getParameter("umail"));
			ub.setPhone(req.getParameter("uphn"));
			
			int rowCount = new UpdateProfileDAO().updateProfile(ub);
			
			if(rowCount > 0) {
				req.setAttribute("msg", "Profile Updated");
				for(Cookie ck:arr) {
					if("ck1".equals(ck.getName())) {
						fname = ck.getValue();
					}
				}
				req.setAttribute("fname", fname);
				req.getRequestDispatcher("UpdateProfile.jsp").forward(req, res);
				
			}
		}
		
	}
}
