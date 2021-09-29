<%@ page import="dao.RestaurantDao" %>
<%@ page import="dto.RestaurantDto" %>
<%@ page import="dto.MemberDto" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2021-06-24
  Time: 오후 3:08
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
    request.setCharacterEncoding("UTF-8");

    String location = request.getParameter("location");

    int seq = Integer.parseInt(request.getParameter("seq"));
    RestaurantDao dao = RestaurantDao.getInstance();

    RestaurantDto dto = dao.getRestaurant(mem.getId(), seq);

%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="./css/restaurant.css">
    <link rel="stylesheet" href="./css/liked.css" >
    <link rel="stylesheet" href="./css/writetable.css">
    <title>restaurantListDetail.jsp</title>
</head>
<body>


<table class="detailtable" style="margin: auto; margin-top: 30px;">
    <col width="100"><col width="200"><col width="100"><col width="200">
    <tr>
    	<td colspan="4">
    		<h2 style="margin: 20px 0 10px 20px;"><%=dto.getTitle()%></h2>    	
    	</td>   
    </tr>
     <tr>
    	<td colspan="4" style="text-align: center;">
    		<img src="./upload/<%=dto.getNewFileName()%>" width="660">   	
    	</td>   
    </tr>
    <tr>
        <th>가게명 </th> <td> <%=dto.getName()%> </td>
        <th>작성자 </th> <td> <%=dto.getId()%> </td>
    </tr>
    <tr>
        <th>분류 </th> <td> <%=dto.getKinds()%></td>
        <th>작성일 </th> <td> <%=dto.getWdate().substring(0,16)%></td>
    </tr>
    <tr>
        <th>지역 </th> <td> <%=dto.getLocation()%> </td>
        <th>조회수 </th> <td> <%=dto.getReadCount()%> </td>
    </tr>
    <tr>
        <th>가게번호 </th> <td> <%=dto.getTel()%> </td>
        <th>좋아요 </th> <td> <input type="text" id="likecheck" value="<%=dto.getLikeCount()%>" readonly="readonly" style="border: none; background: transparent; outline: none; size: 5; font-size: 11pt; "> </td>
    </tr>
    <tr>
        <th>운영시간 </th> <td> <%=dto.getOperatingTime()%> </td>
        <th>평점</th> <td> <% for(int j = 0; j < dto.getScore(); j++){
    %>

        ⭐
        <%
            }
        %>
    </td>
    </tr>
    <tr>
        <th style="vertical-align: middle;">후기</th>
        <td colspan="3"> <textarea rows="15" name="review" readonly> <%=dto.getReview()%></textarea> </td>
    </tr>
    <tr>
    	<td colspan="4">
    	
   			<!-- LIKE 버튼 -->
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
            
        </td>
    </tr>

    		
<%
    if(dto.getId().equals(mem.getId()) || mem.getAuth() == 3){
%>
	<tr>
    	<td style="text-align: right;" colspan="4">
			<button type="button" class="writebutton" onclick="updateRestaurantList(<%=dto.getSeq() %>)">수정</button>
			<button type="button" class="writebutton" onclick="deleteRestaurantList(<%=dto.getSeq() %>)">삭제</button>
		</td>
    </tr>
<%
    } else {
        dao.readCount(seq); //조회수 증가
    }
%>
</table>
<div style="margin: auto; width: 1100px; margin: 20px auto 100px auto;">
	<input type = "button" class="writebutton" style="float: left;" onclick="location.href='javascript:window.history.back();'" value="목록">
</div>

<script type="text/javascript">
    function updateRestaurantList(  ){
         location.href = 'main.jsp?content=/restaurant/restaurantUpdate&seq=<%=seq%>';       
     

    }
    function deleteRestaurantList( ){
        let v = confirm('정말 삭제하시겠습니까?');

        if(v){
            //alert(v);
            location.href = 'main.jsp?content=/restaurant/restaurantDelete&seq=<%=seq%>&location=<%=dto.getLocation()%>';
        }
    }
    $('a.like-button').on('click', function (e) {
        $(this).toggleClass('liked');
        let likeCount = $('#likecheck').val() * 1;

        console.log('test');
        $.ajax({
            url : "./restaurant/liked.jsp",
            type : "get",
            data : { "seq" : <%=seq%> , "id" : "<%=mem.getId()%>" },
            success( data ){
                if(data.trim() === "true"){
                    $('#likecheck').val(likeCount + 1);
                }else{
                    $('#likecheck').val(likeCount - 1);
                }
            },
            error ( error, obj ){

            },
        });
    });

    $('a.like-button.liked').on('click', function (e){
        $(e.target).removeClass('liked');
    });
</script>


<div style="background-color: gray; width: 1100px; height: 1px; margin: 50px auto 50px auto;"></div>


<!-- ========================================= 정아 ========================================= -->


<div class="write" role="group" style="width: 1000px; margin: auto; vertical-align: middle;">
    <textarea class="form-control" rows="3" id="reContent" placeholder="댓글을 입력하세요." style="width: 85%; border-color: #A9A9A9; float: left; margin: auto;" ></textarea>
    <% if(mem.getId() != null){ %>
    	<button type="button" class=commentbutton id="commentWrite" style="width: 10%; height: 80px;" >댓글쓰기</button>
	<% } %>
</div>

<div align="center" style="margin: 30px auto; width: 100%;">
<table id="comm_table" class="listtable">
	<colgroup>
		<col style="width: 100%">
	</colgroup>    
</table>
</div>


<script type="text/javascript">
$(document).ready(function() {   
   getCommentList();
});   

// 댓글작성
$("#commentWrite").click(function() {
	writeComment();
});
// 댓글삭제       
$("#comDelete").click(function() {
    comDelete(cseq);
});
// 댓글수정
$("#comUpdateComplete").click(function() {
    comUpdate(cseq);
});
// 수정취소
$("#comUpdateBack").click(function() {
	comUpdateBack(cseq);
});

// 댓글불러오기
function getCommentList() {
	
	console.log('댓글 불러오기 start');
	
    $.ajax({
    	
          url:"./comment/commentWriteAf.jsp",
          data: { seq:<%=seq%> },
          type:"get",
          success:function(str){
        	  
        	 console.log("str=====");
        	 console.log(str);
        	 
             let json = JSON.parse(str);
         	 
             
             let data = "";
             
             $.each(json, function(index, item) {
            	let wdate = item.wdate.substr(0, 16);
            	if(<%=mem.getAuth() %> == 1 || item.id == "<%=mem.getId()%>"){            
	                data += "<tr><th colspan='2' style='font-size: 14px; vertical-align: middle;'><img src='./image/user.png' style='width: 20px; opacity: 0.7; float:left; margin-left: 10px;'><span style='float: left; margin-left: 10px;'><strong>" + item.id + "</strong></span>";
	                data += "<span style='font-size: 12px; float: right; color: gray;'>🕓 " + wdate + "</span></th></tr>";
	                data += "<tr><td style='font-size: 15px; padding: 10px; height: 100px; vertical-align: middle;'><strong>"+ item.content + "</strong></td></tr>"; 
	                data += "<tr><td style='text-align: right; padding: none; width: 100%;'>";
	                data += "<input type='button' class='commentbutton' id='comUpdate"+item.cseq+"' onclick='comUpdate("+item.cseq+")' style='height: 30px; width: 70px; margin: none; font-size: 13px;' value='수정'>";
	                data += "<input type='button' class='commentbutton' id='comDelete"+item.cseq+"' onclick='comDelete("+item.cseq+")' style='height: 30px; width: 70px; margin: none; font-size: 13px;' value='삭제'></td></tr>";
	                data += "<tr id='comm"+item.cseq+"'></tr>";
                } else if(item.id != "<%=mem.getId()%>"){
                	data += "<tr><th colspan='2' style='font-size: 14px; vertical-align: middle;'><img src='./image/user.png' style='width: 20px; opacity: 0.7; float:left; margin-left: 10px;'><span style='float: left; margin-left: 10px;'><strong>" + item.id + "</strong></span>";
 	                data += "<span style='font-size: 12px; float: right; color: gray;'>🕓 " + wdate + "</span></th></tr>";
 	                data += "<tr><td style='font-size: 15px; padding: 10px; height: 100px; vertical-align: middle;'><strong>"+ item.content + "</strong></td></tr>"; 
	                data += "<tr id='comm"+item.cseq+"'></tr>";	
                }
                $("#comm_table").html(""); // 초기화
                $("#comm_table").append(data);
             });                      
          },
          error : function() {
        	  
        	 /*  alert('error'); */
            // alert(' getCommentList error');
          }
   });   
}

// 수정할 댓글 불러오기
 function comUpdate(cseq) {
   $.ajax({
        url  : "./comment/commentSelect.jsp",
        type : "post",
        data : {cseq: cseq },
        success : function(data) {
        	
            let json = JSON.parse(data);
            
            let datas = "";            
            
            $.each(json, function(index, item) {
        	datas += $('#comUpdate' + item.cseq).hide();
           	datas += $('#comDelete' + item.cseq).hide();
            datas += "<td><textarea class='comment' id='content' rows='5'  style='width: 90%;' >"+item.content.replaceAll('<br>', '\n')+"</textarea>";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            datas += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		    datas += "<input type='button' id='comUpdateComplete' onclick='comUpdateComplete("+item.cseq+")' style='height: 30px; width: 70px; margin: none; font-size: 13px;' class='commentbutton' value='완료'>&nbsp;";
            datas += "<input type='button' id='comUpdateBack' onclick='comUpdateBack()' style='height: 30px; width: 70px; margin: none; font-size: 13px;' class='commentbutton' value='취소'></td>";
             
            $("#comm" + item.cseq).append(datas); 
          });    
        },
        error : function() {
           // alert('comUpdate error');
        }
    }); 
}

// 댓글 수정 닫기 
function comUpdateBack() { 
	getCommentList();
}
   
// 댓글 수정 완료
function comUpdateComplete(cseq) {
   $.ajax({
       url:"./comment/commentUpdate.jsp",
       data: { cseq: cseq, content: $("#content").val() },
       type:"get",
         success : function(data) {
            console.log(data.trim()); 
            if (data.trim() == "yes") {
          //     alert("댓글이 수정되었습니다.");
            } else {
                alert("댓글수정이 실패되었습니다..");
            }
            getCommentList();
        },
        error : function() {
            alert('comUpdateComplete error');
        }
   });
}

// 댓글 삭제
function comDelete(cseq) {
   $.ajax({
        url  : "./comment/commentDelete.jsp", // 이 파일에
        type : "post", 
        data : {cseq: cseq },
        success : function(data) {
           console.log(data.trim()); 
           if (data.trim() == "yes") {
           //   alert("댓글이 삭제되었습니다.");
           } else {
              alert("댓글삭제가 실패되었습니다..");
           }
           getCommentList();
        },
        error : function() {
         //  alert('comDelete error');
        }
     });
}


// 댓글 쓰기
function writeComment() {
	
	
    $.ajax({
          url:"./comment/commentWrite.jsp",
          type:"get",
          data : {id:"<%=mem.getId()%>", seq:<%=seq%> , content:$("#reContent").val()},
          success:function(str){ 
             if (str.trim() == "yes") {
                  // alert("댓글이 추가되었습니다.");
                } else {
                   alert("댓글내용을 작성해 주세요.");
                }
              getCommentList();   
          },
          error : function() {
              alert('writeComment error');
          }
     });   
}  
</script>




</body>
</html>
