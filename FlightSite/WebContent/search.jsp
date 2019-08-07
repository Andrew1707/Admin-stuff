<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body>
<%

String details = request.getParameter("faults");
if (details != null){
	if (details.equals("empty")){
		out.println("<p>Please fill out all fields</p>");
	} 
}


%>
<form method="post" action="Search">
		<!--  drop box for round trip or one way -->
		<select name="tripType" size=1>
			<option value="0">Round Trip</option>
			<option value="1">One Way</option>
		</select>&nbsp;
		<br>
		
		<!--  drop box for economy classes -->
		<select name="classE" size=1>
			<option value="0">Economy</option>
			<option value="1">Business</option>
			<option value="2">First</option>
		</select>&nbsp;
		<br>
		
		<!--  drop box for possible from airports -->
		Departure Airport: <input type="text" name="dAirport">
		<br>
		
		<!--  drop box for possible to airports -->
		Arrival Airport: <input type="text" name="aAirport">
		<br>
		
		<!--  drop box for possible departure date -->
		<div class="form-group ">
		Departure Date: <input class="form-control" id="date" name="dDate" placeholder="MM/DD/YYYY" type="text"/>
		</div>
		<br>
		
		<!--  drop box for possible arrival date -->
		<div class="form-group ">
		Arrival Date: <input class="form-control" id="date" name="aDate" placeholder="MM/DD/YYYY" type="text"/>
		</div>
		<br>
		
		Flexibility:  
		<input type="radio" name="flex" value="1"/> Yes!
		<input type="radio" name="flex" value="0"/> No!
		
		<input type="submit" value="Row!">
</form>


<!-- Extra JavaScript/CSS added manually in "Settings" tab -->
<!-- Include jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Include Date Range Picker -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

<script>
    $(document).ready(function(){
        var date_input=$('input[id="date"]'); //our date input has the name "date"
        var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
        date_input.datepicker({
            format: 'mm/dd/yyyy',
            container: container,
            todayHighlight: true,
            autoclose: true,
        })
    })
</script>
</body>
</html>