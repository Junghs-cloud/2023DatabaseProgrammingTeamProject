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
<%
String s_pwd = request.getParameter("s_pwd");
String s_addr = request.getParameter("s_addr");
String s_mail = request.getParameter("s_mail");
String s_phone = request.getParameter("s_phone");
String exist_pwd = request.getParameter("exist_pwd");
String after_s_pwd = request.getParameter("after_s_pwd");

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = System.getenv("dburl");
String user=System.getenv("user");
String passwd = System.getenv("passwd");
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt=myConn.createStatement();
} catch(SQLException ex){
System.err.println("SQLException: "+ex.getMessage());
}

if(!s_pwd.equals(exist_pwd)){%>
	<script>
	alert("기존 비밀번호가 일치하지 않습니다.");
	location.href="update.jsp";
	</script>
	
<%}
else {
try {
	mySQL = "update student set s_addr='"+s_addr+"', s_pwd='"+after_s_pwd+"', s_mail='"+s_mail+"', s_phone='"+s_phone+"' where s_id='"+session_id+"'";
	stmt.execute(mySQL);
%>
<script>
alert("학생정보가 수정되었습니다.");
location.href="update.jsp";
</script>
<%
} catch(SQLException ex){
String sMessage;
if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다.";
else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
else sMessage="잠시 후 다시 시도하십시오";
%>
<script>
alert("<%=sMessage%>");
location.href="update.jsp";
</script>
<%
}
finally{
if(stmt!=null)try{stmt.close(); myConn.close();}
catch(SQLException ex) { }
}
}
%>
</body>
</html>