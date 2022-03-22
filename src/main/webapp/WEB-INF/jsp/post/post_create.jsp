<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글쓰기</h1>
		<input type="text" name="subject" class="form-control"
			placeholder="제목을 입력해주세요">
		<textarea name="content" class="form-control" rows="15"
			placeholder="내용을 입력해주세요"></textarea>
		<div class="d-flex justify-content-end mt-3">
			<input type="file" name="file" accept=".jpg,.jpeg,.png,.gif">
		</div>

		<div class="clearfix mt-5">
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>
			<div class="float-right">
				<button type="button" id="clearBtn" class="btn btn-secondary">모두
					지우기</button>
				<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	//목록 버튼 클릭
	$('#postListBtn').on('click',function(){
		location.href="/post/post_list_view";
	});
	$('#clearBtn').on('click',function(){
		// 제목과 textarea 영역을 빈 칸으로 만든다.
		$('input[name=subject]').val('');
		$('textarea[name=content]').val('');
	});
	//글 내용 저장
	$('#saveBtn').on('click',function(){
		let subject = $('input[name=subject]').val();
		if(subject == ''){
			alert('제목을 입력해주세요.');
			return;
		}
		
		let content = $('textarea[name=content]').val();
		if(content.length < 1){
			alert('내용을 입력해주세요.');
			return;
		}
		
		// 콘솔로 값이 들어있는 지 확인
		console.log(subject);
		console.log(content);
		
		// 파일이 업로드 된 경우 확장자 체크
		let fileName = $('input[name=file]').val();
		if(fileName != ""){
			console.log(fileName.split(".")); //파일 경로룰 . 기준으로 잘라 배열에 저장한다.
			let ext = fileName.split(".").pop().toLowerCase(); // 확장자를 뽑아내고 소문자로 변경. pop는 list 제일 마지막 칸을 뽑아온 것.
			if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1){
				alert("gif, png, jpg, jpeg 확장자만 업로드 할 수 있습니다.");
				$('input[name=file]').val(''); // 파일을 비운다.
				return;
			}
			
		}
		
		// 폼 태그를 자바스크립트에서 만든다. 
		let formData = new FormData();
		formData.append("subject" , subject);
		formData.append("content" , content);
		formData.append("file", $('input[name=file]')[0].files[0]); // 첫번째꺼 선택 .첫번째 꺼 올림 . 그냥하자...
		
		// ajax 서버 통신
		$.ajax({
			type:"post"
			, url: "/post/create"
			, data: formData
			, enctype: "multipart/form-data" // 파일 업로드를 위한 필수 설정
			, processData: false // 파일 업로드를 위한 필수 설정
			, contentType: false // 파일 업로드를 위한 필수 설정
			, success: function(data){
				if(data.result == "success"){
					alert("메모가 저장되었습니다.");
					location.href = "/post/post_list_view";
					}else {
						alert(data.error_message);
					}
				}
			, error: function(e){
				alert("저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>