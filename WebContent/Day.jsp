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
<form action="DayG.jsp">
<label style="marign-right: 170px;">Select Month Number:</label>
<select name="MonthNum" class="form-control" style="width: 250px;"> 
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
</select>
<br>

<label style="marign-right: 170px;">Select Beer:</label>
<select name="BeerGraph" class="form-control" style="width: 250px;"> 
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