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
<a href='logout.jsp'>Log out</a>

<br>
	Create a Customer Representative : 
     <br>
        <form action = 'registercustomerRep.jsp', method="post">
        <table>
        <tr>
        <td>Username</td><td><input type="text" name="username"></td>
        </tr>
        <tr>
        <td>Password</td><td><input type="text" name="password1"></td>
        </tr>
        <tr>
        <td>Confirm Password</td><td><input type="text" name="password2"></td>
        </tr>
        </table>
        <input type="submit" value="Register">
        </form>
      <br>
     Create Sales Report
		 <form action = 'SalesReport.jsp', method="post">
	        <table>
	        <tr>
	        </tr>
	      
	        </table>
	        <input type="submit" value="Create">
        </form>
<%
    }
%>
