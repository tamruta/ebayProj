<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Computer Ebay</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String email = request.getParameter("userID");
			String password = request.getParameter("password");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM users WHERE userID = " + "'" + email + "'" + " AND PASSWORD= " + "'" + password + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			//Make an HTML table to show the results in:
			if(result.next())           
			response.sendRedirect("welcome.jsp"); 
        	else
        	response.sendRedirect("error.jsp"); 

			//close the connection.
			con.close();

		} catch (Exception ex) {
			out.print(ex);
			out.print("Insert failed :()");
		}
	%>

</body>
</html>