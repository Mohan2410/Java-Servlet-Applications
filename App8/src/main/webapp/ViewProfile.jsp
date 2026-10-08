<%@page import="com.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>
			<%
				String fname = (String)request.getAttribute("fname");
				UserBean ub = (UserBean)application.getAttribute("ubean");
				
				out.println("This session belongs to: "+fname+"<br><br>");
				out.println("<u>Profile Details</u>"+"<br><br>");
				
				String pwd = ub.getPwd();
				String cpwd = pwd.substring(0,1)+"******"+pwd.substring(pwd.length()-1);
				out.println(ub.getUname()+" "+cpwd+" "+ub.getFname()+" "+ub.getLname()+" "+ub.getMailid()+" "+ub.getPhone()+"<br><br>");
				
			%>
			<a href="edit">Edit Profile</a><br><br>
			<a href="logout">Logout</a>
		</h1>
	</center>
</body>
</html>