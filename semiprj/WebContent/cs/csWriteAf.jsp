<%@page import="dto.MemberDto"%>
<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto mem = (MemberDto)session.getAttribute("login");
	if(mem == null){
%>
	<script>
		alert("로그인해 주십시오");
		location.href = "login.jsp";
	</script>
<%
	}
%>

<%

	request.setCharacterEncoding("utf-8"); // title, content의 한글 깨짐 방지
	
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
	
	boolean isS = dao.writeCs(new CsDto(id, title, content, type));
	
	if(isS == true){
%>
	<script type="text/javascript">
		//alert("성공적으로 저장되었습니다");
		location.href = "main.jsp?content=./cs/csMain&csContent=csList"
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("글 저장 중 오류가 발생했습니다");
		location.href = "javascript:history.back();";
	</script>
<%
	}
%>
