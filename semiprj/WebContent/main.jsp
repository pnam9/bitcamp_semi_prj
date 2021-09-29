<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>    
<%
	String content = request.getParameter("content");
	if(content == null){
		content = "body";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배고파?</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <!-- alert css -->
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/alert.css">
 -->
<link rel="stylesheet" type="text/css" href="./css/goTop.css">
<link rel="stylesheet" type="text/css" href="./css/banner.css">
<style>
body{
	background-color: #F1E9D8 !important;
}
table{
	width: 100%;
}
td{
	text-align: center;
}
</style>

</head>
<body>

<div align="center">
<table style="width: 1500px;">

<tr>
	<!-- header -->
	<td colspan="2">
		<jsp:include page="header.jsp" flush="false"/>
	</td>
</tr>

<tr>
	<!-- body -->
	<td style="height: auto;">
		<jsp:include page='<%=content + ".jsp" %>' flush="false"/>
		
	</td>
</tr>

<tr>
	<!-- footer -->
	<td colspan="2" >
		<jsp:include page="bottom.jsp" flush="false"/>
	</td>
</tr>

</table>
</div>

<!-- 위로가기 버튼 -->
<a class="goTop" href="#" ><img src="./image/up.png"></a>

<!-- 왼쪽 배너 -->

<img class="banner" src="./image/banner.png" usemap="#banner" width="130">
<map id="banner" name="banner">
<area shape="rect" alt="kakaotalk" title="" coords="12,12,284,88" href="https://open.kakao.com/o/gauIWscd" target="_blank" />
<area shape="rect" alt="call" title="" coords="12,102,280,196" href="tel:010-0000-0000" target="" />
<area shape="rect" alt="mail" title="" coords="12,208,288,318" href="mailto:bit930508@gmail.com" target="_self" />
</map>

<script type="text/javascript">

$(document).ready(function() {

	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($(".banner").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$(".banner").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();

});

</script>

</body>
</html>


