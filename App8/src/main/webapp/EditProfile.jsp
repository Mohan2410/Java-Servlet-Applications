<%@page import="com.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
</head>
<body>
	<center>
		<h1>
			<%
				String fname = (String)request.getAttribute("fname");
				UserBean ub = (UserBean)application.getAttribute("ubean");
				
				out.println("<u>Edit Progile</u>"+"<br><br>");
			%>
			<form action="update" method="post">
				FirstName: <input type="text" name=ufname value="<%= ub.getFname() %>"><br><br>
				LastName: <input type="text" name=ulname value="<%= ub.getLname() %>"><br><br>
				Mail_Id: <input type="text" name=umail value="<%= ub.getMailid() %>"><br><br>
				Phone no: <input type="text" name=uphn value="<%= ub.getPhone() %>"><br><br>
				<input type="submit" value="Update">
			</form>
		</h1>
	</center>
</body>
</html>