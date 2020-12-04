<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;

    String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";

    Boolean connect = false;

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, "ST2015112135", "ST2015112135");
        connect = true;
        conn.close();
    }
    catch(Exception e) {
        connect = false;
        out.print(e);
    }
%>
<!DOCTYPE html>
<html>
<head><title>데이터베이스를 활용한 수강신청 시스템입니다.</title></head>
<body>
	<%@ include file="top.jsp" %>
	<table width="100%" align="center" height="100%">
	<% if(session_uname != null) { %>
		<tr>
			<td align="center"><%=session_uname%>님 방문을 활영합니다</td>
		</tr>	
	<% } else {	%>
		<tr>
			<td align="center"> 로그인한 후 사용하세요.</td>
		</tr>
	<% } %>
	</table>
</body>
</html>