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
				out.println("Welcome "+request.getParameter("uname")+"<br><br>");
				out.println("Data from FilterConfig"+"<br><br>");
				out.println("Filter Name: "+request.getAttribute("Fname")+"<br><br>");
				out.println("msg1: "+request.getAttribute("msg1")+"<br><br>");
			
			%>
		</h1>
</body>
</html>