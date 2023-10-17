<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String session_id = (String)session.getAttribute("user");
	
	String log;
	if (session_id == null) log = "<a href=login.jsp>로그인</a>";
	else log = "<a href=logout.jsp>로그아웃</a>";
%>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
</head>
<body>
<nav>
		<%=log%>
		<a href="update.jsp">사용자 정보 수정</a>
		<a href="insert.jsp">수강신청 입력</a>
		<a href="delete.jsp">수강신청 삭제</a>
		<a href="select.jsp">수강신청 조회</a>
		<span class="current-bar"></span>
</nav>
</body>
</html>