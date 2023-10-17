<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 시스템</title>
</head>
<body>
<%@include file="top.jsp" %>
<% if(session_id != null) {%>
<div class="insert_wrapper" style="align-items:center;">
<h3><%=session_id%>님 방문을 환영합니다.</h3>
</div>
<% }else { %>
<div class="insert_wrapper" style="align-items:center;">
<h3>로그인 후 사용하세요.</h3>
</div>
<%
}
%>
</body>
</html>