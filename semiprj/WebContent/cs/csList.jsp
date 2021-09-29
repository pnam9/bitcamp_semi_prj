<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>

<%@page import="dto.CsDto"%>
<%@page import="dao.CsDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<%!   /* 선언부 */
      
   // 답글에 depth와 image 추가하기
   public String arrow(int depth){
      
      String rs = "  <img src='./image/arrow.png' width='20px' height='20px' />";
      String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
      
      String ts = "";
      for(int i=0; i<depth; i++){
         ts += nbsp;
      }
      return depth==0?"":ts + rs;
   }
%>

<%
    CsDao dao = CsDao.getInstance();
   
   // 이전 화면의 페이지 번호 가져오기
   String sPageNumber = request.getParameter("pageNumber");
   int pageNumber = 0;
   if(sPageNumber != null && !sPageNumber.equals("")){
      pageNumber = Integer.parseInt(sPageNumber);
   }
   
   // 검색을 통해 리스트에 접근했을 경우
   String choice = request.getParameter("choice");
   String search = request.getParameter("search");
   
   System.out.println("csList choice : " + choice);
   System.out.println("csList search : " + search);
   if(choice == null){
      choice = "";
   }
   if(search == null){   
      search = "";
   }
   
   // 총 게시글 수 가져오기
   int len = dao.getAllCs(choice, search);
   System.out.println(len);
   
   // 한 화면에 노출 가능한 게시글 수 이상일 경우 추가 페이지 생성
   int bbsPage = len / 15;
   if((len%15)>0){
      bbsPage = bbsPage + 1;
   }
   
   // 모든 글 가져오기 (공지용)
   List<CsDto> notice = dao.getCsList();
   
   
   // 검색조건에 맞추어 페이징 하기
   List<CsDto> list = dao.getCsPagingList(choice, search, pageNumber);
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="./css/writetable.css">
<title>Insert title here</title>
</head>
<body>

<!-- 게시물 리스트 -->
<div align="center" class="write">      
   <table class="listtable">
       <col width="10%"><col width="55%"><col width="15%"><col width="20%">
      <thead>
         <tr>
            <td colspan="4">
            <h1><a href="main.jsp?content=./cs/csMain&csContent=csList">1:1 문의 게시판</a></h1>
            <span>총 <%=len %>개의 글</span>
            </td>
         </tr>      
         <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일자</th>
         </tr>
      </thead>
      <tbody>
<%
   if(list == null || list.size() == 0){
%>
      <tr>   
         <td colspan="4" align="center" height="500">작성된 글이 없습니다😥</td>
      </tr>
<%
   } else {
      for(int i=0; i<notice.size(); i++){ // 공지 상단 고정하는 부분
      
         CsDto bbs = notice.get(i);
         
         // 공지글 게시 조건 (type==1이면서 삭제되지 않은 글)
         if(bbs.getType() == 1 && bbs.getDel() == 0){
%>
         <tr>
            <th><strong>공지</strong></th>
            <th><strong>📢 <a href="main.jsp?content=./cs/csMain&csContent=csDetail&seq=<%=bbs.getSeq() %>"><%=bbs.getTitle() %></a></strong></th>
            <th><strong>관리자</strong></th> 
            <th><strong><%=bbs.getWdate().substring(0, 10) %></strong></th>
         </tr>
<%
         }
      }
      for(int i=0; i<list.size(); i++){
         
         CsDto bbs = list.get(i);
         
         if(bbs.getType() == 0){

%>         
         <tr>
            <th><%=i +1 %></th>
            <td style="text-align: left;">
               <%=arrow(bbs.getDepth()) %>
               <% 
                  if(bbs.getDel() == 0){
               %>
                  🔒 <a href="main.jsp?content=./cs/csMain&csContent=csDetail&seq=<%=bbs.getSeq() %>">
                     <%=bbs.getTitle() %>
                  </a>
               <%
                  } else {
               %>
                  <span style="color: red; font-weight: bold;">❗ 삭제된 글입니다</span>
               <%
                  }
               %>
            </td>
            <td><%=bbs.getId() %></td> 
            <td><%=bbs.getWdate().substring(0, 16) %></td>
         </tr>

<%
         } else if (bbs.getType() == 1){
            %>         
            <tr>
               <th><%=i +1 %></th>
               <td style="text-align: left;">
                  <%=arrow(bbs.getDepth()) %>
                  <% 
                     if(bbs.getDel() == 0){
                  %>
                     📢 <a href="main.jsp?content=./cs/csMain&csContent=csDetail&seq=<%=bbs.getSeq() %>">
                        <%=bbs.getTitle() %>
                     </a>
                  <%
                     } else {
                  %>
                     <span style="color: red; font-weight: bold;">❗ 삭제된 공지입니다</span>
                  <%
                     }
                  %>
               </td>
               <td><%=bbs.getId() %></td> 
               <td><%=bbs.getWdate().substring(0, 16) %></td>
            </tr>

   <%
         }
      }
   }
%>

<tr>
   <td colspan="4" style="text-align: center;">   
<%
   for(int i=0; i<bbsPage; i++){
      if(pageNumber == i){
         %>
         <span style="font-weight: bold; color: #A1C5D3;">
            <%=i + 1 %>
         </span>
         &nbsp;
         <%
      } else {
         %>
         <a href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)" style="font-weight: bold;">
         [<%=i + 1 %>]
         </a>
         &nbsp;
         <%
      }
   }   
%>   
   </td>
</tr>
<tr>
   <td colspan="4" style="text-align: right;">
   <button type="button" class="writebutton" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csWrite'">글쓰기</button>
   </td>
</tr>
</tbody>
</table>

   <!-- 게시글 검색창 -->
   <div align="center">
      <select name="choice" id="choice" class="selectoption">
         <option>선택</option>
         <option value="title">제목</option>
         <option value="content">내용</option>
         <option value="id">작성자</option>
      </select>
      <input type="text" id="search" size="20" placeholder="검색내용" name="search">
      <button type="button" class="writebutton" onclick="searchBtn()" style="width: 80px;">검색</button>
   </div>

</div> <!-- class="write" end -->

<script type="text/javascript">

/* 	$(document).ready(function () {
    $('#search').val('');
    $("#choice option:eq(0)").prop("selected", true);

}) */

   /* 페이지 이동 */
   function goPage(pageNum){
   	/* java.lang.IllegalArgumentException 오류 - 파라미터를 encodeURI()로 감싸서 해결 */
      location.href = "main.jsp?content=./cs/csMain&csContent=csList&choice=" + encodeURI(choice) + "&search=" + encodeURI(search) + "&pageNumber=" + encodeURI(pageNum);
   }
   
   function searchBtn(){
       let choice = document.getElementById("choice").value;
       let search = document.getElementById("search").value;
       
       if(search.trim() == '') {        
           alert("검색어를 입력해주세요");
           return;
       }
       
       location.href = "main.jsp?content=./cs/csMain&csContent=csList&choice=" + choice + "&search=" + search;
   }

</script>

</body>
</html>