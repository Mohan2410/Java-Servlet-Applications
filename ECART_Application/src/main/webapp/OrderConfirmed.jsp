<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page import="com.NCart.Bean.ProductBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmed</title>
</head>
<body>
    <center>
        <h1>
            <%
                CustomerBean cbean = (CustomerBean) session.getAttribute("cbean");
                ProductBean pb = (ProductBean) request.getAttribute("productBean");

                Integer quantity = (Integer) request.getAttribute("quantity");
                Double totalAmount = (Double) request.getAttribute("totalAmount");

                if (cbean != null && pb != null && quantity != null && totalAmount != null) {

                    out.println("Hello Mr. " + cbean.getCfname() + " " + cbean.getClname() + "<br><br>");

                    out.println("<h2>Order Confirmed Successfully!</h2>");
                    out.println("Your order has been placed successfully.<br><br>");

                    out.println("<h2>Order Details</h2>");
                    out.println("Product Code: " + pb.getpCode() + "<br><br>");
                    out.println("Product Name: " + pb.getpName() + "<br><br>");
                    out.println("Company: " + pb.getpComp() + "<br><br>");
                    out.println("Price: " + pb.getpPrice() + "<br><br>");
                    out.println("Quantity Purchased: " + quantity + "<br><br>");
                    out.println("Total Amount: Rs. " + String.format("%.2f", totalAmount) + "<br><br>");

                } else {
                    out.println("Order details are not available.<br><br>");
                }

                out.println("<a href='view'>View Products</a><br><br>");
                out.println("<a href='logout'>Logout</a>");
            %>
        </h1>
    </center>
</body>
</html>