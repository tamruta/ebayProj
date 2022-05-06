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
    
    String item = request.getParameter("auctionid");   
        
	
    ResultSet rs;
    rs = st.executeQuery("Select * from viewHistory where auction_id like '%" + item + "%'");

    if (rs.next() == true) {
        session.setAttribute("itemName", item); //delete?
        //response.sendRedirect("HelloWorld.jsp");
       // rs.first();
        %>
 		<table border="2" cellpadding="5">
 			<tr>
 				<td>Bid ID</td>
 				<td>Item ID</td>
 				<td>Current Price</td>
				<td>Seller</td>
				<td>Buyer</td>
 				
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
 				</tr>
 			<%}%>
		</table>
		

		<br><br>

		Delete Bid
 		<form action = 'cusrep-delete-bid.jsp', method="post">
	    	Enter Bid ID of bid to delete </td><td><input type="text" name="bidid"><br>
	    	Enter Seller ID </td><td><input type="text" name="sellerid"><br>
        <input type="submit" value="Delete Bid">
    	</form><br>
		Delete Item/Auction
		<form action = 'cusrep-delete-auction.jsp', method="post">
			Enter Item ID</td><td><input type="text" name="id"><br>
			<input type="submit" value="Delete Item">
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