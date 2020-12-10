<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
	<head>
		<title>과목정보수정</title>
	</head>
	<body>
	<%@ include file="top.jsp" %>
	<%
		if (session_id==null) response.sendRedirect("login.jsp");
	
		Connection conn = null;     
		Statement stmt = null;	
		ResultSet myResultSet = null; 
	   	CallableStatement cstmt1 = null;
		CallableStatement cstmt2 = null;
	   	int nYear = 0;
		int nSemester = 0;
		String mySQL = "";
	
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "FE2015112135";	// 본IN 아이디(ex.FE0000000000)
		String passwd = "FE2015112135";	// 본IN 패스워드(ex.FE0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	   
		String cid = request.getParameter("c_id");                                                             
		String cidno = request.getParameter("c_id_no");    
	
		try {
			Class.forName(dbdriver);
	    	conn =  DriverManager.getConnection (dburl, user, passwd);
	    	stmt = conn.createStatement();

			cstmt1 = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt1.execute();
			nYear = cstmt1.getInt(1);

			cstmt2 = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
			cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt2.execute();
			nSemester = cstmt2.getInt(1);

			mySQL = "select c.c_name as cname, t.t_where as twhere, t.t_time as ctime, p.p_name as pname"
				+ " from teach t inner join course c on t.c_id=c.c_id and t.c_id_no=c.c_id_no"
				+ " inner join professor p on t.p_id=p.p_id where t.c_id='" + cid + "' and t.c_id_no=" + cidno;
			myResultSet = stmt.executeQuery(mySQL);
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}                                                      
	  
		if (myResultSet.next()) {
			String c_name = myResultSet.getString("cname");
			String c_twhere = myResultSet.getString("twhere");
			String c_time = myResultSet.getString("ctime");
			String p_name = myResultSet.getString("pname");
	%>
		<form name="update_class" method="post" action="update_class_verify.jsp">
			<input type="hidden" name="p_id" size="30" value="<%= session_id %>">
			<table width="75%" align="center" border>
				<tr>
					<th>과목명</th>
					<td><%= c_name %></td>
				</tr>
				<tr>
					<th>분반</th>
					<td><%= cidno %><input type="hidden" name="c_id_no" value="<%=cidno%>"></td>
				</tr>
				<tr>
				 	<th>교수명</th>
					<td><%= p_name %></td>
				</tr>
				<tr>
			    	<th>강의실</th>
					<td>
						<select name="t_where">
							<option value=""></option>
							<option value="IN-201">IN-201</option>
							<option value="IN-202">IN-202</option>
							<option value="IN-309">IN-309</option>
							<option value="IN-310">IN-310</option>
							<option value="SW-201">SW-201</option>
							<option value="SW-202">SW-202</option>
							<option value="SW-301">SW-301</option>
							<option value="SW-417">SW-417</option>
						</select>
					</td>
				</tr>      
				<tr>
					<th>시간</th>
				<% if (c_time == null) {%>
						<td><input type="text" name="t_time" size="5"  value=""></td>
				<% } else { %>
						<td><input type="text" name="t_time" size="5"  value="<%= c_time %>"></td>
				<% } %>					
				</tr>      
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" name="c_id" value="<%=cid%>">
						<input type="submit" value="수정">
					</td> 
				</tr>
			</table>
		</form>
		<script>
			document.update_class.t_where.value = "<%=c_twhere%>";
		</script>
	<%
		}	
		cstmt1.close();  
		cstmt2.close();  
		stmt.close();  
		conn.close();
	%>
	</body>
</html> 