<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@ include file="top.jsp"%>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>

<%  
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = ""; 

String dburl = System.getenv("dburl");
String user=System.getenv("user");
String passwd = System.getenv("passwd");
String dbdriver = "oracle.jdbc.driver.OracleDriver";

int nYear=0;
int nSemester=0;
int selectSemester=0;
int count=0;
int u_sum=0;

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl,user,passwd );
	
	String sql = "{? = call Date2EnrollYear(SYSDATE)}";
	CallableStatement cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.execute();
	
	nYear = cstmt.getInt(1);
	
	sql = "{? = call Date2EnrollSemester(SYSDATE)}";
	cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.execute();
	
	nSemester = cstmt.getInt(1);
	
	stmt = myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage()); 
}
%>

<div class="sec-center">
	<input class="dropdown" type="checkbox" id="dropdown" name="dropdown"/>
	<label class="for-dropdown" for="dropdown" style="font-size:15px; font-weight:700; height:40px;">조회 기간 선택</label>
		<div class="section-dropdown">
		<div>
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub" name="dropdown-sub"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub"><%= nYear %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>
		</div>
		<div>
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub2" name="dropdown-sub2"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub2"><%= nYear-1 %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear-1 %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear-1 %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>
		</div>
		<div>
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub3" name="dropdown-sub3"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub3"><%= nYear-2 %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear-2 %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear-2 %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>
		</div>
		<div>
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub4" name="dropdown-sub4"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub4"><%= nYear-3 %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear-3 %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear-3 %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>	
		</div>
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub5" name="dropdown-sub5"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub5"><%= nYear-4 %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear-4 %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear-4 %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>							
	</div>
</div>


<%
stmt.close();
myConn.close();
%>
</body>
</html>