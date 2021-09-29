<%@ page import="dto.MemberDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/locationBtn.css">
<link rel="stylesheet" type="text/css" href="./css/mainSearch.css">
<link rel="stylesheet" type="text/css" href="./css/slide.css">

</head>

<body>
   <!-- 검색창 -->
   
      <div id="searchbox">
<!--       <div id="searchtitle">맛집 검색</div> -->
         <div id="cover">
           <div name="searchform" class="searchform">
             <div class="tb">
               <div class="td"><input type="text" name="search" id="search" class="searchinput" placeholder="배고파? 맛집 검색"></div>
               <div class="td" id="s-cover">
                 <button type="button" class="searchbtn" id="searchbtn">
                   <div id="s-circle"></div>
                   <span></span>
                 </button>
               </div>
             </div>
           </div>
         </div>
      </div>
      
<!-- 이미지 슬라이드 -->
<div id="silder">
<div style="font-size: 24pt; text-align: left; color: #634E41; font-family: YoonDokrip; padding-bottom: 10px; margin-left:20px;">뭐 먹을래?</div>
   <div class="carousel" duration="3500">
  <ul>
   <li id="c1_slide1"><div style=" cursor: pointer; width: 100%; height: 100%;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csDetail&seq=7';"></div></li>
    <li id="c1_slide2"><div style=" cursor: pointer; width: 100%; height: 100%;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csDetail&seq=8';"></div></li>  
    <li id="c1_slide3"><div style=" cursor: pointer; width: 100%; height: 100%;" onclick="location.href='main.jsp?content=./cs/csMain&csContent=csDetail&seq=10';"></div></li>  
    <li id="c1_slide4"><div style=" cursor: pointer; width: 100%; height: 100%;" onclick="#"></div></li>  
<!--     <li id="c1_slide5"><div>  <br /><a href="https://www.google.com">보러가기</a></div></li>   -->
  </ul>
  <ol>
    <li><a href="#c1_slide1"></a></li>
    <li><a href="#c1_slide2"></a></li>
    <li><a href="#c1_slide3"></a></li>
    <li><a href="#c1_slide4"></a></li>
    <!-- <li><a href="#c1_slide5"></a></li> -->
  </ol>
  <div class="prev">&lsaquo;</div>
  <div class="next">&rsaquo;</div>
</div>

</div>

   <br>
   <br>
      <div style="font-size: 24pt; text-align: left; color: #634E41; font-family: YoonDokrip; padding-bottom: 10px; margin-left:20px;">어디로 갈래?</div>
    

   <!-- 서울 지도 & 버튼 -->
   <div style="text-align: center; background-color: #A1C5D3; ">      
      <div style="position: relative; transform:translate(-50%, 0%); left:50%; width:1300px">
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=강남구'" style="position: absolute; top: 650px; left: 800px;" >강남구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=강동구'" style="position: absolute; top: 500px; left: 1000px;" >강동구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=강북구'" style="position: absolute; top: 210px; left: 670px;" >강북구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=강서구'" style="position: absolute; top: 440px; left: 240px;" >강서구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=관악구'" style="position: absolute; top: 720px; left: 540px;" >관악구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=광진구'" style="position: absolute; top: 500px; left: 870px;" >광진구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=구로구'" style="position: absolute; top: 630px; left: 310px;" >구로구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=금천구'" style="position: absolute; top: 760px; left: 430px;" >금천구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=노원구'" style="position: absolute; top: 160px; left: 830px;" >노원구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=도봉구'" style="position: absolute; top: 120px; left: 720px;" >도봉구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=동대문구'" style="position: absolute; top: 400px; left: 780px;" >동대문구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=동작구'" style="position: absolute; top: 640px; left: 550px;" >동작구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=마포구'" style="position: absolute; top: 460px; left: 440px;" >마포구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=서대문구'" style="position: absolute; top: 400px; left: 500px;" >서대문구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=서초구'" style="position: absolute; top: 700px; left: 690px;" >서초구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=성동구'" style="position: absolute; top: 490px; left: 760px;" >성동구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=성북구'" style="position: absolute; top: 330px; left: 710px;" >성북구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=송파구'" style="position: absolute; top: 640px; left: 970px;" >송파구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=양천구'" style="position: absolute; top: 550px; left: 290px;" >양천구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=영등포구'" style="position: absolute; top: 560px; left: 460px;" >영등포구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=용산구'" style="position: absolute; top: 550px; left: 620px;" >용산구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=은평구'" style="position: absolute; top: 280px; left: 470px;" >은평구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=종로구'" style="position: absolute; top: 350px; left: 580px;" >종로구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=중구'" style="position: absolute; top: 460px; left: 630px;" >중구</button>
      <button type="button" class="locationbtn" onclick="location.href='main.jsp?content=restaurant/restaurantList&location=중랑구'" style="position: absolute; top: 350px; left: 880px;" >중랑구</button>

      <img src="./image/seoulmap.jpg" width=100%>
      
      </div>
      
   </div>

<script type="text/javascript">

   /* 이미지 슬라이드용 */
   document.addEventListener('DOMContentLoaded', function() {
    
     const carousels = document.querySelectorAll('.carousel');
     carousels.forEach(function( carousel ) {
   
       const ele = carousel.querySelector('ul');
       const bullets = carousel.querySelectorAll('ol li');
       const nextarrow = carousel.querySelector('.next');
       const prevarrow = carousel.querySelector('.prev');
       bullets[0].classList.add('selected');
   
       const setSelected = function() {
           bullets.forEach(function(bullet) {
              bullet.classList.remove('selected');
           });
           let nthchild = (Math.round(ele.scrollLeft/carousel.scrollWidth)+1);
           carousel.querySelector('ol li:nth-child('+nthchild+')').classList.add('selected'); 
       }
       
       const nextSlide = function() {
         if(!carousel.querySelector('ol li:last-child').classList.contains('selected')) {
           carousel.querySelector('ol li.selected').nextElementSibling.querySelector('a').click();
           ele.scrollLeft = ele.scrollLeft + carousel.scrollWidth;
         } else {
           carousel.querySelector('ol li:first-child a').click();
           ele.scrollLeft = 0;
         }
       }
   
       const prevSlide = function() {
         if(!carousel.querySelector('ol li:first-child').classList.contains('selected')) {
           carousel.querySelector('ol li.selected').previousElementSibling.querySelector('a').click();
           ele.scrollLeft = ele.scrollLeft - carousel.scrollWidth;
         } else {
           carousel.querySelector('ol li:last-child a').click();
           ele.scrollLeft = ele.scrollWidth - carousel.scrollWidth;
         }
       }
         
       // Attach the handlers
       ele.addEventListener("scroll", setSelected);
       nextarrow.addEventListener("click", nextSlide);
       prevarrow.addEventListener("click", prevSlide);
   
       //setInterval for autoplay
       if(carousel.getAttribute('duration')) {
         setInterval(function(){ 
           if (ele != document.querySelector(".carousel:hover ul")) {
             if(ele.scrollWidth > ele.scrollLeft + carousel.scrollWidth) {
               ele.scrollLeft = ele.scrollLeft + carousel.scrollWidth;
             } else ele.scrollLeft = 0;
           }
         }, carousel.getAttribute('duration'));
       }
       
     }); //end foreach
     
   }); //end onload
<%
   Object objLogin = session.getAttribute("login");
   MemberDto mem = null;
%>
   $('#searchbtn').on('click', function (){
      /*if( $('#search').val().trim() == "" ){
         alert('검색어를 입력해주세요');
      }*/
<%
   if(objLogin == null){
%>
         alert('로그인이 필요한 서비스입니다.');
         location.href = "login.jsp";
      <%
         }else{
      %>
         totalSearch();
<%   }  %>
   });

   function totalSearch() {
         let search = $('#search').val();
         //alert(search);
         if(search == null && search.equals(" ")) {
            location.href = "main.jsp?content=/restaurant/restaurantTotal";
         }else{
          location.href = "main.jsp?content=/restaurant/restaurantTotal&choice=name&search=" + search;
         }
   }


</script>


</body>
</html>