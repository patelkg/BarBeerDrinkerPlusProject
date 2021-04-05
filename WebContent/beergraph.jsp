<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="TS" method="post">
<p> Choose Which Time Series Graph You would Like To See

<label style="marign-right: 170px;">Select :</label>
<select name="TimeSeries" class="form-control" style="width: 250px;"> 
<option value="Time">Per Time of Day</option>
<option value="Day">Per Day</option>
<option value="Month">Per Month</option>
</select>

<input type="submit" value="Go">
</form>

</body>
</html>