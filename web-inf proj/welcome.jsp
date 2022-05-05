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
      background-color: rgb(212, 166, 166);
      color: white;
      text-align: center;
    } </style>
    
    <div class="footer"> 
      <p><a href='welcome.jsp'>Home</a><a href='logout.jsp'>Log out</a></p>
    </div>

Put Items up for Sale
<form action = 'auctionItem.jsp', method="POST">
		Model Number: <input type="text" name="model_number"/> <br/>
		Year: <input type="text" name="yearn"/> <br/>
       Type of Item(Monitor, Laptop or Desktop): <input type="text" name="itemType"/> <br/>
       Item Description(Monitor dimensions, Laptop memory or Desktop GPU): <input type="text" name="description"/> <br/>
       Starting Price of item: <input type="text" name="startingPrice"/> <br/>
       Minimum price that item will be sold at: <input type="text" name="minPrice"/> <br/>
       Maximum price that item will be sold at: <input type="text" name="maxPrice"/> <br/>
       Bid increment: <input type="text" name="bidIncrement"/> <br/>
       Closing date (YYYY-MM-DD HH:MM:SS): <input type="text" name="closing_date"/> <br/>
 
       <input type="submit" value="Post Item"/>
</form>

<%
    }
%>
