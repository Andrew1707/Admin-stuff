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

 		List<String> list = new ArrayList<String>();
		String entity = request.getParameter("searchCust");
		if (entity.isEmpty()) {
			response.sendRedirect("WelcomeAdmin.jsp?try=No User entered. Please enter a User");
			}
		try {
			
			//Get the database connection
			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
	
			String str = "SELECT * FROM Account WHERE Username =?";
			PreparedStatement stmt = con.prepareStatement(str);
			stmt.setString(1,entity);
			ResultSet result = stmt.executeQuery();
			
			if (result.next()) {
			//out.print(result.getString("Username"));
				if(result.getString("AccountType") == "SiteAdmin")
					response.sendRedirect("WelcomeAdmin.jsp?try=You can not change a Site Admins Information");
			//Make an HTML table to show the results in:
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Password");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Email");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			out.print("</tr>");
			
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("Username"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Password"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Email"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Name"));
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
			}
			else 
				response.sendRedirect("WelcomeAdmin.jsp?try= User not found. Try again");
			
			con.close();
			result.close();
			stmt.close();
			db.closeConnection(con);
		
		} catch (Exception e) {
		}
%>
<form action="EditCust" method="post">
<pre>
Change data for user (all feilds required): 
Username: <input type="text" name="oldUser">
New Username: <input type="text" name="newUser">
New Password: <input type="text" name="newPass">
New Email: <input type="email" name="newEmail">
New Name: <input type="text" name="newName">
	<input type="submit" value="Submit">
</pre>
</form>
</body>
</html>