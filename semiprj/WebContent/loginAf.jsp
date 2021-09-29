<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
%>    

<%
MemberDao dao = MemberDao.getInstance();
MemberDto dto = dao.login(new MemberDto(id, pwd, null, null,null,null, null, 0));

if(dto != null && !dto.getId().equals("")  && dto.getAuth() != 0 ){
	// session 저장	
	session.setAttribute("login", dto);
%>
	<script type="text/javascript">
	location.href = "main.jsp?id=<%=dto.getId() %>" ; //로그인세션 전송
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("아이디 또는 비밀번호를 확인해주세요");
	/* swal(" ", "아이디 또는 비밀번호를 확인해주세요", "warning"); */
	location.href = "login.jsp";
	</script>
<%
}
%>
	


