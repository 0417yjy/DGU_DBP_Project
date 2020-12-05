<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%
    String groupname = request.getParameter("groupname");
    String groupid = request.getParameter("groupid");
%>
<!DOCTYPE html>
<html>
<head>
<title><%=groupname %></title>
<style>
.flex-container {
    display: flex;
}
.flex-container > div {
    flex: 1;
}
.flex-box {
    margin: 5px;
    padding-left: 20px;
    border-radius: 25px;
    border: 2px solid;
    height: 400px;
}
#process_required {
    background: #ff7777;
}
#send_required {
    background: #66b3ff;
}
#accepted {
    background: #99ff99;
}
</style>
</head>
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
        관리자: <b style="color: red;"><%= adminName %></b> <br>
        총무: <b style="color: blue;"><%= faName %></b> <br>
        멤버: <b>| </b>
<%
    // get group description
    mySQL = "select distinct m.username from fishy_member m, fishy_membergroup mg where mg.groupid="  + groupid + " and m.username not in ("
    + "(select m.username from fishy_member m, fishy_group g where m.memberid=g.adminid and g.groupid =" + groupid + ")"
    + " UNION (select m.username from fishy_member m, fishy_group g where m.memberid=g.financialagentid and g.groupid =" + groupid + "))";
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String participant = myResultSet.getString("username");
%>
    <b><%= participant %> | </b>
<%
    }
%>
        <div class="flex-container">
            <div class="flex-box" id="process_required">
                <h3> 처리를 기다리는 중 </h3>
            </div>
            <div class="flex-box" id="send_required">
                <h3> 송금을 기다리는 중 </h3>
            </div>
        </div>
        <div class="flex-container">
            <div class="flex-box" id="accepted"">
                <h3> 완료됨 </h3>
            </div>
        </div>
    </div>
</div>
<%
    stmt.close();  
	myConn.close();
%>
</body>
</html>