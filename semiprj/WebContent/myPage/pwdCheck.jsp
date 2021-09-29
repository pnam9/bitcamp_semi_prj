<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 체크</title>
</head>
<body>
<div align="center">
<form action="main.jsp?content=./myPage/myPageMain&myContent=pwdCheckAf" method="post">

<table class="listtable">
<tr>
	<td colspan="6" style="text-align: left;">
		<h2 style="margin-left: 20px;">비밀번호를 입력해주십시오.</h2>
	</td>
</tr>
<tr>	
	<td style="text-align: center; vertical-align: middle; height: 400px;">
		<div class="write">
			<span style="font-size: 13pt; font-family: 'Nanum Gothic', sans-serif;">패스워드 : </span>
			<input type="password" name="pwd" size="30" required="required">
		</div>
	</td>
</tr>
<tr>
	<td style="text-align: center; height: 100px; vertical-align: middle;">
		<input class="writebutton" type="submit" value="확인">
	</td>
</tr>
</table>
</form>
</div>
</body>
</html>