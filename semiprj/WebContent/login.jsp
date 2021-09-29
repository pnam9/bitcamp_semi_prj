<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body bgcolor="#F1E9D8">


<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->
    <h2 class="active">  </h2>
  <!--<h2 class="inactive underlineHover">Sign Up </h2> -->

    <!-- Icon -->
    <div class="fadeIn first">
     <a href="main.jsp"> <img src="image/logo1.png" id="icon" ></a>
    </div>
	<br>
    <!-- Login Form -->
    <form action="loginAf.jsp">
      <input type="text" id="id" class="fadeIn second" name="id" placeholder="아이디를 입력해주세요">
      <input type="password" id="password" class="fadeIn third" name="pwd" placeholder="비밀번호를 입력해주세요">
<!--       <p class="active"><input type="checkbox" id="chk_save_id">ID저장</p> -->	  
	<br><br>
    <input type="submit" class="fadeIn fourth" value="로그인">
    </form>
	
    <!-- Remind Id,Pw -->
    <div id="formFooter">
      <a class="underlineHover" href="findid.jsp">아이디 찾기</a> | 
      <a class="underlineHover" href="findpw.jsp">비밀번호 찾기</a>
      <br><br>
      <a class="underlineHover" href="regi.jsp">회원가입</a>
    </div>
  </div>
</div>
<!-- </form> -->

<script type="text/javascript">
let user_id = $.cookie("user_id");
if(user_id != null){
	$("#id").val(user_id);
	$("#chk_save_id").prop("checked", true);
}

$("#chk_save_id").click(function () {

	if( $("#chk_save_id").is(":checked") ){	// 체크 할 경우		
		if( $("#id").val().trim() == "" ){
			//alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{
			// id 쿠키 저장
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'/' });
		}
	}
	else{
		$.removeCookie("user_id", { path:'/' });
	}	
});

</script>

<script type="text/javascript">
$(document).ready(function(){ //id 한글입력 불가능 영어+숫자조합
	  $("input[name=id]").keyup(function(event){ 
	   if (!(event.keyCode >=37 && event.keyCode<=40)) {
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	   }
	  });
	});
</script>

</body>
</html>