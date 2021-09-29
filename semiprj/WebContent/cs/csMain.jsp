<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
   try{
   String csContent = request.getParameter("csContent");
   if(csContent == null){
      csContent = "csInfo";
   }
%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>

   <link rel="stylesheet" href="./css/writetable.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

<!-- 네비게이션/cs메인화면 레이아웃 잡는 테이블 -->
<table style="width: 1500px;">
   <tr align="center">
      <td width="300" style="vertical-align: top;">

         <!-- 고객센터 좌측 네비게이션바 -->
         <div>
            <table id="nav" class="writetable" style="min-height: 300px; vertical-align: top; margin-top: 100px;">
               <tr height="50px">
                  <th>
                     <h2>고객센터</h2>
                  </th>
               </tr>
               <tr>
                  <td>
                     <button type="button" class="menubutton" onclick="location.href='main.jsp?content=./cs/csMain'">고객센터 메인</button> <br><br>
                     <button type="button" class="menubutton" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csList'">1:1 문의하기</button>
                  </td>
               </tr>
            </table>
         </div>

      </td>
      <td>
         <jsp:include page='<%=csContent + ".jsp" %>' flush="false"/>
      </td>
   </tr>
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

<%} catch(Exception e) { %>
      <script>
         alert('로그인해 주십시오');
         location.href = "login.jsp";
      </script>
<%
      e.printStackTrace();
   }
%>
</body>

</html>