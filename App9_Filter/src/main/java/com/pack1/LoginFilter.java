package com.pack1;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/log")
public class LoginFilter implements Filter{
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc) throws ServletException, IOException {
		UserBean ub = new UserLoginDAO().retriveData(req.getParameter("uname"), req.getParameter("upwd"));
		if(ub == null) {
			req.getRequestDispatcher("index.html").forward(req, res);
		}else {
			req.setAttribute("UserBean", ub);
			fc.doFilter(req, res);
			
		}
	}
}
