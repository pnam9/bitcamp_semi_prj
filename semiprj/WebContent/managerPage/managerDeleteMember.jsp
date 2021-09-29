<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>deleteMember.jsp</title>
</head>
<body>

<%
String id = request.getParameter("id");

MemberDao dao = MemberDao.getInstance();
boolean isS = dao.deleteMember(id);

if(isS == true){
	%>
	<script type="text/javascript">
	alert("회원삭제 완료");
	location.href = "main.jsp?content=./managerPage/managerMain&myContent=allMember";
	</script>	
	<%
}else{	
	%>
	<script type="text/javascript">
	alert("회원삭제 실패");
	location.href = "main.jsp?content=./managerPage/managerMain&myContent=allMember";
	</script>
	<%
}	
%>

</body>
</html>
