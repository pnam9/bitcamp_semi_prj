<%@page import="dto.CommentDto"%>
<%@page import="dao.CommentDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


int seq = Integer.parseInt(request.getParameter("seq"));

// DB 

CommentDao dao = CommentDao.getInstance();
List<CommentDto> list = dao.getCommentList(seq);

//json

String json = "[";

for(int i = 0; i<list.size(); i++){

	  json += "{ \"cseq\":" + list.get(i).getCseq() + ", "
	           +    " \"id\":\"" + list.get(i).getId() + "\", " 
	           +    " \"wdate\":\"" + list.get(i).getWdate()+ "\","  
	           +    " \"seq\":" + list.get(i).getSeq_restaurant() + ", "
	           +    " \"content\":\"" + list.get(i).getContent().replace("\n", "<br>") + "\"";
	      json += " },";  
}

if(list.size() != 0 ){
	json = json.substring(0, json.lastIndexOf(",")); 
}
json += "]";


//String json = "[{ \"id\":\"hello\", \"number\":24 }]";
out.println(json);
%>








