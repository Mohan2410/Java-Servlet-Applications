<%@page import="com.NCart.Bean.ProductBean"%>
<%@page import="com.NCart.Bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Product </title>
</head>
<body>
	<center>
		<h1>
			<%
				
				AdminBean abean =(AdminBean)session.getAttribute("abean");
				out.println("Hello "+abean.getaFNAME()+" "+request.getAttribute("msg")+" <br><br>");
			%>
			<a href="AddProduct.html">Add Product</a><br><br>
			<a href="view1">View Product</a><br><br>
			<a href="logout">Logout</a>
		</h1>
	</center>
</body>
</html>