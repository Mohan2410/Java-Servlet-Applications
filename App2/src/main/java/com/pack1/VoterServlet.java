package com.pack1;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.annotation.WebServlet;

@WebServlet("/vs")
public class VoterServlet extends GenericServlet{
	@Override
	public void service(ServletRequest req, ServletResponse res) throws IOException{
		
		PrintWriter pw = res.getWriter();
		res.setContentType("text/html");
		
		String v_name = req.getParameter("vname");
		String v_dob = req.getParameter("vdob");
		String v_city = req.getParameter("vcity");
		
		System.out.println("Voter Name: "+v_name);
		System.out.println("Voter Dob: "+v_dob);
		System.out.println("voter City: "+v_city);
		
		String arr[] = v_dob.split("-");
		int age = 2026-Integer.parseInt(arr[0]);
		if(age>=18) {
			pw.println(v_name+" is eligible for Vote");
		}else {
			pw.println(v_name+" is NOT eligible for vote");
		}
		
	}
}
