<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}
%>

<% 
MemberDao dao = MemberDao.getInstance();

String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}

List<MemberDto> list = dao.getMemberPagingList(choice, search, pageNumber);

int len = dao.getAllMember(choice, search);
System.out.println("총 가입 수:" + len);

int bbsPage = len / 15;
if((len % 15)>0){
	bbsPage = bbsPage + 1;
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든회원정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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
<col width="70"><col width="70"><col width="70"><col width="70"><col width="70"><col width="70"><col width="70"><col width="120"><col width="90"><col width="90">
<tr>
	<td colspan="10" style="text-align: left;">
		<h2 style="margin-left: 20px;">모든회원정보</h2>
	</td>
</tr>
<tr>
	<th>번호</th><th>아이디</th><th>비밀번호</th><th>이름</th><th>생년월일</th><th>성별</th><th>이메일</th><th>주소</th><th>회원상태</th><th>회원삭제</th>
</tr>
<%
	if(list == null || list.size() == 0){
		%>
		<tr>
			<td colspan="10">회원정보가 없습니다</td>
		</tr>
<%
	}else{
		for(int i = 0;i < list.size(); i++){
			MemberDto bbs = list.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td><%=bbs.getId() %></td>
			<td>*******</td>
			<td><%=bbs.getName() %></td>
			<td><%=bbs.getBirth() %></td>
			<td><%=bbs.getGender() %></td>
			<td><%=bbs.getEmail() %></td>
			<td><%=bbs.getAddr() %></td>
			<%
			if(bbs.getAuth() == 0) { 
			%>
			<td>비회원</td>
			<% 
			} else if (bbs.getAuth() == 1){
			%>
			<td>회원</td>
			<% 
			} else if (bbs.getAuth() == 3){
			%><td>관리자</td>
			<% 
			}
			%>
			<%
			if(bbs.getAuth() == 1) { 
			%>
			<td><button type="button" onclick="_delete('<%=bbs.getId() %>')">삭제</button></td>
			<% 
			} else if(bbs.getAuth() == 0) {
			%>
			<td><button type="button" onclick="_restore('<%=bbs.getId() %>')">회원복구</button></td>
			<% 
			}else {
			%>
			<td></td>
			<% 
			}
			%>
		</tr>
	<%
	}
}
%> 
<tr>
	<td colspan="10" style="text-align: center;">총 <%=len %>명의 회원</td>
</tr>
<tr>
	<td colspan="10" style="text-align: center;">
	<%
	for(int i=0; i<bbsPage; i++){
	if(pageNumber == i){
		%>
		<span style="color: #A1C5D3; font-weight: bold;">
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

<div align="center" class="write">
<select id="choice" class="selectoption">
	<option>선택</option>
	<option value="id">아이디</option>
	<option value="auth">회원상태</option>
	<option value="name">이름</option>
	<option value="addr">주소</option>
	<option value="gender">성별</option>
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
	let search = document.getElementById('search').value;
	
	location.href = "main.jsp?content=./managerPage/managerMain&myContent=allMember&choice=" + choice + "&search=" + search;
}

function goPage(pageNum) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "main.jsp?content=./managerPage/managerMain&myContent=allMember&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}
function _delete(id) {
	
	let v = confirm('정말 삭제하시겠습니까?');
	
	if(v == true){
	//	alert('true');
		location.href = "main.jsp?content=./managerPage/managerMain&myContent=managerDeleteMember&id=" + id;
	}
}
function _restore (id) {
	
	let v = confirm('정말 복구하시겠습니까?');
	
	if(v == true){
	//	alert('true');
		location.href = "main.jsp?content=./managerPage/managerMain&myContent=managerRestoreMember&id=" + id;
	}
}
</script>
</body>
</html>