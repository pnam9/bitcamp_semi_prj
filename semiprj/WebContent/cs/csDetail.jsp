<%@page import="dto.MemberDto"%>
<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	request.setCharacterEncoding("utf-8");

	// 글의 seq 정보 가져오기
	int seq = Integer.parseInt(request.getParameter("seq"));

	CsDao dao = CsDao.getInstance();
	CsDto dto = dao.getCs(seq);
	
	System.out.println("csdetail="+dto.getContent());
	
 	// 로그인 정보 확인해서 글쓴이 or 관리자가 아닐시 alert & 리스트로 돌아가기
 	// 공지글일 경우 로그인여부와 관계없이 읽기 가능
 	
 	MemberDto mem = (MemberDto)session.getAttribute("login");
 	
 	if(dto.getType() == 1){ // 공지글일 경우 조건 없음
 		
 	}else if(!(dto.getId().equals(mem.getId()) || mem.getAuth() == 3)){ // 공지글이 아닐 경우 - 글쓴이 or 관리자 해당 안되면 접근 불가
%>
		<script>
			alert("문의글은 작성자와 관리자만 확인이 가능합니다");
			location.href = "main.jsp?content=./cs/csMain&csContent=csList";
		</script>
<%
	}
%>

<title>Insert title here</title>
</head>
<body>

<div align="center">
<table class="detailtable">
<col width="200px"><col width="700px">
<tr>
	<td colspan="2"><h2>상세 글 보기</h2></td>
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
<tr>
	<td colspan="2" style="text-align: right;">
	<button type="button" class="writebutton" style="float: left;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csList'">목록으로</button>
	<button type="button" class="writebutton" onclick="updateCs(<%=dto.getSeq() %>)">수정</button>
	<button type="button" class="writebutton" onclick="deleteCs(<%=dto.getSeq() %>)">삭제</button>
		<!-- 관리자만 답글 버튼이 보이도록 함 -->
	<%
//		if(mem.getAuth() == 3){			
	%>
		<button type="button" class="writebutton" onclick="answerCs(<%=dto.getSeq() %>)">답글</button>
	<%		
//		}
	%>
	</td>
</tr>
</table>
</div>

<script type="text/javascript">
	function answerCs(seq){
		location.href = "main.jsp?content=./cs/csMain&csContent=csAnswer&seq=" + seq;
	}
	function updateCs(seq){
		location.href = "main.jsp?content=./cs/csMain&csContent=csUpdate&seq=" + seq;
	}
	function deleteCs(seq){
		
		if(confirm("정말 삭제하시겠습니까 ?") == true){
	        location.href = "main.jsp?content=./cs/csMain&csContent=csDelete&seq=" + seq;
	    }
	    else{
	        return;
	    }		
	}
	
</script>

</body>
</html>