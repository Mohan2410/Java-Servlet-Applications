<%@page import="java.util.Iterator"%>
<%@page import="com.bean.EmpBean"%>
<%@page import="java.util.ArrayList"%>
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
				ArrayList<EmpBean> al = (ArrayList<EmpBean>)request.getAttribute("data");
				if(al.size() == 0){
					out.println("There are No Employee Records");
				}else{
					Iterator<EmpBean> i = al.iterator();
					while(i.hasNext()){
						EmpBean eb = i.next();
						out.println(eb.getEmpId()+" "+eb.getEmpFname()+" "+eb.getEmpLname()+" "+eb.getEmpSal()+" "+eb.getGetAddr()+"<br><br>");
					}
					
					
				}
			
			%>
				<h1>
					<jsp.include page="index.html"/>
				</h1>
		</h1>
</body>
</html>
