<%@page import="com.pack1.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login jsp file</title>
</head>
<body>
	<center>
		<h2>
			<u>User Details</u><br><br>
			<%
				UserBean ub = (UserBean)request.getAttribute("UserBean");
				out.println("UserName: "+ub.getUname()+"<br>");
				out.println("Password: "+ub.getUpwd()+"<br>");
				out.println("User First Name: "+ub.getUfname()+"<br>");
				out.println("User Last Name: "+ub.getUlname()+"<br>");
				out.println("User Email: "+ub.getUmailid()+"<br>");
				out.println("User Phone: "+ub.getUpnone()+"<br>");
			%>
		</h2>
	</center>
</body>
</html>