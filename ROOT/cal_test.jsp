<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title> CallableStatement Test </title></head>
<body>
<%
    Connection myConn = null;
    String result = null;
    String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
    String sql = "";

    try {
        Class.forName(dbdriver);
        myConn = DriverManager.getConnection(dburl, user, passwd);
    } catch (SQLException ex) {
        System.err.println("SQLException : " + ex.getMessage());
    }
    CallableStatement ostmt = myConn.prepareCall("{call test(?, ?)}");
    ostmt.setInt(1, 20011234);
    ostmt.registerOutParameter(2, java.sql.Types.VARCHAR);

    try {
        ostmt.execute();
        result = ostmt.getString(2);
%>
<script>
    alert("<%= result %>");
</script>
<%        
    } catch (SQLException ex) {
        System.err.println("SQLException : " + ex.getMessage());
    } finally {
        if (ostmt != null)
            try {
                myConn.commit();
                ostmt.close();
                myConn.close();
            } catch (SQLException ex) {

            }
    }
%>
</body>
</html>