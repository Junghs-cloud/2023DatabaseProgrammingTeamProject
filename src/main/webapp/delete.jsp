<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
<title>수강 삭제</title>
</head>
<body>
<%@ include file = "top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>

<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = " ";

String dburl = System.getenv("dburl");
String user=System.getenv("user");
String passwd = System.getenv("passwd");
String dbdriver = "oracle.jdbc.driver.OracleDriver";

int nYear = 0;
int nSemester = 0;

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	String sql = "{? = call Date2EnrollYear(SYSDATE)}";
	CallableStatement cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt.execute();
	nYear = cstmt.getInt(1);
	
	sql = "{? = call Date2EnrollSemester(SYSDATE)}";
	cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt.execute();
	nSemester = cstmt.getInt(1);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: "+ ex.getMessage());
}
%>
<div class="insert_wrapper">
<h3><%=nYear %>년 <%= nSemester %>학기 신청 과목</h3>

<%
	mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_professor from course c, enroll e, teach t where e.s_id='" + session_id+"' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and e.e_year=" + nYear+" and e.e_semester="+nSemester+"and t.c_id =c.c_id and t.c_id_no = c.c_id_no and t.t_year=" + nYear+" and t.t_semester="+nSemester+"";

	myResultSet = stmt.executeQuery(mySQL);
	
	if (myResultSet != null)
	{ if(!myResultSet.next()){
	%> <h3 style="text-align: center;">신청 과목이 없습니다.</h3>
	<%} else { %>
	<div class="table">
	<div class="row header">
	<div class="cell">과목번호</div>
	<div class="cell">분반</div>
	<div class="cell">담당교수</div>
	<div class="cell">과목명</div>
	<div class="cell">학점</div>
	<div class="cell">수강 취소</div>
	</div>
	<%
	String c_id = myResultSet.getString("c_id");
	int c_id_no = myResultSet.getInt("c_id_no");
	String t_professor = myResultSet.getString("t_professor");
	String c_name = myResultSet.getString("c_name");
	int c_unit = myResultSet.getInt("c_unit");
	%>
	<div class="row">
		<div class="cell" align="center"><%=c_id %></div>
		<div class="cell" align="center"><%=c_id_no %></div>
		<div class="cell" align="center"><%=t_professor %></div>				
		<div class="cell" align="center"><%=c_name %></div>
		<div class="cell" align="center"><%=c_unit %></div>
		<div class="cell" align="center">
			<button class="delete_button rounded" onclick="location.href='delete_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>'">취소</button></div>
	</div>
	<%
		while (myResultSet.next())
		{
			c_id = myResultSet.getString("c_id");
			c_id_no = myResultSet.getInt("c_id_no");
			t_professor = myResultSet.getString("t_professor");
			c_name = myResultSet.getString("c_name");
			c_unit = myResultSet.getInt("c_unit");
			%>
			<div class="row">
				<div class="cell" align="center"><%=c_id %></div>
				<div class="cell" align="center"><%=c_id_no %></div>
				<div class="cell" align="center"><%=t_professor %></div>				
				<div class="cell" align="center"><%=c_name %></div>
				<div class="cell" align="center"><%=c_unit %></div>
				<div class="cell" align="center">
					<button class="delete_button rounded" onclick="location.href='delete_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>'">취소</button></div>
			</div>
			<%
		}
	}
	}
	stmt.close();
	myConn.close();
%>
</div>
</div>
</body>
</html>