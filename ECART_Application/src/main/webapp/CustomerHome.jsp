<%@ page import="com.NCart.Bean.CustomerBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Home</title>
</head>
<body>
    <center>
        <h1>
            <%
                CustomerBean cbean =(CustomerBean) session.getAttribute("cbean");
                if(cbean != null){
                    out.println("Welcome Mr. " +cbean.getCfname()+" "+ cbean.getClname()+"<br><br>");
                }else {
                    out.println("Customer session not found.");
                }
            %>
            <a href="view">View Product</a><br><br>
            <a href="logout">Logout</a>
        </h1>
</body>
</html>