<%@ page import="dto.MemberDto" %>
<%@ page import="dao.RestaurantDao" %>
<%@ page import="dto.RestaurantDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    MemberDto mem = (MemberDto)session.getAttribute("login");
    if(mem == null){
%>
<script>
    alert("로그인 해 주십시오");
    location.href = "login.jsp";
</script>
<%
    }
%>

<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    RestaurantDao dao = RestaurantDao.getInstance();
    RestaurantDto dto = dao.getRestaurant(mem.getId(), seq);

    String tel = dto.getTel();

    //전화번호
    int idx = tel.indexOf("-");
    int idx2 = tel.lastIndexOf("-");

    String tel1 = tel.substring(0,idx);
    String tel2 = tel.substring(idx+1,idx2);
    String tel3 = tel.substring(idx2+1);

    //시간
    String opTime = dto.getOperatingTime();
    int idx3 = opTime.indexOf("~");
    System.out.println(idx3);
    String openTime = opTime.substring(0,idx3).trim();
    String closeTime = opTime.substring(idx3+1).trim();

    System.out.println(openTime);
    System.out.println(closeTime);


%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="./css/writetable.css">
    <meta charset="UTF-8">
    <title>restaurantUpdate.jsp</title>
</head>
<body>

<div class="container" align="center">
	<div class="writebox">
    <form action="main.jsp?content=/restaurant/restaurantUpdateAf" method="post" encType = "multipart/form-data">
        <input type="hidden" name="seq" value="<%=seq%>">
        <input type="hidden" name="id" value="<%=mem.getId() %>">
        <table class="writetable" style="margin: auto auto 30px;">
            <col width="100">
            <tr>
            	<td colspan="2">
            		<h2 style="margin-left: 20px">글수정</h2>
            	</td>
            </tr>
            <tr> <!-- 1열 -->
                <th>제목</th>
                <td colspan="2">
                    <input type="text" name="title" size="98" value="<%=dto.getTitle()%>">
                </td>
            </tr>

            <tr> <!-- 2열 -->
                <th>가게명</th>
                <td>
                    <input type="text" name="name" size="98" value="<%=dto.getName()%>">
                </td>
            </tr>

            <tr>
                <th>지역</th>
                <td>
                    <select id="location" name="location" >
                        <option value="강남구">강남구</option>
                        <option value="강동구">강동구</option>
                        <option value="강북구">강북구</option>
                        <option value="강서구">강서구</option>
                        <option value="관악구">관악구</option>
                        <option value="광진구">광진구</option>
                        <option value="구로구">구로구</option>
                        <option value="금천구">금천구</option>
                        <option value="노원구">노원구</option>
                        <option value="도봉구">도봉구</option>
                        <option value="동대문구">동대문구</option>
                        <option value="동작구">동작구</option>
                        <option value="마포구">마포구</option>
                        <option value="서대문구">서대문구</option>
                        <option value="서초구">서초구</option>
                        <option value="성동구">성동구</option>
                        <option value="성북구">성북구</option>
                        <option value="송파구">송파구</option>
                        <option value="양천구">양천구</option>
                        <option value="영등포구">영등포구</option>
                        <option value="용산구">용산구</option>
                        <option value="은평구">은평구</option>
                        <option value="종로구">종로구</option>
                        <option value="중구">중구</option>
                        <option value="중랑구">중랑구</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>
                    분류
                </th>
                <td >
                    <select id="kinds" name="kinds">
                        <option value="한식">한식</option>
                        <option value="일식">일식</option>
                        <option value="중식">중식</option>
                        <option value="양식">양식</option>
                        <option value="기타">기타</option>
                    </select>
                </td>
            </tr>

            <tr > <!-- 3열 -->
                <th>전화번호</th>
                <td>
                    <input type='tel' name='tel1' size="3" value="<%=tel1%>" maxlength="3"> -
                    <input type='tel' name='tel2' size="4" value="<%=tel2%>" maxlength="4"> -
                    <input type='tel' name='tel3' size="4" value="<%=tel3%>" maxlength="4">
                </td>
            </tr>
            <tr>
                <th>운영시간</th>
                <td >
                    오픈시간  <input name="opentime" type="time" value="<%=openTime%>"> ~
                    마감시간  <input name="closetime" type="time" value="<%=closeTime%>">
                    <%--                    <select></select> : <select>분</select> ~ <select>시</select> : <select>분</select>--%>
                    <!--
                    <select>
                        <option value="00">00</option>
                    </select>
                     -->
                </td>
            </tr>
            <tr> <!-- 4열 -->
                <th>평점</th>
                <td>
                    <select id="score" name="score">
                        <option value="1">1점</option>
                        <option value="2">2점</option>
                        <option value="3">3점</option>
                        <option value="4">4점</option>
                        <option value="5">5점</option>
                    </select>
                </td>
            </tr>

            <tr> <!-- 5열 -->
                <th>후기</th>
                <td >
                    <textarea rows="20" cols="100" name="review" ><%=dto.getReview()%></textarea>
                </td>
            </tr>

            <tr>
                <th>첨부파일</th>
                <td>
                    <input type="file" name="fileload" value="이미지 선택" accept="image/*" required >
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align: right;">
                    <input type="submit" class="writebutton" value="글쓰기">
                </td>
            </tr>

        </table>
    </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#location').val('<%=dto.getLocation()%>').prop("selected",true);
        $('#kinds').val('<%=dto.getKinds()%>').prop("selected",true);
        $('#score').val('<%=dto.getScore()%>').prop("selected",true);
    })

</script>


</body>
</html>