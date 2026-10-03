<%@page import="java.util.Iterator"%>
<%@page import="com.bean.EmpBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Employee Data</title>
</head>
<body>
	<center>
		<h1>
			<%
				ArrayList<EmpBean> al = (ArrayList<EmpBean>)request.getAttribute("data");
			
			if(al.size() == 0){
				out.println("There are no Employee Records");
			}else{
				Iterator<EmpBean> i = al.iterator();
				while(i.hasNext()){
					EmpBean eb = i.next();
					out.println(eb.getEmpid()+" "+eb.getEmpfname()+" "+eb.getEmplname()+" "+eb.getEsal()+" "+eb.getEaddr()+"<br><br>");
				}
			}
			%>
				
		</h1>
			<h1>
					<jsp:include page="index.html"/>
				</h1>
	</center>
</body>
</html>