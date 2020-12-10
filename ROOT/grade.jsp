<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*, eduBean.*"%>
<html>
	<head>
		<title>성적등록</title>
	<head>
	<body>
		<%@ include file="top.jsp" %>
		<% if (session_id==null) response.sendRedirect("login.jsp"); %>
		<form method="post" action="update_score_verify.jsp">
			<table width="75%" align="center" border>
				<tr>
					<th>과목번호</th>
					<th>분반</th>
					<th>과목명</th>
					<th>학번</th>
					<th>학생</th>
					<th>점수</th>
					<th>성적</th>
				</tr><br>
				
				<jsp:useBean id="gradeMgr" class="eduBean.GradeMgr" />
				
			<%
				Vector vlist = null;
				int year, semester;
			
				if (request.getParameter("year") == null && request.getParameter("semester") == null) {
					year = gradeMgr.getCurrentYear();
					semester = gradeMgr.getCurrentSemester();
				} else {
					year = Integer.parseInt(request.getParameter("year"));
					semester = Integer.parseInt(request.getParameter("semester"));
				}
			
				vlist = gradeMgr.getScoreList(session_id, year, semester);
				int counter = vlist.size();
			
				for(int i=0; i<vlist.size(); i++) {
					Grade tr = (Grade)vlist.elementAt(i);
			%>
				<tr>
					<td align="center">
						<%=tr.getCId()%><input type="hidden" name="cid" value="<%=tr.getCId()%>">
					</td>
					<td align="center">
						<%=tr.getCIdNo()%><input type="hidden" name="cidno" value="<%=tr.getCIdNo()%>">
					</td>
					<td align="center">
						<%=tr.getCName()%><input type="hidden" name="cname" value="<%=tr.getCName()%>">
					</td>
					<td align="center">
						<%=tr.getSId()%><input type="hidden" name="sid" value="<%=tr.getSId()%>">
					</td>
					<td align="center">
						<%=tr.getSName()%><input type="hidden" name="sname" value="<%=tr.getSName()%>">
					</td>
					<td align="center">
						<input type="text" name="score" size="5" value="<%=tr.getEScore()%>">
					</td>
					<td align="center">
			<% if (tr.getEGrade() == null) {%>
						&nbsp;
			<% } else { %>
						<%=tr.getEGrade()%>
			<% } %>
					</td>
				</tr>
			<%	}  %>
				<input type="hidden" name="counter" value="<%=vlist.size()%>">
				<input type="hidden" name="p_id" size="30" value="<%=session_id%>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="semester" size="30" value="<%=semester%>">    
			</table><br>
			<table align="center">
				<tr>
					<td>
						<input type="submit" name="submit" value="성적일괄등록">
					</td>
				</tr>
			</table>
		</form><br><br>
		<form method="post" action="grade_verify.jsp" >
			<table width="30%" align="center">			
				<tr>
					<td>
						<input type="text" name="year" value=<%= year %> size=4> 년도
						<input type="text" name="semester" value=<%= semester %> size=1> 학기
						<input type="submit" name="submit" value="조회">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
