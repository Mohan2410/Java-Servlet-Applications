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
			String data = (String)request.getAttribute("msg");
			out.println("<h1>"+data+"</h1><br><br>");
		%>
		<h1>
			<a href="AddProduct.html">Add Product details</a><br><br>
			<a href="view">view Product Data</a>
		</h1>
	</center>
</body>
</html>