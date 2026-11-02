package com.pack1;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/dis")
public class DisplayFilter implements Filter{
	public FilterConfig fcf = null;
	
	public void init(FilterConfig fcf) {
		this.fcf = fcf;
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)throws IOException, ServletException {
		req.setAttribute("Fname", fcf.getFilterName());
		req.setAttribute("msg1", fcf.getInitParameter("msg1"));
		req.getRequestDispatcher("Display.jsp").forward(req, res);
	}
}
