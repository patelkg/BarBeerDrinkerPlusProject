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
<h1>Bar</h1>
<a href="home.jsp">Home Page</a> <br>
<form action="bar.jsp">
<label style="marign-right: 170px;">Select Bar :</label>
<select name="bar" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

String sql = "Select bar_name FROM Bar";
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
	<option value="<%=rs.getString("bar_name")%>"><%=rs.getString("bar_name")%></option>
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
String bar = request.getParameter("bar");
String query = "Select DISTINCT Bills.drinker_name,Bills.total_price FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where bar_name = '"+bar+"' AND type = 'beer' ORDER BY Bills.total_price desc limit 10;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}



Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h2 align=""><font><strong>Top 10 Drinkers Based on Spending$$$</strong></font></h2>
<table align="" cellpadding="" cellspacing="" border="">
<tr>
</tr>
<tr>
<td><b>Drinker</b></td>
<td><b>Total Spending</b></td>

</tr>

 <%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query);

while(resultSet.next()){
%>
<tr>
<td><input type="text"  value= "<%=resultSet.getString("Bills.drinker_name") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Bills.total_price") %>"></td>

</tr>
<% 

}

} catch (Exception e) {
e.printStackTrace();
}
%>


</table>

<%
String query2 = "Select SUM(Transactions.quantity), Transactions.item FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where bar_name = '"+bar+"' and type = 'beer' GROUP BY Transactions.item  ORDER BY SUM(Transactions.quantity) DESC limit 10;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}

%>

<h2 align=""><font><strong>Top 10 Beers Sold</strong></font></h2>
<table align="" cellpadding="" cellspacing="" border="">
<tr>
</tr>
<tr>
<td><b>Beer</b></td>
<td><b>Total bottles sold</b></td>

</tr>

 <%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query2);

while(resultSet.next()){
%>
<tr>
<td><input type="text"  value= "<%=resultSet.getString("Transactions.item") %>"></td>
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
String query3 = "Select Distinct Beer.manf,Transactions.item ,SUM(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id INNER JOIN Beer ON Transactions.item = Beer.beer_name where bar_name = '"+bar+"' and type = 'beer' GROUP BY Transactions.item  ORDER BY SUM(Transactions.quantity) DESC limit 5 ;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}

%>
<h2 align=""><font><strong>Top 5 Manufacturers</strong></font></h2>
<table align="" cellpadding="" cellspacing="" border="">
<tr>
</tr>
<tr>
<td><b>Manufacturer</b></td>
<td><b>Beer</b></td>

</tr>

 <%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query3);

while(resultSet.next()){
%>
<tr>
<td><input type="text"  value= "<%=resultSet.getString("Beer.manf")%>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Transactions.item")%>"></td>

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
<br>

<form action="bargraph.jsp">
<input type="hidden" name ="GBar" value='<%=bar%>'>
<input type="submit" value="Graph">

</form>






</body>
</html>