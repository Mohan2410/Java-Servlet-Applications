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
		<h1>Product Data</h1>
		<%
		String p_name = request.getParameter("pname");
		String p_id = request.getParameter("pid");
		String p_price = request.getParameter("pprice");
		String p_qty = request.getParameter("pqty");
				
		out.println("<h2>Product Name: "+p_name+"<br><br>");
		out.println("Product Id: "+p_id+"<br><br>");
		out.println("Product Price: "+p_price+"<br><br>");
		out.println("Product Quality: "+p_qty+"<br><br></h2>");
		
		%>
</body>
</html>