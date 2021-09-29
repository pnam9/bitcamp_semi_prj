<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>	
<%
}
%>
<%
String id =  mem.getId();//세션에 있는 아이디
String pwd = request.getParameter("pwd"); //pwd
%>    

<%
MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.login(new MemberDto(id, pwd, null, null,null,null, null, 0));

if(dto != null && !dto.getId().equals("")){
	// session 저장	
	session.setAttribute("login", dto);
%>
	<script type="text/javascript">
	alert("확인되었습니다.");
	location.href = "main.jsp?content=./myPage/myPageMain&myContent=myInfo"; 
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("비밀번호를 확인하세요");
	location.href = "main.jsp?content=./myPage/myPageMain";
	</script>
<%
}
%>