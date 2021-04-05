<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%String aa = (String) request.getAttribute("myBeer");  %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.highcharts.com/highcharts.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="TimeG.jsp">
Select a Date
<input type="text" name="TimeDay"><br>
<label style="marign-right: 170px;">Select Beer:</label>
<select name="BGraph" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

String sql = "Select beer_name FROM Beer";
String url = "jdbc:mysql://localhost:3306/BARBEERDRINKERPLUS?serverTimezone=UTC";
String username = "root";
String password = "swami100";

try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url,username,password);
	Statement stm =con.createStatement();
	ResultSet rs = stm.executeQuery(sql);
	while(rs.next())
	{
		%>
	<option value="<%=rs.getString("beer_name")%>"><%=rs.getString("beer_name")%></option>
	<%
	}
	
} catch(Exception ex){
	ex.printStackTrace();
	  out.println("Error " +ex.getMessage());
}
	
	
	%>	
		
</select>
 <br>

<input type="submit" value="Graph">
</form>


</body>
</html>