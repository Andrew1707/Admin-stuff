<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "finalProject.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String Rev = request.getParameter("Revenue");
	String name = request.getParameter("name");
	if (name.isEmpty()) {
		response.sendRedirect("WelcomeAdmin.jsp?try=No flight/Customer/airline entered please enter one");
		}
	try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String qry, qry2;
			if(Rev.equals("Customer"))
			{
				qry = "Select SUM(Buys.BookingFee) AS fee,SUM(Tickets.Fare) AS fare From Buys, Tickets Where Buys.CancelledDate IS NULL and Buys.BuysUsername=? and Tickets.TicketNumber = Buys.BuysTicketNumber";
				qry2 = "Select Count(Buys.CancelledDate) AS cancel  FROM Buys,Tickets WHERE Buys.BuysUsername = ? and Buys.BuysTicketNumber = Tickets.TicketNumber AND Buys.Class Like 'E%' = ?"; 
			}
			else if(Rev.equals("Flight"))
			{
				qry = "Select SUM(Buys.BookingFee) AS fee, SUM(Tickets.Fare) AS fare From Buys, Tickets, FlightSequences Where Buys.CancelledDate IS NULL and FlightSequences.FSFlightNumber = ? and FlightSequences.FSTicketNumber = Buys.BuysTicketNumber and Tickets.TicketNumber = Buys.BuysTicketNumber";			
				qry2 = "Select Count(Buys.CancelledDate) AS cancel  FROM Buys,FlightSequences, Tickets WHERE FlightSequences.FSFlightNumber = ? and FlightSequences.FSTicketNumber = Buys.BuysTicketNumber and Buys.BuysTicketNumber = Tickets.TicketNumber AND Buys.Class Like 'E%' = ?";
			}
			else
			{
				qry = "Select SUM(Buys.BookingFee) AS fee, SUM(Tickets.Fare) AS fare From Buys, Tickets, FlightSequences, OperatedBy Where Buys.CancelledDate IS NULL and OperatedBy.OperatedByAirlineID = ? and OperatedBy.OperatedByFlightNumber = FlightSequences.FSFlightNumber and FlightSequences.FSTicketNumber = Buys.BuysTicketNumber and Tickets.TicketNumber = Buys.BuysTicketNumber";
				qry2 = "Select Count(Buys.CancelledDate) AS cancel FROM Buys,FlightSequences,OperatedBy, Tickets WHERE OperatedBy.OperatedByAirlineID = ? and OperatedBy.OperatedByFlightNumber = FlightSequences.FSFlightNumber and FlightSequences.FSTicketNumber = Buys.BuysTicketNumber and Buys.BuysTicketNumber = Tickets.TicketNumber AND Buys.Class Like 'E%' = ?";
			}
			PreparedStatement stmt = con.prepareStatement(qry);
			stmt.setString(1,name);
			ResultSet result = stmt.executeQuery();
			
			PreparedStatement stmt2 = con.prepareStatement(qry2);
			stmt2.setString(1,name);
			stmt2.setString(2,"Economy");

			ResultSet result2 = stmt2.executeQuery();
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print(name + " money from booking fees");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print(name + " money from ticket fares");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print(name + " money from cancelation fees");
			out.print("</td>");
			out.print("</tr>");
			//make a row
			if(result.next() && result2.next())
			{
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(Float.toString(result.getFloat("fee")));
				out.print("</td>");
				out.print("<td>");
				out.print(Float.toString(result.getFloat("fare")));
				out.print("</td>");	
				out.print("<td>");
				out.print(75*result2.getFloat("cancel"));
				out.print("</td>");
				out.print("</tr>");
			}
			else
				response.sendRedirect("WelcomeAdmin.jsp?try= entity not found. Make sure you select the proper type for the entry you want to see");
		

			

			out.print("</table>");
	
			//close the connection.
			con.close();
			result.close();
			
			stmt.close();
			db.closeConnection(con);
		} catch (Exception e) {
		}
	%>
	<form action="WelcomeAdmin.jsp" method="post">
<pre>
Return to main admin page
	<input type="submit" value="Submit">
</pre>
</form>

</body>
</html>