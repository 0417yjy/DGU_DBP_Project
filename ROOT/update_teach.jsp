<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html>
	<head>
		<title>수강정원변경</title>
	<head>
	<body>	
	<%@ include file="top.jsp" %>
	<% if (session_id==null) response.sendRedirect("login.jsp"); %>
		<form method="post" action="update_teach_verify.jsp">
			<table width="75%" align="center" border>
				<tr>
					<th>과목번호</th>
					<th>분반</th>
					<th>과목명</th>
					<th>학점</th>
					<th>수강정원</th>
				</tr><br>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		CallableStatement cstmt1 = null;
		CallableStatement cstmt2 = null;
		String mySQL = "";
		String p_id = (String)session.getAttribute("user");
		int nYear = 0;
		int nSemester = 0;
		ResultSet myResultSet = null;
		
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:DBLAB";
		String user = "FE2015112135";	// 본인 아이디(ex.FE0000000000)
		String passwd = "FE2015112135";	// 본인 패스워드(ex.FE0000000000)
		String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	
		try {
			Class.forName(dbdriver);
	    	conn =  DriverManager.getConnection (dburl, user, passwd);
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}

		cstmt1 = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
		cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt1.execute();
		nYear = cstmt1.getInt(1);

		cstmt2 = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
		cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt2.execute();
		nSemester = cstmt2.getInt(1);
		
		mySQL = "select t.c_id as cid, t.c_id_no as cid_no, c.c_name as cname, c.c_unit as cunit, t.t_max as tmax "
			+ "from teach t inner join course c on t.c_id=c.c_id and t.c_id_no=c.c_id_no "
			+ "where t.p_id=? and t.t_year=? and t.t_semester=?";
		pstmt = conn.prepareStatement(mySQL);
		pstmt.setString(1, p_id);
		pstmt.setInt(2, nYear);
		pstmt.setInt(3, nSemester);
		myResultSet = pstmt.executeQuery();
		
		while (myResultSet.next()) {
			String cid = myResultSet.getString("cid");
			String cid_no = myResultSet.getString("cid_no");
			String cname = myResultSet.getString("cname");
			String cunit = myResultSet.getString("cunit");
			String tmax = myResultSet.getString("tmax");
	%>

				<tr>
					<td align="center"><%=cid%><input type="hidden" name="cid" value=<%=cid%>></td>
					<td align="center"><%=cid_no%><input type="hidden" name="cidno" value="<%=cid_no%>"></td>
					<td align="center"><%=cname%></td>
					<td align="center"><%=cunit%><input type="hidden" name="cunit" value="<%=cunit%>"></td>
					<td align="center"><input type="text" name="tmax" size=5 value="<%=tmax%>"></td>
				</tr>
	<%	
		}
		pstmt.close();  
		conn.close();
	%>
			</table><br>
			<table align="center">
				<tr> 
					<td><input type="submit" name="submit" value="수강정원변경"></td>
				</tr>
			</table>
		</form>		
	</body>
</html>

    