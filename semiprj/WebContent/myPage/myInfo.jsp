<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
Object objLogin = session.getAttribute("login");
MemberDto mem = null;
if(objLogin == null){
	%>
	<script>
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>	
	<%
}
mem = (MemberDto)objLogin;
%>

<%
MemberDto dto = (MemberDto)session.getAttribute("login");

String email = mem.getEmail();
int s = email.indexOf("@");
String email_id = email.substring(0, s);
String email_domain = email.substring(s + 1);

String addr = mem.getAddr();
int c = addr.indexOf(",");
String addr_basic = addr.substring(0, c);
String addr_detail = addr.substring(c + 1).trim();
%>    
<!DOCTYPE html>
<html>
<head>
<style>
	#box1 td { text-align: left; }
</style>
<meta charset="UTF-8">
<title>회원정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div class="write" align="center">
<form name="myInfoUpdate" action="main.jsp?content=./myPage/myPageMain&myContent=myInfoUpdate" method="post">

<table class="writetable" id= "box1">
<tr>
	<td colspan="6" style="text-align: left;">
		<h2 style="margin-left: 20px;">회원정보 수정</h2>
	</td>
</tr>
<tr>	
	<th>아이디</th>
	<td >
		<input type="text" name="id" size = "25" value="<%=mem.getId() %>" readonly="readonly" > 		
	</td>	
</tr>

<tr>
	<th>비밀번호</th>
	<td>
		<input type="password" name="pwd" id="pw1" size = "25" placeholder="영문자+숫자+특수문자 조합">
		<p id="chkPW" style="font-size: 8px" ></p>
	</td>
</tr>

<tr>
	<th>비밀번호 재확인</th>
	<td>
		<input type="password" name="pwd_check" id="pw2" size = "25" onkeyup="checkPwd()">	
		 <p id="checkPwd" style="font-size: 8px" ></p>
	</td>
</tr>
<tr>	
	<th>이름</th>
	<td>
		<input type="text" name="name" value="<%=mem.getName() %>" size = "25" readonly="readonly"> 		
	</td>	
</tr>
<tr>	
	<th>생년월일</th>
	<td>
		<input type="text" name="year" size="4" value="<%=mem.getBirth().substring(0, 4) %>" readonly="readonly">년
		<input type="text" name="month" size="3" value="<%=mem.getBirth().substring(4, 6) %>" readonly="readonly">월 	
		<input type="text" name="day" size="3" value="<%=mem.getBirth().substring(6, 8) %>" readonly="readonly">일 		
	</td>	
</tr>
<tr>
	<th>성별</th>
	<td>
		<input type="text" name="gender" size="25" value="<%=mem.getGender() %>" size = "25" readonly="readonly">
	</td> 	
</tr>
<tr>
	<th>이메일</th>
	<td>
	  <input type="text" name="email_id"  id="email_id" size="15" value="<%=email_id %>">@
	  <input type="text" name="email_domain" id="email_domain" size="10"  value = "<%=email_domain %>" >
	</td>
</tr>
<tr>
	<th>주소</th>
	<td>
		<input type="text" name = "addr_basic" id="addr_basic" size="30" value="<%=addr_basic %> " placeholder="주소" >
		<input type="text" name = "addr_detail" id = "addr_detail" size="30" value="<%=addr_detail %> " placeholder="상세주소" >
	</td>	
</tr>
<tr>
</tr>
<tr>
	<th colspan="2">
		<button type="button" class="writebutton" onclick="updateform_check()">수정</button> 
		<button type="button" class="writebutton" onclick="location.href='main.jsp?content=./myPage/myPageMain'">취소</button>
		<button type="button" class="writebutton" onclick="_deleteMember('<%=mem.getId() %>')">회원탈퇴</button>
	</th>	
</tr>
</table>
</form>
</div>


<script type="text/javascript">
function updateform_check(){ 	

	let pwd1 = document.myInfoUpdate.pw1;
	
	let pwd2 = document.myInfoUpdate.pw2;
	let email_id = document.myInfoUpdate.email_id;
	let email_domain = document.myInfoUpdate.email_domain;
	let addr_basic = document.myInfoUpdate.addr_basic;
	let addr_detail = document.myInfoUpdate.addr_detail;
	let v = confirm("회원정보를 수정하시겠습니까?");
	
	if(pwd1.value.trim() == ""){
		alert("비밀번호를 입력하세요");
		pwd1.focus();
		return false;
	}else if(pwd2.value.trim() == ""){
		alert("비밀번호 다시 입력하세요");
		pwd2.focus();
		return false;
	}else if(email_id.value.trim() == ""){
		alert("이메일 아이디를 입력하세요");
		email_id.focus();
		return false;
	}else if(email_domain.value.trim() == ""){
		alert("이메일 주소를 입력하세요");
		email_domain.focus();
		return false;
	}else if(addr_basic.value.trim() == ""){
		alert("주소를 입력하세요");
		addr_basic.focus();
		return false;
	}else if(addr_detail.value.trim() == ""){
		alert("상세주소를 입력하세요");
		addr_detail.focus();
		return false;
	}else if (v==true) {
	
	document.myInfoUpdate.submit();
	} 	
	
};

function _deleteMember(id) {
	
	let v = confirm('정말 탈퇴하시겠습니까?');
	
	if(v == true){
		location.href = "main.jsp?content=./myPage/myPageMain&myContent=myInfoDelete&id=" + id;

	}
};

function checkPwd(){
	  var f1 = document.forms[0];
	  var pw1 = f1.pwd.value;
	  var pw2 = f1.pwd_check.value;
	  if(pw1!=pw2){
	   document.getElementById('checkPwd').style.color = "#ff0000";
	   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
	  }else{
	   document.getElementById('checkPwd').style.color = "#0000ff";
	   document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
	  }
};
</script>

</body>
</html>