<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%String name1  = request.getParameter("DNAME");
String Bar = request.getParameter("DrinkerBar");%>

<% 
String url = "jdbc:mysql://localhost:3306/BARBEERDRINKERPLUS?serverTimezone=UTC";
String username ="root";
String password ="swami100";

%>
<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Double>> list = new ArrayList();
   		Map<String,Double> map = null;
   		//Get the database connection
   		Class.forName("com.mysql.jdbc.Driver").newInstance();
   		Connection con =DriverManager.getConnection(url,username,password);		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		  
   		//Make a query
   		System.out.println(name1);
   		String query = "Select distinct Bills.bill_date , Bills.total_price FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where drinker_name = '"+name1+"' and bar_name ='"+Bar+"' ;" ;
		System.out.println(query);
   		//String query2="Select  Bills.bill_date , Bills.total_price From Bills where drinker_name = 'Aaron Adkins' and bar_name ='Blue City' and month(bill_date)=4;";
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			
   			map=new HashMap<String,Double>();
   	   			map.put(result.getDate("Bills.bill_date").toString(),result.getDouble("Bills.total_price"));
   	   		
   			list.add(map);
   	    } 
   	    result.close();
   	    System.out.println(list);
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Double> hashmap : list){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
   	    System.out.println(myData.length()-1);
        strData = myData.substring(0, myData.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
      
        
        
            chartTitle = "Graph1 Based on Days";
            legend="Days";

	}catch(SQLException e){
    		out.println(e);
    }
%>








<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<h1>Spendings on <%=Bar%> For <%=name1%></h1>
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
<a href="drinker.jsp">Drinker</a> <br>

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
   		System.out.println(name1);
   		String query1 = "Select month(C.B) , SUM(C.D) From (Select distinct Bills.bill_date as B, Bills.total_price as D FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where drinker_name = '"+name1+"' and bar_name ='"+Bar+"') as C Group by month(C.B);" ;
		System.out.println(query1);
   		//String query2="Select  Bills.bill_date , Bills.total_price From Bills where drinker_name = 'Aaron Adkins' and bar_name ='Blue City' and month(bill_date)=4;";
   		//Run the query against the database.
   		ResultSet result1 = stmt1.executeQuery(query1);
   		//Process the result
   		while (result1.next()) { 
   			
   			map1=new HashMap<String,Double>();
   	   			map1.put(result1.getString("month(C.B)"),result1.getDouble("SUM(C.D)"));
   	   		
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
      
        
        
            chartTitle1 = "Graph2 Based on Months";
            legend1="TotaL Price";

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