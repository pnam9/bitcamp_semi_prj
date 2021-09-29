<%@page import="dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int cseq = Integer.parseInt(request.getParameter("cseq"));
String content = request.getParameter("content");
CommentDao dao = CommentDao.getInstance();
boolean isS = dao.updateCommentBbs(cseq, content);
if(isS){    
	out.println("yes");    
}else{
	out.println("no");  	   
}
%>  