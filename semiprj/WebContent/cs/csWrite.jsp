<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

    Object objLogin = session.getAttribute("login");
    MemberDto mem = null;
    if(objLogin == null){
%>
<script>
    alert("로그인 해 주십시오");
    location.href = "login.jsp";
</script>
<%
    }
    mem = (MemberDto)objLogin;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="./css/writetable.css">

<title>Insert title here</title>
</head>
<body>

<div class="write" align="center">
<form name="write_form" action="main.jsp?content=/cs/csMain&csContent=csWriteAf" method="post">

<table class="writetable">
<col width="100"><col width="400" style="align: left; ">
<tr>
	<td colspan="2"><h1 style="margin-left: 20px">글쓰기</h1></td>
</tr>
<tr>
	<th>작성자</th>
	<td><input type="hidden" name="id" value="<%=mem.getId() %>" /><strong><%=mem.getName() %>(<%=mem.getId() %>)</strong> 님</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" id="title" size="50" />
		<%
		if(mem.getAuth() == 3){ // 관리자가 글작성 하는 경우에만 공지글 설정 버튼 나오도록 함
		%>
			<input type="checkbox" name="type" id="type" />
			<label for="type"><b>공지글 설정</b></label>
		<%
		}
		%>

	</td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="30" cols="80" name="content2" id="content"></textarea></td>
</tr>
<tr>
	<td colspan="2" style="text-align: right;">
		<button type="button" class="writebutton" style="float: left;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csList'">목록으로</button>
		<button type="button" class="writebutton" onclick="writeform_check();">글쓰기</button>
	</td>
</tr>

</table>

</form>
</div>

<script type="text/javascript">
	
	// 글쓰기 form 유효성 검사
	function writeform_check(){
		var title = document.getElementById("title");
		var content = document.getElementById("content");
		
		if(title.value.trim() == ""){
			alert("제목을 입력하세요");
			title.focus();
			return false;
		}
		
		if(content.value.trim() == ""){
			alert("내용을 입력하세요");
			content.focus();
			return false;
		}
		
		document.write_form.submit();
	};
	

</script>

</body>
</html>