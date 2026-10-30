<%@page import="java.util.Iterator"%>
<%@page import="com.NCart.Bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.NCart.Bean.CustomerBean"%>
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
				CustomerBean cbean =(CustomerBean) session.getAttribute("cbean");
		        ArrayList<ProductBean> al =(ArrayList<ProductBean>) session.getAttribute("productList");
		 
		        out.println("Hello Mr. " + cbean.getCfname() + " "+ cbean.getClname()+ "<br><br>");
		        
		        Iterator<ProductBean> i = al.iterator();
		        while (i.hasNext()){
		            ProductBean pb = i.next();
					out.println(pb.getpCode()+" "+pb.getpName()+" "+pb.getpComp()+" "+pb.getpPrice()+" "+pb.getpQty()
					+"<a href='buy?pcode=" + pb.getpCode() + "'> Buy</a> "+" <br><br>");
		        }
				%>
		</h1>
	
</body>
</html>