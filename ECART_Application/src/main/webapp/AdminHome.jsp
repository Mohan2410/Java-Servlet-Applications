<%@page import="com.NCart.Bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
</head>
<body>
	<center>
		<h1>
			<%	
				AdminBean abean = (AdminBean)session.getAttribute("abean");
				out.println("Welcome Mr."+abean.getaFNAME()+" "+abean.getaLNAME()+"<br><br>");
			%>
			<a href="AddProduct.html">Add Product</a><br>
			<a href="view1">View Product</a><br>
			<a href="logout">Logout</a>
		</h1>
	</center>
</body>
</html>