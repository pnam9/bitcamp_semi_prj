<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	Object objLogin = session.getAttribute("login");
	
	MemberDto mem = null;
	String loginName = null;
	String loginId = null;
	String loginAuth = null;
	
	if(objLogin != null){
		mem = (MemberDto)objLogin;
		loginId = mem.getId();
		loginName = mem.getName();
	}	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/628c8d2499.js" crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link rel="stylesheet" type="text/css" href="./css/topNav.css">

<style type="text/css">

/* 움직이는 로고 */
#logoDiv img:last-child{display:none} 
#logoDiv:hover img:first-child{display:none} 
#logoDiv:hover img:last-child{display:inline-block }

</style>

</head>
<body style="text-align:center;">

<!-- 사이트 로고 -->
<div style="align: center; margin-top: 30px;">
	
	<div id="logoDiv" style="width: 300; height: auto; margin-bottom: 30px">
		<a href="main.jsp">
			<img id="logo1" src="./image/logo1.png" width="250" />
			<img id="logo2" src="./image/logo2.png" width="250" />
		</a>
	</div>
	
</div>

<!-- 네비게이션 바 -->
<div class="nav">
	<div class="wrap">
	 	<ul class="menu">
		
		<li>
	      <a href="main.jsp?content=info1" >배고파?</a>
	      <ul class="drop">
	        <li><a href="main.jsp?content=info1">기획 의도</a></li>
	        <li><a href="main.jsp?content=info2">팀원 소개</a></li>
	      </ul>
	    </li>
<%	
	if(loginId == null){ // 로그아웃 상태일 경우
%>	  
	    <li>
	      <a href="login.jsp">로그인</a>
	    </li>
	    
	    <li>
	      <a href="regi.jsp">회원가입</a>
	    </li>	    

<% 
	} else { // 로그인 상태일 경우
%>	    
	    <li>
	      <a href="main.jsp?content=./myPage/myPageMain" >마이페이지</a>
	      <ul class="drop">
	         <li><a href="main.jsp?content=./myPage/myPageMain&myContent=myRestaurant">내가 쓴 글</a></li>
	        <li><a href="main.jsp?content=./myPage/myPageMain&myContent=myComment">내가 쓴 댓글</a></li>
	        <li><a href="main.jsp?content=./myPage/myPageMain&myContent=myLikedRestaurant">좋아요 누른 목록</a></li>
	        <li><a href="main.jsp?content=./myPage/myPageMain&myContent=myCs">내가 쓴 고객센터 글</a></li>
	        <li><a href="main.jsp?content=./myPage/myPageMain&myContent=pwdCheck">회원정보</a></li>
	      </ul>
	    </li>
	  
		<li>
	      <a href="javascript:void(0);" onclick="logout();">로그아웃</a>
	    </li>
<%
		if(mem.getAuth() == 3){ // 관리자 계정으로 로그인 했을 경우
%>
		<li>
	      <a href="main.jsp?content=./managerPage/managerMain">관리자페이지</a>
	      <ul class="drop">
	        <li><a href="main.jsp?content=./managerPage/managerMain&myContent=allRestaurant">전체게시글</a></li>
	        <li><a href="main.jsp?content=./managerPage/managerMain&myContent=allMember">모든 회원 정보</a></li>
	        <li><a href="main.jsp?content=./managerPage/managerMain&csContent=./cs/csList">고객센터</a></li>
	      </ul>
	    </li>
<% 
		}	
	}
%>
		<li>
	      <a href="main.jsp?content=./cs/csMain">고객센터</a>
	      <ul class="drop">
	        <li><a href="main.jsp?content=./cs/csMain">고객센터 메인</a></li>
	        <li><a href="main.jsp?content=./cs/csMain&csContent=csList">1:1 문의</a></li>
	      </ul>
	    </li>
	    
	  	</ul>
	</div>
</div>

<!-- 로그인 시 이름 표시되는 부분 -->


<%	
	if(loginId != null){ // 로그인을 안했을 경우
%>
	<div class="name">
	<span><strong>반가워요, 맛집평론가 <span style="color: #634E41; font-weight: 800; text-transform : uppercase; "><%=loginName %></span>님!</strong></span>
	</div>
<%
	}
%>


<div style="height: 2px; width: 100%; margin-top: 50px; background-color: #634E41; box-shadow: 1px 1px 1px 1px rgba(0,0,0,0.1);"></div>

<script type="text/javascript">

	function logout() {		
		let result = confirm("로그아웃하시겠습니까?");
		if(result){
			location.href = "logout.jsp"
		}else{
		    return;
		}		
	}
	
</script>


</body>
</html>



