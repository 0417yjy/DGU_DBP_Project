<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*, eduBean.*"%>
<html>
	<head>
		<title>강좌개설신청</title>
	<head>
	<body>	
	<%@ include file="top.jsp" %>
	<% 
		if (session_id==null) response.sendRedirect("login.jsp"); 
	%>
		<table width="75%" align="center" border>
			<tr>
				<th>과목번호</th>
				<th>분반</th>
				<th>과목명</th>
				<th>학점</th>
				<th>교수</th>
				<th>개설신청</th>
			</tr><br>
			
	<jsp:useBean id="courseMgr" class="eduBean.CourseMgr" />
	<%
		Vector vlist = courseMgr.getCourseList();
		
		for(int i=0; i<vlist.size(); i++) {
			Course en = (Course)vlist.elementAt(i);
	%>
			<tr>
				<td align="center"><%=en.getCId()%></td>
				<td align="center"><%=en.getCIdNo()%></td>
				<td align="center">
			<% if(session_id.equals(en.getPId())) { %>
					<a href="update_class.jsp?p_id=<%=en.getPId()%>&c_id=<%= en.getCId() %>&c_id_no=<%= en.getCIdNo() %>"><%}%><%=en.getCName()%>
				</td>
				<td align="center"><%=en.getCUnit()%></td>
				<td align="center">
			<% if (en.getPName() == null) { %>
					&nbsp;
			<% } else { %>
				<%=en.getPName()%>
			<% } %>
				</td>
				<td align="center">
			<% if(en.getPId() == null) { %>
					<a href="insert_teach_verify.jsp?c_id=<%= en.getCId() %>&c_id_no=<%= en.getCIdNo() %>&type=1">신청</a>
			<% } else if(session_id.equals(en.getPId())) { %>
					<a href="insert_teach_verify.jsp?c_id=<%= en.getCId() %>&c_id_no=<%= en.getCIdNo() %>&type=2">취소</a>
			<% } else { %>
					&nbsp;
			<% } %>
				</td>	
			<% } %>
			</tr>
		</table> 
	</body>
</html>
