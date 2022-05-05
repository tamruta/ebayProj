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
Welcome <%=session.getAttribute("userID")%> 

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
    rs = st.executeQuery("Select * from auction where item_id like '%" + item + "%'");

    if (rs.next() == true) {
        session.setAttribute("itemName", item); //delete?
        //response.sendRedirect("HelloWorld.jsp");
       // rs.first();
        %>
 		<table>
 			<tr>
 				<td>Bid ID</td>
 				<td>Item Type</td>
 				<td>Current Price</td>
				<td>Seller</td>
				<td>Buyer</td>
 				<td>Closing Date</td>
 				
 			</tr>
 				<%
 				rs.previous();
 				while(rs.next()){%>
 					<tr>
 						<td><%=rs.getInt("auction_id")%></td>
 						<td><%=rs.getInt("item_id")%></td>
 						<td><%=rs.getFloat("current_price")%></td>
						<td><%=rs.getInt("seller_id")%></td>
 						<td><%=rs.getInt("buyer_id")%></td>
 						<td><%=rs.getString("closingdate")%></td>
 						
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
        out.println("Invalid Search <a href='cusrep-home.jsp'>Go Back</a>");
    }
    
    con.close();
%>
 				
  
<%
}
%>