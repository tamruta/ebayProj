<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    if ((session.getAttribute("userID") == null)) {
%>
You are not logged in<br/>
<a href="Users.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("userID")%> <br><br>

<style> .footer {
      position: fixed;
      left: 0;
      bottom: 0;
      width: 100%;
      font-size: 30;
      background-color: rgb(211, 208, 208);
      color: white;
      text-align: center;
    } </style>
    
    <div class="footer"> 
      <p><a href='welcome.jsp'>Home</a><br><a href='logout.jsp'>Log out</a></p>
    </div>


<%

	ApplicationDB db = new ApplicationDB();	
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyElectronics", "root", "Rootuser!1");	
    Statement st = con.createStatement();

    String item = request.getParameter("itemName");   
        

    ResultSet rs;
    rs = st.executeQuery("Select * from item where itemName like '%" + item + "%'");

    if (rs.next() == true) {
        session.setAttribute("itemName", item); // the username will be stored in the session
        //response.sendRedirect("HelloWorld.jsp");
       // rs.first();
        %>
 		<table>
 			<tr>
 				<td>Item ID</td>
 				<td>Name</td>
 				<td>Description</td>
 				<td>Current Price</td>
 				<td>Type</td>
 				
 			</tr>
 				<%
 				rs.previous();
 				while(rs.next()){%>
 					<tr>
 						<td><%=rs.getInt("item_ID")%></td>
 						<td><%=rs.getString("itemName")%></td>
 						<td><%=rs.getString("description")%></td>
 						<td><%=rs.getInt("current_price")%></td>
 						<td><%=rs.getString("typ")%></td>
 						
 					</tr>
 			<%}%>
 			<form action = 'deleteItem.jsp', method="post">
	        <table>
	        <tr>
	        <td>Enter Item ID</td><td><input type="text" name="id"></td>
	        </tr>
	        </table>
	        <input type="submit" value="Delete Auction">
        	</form>
 	<%
    }else {
        out.println("Invalid Search <a href='cusrep-home.jsp'>Go Back</a>");
    }
    
    con.close();
%>

  
<%
}
%>
 				