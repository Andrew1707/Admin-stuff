<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="finalProject.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket History</title>
</head>
<body>

<%

ConnectDB db = new ConnectDB();
Connection conn = db.getConnection();

String qry = "select * from Buys where Username=?";
String username = (String) session.getAttribute("username");

PreparedStatement stmt = conn.prepareStatement(qry);
stmt.setString(1, username); 
ResultSet rs = stmt.executeQuery();

out.print("<table>");
out.print("<tr>");
out.print("<td>");
out.print("Date Bought");
out.print("</td>");
out.print("<td>");
out.print("Ticket Number");
out.print("</td>");
out.print("<td>");
out.print("Flight Number");
out.print("</td>");
out.print("<td>");
out.print("Departure Airport");
out.print("</td>");
out.print("<td>");
out.print("Departure Time");
out.print("</td>");
out.print("<td>");
out.print("Arrival Airport");
out.print("</td>");
out.print("<td>");
out.print("Arrival Time");
out.print("</td>");
out.print("</tr>");

while (rs.next()){
	int ticketNumber = rs.getInt("TicketNumber");
/* 	LocalDate boughtDate = rs.getDate("BoughtDate").toLocalDate();
 */	
	String qry1 = "select * from FlightSequences where FSTicketNumber=? order by Order";
	PreparedStatement stmt1 = conn.prepareStatement(qry1);
	stmt1.setInt(1, ticketNumber); 
	ResultSet rs1 = stmt1.executeQuery();

	while (rs1.next()){
		int flightNumber = rs.getInt("FSFlightNumber");
		
		String qry2 = "select * from FlyFrom where FlyFromFlightNumber=?";
		PreparedStatement stmt2 = conn.prepareStatement(qry2);
		stmt2.setInt(1, flightNumber); 
		ResultSet rs2 = stmt2.executeQuery();
		
		if (rs2.next()){
			String dAirport = rs2.getString("FlyFromAirportID");
/* 			LocalTime dTime = rs2.getTime("DepartureTime").toLocalTime();
 */			
			String qry3 = "select * from FlyTo where FlyToFlightNumber=?";
			PreparedStatement stmt3 = conn.prepareStatement(qry3);
			stmt3.setInt(1, flightNumber); 
			ResultSet rs3 = stmt3.executeQuery();
			
			if ( rs3.next() ) {
				String aAirport = rs3.getString("FlyToAirportID");
/* 				LocalTime aTime = rs3.getTime("ArrivalTime").toLocalTime();
 */				
				out.print("<tr>");
				out.print("<td>");
/* 				out.print(boughtDate);
 */				out.print("</td>");
				out.print("<td>");
				out.print(ticketNumber);
				out.print("</td>");
				out.print("<td>");
				out.print(flightNumber);
				out.print("</td>");
				out.print("<td>");
				out.print(dAirport);
				out.print("</td>");
				out.print("<td>");
/* 				out.print(dTime);
 */				out.print("</td>");
				out.print("<td>");
				out.print(aAirport);
				out.print("</td>");
				out.print("<td>");
/* 				out.print(aTime);
 */				out.print("</td>");
				out.print("</tr>");
			}
						
		}
		
	}

	//flightSequence all ticket numbers to get flight number
	//flights to get departureAirport, arrivalAirport, departureTime, arrival Time 
}

out.print("</table>");
%>

</body>
</html>