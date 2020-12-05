<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head><title>마이페이지</title></head>
<body>
<%@ include file="top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("login.jsp");

	Connection myConn = null;     
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
  	    Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	    stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	    System.err.println("SQLException: " + ex.getMessage());
	}
    mySQL = "select * from fishy_member where memberid='" + session_id + "'" ;
	myResultSet = stmt.executeQuery(mySQL);
	if (myResultSet.next()) {
		String username = myResultSet.getString("username");
		String password = myResultSet.getString("password");
		String email = myResultSet.getString("email");
%>

<form method="post" action="mypage_verify.jsp">
  <input type="hidden" name="memberid" size="30" value="<%= session_id %>">
  <table width="75%" align="center" border>
     <tr><th>유저네임</th>
         <td><input type="text" name="username" size="50" value="<%= username %>" disabled> </td>
     </tr>
     <tr><th>패스워드</th>
         <td><input type="password" name="password" size="20"  value="<%= password %>"></td>
     </tr>
     <tr><th>이메일</th>
         <td><input type="text" name="email" size="50" value="<%= email %>"> </td>
     </tr>
<%
	}
%>
<tr>
	<td colspan="2" align="center">
	<input type="submit" value="수정">
	</td> 
</tr>
</table></form>
<%-- 이 멤버가 속해 있는 그룹 정보 --%>
<table width="75%" align="center" border>
<tr>
	<th>그룹</th>
</tr>
<%
	mySQL = "select g.groupname from fishy_group g, fishy_membergroup mg where mg.memberid=" + session_id + "and g.groupid=mg.groupid";
	myResultSet = stmt.executeQuery(mySQL);
	while(myResultSet.next()) {
		String groupname = myResultSet.getString("groupname");
%>
<tr>
	<td><%= groupname %></td>
</tr>
<%		
	}
	
%>
<tr>
	
</tr>
</table>
</body>
</html>
