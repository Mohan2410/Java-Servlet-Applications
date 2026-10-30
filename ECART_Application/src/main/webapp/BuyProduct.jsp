<%@page import="com.NCart.Bean.CustomerBean"%>
<%@page import="com.NCart.Bean.ProductBean"%>
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
                ProductBean pb =(ProductBean) request.getAttribute("productBean");
                out.println("Hello Mr. " + cbean.getCfname() + " "+ cbean.getClname() + "<br><br>");
                
                if(pb != null){
                    out.println("<h4102>Selected Product Details</h2>");
                    out.println("Product Code: "+pb.getpCode()+"<br><br>");
                    out.println("Product Name: "+pb.getpName()+"<br><br>");
                    out.println("Company: "+pb.getpComp()+"<br><br>");
                    out.println("Price: " +pb.getpPrice()+"<br><br>");
                    out.println("Available Quantity: " + pb.getpQty()+ "<br><br>");
            %>
                    <form action="confirmPurchase" method="post">
                        <input type="hidden" name="pcode" value="<%= pb.getpCode() %>">
                         Enter Quantity: <input type="number" name="pqty" min="1" max="<%= pb.getpQty() %>" required><br><br>
                        <input type="submit" value="Buy">
                    </form>
            <%
                }else {
                    out.println("Product not found!<br><br>");
                    
                }
                out.println("<br><br>");
                out.println("<a href='view'>Back to Products</a>");
            %>
        </h1>
    
</body>
</html>