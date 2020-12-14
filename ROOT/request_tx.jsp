<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>Request a transaction</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha256-4+XzXVhsDmqanXGHaHvgh1gMQKX40OUvDEBTu8JcmNs=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
	<%@ include file="top.jsp" %>
<%
    if (session_id==null) response.sendRedirect("login.jsp");
    String req_groupid = request.getParameter("groupid");

    Connection conn = null;
    Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";

    String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";

    Boolean connect = false;

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, "ST2015112135", "ST2015112135");
        stmt = conn.createStatement();
    }
    catch(Exception e) {
        System.err.println("SQLException: " + e.getMessage());
    }
%>
    <script>
    function groupsOnChange() {
        var selected_groupid = document.getElementById("groups").value;
        location.replace("request_tx.jsp?groupid=" + selected_groupid);
    }
    </script>
    <table width="75%" align="center" border>
        <form method=post" action="request_tx_action.jsp">
            <tr>
                <td><div align="center">그룹 선택</div></td>
                <td><div align="center">
                <select onchange="groupsOnChange()" id="groups" name="groups">
<%
    if(req_groupid==null) {
%>
            <option value="" selected disabled hidden>그룹 선택</option>
<%            
    }
    mySQL = "select g.groupid, g.groupname from fishy_group g, fishy_membergroup mg where mg.groupid=g.groupid and mg.memberid='" + session_id + "'" ;
	myResultSet = stmt.executeQuery(mySQL);
	while (myResultSet.next()) {
		String groupid = myResultSet.getString("groupid");
		String groupname = myResultSet.getString("groupname");

        if(req_groupid != null && req_groupid.equals(groupid)) {
%>
            <option value="<%= groupid %>" selected><%= groupname%></option>
<%            
        } else {
%>
            <option value="<%= groupid %>"><%= groupname%></option>
<%            
        }
    }
%>
                </select>
                </div></td>
            </tr>
            <tr>
                <td><div align="center">멤버 선택</div></td>
                <td><div align="center">
                <select id="members" name="members">
                    <option value="" selected disabled hidden>멤버 선택</option>
<%
    if(req_groupid == null) {

%>
                    
<%
    }
    else {
        mySQL = "select m.memberid, m.username from fishy_member m, fishy_membergroup mg where m.memberid=mg.memberid and mg.groupid=" + req_groupid;
        myResultSet = stmt.executeQuery(mySQL);
        while (myResultSet.next()) {
            String memberid = myResultSet.getString("memberid");
            String username = myResultSet.getString("username");
%>
                    <option value="<%= memberid %>"><%= username%></option>
<%        
        }
    }
%>
                </select>
            </tr>
            <tr>
                <td><div align="center">통화 선택</div></td>
                <td><div align="center">
                    <select id="currencies" name="currencies">
                    <option value="" selected disabled hidden>통화 선택</option>
<%
    mySQL = "select currencyid, currencyname, currencysymbol from fishy_currency";
    myResultSet = stmt.executeQuery(mySQL);
    while (myResultSet.next()) {
        String currencyid = myResultSet.getString("currencyid");
        String currencyname = myResultSet.getString("currencyname");
        String currencysymbol = myResultSet.getString("currencysymbol");
%>
                    <option value="<%= currencyid %>"><%= currencyname%> <%= currencysymbol%></option>
<%
    }
%>
                    </select>
                </div></td>
            </tr>
            <tr>
                <td><div align="center">액수 입력</div></td>
                <td><div align="center">
                    <input type="text" name="amount"></input>
                </div></td>
            </tr>
            <tr>
            <tr>
                <td><div align="center">날짜 입력</div></td>
                <td><div align="center">
                    <input class="dp" type="text" name="startdate" id="datepicker_start"></input>

                    <input type="checkbox" name="is_duedate_inserted" value="true">기한</input>
                    <input class="dp" type="text" name="duedate" id="datepicker_end" disabled></input>
                </div></td>

                <script>
                $('input[name=is_duedate_inserted').change(function() {
                    var is_checked = $('input[name=is_duedate_inserted').is(":checked");
                    $('#datepicker_end').attr('disabled', !is_checked);
                    $('#datepicker_end').datepicker('option', 'disabled', !is_checked);
                })

                $(function() {
                    //input을 datepicker로 선언
                    $(".dp").datepicker({
                        dateFormat: 'yy-mm-dd' //Input Display Format 변경
                        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                        ,changeYear: true //콤보박스에서 년 선택 가능
                        ,changeMonth: true //콤보박스에서 월 선택 가능                
                        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                        ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                        ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                        ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                        ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
                    });                    
                    
                    //초기값을 오늘 날짜로 설정
                    $('#datepicker_start').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
                });
                </script>
            </tr>
            <tr>
                <td><div align="center">설명 입력</div></td>
                <td><div align="center">
                    <input type="checkbox" name="is_desc_inserted" value="true">사용</input>
                    <input type="text" name="desc" id="desc" width="100" disabled></input>
                </div></td>

                <script>
                $('input[name=is_desc_inserted').change(function() {
                    var is_checked = $('input[name=is_desc_inserted').is(":checked");
                    $('#desc').attr('disabled', !is_checked);
                })
                </script>
            </tr>
            <tr>
                <td colspan=2>
                    <div align="center">
                        <input type="submit" name="submit" value="생성">
                        <input type="reset" value="취소">
                    </div>
                </td>
            </tr>
        </form>
    </table>
</body>
</html>