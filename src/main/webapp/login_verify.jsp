<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<body style="background: #fff;">
<% 
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	
	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;
	
	String dburl = System.getenv("dburl");
	String user=System.getenv("user");
	String passwd = System.getenv("passwd");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();	
	mySQL = "SELECT s_id FROM student WHERE s_id='"+userID+"'and s_pwd='"+userPassword+"'";

	
	ResultSet myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet.next()){
		session.setAttribute("user", userID);
		response.sendRedirect("main.jsp");
	}else {
		%>
		<script>
		alert("사용자 아이디 혹은 암호가 틀렸습니다");
		location.href="login.jsp";
		</script>
<%
}
	stmt.close();
	myConn.close();
%>
</body>