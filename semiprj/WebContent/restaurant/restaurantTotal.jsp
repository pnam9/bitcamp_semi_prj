<%@ page import="dao.RestaurantDao" %>
<%@ page import="dto.RestaurantDto" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.MemberDto" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2021-06-24
  Time: 오후 5:01
  To change this template use File | Settings | File Templates.
--%>
<%
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    RestaurantDao dao = RestaurantDao.getInstance();

    String choice = request.getParameter("choice");
    String search = request.getParameter("search");
    
    if(choice == null){
        choice = "";
    }
    if(search == null){
        search = "";
    }

    String sPageNumber = request.getParameter("pageNumber");
    int pageNumber = 0;
    if(sPageNumber != null && !sPageNumber.equals("")){
        pageNumber = Integer.parseInt(sPageNumber);
    }

    List<RestaurantDto> list = dao.getRestaurantPagingTotalList(mem.getId(), choice, search, pageNumber);

    int len = dao.getAllRestaurantTotal(choice, search);
    System.out.println("총 글의 수:" + len);

// 페이지 수
    int bbsPage = len / 12;      // 24 / 10 -> 2
    if((len % 10) > 0){
        bbsPage = bbsPage + 1;
    }

%>
<%!
    //제목 나누기
    public String skipTitle(String msg){
        String str = "";
        if(msg.length() >= 13){
            str = msg.substring(0, 13);
            str += "...";
        }else{
            str = msg.trim();
        }
        return str;
    }
    public String skipName(String msg){
        String str = "";
        if(msg.length() >= 8){
            str = msg.substring(0, 8);
            str += "...";
        }else{
            str = msg.trim();
        }
        return str;
    }
%>

<html>
<head>
     <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/restaurant.css">
    <link rel="stylesheet" href="./css/liked.css" >
   <link rel="stylesheet" href="./css/searchBar.css">
   <link rel="stylesheet" href="./css/writetable.css">
   
    <title>restaurantList.jsp</title>

    <script type="text/javascript">
        $(document).ready(function() {
            let search = "<%=search %>";
            if(search == "") return;

            let obj = document.getElementById("type-users1");
            obj.value = "<%=choice%>";
            obj.setAttribute("checked", "checked");

           
            
        });
    </script>

</head>
<body>

<%
    if( list == null || list.size() ==0 ){
%>
<div style="height: 700px; text-align: center; padding: 300px;">
    <div style="vertical-align: middle">
        <span style="font-family: 'ONE-Mobile-POP'; font-size: 30px;"> 작성된 글이 없습니다 😥 </span><br>
        <input type="button" style="width: 300px; font-size: 15px;" value="가장 먼저 후기 남기러 가기!" class="writebutton" onclick="location.href='main.jsp?content=/restaurant/restaurantWrite'">
    </div>
</div>
<%
} else {
%>
    <div class="container" style="margin-top: 50px;">
       <h2><span style="font-family: 'ONE-Mobile-POP'; font-size: 35pt; color: #333333; text-shadow: 2px 2px 0px #FFFFFF, 5px 4px 0px rgba(0,0,0,0.15); ">전체게시글 검색 결과</span></h2><br><br>
        <div style="width: 500px; margin: auto auto 50px auto; ">
            <form class="search-form">
                <input type="text" id="searchText" value="<%=search%>" placeholder="Search" class="search-input" >
                <button type="button" onclick="searchBtn()" class="search-button">
                    <svg class="submit-button">
                        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#search"></use>
                    </svg>
                </button>
                <div class="search-option">

                    <div hidden>
                        <input class="choice" type="radio" value="" id="type-users1" name="choice" >
                        <label for="type-users">
                            <svg class="edit-pen-title">
                                <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
                            </svg>
                            <span>test</span>
                        </label>
                    </div>

                    <div>
                        <input class="choice" type="radio" value="id" id="type-users" name="choice" >
                        <label for="type-users">
                            <svg class="edit-pen-title">
                                <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
                            </svg>
                            <span>작성자</span>
                        </label>
                    </div>

                    <div>
                        <input class="choice" type="radio" value="name" id="type-posts" name="choice">
                        <label for="type-posts">
                            <svg class="edit-pen-title">
                                <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#post"></use>
                            </svg>
                            <span>가게명</span>
                        </label>
                    </div>
                    <div>
                        <input class="choice" type="radio" value="title" id="type-images" name="choice">
                        <label for="type-images">
                            <svg class="edit-pen-title">
                                <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#images"></use>
                            </svg>
                            <span>글제목</span>
                        </label>
                    </div>
                    <div>
                        <input class="choice" type="radio" value="review" id="type-special" name="choice" >
                        <label for="type-special">
                            <svg class="edit-pen-title">
                                <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#special"></use>
                            </svg>
                            <span>내용</span>
                        </label>

                    </div>

                </div>

                <!-- 글쓰기 버튼 -->
                <div style="width: 610px">
                    <input type="button" style="float: right;"class="writebutton" value="글쓰기" onclick="location.href='main.jsp?content=restaurant/restaurantWrite'">
                </div>

                <svg xmlns="http://www.w3.org/2000/svg" width="0" height="0" display="none">
                    <symbol id="search" viewBox="0 0 32 32">
                        <path d="M 19.5 3 C 14.26514 3 10 7.2651394 10 12.5 C 10 14.749977 10.810825 16.807458 12.125 18.4375 L 3.28125 27.28125 L 4.71875 28.71875 L 13.5625 19.875 C 15.192542 21.189175 17.250023 22 19.5 22 C 24.73486 22 29 17.73486 29 12.5 C 29 7.2651394 24.73486 3 19.5 3 z M 19.5 5 C 23.65398 5 27 8.3460198 27 12.5 C 27 16.65398 23.65398 20 19.5 20 C 15.34602 20 12 16.65398 12 12.5 C 12 8.3460198 15.34602 5 19.5 5 z" />
                    </symbol>
                    <symbol id="user" viewBox="0 0 32 32">
                        <path d="M 16 4 C 12.145852 4 9 7.1458513 9 11 C 9 13.393064 10.220383 15.517805 12.0625 16.78125 C 8.485554 18.302923 6 21.859881 6 26 L 8 26 C 8 21.533333 11.533333 18 16 18 C 20.466667 18 24 21.533333 24 26 L 26 26 C 26 21.859881 23.514446 18.302923 19.9375 16.78125 C 21.779617 15.517805 23 13.393064 23 11 C 23 7.1458513 19.854148 4 16 4 z M 16 6 C 18.773268 6 21 8.2267317 21 11 C 21 13.773268 18.773268 16 16 16 C 13.226732 16 11 13.773268 11 11 C 11 8.2267317 13.226732 6 16 6 z" /></symbol>
                    <symbol id="images" viewbox="0 0 32 32">
                        <path d="M 2 5 L 2 6 L 2 26 L 2 27 L 3 27 L 29 27 L 30 27 L 30 26 L 30 6 L 30 5 L 29 5 L 3 5 L 2 5 z M 4 7 L 28 7 L 28 20.90625 L 22.71875 15.59375 L 22 14.875 L 21.28125 15.59375 L 17.46875 19.40625 L 11.71875 13.59375 L 11 12.875 L 10.28125 13.59375 L 4 19.875 L 4 7 z M 24 9 C 22.895431 9 22 9.8954305 22 11 C 22 12.104569 22.895431 13 24 13 C 25.104569 13 26 12.104569 26 11 C 26 9.8954305 25.104569 9 24 9 z M 11 15.71875 L 20.1875 25 L 4 25 L 4 22.71875 L 11 15.71875 z M 22 17.71875 L 28 23.71875 L 28 25 L 23.03125 25 L 18.875 20.8125 L 22 17.71875 z" />
                    </symbol>
                    <symbol id="post" viewbox="0 0 32 32">
                        <path d="M 3 5 L 3 6 L 3 23 C 3 25.209804 4.7901961 27 7 27 L 25 27 C 27.209804 27 29 25.209804 29 23 L 29 13 L 29 12 L 28 12 L 23 12 L 23 6 L 23 5 L 22 5 L 4 5 L 3 5 z M 5 7 L 21 7 L 21 12 L 21 13 L 21 23 C 21 23.73015 21.221057 24.41091 21.5625 25 L 7 25 C 5.8098039 25 5 24.190196 5 23 L 5 7 z M 7 9 L 7 10 L 7 13 L 7 14 L 8 14 L 18 14 L 19 14 L 19 13 L 19 10 L 19 9 L 18 9 L 8 9 L 7 9 z M 9 11 L 17 11 L 17 12 L 9 12 L 9 11 z M 23 14 L 27 14 L 27 23 C 27 24.190196 26.190196 25 25 25 C 23.809804 25 23 24.190196 23 23 L 23 14 z M 7 15 L 7 17 L 12 17 L 12 15 L 7 15 z M 14 15 L 14 17 L 19 17 L 19 15 L 14 15 z M 7 18 L 7 20 L 12 20 L 12 18 L 7 18 z M 14 18 L 14 20 L 19 20 L 19 18 L 14 18 z M 7 21 L 7 23 L 12 23 L 12 21 L 7 21 z M 14 21 L 14 23 L 19 23 L 19 21 L 14 21 z" />
                    </symbol>
                    <symbol id="special" viewbox="0 0 32 32">
                        <path d="M 4 4 L 4 5 L 4 27 L 4 28 L 5 28 L 27 28 L 28 28 L 28 27 L 28 5 L 28 4 L 27 4 L 5 4 L 4 4 z M 6 6 L 26 6 L 26 26 L 6 26 L 6 6 z M 16 8.40625 L 13.6875 13.59375 L 8 14.1875 L 12.3125 18 L 11.09375 23.59375 L 16 20.6875 L 20.90625 23.59375 L 19.6875 18 L 24 14.1875 L 18.3125 13.59375 L 16 8.40625 z M 16 13.3125 L 16.5 14.40625 L 17 15.5 L 18.1875 15.59375 L 19.40625 15.6875 L 18.5 16.5 L 17.59375 17.3125 L 17.8125 18.40625 L 18.09375 19.59375 L 17 19 L 16 18.40625 L 15 19 L 14 19.59375 L 14.3125 18.40625 L 14.5 17.3125 L 13.59375 16.5 L 12.6875 15.6875 L 13.90625 15.59375 L 15.09375 15.5 L 15.59375 14.40625 L 16 13.3125 z" />
                    </symbol>
                </svg>

            </form>
        </div>


        <% for(int i = 0; i < list.size(); i++){
            RestaurantDto dto = list.get(i);
        %>
        <div class="col-md-4" style="float: left; margin-bottom: 40px;">
            <div class="card shadow" style="width: 20rem;">
                <a href = main.jsp?content=/restaurant/restaurantDetail&seq=<%=dto.getSeq()%> style="margin-top: auto">
                    <div class="inner">
                        <img src="./upload/<%=dto.getNewFileName()%>" class="card-img-top" alt="..." width="300" height="200">
                    </div>
                </a>
                <div class="card-body text-center">
                    <h5 class="card-title"><b><%=skipTitle(dto.getTitle())%></b></h5>
                    가게명 : <%=skipName(dto.getName())%>&nbsp;&nbsp;( <%=dto.getKinds()%> )<br>
                    전화번호 : <%=dto.getTel()%><br>
                    영업시간 : <%=dto.getOperatingTime()%><br>
                    평점 : <%
                            for(int j = 0; j < dto.getScore(); j++){
                            %>
                                 ⭐
                                <!--<img src="./image/score.png" width="25" height="25">-->
                            <%
                                }
                            %>
                     <p> </p>
                                <div>
                                    <div class='middle-wrapper'>
                                        <div class='like-wrapper'>
                                                    <%
                                                        if(dto.getLikedYn() == 1){
                                                            System.out.println("getLikedYn = " + dto.getLikedYn());
                                                            %>
                                                          <a class='like-button liked' value="<%=dto.getSeq()%>">
                                                                <span class='like-icon liked'>
                                                                    <div class='heart-animation-1'></div>
                                                                    <div class='heart-animation-2'></div>
<%--                                                                    <script type="text/javascript">--%>
<%--                                                                        $(this).toggleClass('liked');--%>
<%--                                                                    </script>--%>
                                                                </span>
                                                              Like
                                                          </a>
                                                            <%
                                                        }else {
                                                    %>
                                                        <a class='like-button' value="<%=dto.getSeq()%>">
                                                                <span class='like-icon'>
                                                                    <div class='heart-animation-1'></div>
                                                                    <div class='heart-animation-2'></div>
                                                                </span>
                                                            Like
                                                        </a>
                                                    <%
                                                              }
                                                    %>

                                        </div>
                                    </div>
                                </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
<% } %>
<div class="container" style="margin: auto">
    <div class="row">
        <div class="col" style="margin:auto">
            <ul class="pagination justify-content-center">
                                    <!--//Integer.parseInt(request.getParameter("pageNumber"))% - 1 -->
                <%--<li class="page-item"><a class="page-link" href="#" onclick="goPage(<%=pageNumber%>)">이전</a></li>--%>
<%
    for(int i = 0;i < bbsPage; i++){
        if(pageNumber == i){   // 현재페이지      [1] 2 [3]
%>
        <li class="page-item active">
            <a class="page-link" href="#">
        <!-- <span style="font-size: 15pt; color: #0000ff; font-weight: bold"; > -->
      <%=i + 1 %>
      <!-- </span>&nbsp; -->
            </a>
        </li>

        <%
        }else{               // 그밖에 페이지
        %>
                <li>
                <a class="page-link" href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)">
                    <%=i + 1 %>
                </a>&nbsp;
                </li>

<%
        }
    }
%>
                <!--//Integer.parseInt(request.getParameter("pageNumber"))% + 1 -->
                <%--<li class="page-item"><a class="page-link" href="#" onclick="goPage(<%=pageNumber%>)" >다음</a></li>--%>
            </ul>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        /* $('#search').val(''); */
        /* $("#choice option:eq(0)").prop("selected", true); */

    })

   <%--  //let loc = "<%=location%>"; --%>
    //alert(location);

    function searchBtn() {
        let choice = $('input[name="choice"]:checked').val();
        let search = $('#searchText').val();

        if(choice == undefined){
            alert('옵션을 선택해 주십시오');
            return;
        }

        if(search.trim() == '') {
            alert('검색어를 입력해 주십시오');
            return;
        }
        location.href = "main.jsp?content=/restaurant/restaurantTotal&choice=" + choice + "&search=" + search;
    }

    function goPage( pageNum ) {
    	  let choice = $('.choice').val();
          let search = $('#searchText').val();


        //let num = <%=pageNumber%>;
        //console.log(typeof num);

        /*if(pageNum < 0 || pageNum > num - 1){
             alert('페이지가 존재하지 않습니다.');
             location.href = 'restaurantList.jsp?location='+ location;
         }*/

        location.href = "main.jsp?content=/restaurant/restaurantTotal&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
    }
    
    $('a.like-button').on('click', function (e) {
        $(this).toggleClass('liked');
        let seq = $(this).attr("value");
        
        $.ajax({
            url : "./restaurant/liked.jsp",
            type : "get",
            data : { "seq" : seq , "id" : "<%=mem.getId()%>" },
                success( data ){

                },
               error ( error, obj ){

               },
          });
    });

    $('a.like-button.liked').on('click', function (e){
        $(e.target).removeClass('liked');
    });


</script>
</body>
</html>