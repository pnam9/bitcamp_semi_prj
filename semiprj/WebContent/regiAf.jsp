<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<!-- DB에 추가 -->    
<%!
public String two(String msg){
	return msg.trim().length()<2?"0"+msg.trim():msg.trim();
}
%>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String name = request.getParameter("name");

String birthyy = request.getParameter("birthyy");
String birthmm = request.getParameter("birthmm"); 
String birthdd = request.getParameter("birthdd");
String birth = birthyy + birthmm + two(birthdd);
String gender = request.getParameter("gender");
String email = request.getParameter("email_id")+"@"+ request.getParameter("email_add");
String addr = request.getParameter("sample2_address")+", "+request.getParameter("sample2_detailAddress");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

MemberDao dao = MemberDao.getInstance();
MemberDto dto = new MemberDto(id, pwd, name, birth, gender, email, addr, 0);
boolean isS = dao.addMember(dto);
if(isS){
	%>
	<script type="text/javascript">
 	alert("회원가입이 완료되었습니다."); 
/* 	swal(" ", "회원가입이 완료되었습니다.", "success"); */
	location.href = "login.jsp";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
 	alert("다시 기입해 주십시오"); 
/* 	swal(" ", "다시 기입해 주십시오", "warning"); */
	location.href = "regi.jsp";
	</script>
	<%
}
%>


</body>
</html>