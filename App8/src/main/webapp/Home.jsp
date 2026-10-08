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
		<%
			UserBean ub =(UserBean)application.getAttribute("ubean");
			String fname = ub.getFname();
			out.println("<h1>Welcome: "+fname+"<br><br></h1>");
		%>
		<a href="view">View Profile</a><br>
		<a href="logout">Logout</a><br><br>
	
</body>
</html>