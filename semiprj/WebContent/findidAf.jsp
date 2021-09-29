<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
MemberDao dao = MemberDao.getInstance();
String id = dao.findid(name, email);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%if(id == null){ %>
<script type="text/javascript">
alert("존재하지 않은 계정입니다");
location.href="findid.jsp";
</script>
<%
}else{
%>
<script type="text/javascript">
alert("고객님의 정보와 일치하는 아이디는<%=id %> 입니다.");
location.href="login.jsp";
</script>
<%
}
%>

</body>
</html>