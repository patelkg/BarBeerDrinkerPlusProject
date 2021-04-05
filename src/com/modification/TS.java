package com.modification;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TS
 */
@WebServlet("/TS")
public class TS extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost:3306/BARBEERDRINKERPLUS?serverTimezone=UTC";
	String username ="root";
	String password ="swami100";
    public TS() {
        super();
        // TODO Auto-generated constructor stub
    }



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String pick = request.getParameter("TimeSeries");
		if(pick.equals("Time")) {
			response.sendRedirect("Time.jsp");
			
		} else if(pick.equals("Day")) {
			response.sendRedirect("Day.jsp");
			
			
		} else if(pick.equals("Month")) {
			response.sendRedirect("Month.jsp");
			
			
		}
		
		
	}

}
