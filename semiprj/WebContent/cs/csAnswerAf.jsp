<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt( request.getParameter("seq") );

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content2");
String stype = request.getParameter("type");

int type;
if(stype == null){
	type = 0;
}else{
	type = 1;
}

CsDao dao = CsDao.getInstance();

boolean isS = dao.answerCs(seq, new CsDto(id, title, content, type));

if(isS){
%>
	<script type="text/javascript">
	alert("성공적으로 저장되었습니다");
	location.href = "main.jsp?content=./cs/csMain&csContent=csList";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("글 저장 중 오류가 발생했습니다");
	location.href = "javascript:history.back();";
	</script>
<%
}
%>
