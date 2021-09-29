<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>regi.jsp</title>
<!-- <link rel="stylesheet" type="text/css" href="./css/login.css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="./css/regi.css"/>
</head>
<body>

<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->
    <!-- Icon -->
    <div class="fadeIn first">
     <a href="main.jsp"> <img src="image/logo1.png" width="250"></a>
    </div>

<form action="regiAf.jsp" method="post">
<div class="container">
    <div class="row">
    
      <h4>가입정보</h4>
      <div class="input-group">
      	<input type="text" id="id" name="id" maxlength="20" placeholder="아이디" required>
        <p id="idcheck" style="font-size: 12px"></p>	
		<input type="password" name="pwd" id="pw1" placeholder="비밀번호" required>
        <p id="chkPW" style="font-size: 12px" ></p>
        <input type="password" placeholder="비밀번호 확인" name="pwd_check" id="pw2" onkeyup="checkPwd()" required>
        <p id="checkPwd" style="font-size: 12px" ></p>
        <input type="text" name="name" placeholder="이름" required>
      </div>

      <div class="input-group">
        <!-- <input type="text" placeholder="Email"/> -->
      <input type="text" name="email_id"  id="email_id" style="width:150px;" placeholder="Email Id" required>@
	  <input type="text" name="email_add" id="email_add" style="width:145px;" placeholder="Email Addr" required>

	
      <select name="email_sel" id="email_sel" onchange="change_email();" style="width:130px;height:55px;">
	      <option value="">직접입력</option>
	      <option value="naver.com">naver.com</option>
	      <option value="gmail.com">gmail.com</option>
	      <option value="nate.com">nate.com</option>
	  </select>
    </div>
    
    
    <div class="row">
      <div>
        <h4>생년월일</h4>
        <div class="input-group">
        
          <div class="col-third">
            <input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" style="width:130px;height:55px;"
			oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required >
          </div>
        
      
        <div class="col-five">   
             <select name="birthmm" style="width:130px;height:55px;" required>
				<option value="">월</option>
				<option value="01" >1</option>
				<option value="02" >2</option>
				<option value="03" >3</option>
				<option value="04" >4</option>
				<option value="05" >5</option>
				<option value="06" >6</option>
				<option value="07" >7</option>
				<option value="08" >8</option>
				<option value="09" >9</option>
				<option value="10" >10</option>
				<option value="11" >11</option>
				<option value="12" >12</option>
			</select>
          </div>
      
          <div class="col-fo">
            <input type="text" name="birthdd" maxlength="2" placeholder="일" style="width:130px;height:55px;"
			oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required>
          </div>
        </div>
      </div>
</div> 
</div>     
	      <div class="row">
	        <h4>성별</h4>
	        <div class="input-group" >
	          <input id="gender-male" type="radio" name="gender" value="남자" required >
	          <label for="gender-male" >남성</label>
	          <input id="gender-female" type="radio" name="gender" value="여자" required>
	          <label for="gender-female">여성</label>
	        </div>
	      </div>
	    
	    
    
	   <div class="row">
	      <h4>주소</h4>
	      <div class="input-group">
			<input type="text" id="sample2_postcode" placeholder="우편번호" required>
			<input type="text" name="sample2_address" id="sample2_address" placeholder="주소"><br>
			<input type="text" name="sample2_detailAddress" id="sample2_detailAddress" placeholder="상세주소">
			<input type="text" id="sample2_extraAddress" placeholder="참고항목">
			<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
			<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
	      </div>
	   </div>
    
	    
	   <div class="row">
	      <div class="input-group">
	       <input type="submit" class="fadeIn fourth" value="회원가입">
	      </div>
	   </div>
</div>
</form>
</div>
</div>



<script type="text/javascript">
$(document).ready(function(){ //id 한글입력 불가능 영어+숫자조합
	  $("input[name=id]").keyup(function(event){ 
	   if (!(event.keyCode >=37 && event.keyCode<=40)) {
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	   }
	  });
	});
</script>

<script type="text/javascript"> //id 유효성체크 하단 
$(document).ready(function() {
	$("#id").blur(function() {
		$.ajax({
			url:"idcheck.jsp",
			type:"post",
			data:{ "id":$("#id").val() },
			success:function( data ){
				if(data.trim() == "YES"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").text("사용할 수 있는 아이디입니다");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").text("사용할 수 없는 아이디입니다");
					$("#id").val("");
				}
			},
			error:function(){
				alert('error');
			}			
		});
	});
});
</script>

<script type="text/javascript"> //pw 유효성 체크
function checkPwd(){
	  var f1 = document.forms[0];
	  var pw1 = f1.pwd.value;
	  var pw2 = f1.pwd_check.value;
	  if(pw1!=pw2){
	   document.getElementById('checkPwd').style.color = "#ff0000";
	   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
	  }else{
	   document.getElementById('checkPwd').style.color = "#0000ff";
	   document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
	  }
	 }
</script>

<script type="text/javascript"> // 이메일 선택시옵션값 추가
function change_email() { //이메일 옵션값 추가 함수
	  var email_add = document.getElementById("email_add");
	  var email_sel = document.getElementById("email_sel");
	  //지금 골라진 옵션의 순서와 값 구하기
	  var idx = email_sel.options.selectedIndex;
	  var val = email_sel.options[idx].value;
	  email_add.value = val;
	}
</script>


<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 400; //우편번호서비스가 들어갈 element의 width
        var height = 500; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 3; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/3 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/1.8 - borderWidth) + 'px';
    }
</script>


</body>
</html>