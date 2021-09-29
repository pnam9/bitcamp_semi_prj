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
<title>updateMember.jsp</title>
</head>
<body>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String email = request.getParameter("email_id")+"@"+ request.getParameter("email_domain");
String addr = request.getParameter("addr_basic")+", "+request.getParameter("addr_detail");

MemberDao dao = MemberDao.getInstance();
boolean isS = dao.updateMember(id, pwd, email, addr);

if(isS == true){
	%>
	<script type="text/javascript">
	alert("회원정보수정 완료");
	location.href = "main.jsp?content=./myPage/myPageMain";
	</script>	
	<%
}else{	
	%>
	<script type="text/javascript">
	alert("회원정보수정 실패");
	location.href = "main.jsp?content=./myPage/myPageMain";
	</script>
	<%
}	
%>

</body>
</html>

