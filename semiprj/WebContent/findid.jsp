<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/login.css">

</head>
<body bgcolor="#F1E9D8">


<form action="findidAf.jsp" method="post">
<div class="wrapper fadeInDown">
<div id="formContent">
    <div class="fadeIn first">
     <a href="main.jsp"> <img src="./image/logo1.png" id="icon" ></a>
    </div>
	<input type="text" size="20" name="name" placeholder="이름을 입력해주세요" required>
<br>

	<input type="text" size="20" name="email" placeholder=" 이메일을 입력해주세요." required>
<br><br>
	<input type="submit" value="아이디찾기" class="findid">
</div>
</div>
</form>


</body>
</html>
