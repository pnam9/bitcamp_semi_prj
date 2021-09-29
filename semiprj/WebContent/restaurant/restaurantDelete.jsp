<%@ page import="dao.RestaurantDao" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2021-06-25
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    String location = request.getParameter("location");

    RestaurantDao dao = RestaurantDao.getInstance();
    boolean result = dao.delRestaurant(seq);

 if(result){
%>
    <script type="text/javascript">
        alert('삭제되었습니다.')
        location.href ='main.jsp?content=/restaurant/restaurantList&location=<%=location%>'
    </script>
<% } %>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
