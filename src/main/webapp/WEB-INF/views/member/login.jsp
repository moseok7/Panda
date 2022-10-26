<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jspf"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<style>
 .account .block {
    background-color: #fff;
    border: 1px solid #dedede;
    padding: 50px;
    margin: 150px 0;
} 

.account .block h2 {
    font-weight: 400;
    font-size: 25px;
    text-transform: uppercase;
    margin-bottom: 40px;
}
/* 로그인 실패시 경고글 */
.login_warn{
    margin-top: 30px;
    text-align: center;
    color : red;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body id="body">
	<!-- Login box -->
	<section class="signin-page account">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-3">
					<div class="block text-center">
						<h2 class="text-center">환영합니다</h2>
						<form id="login_form" class="text-left clearfix" method="post">
							<div class="form-group">
								<input type="text" name="memberId" class="form-control" placeholder="아이디" value="${saveIdCookie}">
							</div>
							
							<div class="form-group">
								<input type="password" name="memberPw" class="form-control" placeholder="비밀번호">
							</div>
							
							<c:if test = "${result == 0 }">
							<div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
							</c:if>
							
							<input type="checkbox" name="saveId" <c:if test="${saveIdCookie != null}">checked</c:if> >
							<span style="font-size: 11px; position: relative; top: -2px;">아이디 저장</span>
							<div class="text-center">
								<input type="button" id="login_button" class="btn btn-main text-center" value="로그인">
							</div>
						</form>
						<p class="mt-20">처음이세요☞<a href="<%=request.getContextPath()%>/member/register">회원가입</a></p>
						<p class="mt-20">비밀번호를 잊으셨나요☞<a href="forgetPwd.do">비밀번호 찾기</a></p>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<script>
 
    /* 로그인 버튼 클릭 */
    $("#login_button").click(function(){
        
    	 /* 로그인 메서드 서버 요청 */
        $("#login_form").attr("action", "${pageContext.request.contextPath}/member/login");
        $("#login_form").submit();
        
    });
 
</script>
	
	
<%@ include file="../include/footer.jspf"%>
</body>
</html>