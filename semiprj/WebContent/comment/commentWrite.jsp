<%@page import="dto.CommentDto"%>
<%@page import="dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
String id = request.getParameter("id");
String content = request.getParameter("content");


CommentDao dao = CommentDao.getInstance();
boolean isS = dao.writeCommentBbs(new CommentDto(seq, id, content));

if(isS){    
	out.println("yes");    
}else if(isS == false || content.equals("")){
	out.println("no");  	   
}

%>    
