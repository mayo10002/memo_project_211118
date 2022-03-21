<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="shadow-box m-5">
		<div class="d-flex justify-content-center m-5">
			<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
			
			<form id="loginForm" action="/user/sign_in" method="post">
				<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">ID</span>
					</div>
					<input type="text" class="form-control" id="loginId" name="loginId">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">PW</span>
					</div>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				
				<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
				<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
				<input type="submit" id="signInBtn" class="btn btn-block btn-info" value="로그인">
				
				<!-- enter login event : 
				1. enter 키가 잡히는 걸 내가 지정해준다. 
				2. form태그로 로그인 버튼 class를 submit로 걸어준다. -->
			</form>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	$('#loginForm').on('submit',function(e){
		e.preventDefault(); // submit 수행 중단. (자동 submit 막는 것. submit이 일어나지 않는 함수)
		
		let loginId = $('#loginId').val().trim();
		//alert(loginId);
		
		if( loginId == ''){
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		let password = $('#password').val();
		if(password == ""){
		 	alert("비밀번호를 입력해주세요.");
		 	return false;
		}
		// submit 말고 ajax로 하기. 
		let url = $(this).attr('action'); // this = form 태그 ('#loginForm')
		let params = $(this).serialize();
		
		console.log("url:" + url);
		console.log("params: " + params);
		
		$.post(url, params)
		.done(function(data){
			if(data.result == "success"){
				// 로그인 성공
				location.href = "/post/post_list_view"; // 화면으로 가는 것
			}else {
				// 로그인 실패
				alert(data.error_message);
			}
		});
	});
});
</script>