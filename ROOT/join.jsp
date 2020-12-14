<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head><title>그룹에 참여</title></head>
<body>
<%@ include file="top.jsp" %>
<%
	if (session_id==null) response.sendRedirect("login.jsp");
    String search_input = request.getParameter("search_input");
    if(search_input == null) search_input = "";

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
%>
    <form method="get" action="?">
        <table width="75%" align="center" border>
            <tr>
                <th>그룹 이름 검색</th>
                <td><input type="text" name="search_input" size="50" value="<%=search_input %>"> <input type="submit" value="검색"></td>
            </tr>
        </table>
    </form>
<%-- 그룹 이름 검색 --%>
<table width="75%" align="center" border>
<tr>
	<th rowspan=0>그룹</th>
</tr>
<%
    if(search_input != null) {
        try {
        mySQL = "select g.groupname, g.groupid from fishy_group g where g.groupname like '" + search_input + "%'";
        myResultSet = stmt.executeQuery(mySQL);
        while(myResultSet.next()) {
            String groupname = myResultSet.getString("groupname");
            String groupid = myResultSet.getString("groupid");    
%>
<tr>
	<td style="width: 91%;"><%= groupname %></td> <td><button onclick="location.href='join_verify.jsp?groupid=<%=groupid%>'">그룹에 참가</button></td>
</tr>
<%		
            }
            stmt.close();  
            myConn.close();
        } catch(SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
    }
%>
</body>
</html>
