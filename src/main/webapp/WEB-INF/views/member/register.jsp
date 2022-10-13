<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jspf"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Basic Page Needs
  ================================================== -->
  <meta charset="utf-8">
  <title>밀슐랭 | 회원가입</title>
  
<style>
.gradient-btn{
	display: inline-block;
  	padding: 0.5em 0.7em;
  	border-radius: 50px;
	color: #5a574c;
  	margin-top:0.7rem;
  	font-weight: bold;
  	font-size: 0.678rem;
  	letter-spacing: 0px;
	border: 0;
	outline: 0;
	background-color: #e1e1e1;
}

span{
	font-size: 11px;
}

.account .block {
    background-color: #fff;
    border: 1px solid #dedede;
    padding: 30px;
    margin: 50px 0;
}

/* 중복아이디 존재하지 않는경우 */
.memberId_re1{
	color : green;
	display : none;
}
/* 중복아이디 존재하는 경우 */
.memberId_re2{
	color : red;
	display : none;
}
.form-group1{
	margin-bottom: 8px;
} 
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<body id="body">

<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <h2 class="text-center">계정을 만드세요</h2>
          <form method="post" class="text-left clearfix" id="register_form">
            <div class="form-group1">
              <input type="text" name="memberId" id="memberId_re" class="form-control"  placeholder="아이디">
            </div>
            <span class = "memberId_re1">사용 가능한 아이디 입니다.</span>
            <span class = "memberId_re2">아이디가 이미 존재합니다.</span>
            <div class="form-group">
              <input type="password" name="memberPw" id="memberPw" class="form-control"  placeholder="비밀번호">
            </div>
            <div class="form-group">
              <input type="password" id="memberPw2" class="form-control"  placeholder="비밀번호 확인">
            </div>
            <div class="form-group">
              <input type="text" name="memberName" class="form-control"  placeholder="이름">
            </div>
            
            <div class="form-group">
			<input type="email" name="memberEmail" id="memberEmail_re" class="form-control"  placeholder="이메일" >                
			
			<!-- <button type="button" class="gradient-btn">확인 내용</button>
              <span id="emailCheckText">이메일 중복확인이 필요합니다.</span>   
             -->  
            </div>
            
            <div class="form-group">
			<input type="text" id="VerificationCode" class="form-control"  placeholder="인증코드" disabled="disabled">                
			<input type="button" id="emailSendBtn" class="gradient-btn" value = "본인확인">
            </div>
            
            <div class="form-group">
              <input type="text" name="memberAddress1" class="form-control"  placeholder="주소">
            </div>
            <div class="form-group">
              <input type="text" name="memberAddress2" class="form-control"  placeholder="주소">
            </div>
            <div class="form-group">
              <input type="text" name="memberAddress3" class="form-control"  placeholder="주소">
              <button type="button" class="gradient-btn">확인 내용</button>
            </div>
            <input type="hidden" name="isUniqueId" value="false">
            <input type="hidden" name="isUniqueEmail" value="false">
            <br>
            <div class="text-center">
              <input type="button" id="register_button" class="btn btn-main text-center" value ="회원가입">
            </div>
          </form>
          <p class="mt-20">이미 계정이 있으신가요☞<a href="login.do">로그인</a></p>    
        </div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$("#register_button").click(function(){
		$("#register_form").attr("action", "${pageContext.request.contextPath}/member/register")
		$("#register_form").submit();
	});
});

$('#memberId_re').on("propertychange change keyup paste input", function(){

	var memberId = $('#memberId_re').val();			// .memberId_re에 입력되는 값
	var data = {memberId : memberId}				// '컨트롤에 넘길 데이터 이름' : '데이터(.memberId_re에 입력되는 값)'
	
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/member/Idcheck",
		data : data,
		success : function(result) {
			if(result != 'fail'){
				$('.memberId_re1').css("display","inline-block");
				$('.memberId_re2').css("display", "none");				
			} else {
				$('.memberId_re2').css("display","inline-block");
				$('.memberId_re1').css("display", "none");				
			} 
		}
	}); // ajax 종료	

});// function 종료


$('#emailSendBtn').click(function(){
	
	var email = $('#memberEmail_re').val(); // 이메일
	
	$.ajax({
		
		type: "GET",
        url: "${pageContext.request.contextPath}/member/mailCheck?email=" + email,
		success: function(data){
			
			console.log("data : " + data);
		}
        		
        		
	});
	
});




</script>

<%@ include file="../include/footer.jspf"%>