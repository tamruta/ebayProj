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

Look at questions
<form action = '.jsp', method="POST">
       Enter the item name for bid: <input type="text" name="itemName"/> <br/>
       <input type="submit" value="Search by Keyword:"/>
</form>

Delete a bid
<form action = 'cusrep-remove-bid.jsp', method="POST">
       Enter the auction/bid id: <input type="text" name="itemName"/> <br/>
       <input type="submit" value="Search by Keyword:"/>
</form>

Delete an auction
<form action = 'cusrep-remove-auction.jsp', method="POST">
       Enter the item id: <input type="text" name="itemName"/> <br/>
       <input type="submit" value="Search by Keyword:"/>
</form>

Edit an account
    <br>
        <form action = 'cusrep-edit-acc-info.jsp', method="post">
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