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
<h1>Drinker</h1>
<a href="home.jsp">Home Page</a> <br>

<form action="drinker.jsp">
<label style="marign-right: 170px;">Select Drinker :</label>
<select name="DrinkerName" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

String sql = "SELECT name FROM Drinker";
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
	<option value="<%=rs.getString("name")%>"><%=rs.getString("name")%></option>
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
String name = request.getParameter("DrinkerName");

%>





<%

String query = "Select Bills.bill_id, Bills.bar_name,Bills.bill_date,Bills.bill_time ,Bills.drinker_name,Transactions.quantity, Transactions.item,Transactions.type,Bills.items_price,Transactions.price,Bills.tax_price,Bills.tip,Bills.total_price FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where drinker_name = '"+name+"' ORDER BY bar_name , bill_time ;";
try {
	Class.forName("com.mysql.jdbc.Driver");
	
} catch(Exception e){
	e.printStackTrace();
}



Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<h2 align="center"><font><strong>Drinker Transactions For <%=name %></strong></font></h2>
<table align="center" >
<tr>
</tr>
<tr>
<td><b>Bill ID</b></td>
<td><b>Bar Name </b></td>
<td><b>Bill Date </b></td>
<td><b>Bill Time </b></td>
<td><b>Quantity of Bought</b></td>
<td><b>Item</b></td>
<td><b>Item Type</b></td>
<td><b>Price of all items</b></td>
<td><b>Price of food types</b></td>
<td><b>Tax</b></td>
<td><b>Tip</b></td>
<td><b>Total Price</b></td>


</tr>

  <%
try{ 
connection = DriverManager.getConnection(url,username,password);
statement=connection.createStatement();

resultSet = statement.executeQuery(query);

while(resultSet.next()){
%>
<tr>
<td><input type="text"  value= "<%=resultSet.getString("Bills.bill_id") %>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Bills.bar_name") %>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Bills.bill_date") %>"></td>
<td><input type ="text"  value= "<%=resultSet.getString("Bills.bill_time") %>"></td>
<td><input type="text"  value ="<%=resultSet.getString("Transactions.quantity")%>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Transactions.item") %>"></td>
<td><input type="text"  value= "<%=resultSet.getString("Transactions.type") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Bills.items_price") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Transactions.price") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Bills.tax_price") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Bills.tip") %>"></td>
<td><input type="text"  value= "<%="$"+resultSet.getString("Bills.total_price") %>"></td>
</tr>
<% 

}

} catch (Exception e) {
e.printStackTrace();
}
  
%>
<br>

</table>

<form action="drinkergraphs.jsp">
<input type="hidden" name=dname value ="<%=name%>">
<input type="submit" value="See graphs">
</form>


</body>
</html>



