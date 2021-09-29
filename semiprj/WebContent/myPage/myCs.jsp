<%@page import="dao.CsDao"%>
<%@page import="dto.CsDto"%>
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
	location.href = "login.jsp";
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

CsDao dao = CsDao.getInstance();

String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);	
}

//검색조건에 맞추어 페이징 하기
List<CsDto> list = dao.getMyCsPagingList(choice, search, pageNumber, id);

// 총 게시글 수 가져오기
int len = dao.getMyAllCs(choice, search, id);
System.out.println("총 글의 수:" + len);

// 한 화면에 게시글 10개씩 노출
int bbsPage = len / 15;
if((len% 15)>0){
	bbsPage = bbsPage + 1;
}
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myCs.jsp</title>
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
<col width="70"><col width="600"><col width="100">
<tr>
	<td colspan="3" style="text-align: left;">
		<h2 style="margin-left: 20px;">고객센터에 작성한 글</h2>
	</td>
</tr>
<tr>
	<th>번호</th><th>내용</th><th>작성날짜</th>
</tr>
<%
if(list == null || list.size() == 0){
	%>
		<tr>
			<td colspan="3">작성한 글이 없습니다</td>
		</tr>
<%
}else{
	for(int i = 0;i < list.size(); i++){
		CsDto bbs = list.get(i);
	%>
		<tr>
			<th><%=i + 1 %></th>
			<td>
			<a href="main.jsp?content=/myPage/myPageMain&myContent=/cs/csDetail&seq=<%=bbs.getSeq() %>">
						<%=bbs.getTitle() %>
			</a>
			</td>
			<td><%=bbs.getWdate().substring(0, 10) %></td>
		</tr>
	<%
	}
}
%>
<tr>
	<td colspan="3" style="text-align: center;">총 <%=len %>개의 글</td>
</tr>
<tr>
	<td colspan="3" style="text-align: center;">
		<%
	for(int i=0; i<bbsPage; i++){
	if(pageNumber == i){
		%>
		<span style="color: #A1C5D3; font-weight: 800;">
			<%=i + 1 %>
		</span>&nbsp;
		<%
	} else {
			%>
			<a href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)" 
				style="color: #000; font-weight: bold; text-decoration: none;">
				[<%=i + 1 %>]
			</a>&nbsp;
			<%
		}
	}	
%>	
	</td>
</tr>
</table>

<br>

<div align="center">
<select id="choice" class="selectoption">
	<option>선택</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
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

	location.href = "main.jsp?content=./myPage/myPageMain&myContent=myCs&choice=" + choice + "&search=" + search;
}
function goPage(pageNum){
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "main.jsp?content=./myPage/myPageMain&myContent=myCs&choice=" +choice+ "&search=" +search+ "&pageNumber=" + pageNum;
		
}

</script>


</body>
</html>