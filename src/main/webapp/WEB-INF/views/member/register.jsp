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
	margin-bottom: 5px;
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
.form-group{
	margin-bottom: 8px;
} 
.correct{
	color : green;
}
.incorrect{
	color : red;
}
/* 유효성 검사 문구 */
.final_id_ck{
    display: none;
}
.final_pw_ck{
    display: none;
}
.final_pwck_ck{
    display: none;
}
.final_name_ck{
    display: none;
}
.final_mail_ck{
    display: none;
}
.final_addr_ck{
    display: none;
}
/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1{
        color : green;
        display : none;    
}
.pwck_input_re_2{
        color : red;
        display : none;    
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
            <div class="form-group">
              <input type="text" name="memberId" id="memberId_re" class="form-control"  placeholder="아이디">
            </div>
            <span class = "memberId_re1">사용 가능한 아이디 입니다.</span>
            <span class = "memberId_re2">아이디가 이미 존재합니다.</span>
            <span class="final_id_ck">아이디를 입력해주세요.</span>
            
            <div class="form-group">
              <input type="password" name="memberPw" id="memberPw_re" class="form-control"  placeholder="비밀번호">
            </div>
            <span class="final_pw_ck">비밀번호를 입력해주세요.</span>
            
            <div class="form-group">
              <input type="password" id="memberPw_re2" class="form-control"  placeholder="비밀번호 확인">
            </div>
            <span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
            <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
            <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
            
            <div class="form-group">
              <input type="text" name="memberName" id="memberName_re" class="form-control"  placeholder="이름">
            </div>
            <span class="final_name_ck">이름을 입력해주세요.</span>
            
            <div class="form-group">
			<input type="email" name="memberEmail" id="memberEmail_re" class="form-control"  placeholder="이메일" >                
            </div>
            <span class="final_mail_ck">이메일을 입력해주세요.</span>
            <span class="email_warn"></span>
            
            <div class="form-group">
			<input type="text" id="VerificationCode" class="form-control"  placeholder="인증코드" disabled="disabled">                
			<input type="button" id="emailSendBtn" class="gradient-btn" value = "본인확인">
			<div class = "clearfix"></div>
			<span id="email_check_warn"></span>
            </div>
            
            <div class="form-group">
              <input type="text" id="address_input_1" name="memberAddress1" class="form-control"  readonly="readonly" placeholder="주소">
            </div>
            <div class="form-group">
              <input type="text" id="address_input_2" name="memberAddress2" class="form-control" readonly="readonly" placeholder="주소">
            </div>
            <div class="form-group">
              <input type="text" id="address_input_3" name="memberAddress3" class="form-control"  readonly="readonly" placeholder="주소">
              <span class="final_addr_ck">주소를 입력해주세요.</span>
              <input type="button" id="addressBtn" class="gradient-btn" onclick="execution_daum_address()" value = "주소찾기">
            </div>
            
            
          	<!--  <input type="hidden" name="isUniqueId" value="false">
            <input type="hidden" name="isUniqueEmail" value="false"> -->
            
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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

var code = "";

/* 유효성 검사 통과유무 변수 */
var idCheck = false;            // 아이디
var idckCheck = false;            // 아이디 중복 검사
var pwCheck = false;            // 비번
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;        // 비번 확인 일치 확인
var nameCheck = false;            // 이름
var mailCheck = false;            // 이메일
var mailnumCheck = false;        // 이메일 인증번호 확인
var addressCheck = false         // 주소



$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$("#register_button").click(function(){
		/* 입력값 변수 */
        var id = $('#memberId_re').val();                 // id 입력란
        var pw = $('#memberPw_re').val();                // 비밀번호 입력란
        var pwck = $('#memberPw_re2').val();            // 비밀번호 확인 입력란
        var name = $('#memberName_re').val();            // 이름 입력란
        var mail = $('#memberEmail_re').val();            // 이메일 입력란
        var addr = $('#address_input_3').val();        // 주소 입력란
        
        /* 아이디 유효성검사 */
        if(id == ""){
            $('.final_id_ck').css('display','block');
            idCheck = false;
        }else{
            $('.final_id_ck').css('display', 'none');
            idCheck = true;
        }
        
        /* 비밀번호 유효성 검사 */
        if(pw == ""){
            $('.final_pw_ck').css('display','block');
            pwCheck = false;
        }else{
            $('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        }
        
        /* 비밀번호 확인 유효성 검사 */
        if(pwck == ""){
            $('.final_pwck_ck').css('display','block');
            pwckCheck = false;
        }else{
            $('.final_pwck_ck').css('display', 'none');
            pwckCheck = true;
        }
        
        /* 이름 유효성 검사 */
        if(name == ""){
            $('.final_name_ck').css('display','block');
            nameCheck = false;
        }else{
            $('.final_name_ck').css('display', 'none');
            nameCheck = true;
        }
        
        /* 이메일 유효성 검사 */
        if(mail == ""){
            $('.final_mail_ck').css('display','block');
            mailCheck = false;
        }else{
            $('.final_mail_ck').css('display', 'none');
            mailCheck = true;
        }
 		
        /* 주소 유효성 검사 */
        if(addr == ""){
            $('.final_addr_ck').css('display','block');
            addressCheck = false;
        }else{
            $('.final_addr_ck').css('display', 'none');
            addressCheck = true;
        }
	
        /* 최종 유효성 검사 */
        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&mailCheck&&mailnumCheck&&addressCheck ){
 		
        	$("#register_form").attr("action", "${pageContext.request.contextPath}/member/register")
    		$("#register_form").submit();
        }    
        
        return false; 
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
				idckCheck = true;
			} else {
				$('.memberId_re2').css("display","inline-block");
				$('.memberId_re1').css("display", "none");	
				idckCheck = false;
			} 
		}
	}); // ajax 종료	

});// function 종료

// 이메일 전송 버튼
$('#emailSendBtn').click(function(){
	
	var email = $('#memberEmail_re').val(); // 이메일
	var checkBox = $('#VerificationCode');
	var warnMsg = $(".email_warn");    // 이메일 입력 경고글
	
	/* 이메일 형식 유효성 검사 */
    if(mailFormCheck(email)){
        warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
        warnMsg.css("display", "inline-block");
    } else {
        warnMsg.html("올바르지 못한 이메일 형식입니다.");
        warnMsg.css("display", "inline-block");
        return false;
    }    
	
	
	$.ajax({
		
		type: "GET",
        url: "${pageContext.request.contextPath}/member/mailCheck?email=" + email,
		success: function(data){
			
			//console.log("data : " + data);
			checkBox.attr("disabled",false);
			code = data;
			
		}
        		
        		
	});
	
});

// 인증번호 비교
$("#VerificationCode").blur(function(){
	
	var inputCode = $("#VerificationCode").val();
	var checkResult = $("#email_check_warn");
	
	if(inputCode == code){                            // 일치할 경우
        checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct");
        mailnumCheck = true;     // 일치할 경우
    } else {                                            // 일치하지 않을 경우
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
        mailnumCheck = false;     // 일치하지 않을 경우
    }    
	
});

// 주소 연동하기
function execution_daum_address(){
	
	new daum.Postcode({
		oncomplete: function(data){
			
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
             // 주소변수 문자열과 참고항목 문자열 합치기
                addr += extraAddr;
            
            } else {
            	addr += ' ';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $('#address_input_1').val(data.zonecode);
            $('#address_input_2').val(addr);
            
            // 커서를 상세주소 필드로 이동한다.
            $('#address_input_3').attr("readonly",false);
            $('#address_input_3').focus();
			
		}
	}).open();
	
}

/* 비밀번호 확인 일치 유효성 검사 */
$('#memberPw_re2').on("propertychange change keyup paste input", function(){
        
	 var pw = $('#memberPw_re').val();
	 var pwck = $('#memberPw_re2').val();
	 $('.final_pwck_ck').css('display', 'none');
	 
	    if(pw == pwck){
	        $('.pwck_input_re_1').css('display','block');
	        $('.pwck_input_re_2').css('display','none');
	        pwckcorCheck = true;
	    }else{
	        $('.pwck_input_re_1').css('display','none');
	        $('.pwck_input_re_2').css('display','block');
	        pwckcorCheck = false;
	    }        
    
});  

/* 입력 이메일 형식 유효성 검사 */
function mailFormCheck(email){

	 var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	
	 return form.test(email);
}

</script>

<%@ include file="../include/footer.jspf"%>