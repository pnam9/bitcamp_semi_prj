<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
String myContent = request.getParameter("myContent");
	if(myContent == null){
	myContent = "myRestaurant";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/writetable.css">
<title>Insert title here</title>

</head>
<body>

<table style="width: 1500px;">
<tr align="center">
	<td width="300" style="vertical-align: top;">
	
	<div>
	<table id="nav" class="writetable" style="min-height: 300px; vertical-align: top; margin-top: 100px;">
		<tr height="50px">
			<th>
				<h2>마이페이지</h2>
			</th>
		</tr>
		<tr>
			<td>
				<button type="button" class="menubutton" onclick="location.href='main.jsp?content=./myPage/myPageMain&myContent=myRestaurant'">내가 쓴 글</button> <br><br>
				<button type="button" class="menubutton" onclick="location.href='main.jsp?content=./myPage/myPageMain&myContent=myComment'">내가 쓴 댓글</button> <br><br>
				<button type="button" class="menubutton" onclick="location.href='main.jsp?content=./myPage/myPageMain&myContent=myLikedRestaurant'">좋아요 누른 목록</button> <br><br>
				<button type="button" class="menubutton" onclick="location.href='main.jsp?content=./myPage/myPageMain&myContent=myCs'">내가 쓴 고객센터 글</button> <br><br>
				<button type="button" class="menubutton" onclick="location.href='main.jsp?content=./myPage/myPageMain&myContent=pwdCheck'">회원정보</button>
			</td>
		</tr>
	</table>
	</div>
	
</td>

<td>			
	<jsp:include page='<%=myContent + ".jsp" %>' flush="false"/>			
</td>

</table>

<script type="text/javascript">

	$(document).ready(function() {

	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#nav").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$("#nav").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();

});

</script>

</body>
</html>
