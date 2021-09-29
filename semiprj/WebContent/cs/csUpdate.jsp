<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>
<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%
	MemberDto mem = (MemberDto)session.getAttribute("login"); // login 정보 가져오기
	if(mem == null){ // 비로그인 상태일 시
%>
	<script>
		alert("로그인해 주십시오");
		location.href = "login.jsp";
	</script>
<%
	}

	int seq = Integer.parseInt(request.getParameter("seq"));

	CsDao dao = CsDao.getInstance();
	
	CsDto dto = dao.getCs(seq);
	
	if(dto.getType() == 1){
		
	}
%>

<link rel="stylesheet" href="./css/writetable.css">
<title>Insert title here</title>
</head>
<body>

<div class="write" align="center">
<form name="update_form" action="main.jsp?content=./cs/csMain&csContent=csUpdateAf" method="post">

<input type="hidden" name="seq" value="<%=seq %>" />

<table class="writetable">
<col width="200"><col width="400">
<tr>
	<td colspan="2"><h2>글 수정하기</h2></td>
</tr>
<tr>
	<th>아이디</th>
	<td><input type="hidden" name="id" value="<%=mem.getId() %>" /><strong><%=mem.getName() %>(<%=mem.getId() %>)</strong> 님</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50" value="<%=dto.getTitle() %>" />
		<% 
			if(dto.getDepth() == 0 && mem.getAuth() == 3){ 	// 로그인 정보가 관리자인 경우만 버튼 나오도록 함 (유저는 설정 불가)
															// 원글인 경우만 공지글 설정 버튼 나오도록 함 (답글은 공지글로 설정되지 않음)															
		%>
			<input type="checkbox" name="type" id="type" <%=dto.getType() == 1 ? "checked = checked" : "" %>/>
			<label for="type">공지글 설정</label>
		<%
			}
		%>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="30" cols="80" name="content2"><%=dto.getContent() %></textarea></td>
</tr>
<tr>
	<td colspan="2" style="text-align: right;">
		<button type="button" class="writebutton" style="float: left;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csList'">목록으로</button>
		<button type="button" class="writebutton" onclick="updateform_check();">수정하기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
	
	// 글수정 form 유효성 검사
	function updateform_check(){
		var title = document.update_form.title;
		var content = document.update_form.content2;
		
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
		
		document.update_form.submit();
	};

</script>

</body>
</html>