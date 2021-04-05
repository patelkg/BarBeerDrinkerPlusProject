<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>End User Modifications</h1>
<a href="home.jsp">Home Page</a> <br>

Enter SQL Query
<form action="Insert" method="post">
<input type ="text" name ="statement">
<input type="submit" value="Enter">
</form>
<br>



</body>
</html>

