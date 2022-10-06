<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
</head>
<body>
<%@ include file="../include/header.jspf"%>


<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-left">
          <h2 class="text-left">회원가입</h2>
          <form action="submitSignUp.do" method="post" class="text-left clearfix" id="submitSignUp" name="submitSignUp" >
            <div class="form-group">
              <input type="text" name="mId" id="mId" class="form-control"  placeholder="ID">
              <button type="button" class="gradient-btn">확인 내용</button>
              <span id="idCheckText">ID 중복확인이 필요합니다.</span> 
            </div>
            <div class="form-group">
              <input type="password" name="pw" id="pw" class="form-control"  placeholder="비밀번호">
            </div>
            <div class="form-group">
              <input type="password" id="pw2" class="form-control"  placeholder="비밀번호 확인">
            </div>
            <div class="form-group">
              <input type="text" name="mName" class="form-control"  placeholder="이름">
            </div>
            <div class="form-group">
			<input type="email" name="email" id="email" class="form-control"  placeholder="이메일" >                
			<button type="button" class="gradient-btn">확인 내용</button>
              <span id="emailCheckText">이메일 중복확인이 필요합니다.</span>   
            </div>
            <div class="form-group">
			<input type="text" id="VerificationCode" class="form-control"  placeholder="인증코드" disabled="disabled">                
			<button type="button" id="emailSendBtn" class="gradient-btn" disabled="disabled">본인 확인</button>
              <span id="codeCheckText">이메일 본인 인증이 필요합니다. 본인 확인 버튼을 클릭하세요.</span>   
            </div>
            <div class="form-group">
              <input type="tel" name="phone" class="form-control"  placeholder="연락처">
            </div>
            <div class="form-group">
              <input type="text" name="address" class="form-control"  placeholder="주소">
            </div>
            <input type="hidden" name="isUniqueId" value="false">
            <input type="hidden" name="isUniqueEmail" value="false">
            <br>
            <div class="text-center">
              <button type="button" class="btn btn-main text-center" onclick="checkSignupForm();">회원가입</button>
            </div>
          </form>
          <p class="mt-20">이미 계정이 있으신가요☞<a href="login.do">로그인</a></p>    
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="../include/footer.jspf"%>
</body>
</html>