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
				String data = (String)request.getAttribute("msg");
				session.invalidate();
				out.println(data+"<br><br>");
			%>
		</h1>
			<jsp:include page="index.html"/>
	</center>
</body>
</html>