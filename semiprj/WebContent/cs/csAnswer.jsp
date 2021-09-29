<%@page import="dao.CsDao"%>
<%@page import="dto.CsDto"%>
<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	MemberDto mem = (MemberDto)session.getAttribute("login");
	if(mem == null){
%>
	<script>
		swal("로그인해 주십시오")
		location.href = "login.jsp";
	</script>
<%
	}else if(mem.getAuth() != 3){
%>
	<script>
		alert("답글은 관리자만 달 수 있습니다");
		location.href = "javascript:history.back();";
	</script>
<%
	}
	
	int seq = Integer.parseInt(request.getParameter("seq"));

	CsDto dto = CsDao.getInstance().getCs(seq);
%>

<title>Insert title here</title>
</head>
<body>

<div align="center">
<table class="detailtable">
<col width="200px"><col width="700px">
<tr>
	<td colspan="2"><h2>문의 글</h2></td>
</tr>

<tr>
	<th>제목</th>
	<td><strong><%=dto.getTitle() %></strong></td>
</tr>
<tr>
	<th>작성자</th> 
	<td><strong><%=dto.getId() %></strong> 님</td>
</tr>
<tr>
	<th>작성일</th> 
	<td><strong><%=dto.getWdate().substring(0, 16) %></strong></td>
</tr>

<tr>
	<th style="vertical-align: middle">문의 내용</th>
	<td style="min-height: 500px; padding: 50px;"><strong><%=dto.getContent() %></strong></td>
</tr>
</table>
</div>



<div class="write" align="center">
<form name="answer_form" action="main.jsp?content=./cs/csMain&csContent=csAnswerAf" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table class="writetable">
<col width="200px"><col width="700px">
<tr>
	<td colspan="2"><h2>답변 작성</h2></td>
</tr>
<tr>
	<th>아이디</th>
	<td><input type="hidden" name="id" value="<%=mem.getId() %>" /><strong><%=mem.getId() %>(<%=mem.getId() %>)</strong> 님</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" id="title" size="50" />
	</td>
</tr>
<tr>
	<th>답변 내용</th>
	<td><textarea rows="30" cols="80" name="content2" id="content2"></textarea></td>
</tr>
<tr>
	<td colspan="2" style="text-align: right;">
		<button type="button" class="writebutton" style="float: left;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csList'">목록으로</button>
		<button type="button" class="writebutton" onclick="answerform_check();">답글쓰기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
	
	// 글쓰기 form 유효성 검사
	function answerform_check(){
		var title = document.getElementById("title");
		var content = document.getElementById("content2");
		
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
		
		document.answer_form.submit();
	};

</script>

</body>
</html>