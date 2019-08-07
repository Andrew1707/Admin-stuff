<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "finalProject.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ActiveFlights</title>
</head>
<body>

<%
		try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String qry;
			qry = "Select FlightSequences.FSFlightNumber, Count(Buys.BuysUsername) AS sold From Buys, FlightSequences WHERE FlightSequences.FSTicketNumber = Buys.BuysTicketNumber group by FSFlightNumber Order By sold DESC limit 5";
			PreparedStatement stmt = con.prepareStatement(qry);
			ResultSet result = stmt.executeQuery();
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Flight Number");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Tickets Sold");
			out.print("</td>");
			out.print("</tr>");
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("FSFlightNumber"));
				out.print("</td>");	
				out.print("<td>");
				out.print(result.getString("sold"));
				out.print("</td>");
				out.print("</tr>");

			}

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