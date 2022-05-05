<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

	ApplicationDB db = new ApplicationDB();	
    //Class.forName("com.mysql.jdbc.Driver");
    Connection con = db.getConnection();	
    Statement st = con.createStatement();
    
    String item = request.getParameter("itemName");   
        
	
    ResultSet rs;
    rs = st.executeQuery("Select * from bidhistory where itemName like '%" + item + "%'");

    if (rs.next() == true) {
        session.setAttribute("itemName", item); // the username will be stored in the session
        //response.sendRedirect("HelloWorld.jsp");
       // rs.first();
        %>
 		<table>
 			<tr>
 				<td>Bid Price</td>
 				<td>Item Name</td>
 				<td>Item Type</td>
 				<td>Item ID</td>
 				<td>Date Posted</td>
 				
 			</tr>
 				<%
 				rs.previous();
 				while(rs.next()){%>
 					<tr>
 						<td><%=rs.getInt("bidPrice")%></td>
 						<td><%=rs.getString("itemName")%></td>
 						<td><%=rs.getString("typ")%></td>
 						<td><%=rs.getInt("item_ID")%></td>
 						<td><%=rs.getString("datePosted")%></td>
 						
 					</tr>
 			<%}%>
 			<form action = 'deleteBid.jsp', method="post">
	        <table>
	        <tr>
	        <td>Enter bid price</td><td><input type="text" name="bidPrice"></td>
	        </tr>
	        <tr>
	        <td>Enter Item ID of bid to delete</td><td><input type="text" name="id"></td>
	        </tr>
	        <tr>
	        <td>Enter date of bid</td><td><input type="text" name="date"></td>
	        </tr>
	        </table>
	        <input type="submit" value="Delete Bid">
        	</form>
 	<%
    }else {
        out.println("Invalid Search <a href='cusrep.jsp'>Go Back</a>");
    }
    
    con.close();
%>
 				
 				