<%@page import="java.util.Iterator"%>
<%@page import="com.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
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
				ArrayList<ProductBean> pb = (ArrayList<ProductBean>)request.getAttribute("data");
				if(pb.size() == 0){
					out.println("There are no employee records");
				}else{
					Iterator<ProductBean> i = pb.iterator();
					while(i.hasNext()){
						ProductBean pbean = i.next();			
						out.println(pbean.getPcode()+" "+pbean.getPname()+" "+pbean.getPcompany()+" "+pbean.getPprice()+" "+pbean.getPqty()+"<br><br>");	
					}
				}
			%>
		</h1>
			<h1>
				<jsp:include page="index.html"/>
			</h1>
	
</body>
</html>