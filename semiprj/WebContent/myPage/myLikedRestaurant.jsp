<%@page import="dto.RestaurantDto"%>
<%@page import="dao.LikedDao"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
Object objLogin = session.getAttribute("login");
MemberDto mem = null;
if(objLogin == null){
	%>
	<script>
	alert("로그인 해 주십시오");
	//location.href = "login.jsp";
	</script>	
	<%
}
mem = (MemberDto)objLogin;
%>

<%
MemberDto dto = (MemberDto)session.getAttribute("login");
String id = mem.getId();

String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
	choice = "";
}
if(search == null){	
	search = "";
}

LikedDao dao = LikedDao.getInstance();

/* String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);	
} */

List<RestaurantDto> list = dao.getMyLikedRestaurantSearch(choice, search, id);

/* int len = dao.getAllMyLikedRestaurant(choice, search, id);
System.out.println("총 글의 수:" + len);

int bbsPage = len / 15;
if((len%15)>0){
	bbsPage = bbsPage + 1;
} */
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./font.css">
<title>myRestaurant.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="./css/writetable.css">
<script type="text/javascript">
$(document).ready(function() {	
	let search = "<%=search %>";
	if(search == "") return;
	
	let obj = document.getElementById("choice"); 
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
});
</script>
</head>
<body>

<div align="center" class="write">
<table class="listtable">
<col width="70"><col width="600"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100">
<tr>
	<td colspan="7" style="text-align: left;">
		<h2 style="margin-left: 20px;">좋아요 누른 목록</h2>
	</td>
</tr>

<tr>
	<th>번호</th><th>제목</th><th>가게명</th><th>좋아요수</th><th>조회수</th><th>작성자</th><th>작성날짜</th>
</tr>
<%
	if(list == null || list.size() == 0){
		%>
		<tr>
			<td colspan="7">좋아요를 누른 글이 없습니다</td>
		</tr>
<%
	}else{
		for(int i = 0;i < list.size(); i++){
			RestaurantDto bbs = list.get(i);
			
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td><a href="main.jsp?content=/restaurant/restaurantDetail&seq=<%=bbs.getSeq() %>">
							<%=bbs.getTitle() %>
			</td>
			<td><%=bbs.getName() %></td>
			<td><%=bbs.getLikeCount() %></td>
			<td><%=bbs.getReadCount() %></td>
			<td><%=bbs.getId() %>
			<td><%=bbs.getWdate().substring(0, 10) %></td>
		</tr>
	<%
	}
}
%>
<%-- <tr>
	<td colspan="7" style="text-align: center;">총 <%=len %>개의 글</td>
</tr> --%>
</table>

<%-- <%
for(int i=0; i<bbsPage; i++){
	if(pageNumber == i){
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i + 1 %>
		</span>&nbsp;
		<%
	} else {
			%>
			<a href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)" 
				style="font-size: 15pt;color: #000;font-weight: bold;text-decoration: none;">
				[<%=i + 1 %>]
			</a>&nbsp;
			<%
		}
	}	
%>	 --%>

<br>

<div align="center">
<select id="choice" >
	<option>선택</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="name">가게명</option> 
	<option value="location">지역명</option>
</select>
<input type="text" id="search" value="<%=search %>" size="20" placeholder="검색어를 입력해주세요.">
<button type="button" class="writebutton" onclick="searchBtn()">검색</button>
</div>
</div>

<script type="text/javascript">
/* $(document).ready(function () {
    $('#id').val('');
    //$('#choice').find('option:first').attr('selected', 'selected');
    $("#choice option:eq(0)").prop("selected", true);

}) */

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById("search").value;	

	location.href = "main.jsp?content=./myPage/myPageMain&myContent=myLikedRestaurant&choice=" + choice + "&search=" + search;
}
/* function goPage(pageNum){
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "main.jsp?content=./myPage/myPageMain&myContent=myRestaurant&choice=" +choice+ "&search=" +search+ "&pageNumber=" + pageNum;
		
} */

</script>

</body>
</html>