<%@page import="java.util.Iterator"%>
<%@page import="com.NCart.Bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.NCart.Bean.AdminBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Product</title>
</head>
<body>
	<center>
		<h1>
			<%
				AdminBean abean = (AdminBean)session.getAttribute("abean");
				ArrayList<ProductBean> al = (ArrayList<ProductBean>)session.getAttribute("productList");
				out.println("Hello "+abean.getaFNAME()+" these are your product details<br><br>");
				
				if(al.size() == 0){
					out.println("There are no product available!!!");
				}else{
					Iterator<ProductBean> i = al.iterator();
					while(i.hasNext()){
						ProductBean pb = i.next();
						 out.println(pb.getpCode() + " "+ pb.getpName() + " "+ pb.getpComp() + " "+ pb.getpPrice() + " "+ pb.getpQty() + " "
					                + "<a href='edit?pcode=" + pb.getpCode() + "'>Edit</a> "
					                + "<a href='delete?pcode=" + pb.getpCode() + "'>Delete</a>"
					                + "<br>");
					}
				}
			%>
		</h1>
	
</body>
</html>