<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");
MemberDao dao = MemberDao.getInstance();
String pw = dao.findpw(id, name, email);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%if(pw == null){ %>
<script type="text/javascript">
alert("존재하지 않은 계정입니다");
location.href="findpw.jsp";
</script>
<%
}else{
%>
<script type="text/javascript">
alert("고객님의 정보와 일치하는 비밀번호는 <%=pw %>입니다.");
location.href="login.jsp";
</script>
<%
}
%>

</body>
</html>