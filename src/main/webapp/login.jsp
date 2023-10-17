<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
<title>로그인</title>
</head>
<body>
<div class="login_page">
	<div class="login_container">
		<form method="post" action="login_verify.jsp">
		<input type="text" class="login_input rounded" placeholder="ID" name="userID"/>
		<input type="password" class="login_input rounded" placeholder="PASSWORD" name="userPassword"/>
		<input type="submit" class="login_button rounded" value="LOGIN"/>
		</form>
	</div>
</div>
</body>
</html>