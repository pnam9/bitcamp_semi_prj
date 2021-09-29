<%@ page import="dao.RestaurantDao" %>
<%@ page import="dao.LikedDao" %>

<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2021-06-25
  Time: 오후 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
System.out.println("testestesstet");
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    int restSeq = Integer.parseInt(request.getParameter("seq"));

    LikedDao likedDao = LikedDao.getInstance();
    RestaurantDao restDao = RestaurantDao.getInstance();

    System.out.println("id = " + id);
    System.out.println("restSeq = " + restSeq);

    int result = likedDao.checkLiked(id, restSeq);

    String str = "";

    if(result == 0){
        str += "plus";
        likedDao.addLiked(restSeq, id);
        restDao.likeCount(str, restSeq);
        out.println("true"); //좋아요 count +1
    }else{
        str += "minus";
        likedDao.delLiked(restSeq, id);
        restDao.likeCount(str, restSeq);
        out.println("false"); //좋아요 count -1
    }

%>

