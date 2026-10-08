package com.servlet;

import java.awt.geom.Rectangle2D;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/edit")
public class EditProfileServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Cookie arr[] = req.getCookies();
		String fname = null;
		if(arr==null) {
			req.setAttribute("msg", "Session expired");
			req.getRequestDispatcher("Register.jsp").forward(req, res);
		}else {
			for(Cookie ck:arr) {
				fname = ck.getValue();
			}
		}
		req.setAttribute("fname", fname);
		req.getRequestDispatcher("EditProfile.jsp").forward(req, res);
	}

}
