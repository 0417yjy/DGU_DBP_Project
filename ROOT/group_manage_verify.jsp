<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>Insert title here</title></head>
<body>
<%
    String session_id = (String)session.getAttribute("user");
	String groupid = request.getParameter("groupid");
	String groupname = request.getParameter("groupname");
	String groupdesc = request.getParameter("groupdesc");
	String newadmin = request.getParameter("newadmin");
    String newfa = request.getParameter("newfa");

	Connection myConn = null;  
	CallableStatement cstmt = null;  

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
    String sMessage = "";

	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		cstmt = myConn.prepareCall("{call UPDATEGROUP(?, ?, ?, ?, ?, ?)}");
        cstmt.setString(1, groupid);
        cstmt.setString(2, groupname);
        cstmt.setString(3, newadmin);
        cstmt.setString(4, newfa);
        cstmt.setString(5, groupdesc);
        cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
        cstmt.execute();
        sMessage = cstmt.getString(6);
%>
        <script>
            alert("<%= sMessage%>");       
            location.href="group_manage.jsp?memberid=<%=session_id%>&groupid=<%=groupid%>";
        </script>
<%        
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());	
	} finally {
		if (cstmt != null)   try { 	cstmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
