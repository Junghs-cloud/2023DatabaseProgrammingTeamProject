<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>

<% Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = System.getenv("dburl");
String user=System.getenv("user");
String passwd = System.getenv("passwd");
String dbdriver = "oracle.jdbc.driver.OracleDriver";

String s_addr = null;
String s_pwd = null;
String s_mail = null;
String s_phone = null;

Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();
mySQL = "select s_addr, s_pwd, s_mail, s_phone from student where s_id='"+session_id+"'";

ResultSet myResultSet = stmt.executeQuery(mySQL);
if(myResultSet.next()){
	s_addr = myResultSet.getString("s_addr");
	s_pwd = myResultSet.getString("s_pwd");
	s_mail = myResultSet.getString("s_mail");
	s_phone = myResultSet.getString("s_phone");
%>

<div class="update_page">
	<div class="update_container">
		<form method="post" action="update_verify.jsp" style="display:flex; flex-direction:column; align-items:flex-start;">
			<input type="hidden" value="<%=s_pwd %>" name="s_pwd"/>
			<a class="update_label">ID</a>
			<input type="text" class="update_input rounded" value="<%=session_id%>" disabled/>
			<a class="update_label">주소</a>
			<input type="text" class="update_input rounded" value="<%=s_addr %>" name="s_addr"/>
			<a class="update_label">EMAIL</a>			
			<input type="email" class="update_input rounded" value="<%=s_mail %>" name="s_mail"/>
			<a class="update_label">전화번호</a>			
			<input type="tel" class="update_input rounded" value="<%=s_phone %>" name="s_phone"/>
			<a class="update_label">기존 비밀번호</a>			
			<input type="password" class="update_input rounded" name="exist_pwd"/>
			<a class="update_label">새 비밀번호</a>			
			<input type="password" class="update_input rounded" name="after_s_pwd"/>
			<input class="update_button" onclick="alertButton();" type="submit" value="수정">
		</form>
	</div>
</div>
<%
}
stmt.close(); myConn.close();
%>
</body>
</html>