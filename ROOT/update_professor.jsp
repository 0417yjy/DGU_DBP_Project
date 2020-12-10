<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
	<head>
		<title>교수정보변경</title>
	</head>
	<body>
	<%@ include file="top.jsp" %>
	<%
		if (session_id==null) response.sendRedirect("login.jsp");
	
		Connection myConn = null;     
		Statement stmt = null;	
		ResultSet myResultSet = null; 
		String mySQL = "";
	
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "FE2015112135";	// 본인 아이디(ex.FE0000000000)
		String passwd = "FE2015112135";	// 본인 패스워드(ex.FE0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	
		try {
			Class.forName(dbdriver);
	    	myConn =  DriverManager.getConnection (dburl, user, passwd);
	    	stmt = myConn.createStatement();	
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		
			mySQL = "select * from professor where p_id='" + session_id + "'" ;
			myResultSet = stmt.executeQuery(mySQL);
		
		if (myResultSet.next()) {
			String p_name = myResultSet.getString("p_name");
			String p_college = myResultSet.getString("p_college");
			String p_major = myResultSet.getString("p_major");
			String p_research = myResultSet.getString("p_research");
			String p_pwd = myResultSet.getString("p_pwd");
	%>
		<form name="update_prof" method="post" action="update_professor_verify.jsp">
			<input type="hidden" name="p_id" size="30" value="<%= session_id %>">
			<table width="75%" align="center" border>
				<tr>
					<th>이름</th>
					<td><input type="text" name="p_name" size="50" value="<%= p_name %>" disabled></td>
				</tr>
			 	<tr>
					<th>학부</th>
					<td><input type="text" name="p_college" size="50" value="<%= p_college %>" disabled> </td>
				</tr>				
			 	<tr>
			 		<th>전공</th>
			 		<td><input type="text" name="p_major" size="50" value="<%= p_major %>" disabled></td>
				</tr>
				<tr>
			 		<th>연구분야</th>
			 		<td><input type="text" name="p_research" size="50" value="<%= p_research %>"></td>
				</tr>				
				<tr>
					<th>패스워드</th>
				   	<td><input type="password" name="p_pwd" size="20"  value="<%= p_pwd %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="수정"></td> 
				</tr>
			</table>
		</form>
	<%
		}	
		stmt.close();  
		myConn.close();
	%>
	</body>
</html>