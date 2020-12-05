<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%
    String groupname = request.getParameter("groupname");
    String groupid = request.getParameter("groupid");
%>
<!DOCTYPE html>
<html>
<head><title><%=groupname %></title></head>
<body>
<%@ include file="top.jsp" %>
<%
    String adminName = null;
    String faName = null;
    String groupdesc = null;

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
    // get admin and fa name
    mySQL = "select (select username from fishy_member where memberid=g.adminid) as admin, (select username from fishy_member where memberid=g.financialagentid) as financialagent from fishy_group g where g.groupid="  + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        adminName = myResultSet.getString("admin");
        faName = myResultSet.getString("financialagent");
    }

    // get group description
    mySQL = "select groupdesc from fishy_group g where g.groupid="  + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        groupdesc = myResultSet.getString("groupdesc");
    }
%>
<div align="center">
    <div style="width: 75%;" align="left">
        <h1><%= groupname %></h1>
        <h2><%= groupdesc %></h2>
        Admin: <b style="color: red;"><%= adminName %></b> <br>
        Financial Agent: <b style="color: blue;"><%= faName %></b>
    </div>
</div>
<%
    stmt.close();  
	myConn.close();
%>
</body>
</html>