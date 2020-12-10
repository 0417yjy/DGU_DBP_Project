<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, eduBean.*" %>
<html>
	<head>
		<title>성적등록</title>
	</head>
	<body>
	
		<jsp:useBean id="gradeMgr" class="eduBean.GradeMgr" />
			
		<script>
			var message = "";
		<%
			String sMessage;
			
			request.setCharacterEncoding("utf-8");
			int year = Integer.parseInt(request.getParameter("year"));
			int semester = Integer.parseInt(request.getParameter("semester"));						
			String result = null;
			String cid[] = request.getParameterValues("cid");			
			String cidnos[] = request.getParameterValues("cidno");
			int [] cidno = new int [cidnos.length];
			for(int i = 0; i < cidnos.length; i++) { cidno[i] = Integer.parseInt(cidnos[i]); }
			String cname[] = request.getParameterValues("cname");
			String sid[] = request.getParameterValues("sid");
			String sname[] = request.getParameterValues("sname");
			String scores[] = request.getParameterValues("score");
			String scounter = request.getParameter("counter");
			int counter = Integer.parseInt(scounter);			
			String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
			String user = "FE2015112135";	// 본인 아이디(ex.ST0000000000)
			String passwd = "FE2015112135";	// 본인 패스워드(ex.ST0000000000)
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			
			Connection myConn = null;     
			CallableStatement cstmt = null;
			
			try {
				myConn =  DriverManager.getConnection (dburl, user, passwd);
				for(int i=0;i<cid.length;i++) {
					result = gradeMgr.setScore(scores[i], sid[i], cid[i], cidno[i], year, semester);
					if (result.equals("20002")){
						result = "등록 불가(사유 : 현재 학기 성적만 입력 가능합니다.)";
		%>
						message = message + "<%=result%>" + "\n"
			<%
						break;
					} else if(result.equals("20003")){
						result = "등록 불가(사유 : 학기 중에만 성적 입력 가능합니다.)";
			%>
						message = message + "<%=result%>" + "\n"
			<%
						break;
					} else {
						result = cname[i] + "-" + sname[i] + "-" + result;
			%>
						message = message + "<%=result%>" + "\n"
			<%
					}
			      }
			} catch(SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			} 	
		%>		
			alert(message);
			location.href = "grade.jsp?year=<%=year%>&semester=<%=semester%>";
		</script>
		
	</body>
</html>
