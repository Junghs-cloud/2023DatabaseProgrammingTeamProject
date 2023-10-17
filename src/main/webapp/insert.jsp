<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
<title>수강신청 입력</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<div style="margin-bottom:15px;">
	<form method="post" action="search.jsp" class="search_form">
	<div class="search_container">
	<input type="text" class="search" placeholder="검색어" name="search"/>
	<input TYPE="SUBMIT" NAME="Submit" class="search_button rounded" value="검색"/>
	</div>
	</form>
</div>

<%
	Connection myConn = null;
	Statement stmt = null;
	Statement enrollStmt = null;
	ResultSet myResultSet = null;
	ResultSet enrollResultSet = null;
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
<div class="sec-center">
	<input class="dropdown" type="checkbox" id="dropdown" name="dropdown"/>
	<label class="for-dropdown" for="dropdown">전체 조회</label>
		<div class="section-dropdown">
			<a href="inquiry_course.jsp?option=all" class="dropdown_a">전체</a>
			<a href="inquiry_course.jsp?option=major" class="dropdown_a">전공</a>
			<a href="inquiry_course.jsp?option=required" class="dropdown_a">필수교양</a>
			<a href="inquiry_course.jsp?option=ge" class="dropdown_a">일반교양</a>			
		</div>
</div>
<div class="insert_wrapper">
<h3><%=nYear %>년 <%= nSemester %>학기 수강신청</h3>
<div class="table">
<div class="row header">
<div class="cell" >과목번호</div>
<div class="cell" >분반</div>
<div class="cell" >담당교수</div>
<div class="cell" >과목명</div>
<div class="cell" >학점</div>
<div class="cell" >정원</div>
<div class="cell" >여석</div>
<div class="cell" style ="border-right-style: none;">수강신청</div>
</div>
<%	
	mySQL = "select c.c_id,c.c_id_no,c.c_name,c.c_unit, t.t_professor, t.t_max, t.t_left from course c, teach t where c.c_id not in (select c_id from enroll where s_id='" + session_id + "' and e_gpa>=2.7) and t.t_year=" + nYear+" and t.t_semester="+nSemester+" and t.c_id=c.c_id and t.c_id_no = c.c_id_no";
	
	myResultSet = stmt.executeQuery(mySQL);
	
	if(myResultSet != null){
		while (myResultSet.next()){
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String c_name = myResultSet.getString("c_name");
			String t_professor = myResultSet.getString("t_professor");
			int t_max = myResultSet.getInt("t_max");
			int t_left = myResultSet.getInt("t_left");
			int c_unit = myResultSet.getInt("c_unit");
			
			%>
			<div class="row">
				<div class="cell"><%=c_id %></div>
				<div class="cell"><%=c_id_no %></div>
				<div class="cell"><%=t_professor %></div>				
				<div class="cell"><%=c_name %></div>
				<div class="cell"><%=c_unit %></div>
				<div class="cell"><%=t_max %></div>
				<div class="cell"><%=t_left %></div>
				<% if(t_left == 0) {%>
				<div class="cell" style ="border-right-style: none;"><button class="nonInsert_button rounded" onclick="location.href='insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>'">신청 불가</button></div>
				<% }	else if(t_left != 0) { %>
				<div class="cell" style ="border-right-style: none;"><button class="insert_button rounded" onclick="location.href='insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>'">신청</button></div>
				<% } %>
			</div>
<% 				
		}
	}
	else
	{
	}
	stmt.close();
	myConn.close();
%>
</div>
</div>
</body>
</html>