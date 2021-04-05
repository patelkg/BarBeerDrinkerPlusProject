<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%String B = request.getParameter("GBar"); %>
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
   		String query = " SELECT X.K, SUM(X.L) FROM (SELECT time_format(bill_time,'%I:%p' ) as K , Count(Transactions.bill_id) as L From Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where bar_name='"+B+"' Group by bill_time Order by bill_time ) as X Group by X.K;" ;
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   			map.put(result.getString("X.K"),result.getInt("SUM(X.L)"));
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
          chartTitle = "Per Hour";
          legend = "Number of Transactions";
	}catch(SQLException e){
    		out.println(e);
    }
%>





<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<h1>Graphs Based on Busiest Periods of The Day </h1>
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
			        defaultSeriesType: 'line',
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
<div id="graphContainer" style="width: 400px; height: 400px; float:left;"></div>
<a href="home.jsp">Home Page</a> <br>

<% 
	StringBuilder myData1=new StringBuilder();
	String strData1 ="";
    String chartTitle1="";
    String legend1="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Double>> list1 = new ArrayList();
   		Map<String,Double> map1 = null;
   		//Get the database connection
   		Class.forName("com.mysql.jdbc.Driver").newInstance();
   		Connection con1 =DriverManager.getConnection(url,username,password);		

   		//Create a SQL statement
   		Statement stmt1 = con1.createStatement();
   		  
   		//Make a query
   		
   		String query1 = "SELECT T.A , SUM(T.B)   FROM( SELECT DAYNAME(Bills.bill_date) as A , Count(Transactions.bill_id) as B  From Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where bar_name='"+B+"' Group by bill_date Order by bill_date) AS T Group By T.A ORDER BY T.A;" ;
		System.out.println(query1);
   		//String query2="Select  Bills.bill_date , Bills.total_price From Bills where drinker_name = 'Aaron Adkins' and bar_name ='Blue City' and month(bill_date)=4;";
   		//Run the query against the database.
   		ResultSet result1 = stmt1.executeQuery(query1);
   		//Process the result
   		while (result1.next()) { 
   			
   			map1=new HashMap<String,Double>();
   	   			map1.put(result1.getString("T.A"),result1.getDouble("SUM(T.B)"));
   	   		
   			list1.add(map1);
   	    } 
   	    result1.close();
   	    System.out.println(list1);
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Double> hashmap : list1){
        		Iterator it1 = hashmap.entrySet().iterator();
            	while (it1.hasNext()) { 
           		Map.Entry pair1 = (Map.Entry)it1.next();
           		String key = pair1.getKey().toString().replaceAll("'", "");
           		myData1.append("['"+ key +"',"+ pair1.getValue() +"],");
           	}
        }
   	    System.out.println(myData1.length()-1);
        strData1 = myData1.substring(0, myData1.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
      
        
        
            chartTitle1 = "Per Days of the Week";
            legend1="Number of Transaction";

	}catch(SQLException e){
    		out.println(e);
    }
%>

<script> 
		
			var data1 = [<%=strData1%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title1 = '<%=chartTitle1%>'; 
			var legend1 = '<%=legend1%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat1 = [];
			data1.forEach(function(item) {
			  cat1.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer2', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title1
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat1
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend1,
			        data: data1
			    }]
			});
			});
		
		</script>
<div id="graphContainer2" style=" top:50px; float:right;"></div>









</body>
</html>