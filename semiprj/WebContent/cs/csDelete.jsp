<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>
<%@page import="dto.MemberDto"%>

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

	int seq = Integer.parseInt(request.getParameter("seq"));
	
	CsDao dao = CsDao.getInstance();
	
	boolean isS = dao.deleteCs(seq);
	
	if(isS == true){
%>
	<script type="text/javascript">
		//alert("성공적으로 삭제되었습니다");
		location.href = "main.jsp?content=/cs/csMain&csContent=csList"
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("글 삭제 중 오류가 발생했습니다");
		location.href = "main.jsp?content=/cs/csMain&csContent=csDelete&seq=" + seq;
	</script>
<%
	}
%>
