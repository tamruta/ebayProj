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

<br><br>

<a href="#" onclick="history.go(-1)">Go Back onclick</a>


<%
}
%>