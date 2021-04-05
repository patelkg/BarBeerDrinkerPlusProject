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
<h1>Beer</h1>
<a href="home.jsp">Home Page</a> <br>
<a href="beergraph.jsp">Graphing</a>
<form action="beer.jsp">
<label style="marign-right: 170px;">Select Beer:</label>
<select name="beer" class="form-control" style="width: 250px;"> 
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
<input type="submit" value="GO">
</form>

<%
String beer = request.getParameter("beer");
String query = "Select  Bills.bar_name,SUM(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where item = '"+beer+"' group by Bills.bar_name ORDER BY SUM(Transactions.quantity) desc Limit 5;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}



Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h2 align=""><font><strong>Top 5 Bars <%=beer%> is Sold at</strong></font></h2>
<table align="" cellpadding="" cellspacing="" border="">
<tr>
</tr>
<tr>
<td><b>Drinker</b></td>
<td><b>Total bottles sold</b></td>

</tr>
<%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query);

while(resultSet.next()){
%>
<tr bgcolor>
<td><input type="text"  value= "<%=resultSet.getString("Bills.bar_name") %>"></td>
<td><input type="text"  value= "<%=resultSet.getString("SUM(Transactions.quantity)") %>"></td>

</tr>
<% 

}

} catch (Exception e) {
e.printStackTrace();
}
%>
<br>

</table>

<%
String query2 = "SELECT Bills.drinker_name,Sum(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where item = '"+beer+"' Group By drinker_name ORDER BY Sum(Transactions.quantity) Desc limit 10;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}

%>
<h2 align=""><font><strong>Top Consumers of  <%=beer%> </strong></font></h2>
<table align="" cellpadding="" cellspacing="" border="">
<tr>
</tr>
<tr>
<td><b>Drinker</b></td>
<td><b>How many Drinks They Consume</b></td>

</tr>

 <%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query2);

while(resultSet.next()){
%>
<tr>
<td><input type="text"  value= "<%=resultSet.getString("Bills.drinker_name") %>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Sum(Transactions.quantity)") %>"></td>


</tr>
<% 

}

} catch (Exception e) {
e.printStackTrace();
}
%>
<br>
</table>

<br>







</body>
</html>