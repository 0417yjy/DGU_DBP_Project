<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="eduBean.*" %>
<html>
	<head>
		<title>강좌개설신청</title>
	</head>
	<body>
	<%
		String p_id = (String)session.getAttribute("user");
		String c_id = request.getParameter("c_id");
		int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
		int type = Integer.parseInt(request.getParameter("type"));
		String result = null;
	%>
	
	<jsp:useBean id="courseMgr" class="eduBean.CourseMgr" />
	
	<%
		if (type == 1) {
			
			courseMgr.insertTeach(p_id, c_id, c_id_no);
			
	%>
		<script>
			alert("해당 과목의 개설 신청이 완료되었습니다.");
		</script>
	<%
		} else {
			result = courseMgr.deleteTeach(p_id, c_id, c_id_no);
			
	%>
		<script>
			alert("<%=result%>");
		</script>
	<%	}	%>
		<script>
			location.href="insert_teach.jsp";
		</script>    
	</body>
</html>
