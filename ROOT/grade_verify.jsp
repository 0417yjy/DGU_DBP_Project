<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<html>
	<head>
		<title>성적등록</title>
	</head>
	<body>
	
	<jsp:useBean id="gradeMgr" class="eduBean.GradeMgr" />
	
	<%	
		String year = request.getParameter("year");
		String semester = request.getParameter("semester");
		if (year.length()!=0 & semester.length()!=0){
			String url = "grade.jsp?year="+ year + "&semester=" + semester;
			response.sendRedirect(url);
		}else{
			year = Integer.toString(gradeMgr.getCurrentYear());
			semester = Integer.toString(gradeMgr.getCurrentSemester());
			String url = "grade.jsp?year="+ year + "&semester=" + semester;			
	%>
	<script>
		alert("년도 혹은 학기를 입력해주세요.");
		location.href = "<%=url%>"
	</script>
	<%	} %>
	</body>
</html>
