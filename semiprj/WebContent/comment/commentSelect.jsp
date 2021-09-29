<%@page import="dto.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int cseq = Integer.parseInt(request.getParameter("cseq"));
CommentDao dao = CommentDao.getInstance();
List<CommentDto> list = dao.selectComment(cseq);

String json = "[";
for(int i = 0; i<list.size(); i++){

	  json += "{ \"cseq\":" + list.get(i).getCseq() + ", "
	           +    " \"id\":\"" + list.get(i).getId() + "\", " 
	           +    " \"wdate\":\"" + list.get(i).getWdate()+ "\","
	           +    " \"seq_restaurant\":" + list.get(i).getSeq_restaurant() + ", "
	           +    " \"content\":\"" + list.get(i).getContent().replace("\n", "<br>") + "\"";
	      json += " }, ";  // , 지워야할수도
}
 json = json.substring(0, json.lastIndexOf(",")); 

json += "]";

out.println(json);
%>