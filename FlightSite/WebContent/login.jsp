<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<%
String details = request.getParameter("login");
if (details!= null){
	if (details.equals("fail")){
		out.println("<p>Wrong username or password. Please try again</p>");
	}else if (details.equals("empty")){
		out.println("<p>Please fill out every field.</p>");
	}
}
%>
<form action="Login" method="post">
<pre>
Username: <input type="text" name="uname">
Password: <input type="text" name="pass">
		<input type="submit" value="Submit">
</pre>
</form>

</body>
</html>