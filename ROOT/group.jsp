<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%
    String groupname = request.getParameter("groupname");
    String groupid = request.getParameter("groupid");
%>
<!DOCTYPE html>
<html>

<head>
    <title><%=groupname %></title>
    <style>
        .flex-container {
            display: flex;
        }

        .flex-container>div {
            flex: 1;
        }

        .flex-box {
            margin: 5px;
            padding-left: 20px;
            border-radius: 25px;
            border: 2px solid;
            height: 400px;
            overflow: auto;
        }

        #process_required {
            background: #ff7777;
        }

        #send_required {
            background: #77c4ff;
        }

        #accepted {
            background: #99ff99;
        }

        /* 공통 트랜지션 리스트 스타일 */
        .transaction_list {
            list-style: none;
            margin: 0px;
            padding: 0px;
        }

        .transaction_list_item {
            border-radius: 25px;
            padding: 8px;
            margin: 10px;
            width: fit-content;
        }

        div.transaction_detail {
            border-radius: 25px;
            padding: 4px 5px;
            display: inline;
            text-align: center;
        }

        .button {
            display: inline-block;
            border-radius: 25px;
            color: white;
            font-style: bold;
            text-align: center;
            padding: 9px 20px;
            width: fit-content;
            cursor: pointer;
            margin: 0px;
        }

        .button span {
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.5s;
        }

        .button span:after {
            content: '\00bb';
            position: absolute;
            opacity: 0;
            top: 0;
            right: -20px;
            transition: 0.5s;
        }

        .button:hover span {
            padding-right: 25px;
        }

        .button:hover span:after {
            opacity: 1;
            right: 0;
        }

        /* --------------- 송금을 기다리는 중 리스트 스타일 ------------------*/
        .transaction_list_item.send_required {
            color: white;
            background: #4d79ff;
        }

        .send_required .date {
            background: #002080;
        }

        .send_required .from {
            /* background: #5200cc; */
            font-weight: bold;
            color: white;
        }

        .send_required .amount {
            color: yellow;
        }

        .send_required .desc {
            color: white;
        }

        .send_required .to {
            color: whitesmoke;
            font-weight: bold;
            font-style: italic;
        }

        .button.send {
            background-color: #fd6969;
        }



        /* --------------- 처리를 기다리는 중 스타일 --------------- */
        .transaction_list_item.sent {
            color: white;
            background: #ff2626;
        }

        .sent .date {
            background: #911313;
        }

        .sent .from {
            /* background: #5200cc; */
            font-weight: bold;
            color: white;
        }

        .sent .amount {
            color: yellow;
        }

        .sent .desc {
            color: white;
        }

        .sent .to {
            color: whitesmoke;
            font-weight: bold;
            font-style: italic;
        }

        .button.accept {
            background-color: #83da83;
        }

        .button.reject {
            background-color: #5d9bca;
        }


        /* --------------- 완료됨 스타일 --------------- */
        .transaction_list_item.accepted {
            color: white;
            background: #16c916;
            display: inline-block;
        }

        .accepted .date {
            background: #107938;
        }

        .accepted .from {
            /* background: #5200cc; */
            font-weight: bold;
            color: white;
        }

        .accepted .amount {
            color: yellow;
        }

        .accepted .desc {
            color: white;
        }

        .accepted .to {
            color: whitesmoke;
            font-weight: bold;
            font-style: italic;
        }
    </style>
</head>

<body>
    <%@ include file="top.jsp" %>
    <%
    String adminName = null;
    String faName = null;
    String groupdesc = null;

    Connection myConn = null;     
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="ST2015112135"; // 본인 아이디(ex.ST0000000000)
	String passwd="ST2015112135"; // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
  	    Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	    stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	    System.err.println("SQLException: " + ex.getMessage());
	}
    // get admin and fa name
    mySQL = "select (select username from fishy_member where memberid=g.adminid) as admin, (select username from fishy_member where memberid=g.financialagentid) as financialagent from fishy_group g where g.groupid="  + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        adminName = myResultSet.getString("admin");
        faName = myResultSet.getString("financialagent");
    }

    // get group description
    mySQL = "select groupdesc from fishy_group g where g.groupid="  + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next()) {
        groupdesc = myResultSet.getString("groupdesc");
    }
%>
    <div align="center">
        <div style="width: 75%;" align="left">
            <h1><%= groupname %></h1>
            <h2><%= groupdesc %></h2>
            관리자: <b style="color: red;"><%= adminName %></b> <br>
            총무: <b style="color: blue;"><%= faName %></b> <br>
            멤버: <b>| </b>
            <%
    // get normal participants
    mySQL = "select m.username from fishy_member m, fishy_membergroup mg where mg.groupid="  + groupid + " and m.memberid=mg.memberid and m.username not in ("
    + "(select m.username from fishy_member m, fishy_group g where m.memberid=g.adminid and g.groupid =" + groupid + ")"
    + " UNION (select m.username from fishy_member m, fishy_group g where m.memberid=g.financialagentid and g.groupid =" + groupid + "))";
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String participant = myResultSet.getString("username");
%>
            <b><%= participant %> | </b>
            <%
    }
%>
            <div class="flex-container">
                <div class="flex-box" id="process_required">
                    <h3> 처리를 기다리는 중 </h3>
                    <ul class="transaction_list">
                        <%
    // get sent transactions
    mySQL = "select transactionid, "
             + "(select username from fishy_member where memberid=t.towhom) as towhom, "
             + "(select username from fishy_member where memberid=t.fromwho) as fromwho, "
             + "to_char(arisedate, 'yyyy-mm-dd') as arisedate, "
             + "to_char(duedate, 'yyyy-mm-dd') as duedate, "
             + "description, amount, c.currencysymbol from fishy_transaction t, fishy_currency c where status='Sent' and t.currencyid = c.currencyid and groupid=" + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String txid = myResultSet.getString("transactionid");
        String towhom = myResultSet.getString("towhom");
        String fromwho = myResultSet.getString("fromwho");
        String arisedate = myResultSet.getString("arisedate");
        String duedate = myResultSet.getString("duedate");
        String description = myResultSet.getString("description");
        String amount = myResultSet.getString("amount");
        String currencysymbol = myResultSet.getString("currencysymbol");
%>
                        <li>
                            <div class="transaction_list_item sent">
                                <div class="transaction_detail date">
                                    <%= arisedate %>
                                </div>
                                <div class="transaction_detail from">
                                    <%= fromwho %>
                                </div>
                                <div class="transaction_detail amount">
                                    <%= currencysymbol + amount %>
                                </div>
                                <%
    if(description != null) {
%>
                                <div class="transaction_detail desc">
                                    <%= description %>
                                </div>
                                <%
    }
%>
                                -->
                                <div class="transaction_detail to">
                                    <%= towhom %>
                                </div>
                                <!-- buttons -->
                                <button class="button accept" style="vertical-align: middle;"
                                    onclick="location.href='tx_update.jsp?action=Accepted&txid=<%=txid %>'"><span>Accept
                                    </span></button>
                                <button class="button reject" style="vertical-align: middle;"
                                    onclick="location.href='tx_update.jsp?action=Requested&txid=<%=txid %>'"><span>Reject
                                    </span></button>
                            </div>
                        </li>
                        <%
    }
%>
                    </ul>
                </div>
                <div class="flex-box" id="send_required">
                    <h3> 송금을 기다리는 중 </h3>
                    <ul class="transaction_list">
                        <%
    // get requested transactions
    mySQL = "select transactionid, "
             + "(select username from fishy_member where memberid=t.towhom) as towhom, "
             + "(select username from fishy_member where memberid=t.fromwho) as fromwho, "
             + "to_char(arisedate, 'yyyy-mm-dd') as arisedate, "
             + "to_char(duedate, 'yyyy-mm-dd') as duedate, "
             + "description, amount, c.currencysymbol from fishy_transaction t, fishy_currency c where status='Requested' and t.currencyid = c.currencyid and groupid=" + groupid;
	myResultSet = stmt.executeQuery(mySQL);
    while(myResultSet.next()) {
        String txid = myResultSet.getString("transactionid");
        String towhom = myResultSet.getString("towhom");
        String fromwho = myResultSet.getString("fromwho");
        String arisedate = myResultSet.getString("arisedate");
        String duedate = myResultSet.getString("duedate");
        String description = myResultSet.getString("description");
        String amount = myResultSet.getString("amount");
        String currencysymbol = myResultSet.getString("currencysymbol");
%>
                        <li>
                            <div class="transaction_list_item send_required">
                                <div class="transaction_detail date">
                                    <%= arisedate %>
                                </div>
                                <div class="transaction_detail from">
                                    <%= fromwho %>
                                </div>
                                <div class="transaction_detail amount">
                                    <%= currencysymbol + amount %>
                                </div>
                                <%
    if(description != null) {
%>
                                <div class="transaction_detail desc">
                                    <%= description %>
                                </div>
                                <%
    }
%>
                                -->
                                <div class="transaction_detail to">
                                    <%= towhom %>
                                </div>
                                <!-- send button -->
                                <button class="button send" style="vertical-align: middle;"
                                    onclick="location.href='tx_update.jsp?action=Sent&txid=<%=txid %>'"><span>Send
                                    </span></button>
                            </div>
                        </li>
                        <%
    }
%>
                    </ul>
                </div>
            </div>
            <div class="flex-container">
                <div class="flex-box" id="accepted"">
                <h3> 완료됨 </h3>
                <ul class="transaction_list">
                    <%
// get accepted transactions
mySQL = "select transactionid, "
         + "(select username from fishy_member where memberid=t.towhom) as towhom, "
         + "(select username from fishy_member where memberid=t.fromwho) as fromwho, "
         + "to_char(arisedate, 'yyyy-mm-dd') as arisedate, "
         + "to_char(duedate, 'yyyy-mm-dd') as duedate, "
         + "description, amount, c.currencysymbol from fishy_transaction t, fishy_currency c where status='Accepted' and t.currencyid = c.currencyid and groupid=" + groupid;
myResultSet = stmt.executeQuery(mySQL);
while(myResultSet.next()) {
    String txid = myResultSet.getString("transactionid");
    String towhom = myResultSet.getString("towhom");
    String fromwho = myResultSet.getString("fromwho");
    String arisedate = myResultSet.getString("arisedate");
    String duedate = myResultSet.getString("duedate");
    String description = myResultSet.getString("description");
    String amount = myResultSet.getString("amount");
    String currencysymbol = myResultSet.getString("currencysymbol");
%>
                    <li>
                        <div class="transaction_list_item accepted">
                            <div class="transaction_detail date">
                                <%= arisedate %>
                            </div>
                            <div class="transaction_detail from">
                                <%= fromwho %>
                            </div>
                            <div class="transaction_detail amount">
                                <%= currencysymbol + amount %>
                            </div>
                            <%
if(description != null) {
%>
                            <div class="transaction_detail desc">
                                <%= description %>
                            </div>
                            <%
}
%>
                            -->
                            <div class="transaction_detail to">
                                <%= towhom %>
                            </div>
                        </div>
                    </li>
                    <%
}
%>
                </ul>
            </div>
        </div>
    </div>
</div>
<%
    stmt.close();  
	myConn.close();
%>
</body>
</html>