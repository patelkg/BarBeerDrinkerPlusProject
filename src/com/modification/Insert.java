package com.modification;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Insert")
public class Insert extends HttpServlet {
	String url = "jdbc:mysql://localhost:3306/BARBEERDRINKERPLUS?serverTimezone=UTC";
	String username ="root";
	String password ="swami100";
	
    public Insert() {
        super();
        
        
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con =DriverManager.getConnection(url,username,password);
			String sql = request.getParameter("statement");
			Statement st =con.createStatement();
			st.executeUpdate(sql);
			PrintWriter out =response.getWriter();
			response.setContentType("text/html");  
		      out.println("<script type=\"text/javascript\">");
			   out.println("alert('Sucess!');");
			   out.println("location='modification.jsp';");
			   out.println("</script>");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			PrintWriter out =response.getWriter();
			response.setContentType("text/html");
			 out.println("<script type=\"text/javascript\">");
			   out.println("alert('Error : Violates Foreign Key Constraint');");
			   out.println("location='modification.jsp';");
			   out.println("</script>");
		}
		
	}

}



