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

<br><br>
Delete a bid
<form action = 'findBid.jsp', method="POST">
       Enter the item name for bid: <input type="text" name="itemName"/> <br/>
       <input type="submit" value="Search by Keyword:"/>
</form>

Delete and auction
<form action = 'findItem.jsp', method="POST">
       Enter the item name: <input type="text" name="itemName"/> <br/>
       <input type="submit" value="Search by Keyword:"/>
</form>

Reset an account's password
    <br>
        <form action = 'resetPassword.jsp', method="post">
        <table>
        <tr>
        <td>Username</td><td><input type="text" name="username"></td>
        </tr>
        <tr>
        <td>New Password</td><td><input type="text" name="password1"></td>
        </tr>

        </table>
        <input type="submit" value="submit">
        </form>
    <br>
    
    <a href='cusRepFeedback.jsp'>Feedback</a>
    <a href='logout.jsp'>Log out</a>

    
<%
}
%>