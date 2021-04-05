<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%  String name  = request.getParameter("dname"); %>

<% 
String url = "jdbc:mysql://localhost:3306/BARBEERDRINKERPLUS?serverTimezone=UTC";
String username ="root";
String password ="swami100";
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list = new ArrayList();
   		Map<String,Integer> map = null;
   		//Get the database connection
   		Class.forName("com.mysql.jdbc.Driver").newInstance();
   		Connection con =DriverManager.getConnection(url,username,password);

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		  
   		//Make a query
   		String query = "Select Transactions.item,Sum(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where drinker_name = '"+name+"' and type='beer'  GROUP BY Transactions.item ORDER BY Sum(Transactions.quantity) DESC;" ;
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   			map.put(result.getString("Transactions.item"),result.getInt("Sum(Transactions.quantity)"));
   			list.add(map);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData = myData.substring(0, myData.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
          chartTitle = "Beers "+name+" orders the Most";
          legend = "beers";
	}catch(SQLException e){
    		out.println(e);
    }
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
</head>
<body>
<h1>Drinker Graphs</h1>
<a href="home.jsp">Home Page</a> <br>	
<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>
<form action="drinkergraphs2.jsp">
<label style="marign-right: 170px;">Select Bar :</label>
<select name="DrinkerBar" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
	<%
 String nameAgain = request.getParameter("dname");
String sql = "Select Distinct bar_name From Bills where drinker_name= '"+name+"';";
System.out.println(nameAgain);

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
<input type="hidden" name="DNAME" value='<%=nameAgain%>'>
	<input type="submit" value="graph">
	</form>


</body>
</html>