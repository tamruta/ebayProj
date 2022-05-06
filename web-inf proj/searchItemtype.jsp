<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

ApplicationDB db = new ApplicationDB();	
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyElectronics", "root", "Rootuser!1");	
Statement st = con.createStatement();
Statement st2 = con.createStatement();
    
    String item_type = request.getParameter("itemType");   
        

    ResultSet rs;
    rs = st.executeQuery("select * from electronic_item as e, auction as a where e.item_type =" + "'" + item_type + "'" + " and e.item_id = a.item_id and a.auction_active = true");
    
    if (rs.next() == true) {
        session.setAttribute("item_Type", item_type); 
        %>
        <table border="1">
        <tr><th>item ID</th><th>Model Number</th><th>Item Type</th><th>Item Year</th><th>dimensions</th><th>memory</th><th>Specifications</th><th>Current Price</th></tr>
 				
 				<%
 				rs.previous();
 				while(rs.next()){%>
 				<%
 			    %>
 					<tr>
 						 <tr><td><%=rs.getInt("item_id")%></td>
 						 <td><%=rs.getInt("model_number")%></td>
 						 <td><%=rs.getString("item_type")%></td>
 						 <td><%=rs.getString("item_year")%></td>
 						 <td><%=rs.getString("dimensions")%></td>
 						 <td><%=rs.getString("item_memory")%></td>
 						 <td><%=rs.getString("specifications")%></td>
 						 <td><%=rs.getFloat("current_price")%></td><tr>
 		
 				<%}%>
 				
 		
 		</table>       
         <form action = 'bidding.jsp', method="post">
	        <table>
	        <tr>
	        <td>Enter Item ID You want to Bid On</td><td><input type="text" name="id"></td>
	        </tr>
	        <tr>
	        <td>Enter Bid Amount</td><td><input type="text" name="bid"></td>
	        </tr>
	        </table>
	        <input type="submit" value="Submit Bid">
        </form>
        
        <form action = 'autobid.jsp', method="post">
	        <table>
	        <tr>
	        <td>Enter Item ID You want to automatically Bid On</td><td><input type="text" name="id"></td>
	        </tr>
	        <tr>
	        <td>Enter Current Bid Price</td><td><input type="text" name="bid"></td>
	        </tr>
	        <tr>
	        <td>Enter Max Bid Price</td><td><input type="text" name="Maxbid"></td>
	        </tr>
	        <tr>
	        <td>Enter own bid increment, if it's lower than the seller set it will be replaced</td><td><input type="text" name="bidincrement"></td>
	        </tr>
	        </table>
	        <input type="submit" value="Submit Automatic Bid">
        </form>
        
        
        
 <%
    }else {
        out.println("No items exist of that type on the market, SORRY!");
    }
    
    
    
    
    
    con.close();
%>
<a href='welcome.jsp'>Go Back</a>
