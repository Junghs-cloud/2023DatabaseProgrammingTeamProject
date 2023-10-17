<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>

<%
	
	int s_year = Integer.parseInt(request.getParameter("selected_year"));
	int s_semester = Integer.parseInt(request.getParameter("selected_semester"));
	
	Connection myConn = null;
	PreparedStatement pstmt = null;
	//Statement stmt = null;
	ResultSet myResultSet = null;
	ResultSet myResultSet_re = null;
	String mySQL = null;
	String mySQL_re = null;
	
	String dburl = System.getenv("dburl");
	String user=System.getenv("user");
	String passwd = System.getenv("passwd");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	int nYear=0;
	int nSemester=0;
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
		
		/* stmt = myConn.createStatement(); */
	} catch(SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage()); 
	}	
	
	mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_place, e.e_gpa from course c, teach t, enroll e " 
			+"where e.s_id='" + session_id+"' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and e.e_year= " + s_year +" and e.e_semester= "+s_semester
			+" and e.c_id = t.c_id and e.c_id_no = t.c_id_no and e.e_year = t.t_year and e.e_semester = t.t_semester";

	pstmt = myConn.prepareStatement(mySQL);
	
	myResultSet = pstmt.executeQuery();
	//myResultSet = stmt.executeQuery(mySQL);
	
	%>
		<div class="sec-center" style="margin-bottom: 17px">
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
		<div>	
		<input class="dropdown-sub" type="checkbox" id="dropdown-sub5" name="dropdown-sub5"/>
		  	<label class="for-dropdown-sub" for="dropdown-sub5"><%= nYear-4 %></label>
	  		<div class="section-dropdown-sub"> 
	  			<a href="select_verify.jsp?selected_year=<%= nYear-4 %>&selected_semester=1" class="dropdown_a">1학기</a>
	  			<a href="select_verify.jsp?selected_year=<%= nYear-4 %>&selected_semester=2" class="dropdown_a">2학기</a>
			</div>							
		</div>
</div>
</div>

	<div class="insert_wrapper">
		<h3><%=s_year %>년 <%=s_semester%>학기</h3>

<div class="table" style="margin-bottom:0;">
<div class="row header">
<div class="cell" >과목번호</div>
<div class="cell" >분반</div>
<div class="cell" >과목명</div>
<div class="cell" >학점</div>
<div class="cell" >시간</div>
<div class="cell" >장소</div>
<div class="cell" >등급</div>
<div class="cell">비고</div>
</div>	
	<% 
	if (myResultSet != null) {
		while (myResultSet.next()) {
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String c_name = myResultSet.getString("c_name");
			int c_unit = myResultSet.getInt("c_unit");
			int t_time = myResultSet.getInt("t_time");
			String t_place = myResultSet.getString("t_place");
			double e_gpa = myResultSet.getDouble("e_gpa");
			u_sum += c_unit;
			count++;
			
	%>
		<div class="row">
				<div class="cell"><%=c_id %></div>
				<div class="cell"><%=c_id_no %></div>
				<div class="cell"><%=c_name %></div>				
				<div class="cell"><%=c_unit %></div>
				<div class="cell"><%=t_time %></div>
				<div class="cell"><%=t_place %></div>
				<%if(myResultSet.wasNull()){%>
				<div class="cell"></div>
				<%}else{ %>
				<div class="cell"><%=e_gpa %></div>
	
				<%} 
				
				mySQL_re = "select count(*) from enroll where s_id ='" + session_id+"' and c_id = '"+ c_id + "'";
				pstmt = myConn.prepareStatement(mySQL_re);
				myResultSet_re = pstmt.executeQuery();
				if(myResultSet_re.next()){
				
					int cnt = myResultSet_re.getInt(1);
					if (cnt > 1){%>
						<div class="cell">재수강</div></div>
					<%} else {%>
						<div class="cell"></div></div>
					<%}
				}%>	
			
		
	<%
		}
		%>
		</div>
	<%
	}
	if (count == 0) {
	%>
		<div align="center">조회된 수업이 없습니다.</div>
	<%
	}else{
	%>
		<div class="table">
			<div class="column">
			<div class="cell_header">총 신청과목 수</div>
			<div class="cell"><%=count %></div>
			</div>
			<div class="column">
			<div class="cell_header">총 신청학점</div>
			<div class="cell"><%=u_sum %></div>
			</div>
	</div>
	</div>
	<%
	}
if(myResultSet != null) myResultSet.close();
if(myResultSet_re != null) myResultSet.close();
if(pstmt != null) pstmt.close();
if(myConn != null) myConn.close();
	/* stmt.close();
	myConn.close(); */
%>
</div>
</body>
</html>