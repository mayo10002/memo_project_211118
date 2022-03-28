<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글 상세/수정</h1>
		<input type="text" name="subject" class="form-control"
			placeholder="제목을 입력해주세요" value="${post.subject}">
		<textarea name="content" class="form-control" rows="15"
			placeholder="내용을 입력해주세요">${post.content}</textarea>
		<div class="d-flex justify-content-end mt-3">
			<input type="file" name="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		
		<c:if test="${not empty post.imagePath}">
		<div class="image-area">
			<img src="${post.imagePath}" width="300" alt="업로드 이미지"> 
		</div>
		</c:if>
		
		<div class="clearfix mt-5">
			<button type="button" id="postDeleteBtn" class="btn btn-secondary">삭제</button>
			<div class="float-right">
				<button type="button" id="postListBtn" class="btn btn-secondary">목록</button>
				<button type="button" id="saveBtn" class="btn btn-primary" data-post-id="${post.id}">수정</button>
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
	$('#saveBtn').on('click', function(){
		let subject = $("input[name=subject]").val().trim();

		if(subject == ''){
			alert('제목을 입력해주세요');
			return;
		}
		let content = $("textarea[name=content]").val();
		if(content == ''){
			alert('내용을 입력해주세요');
			return;
		}
		
		//파일이 업로드 된 경우 확장자 체크
		let filePath = $('input[name=file]').val();
		//alert(filePath);
		if(filePath != ''){
			//console.log(filePath.split('.').pop());
			let ext = filePath.split('.').pop().toLowerCase();
			if($.inArray(ext,['gif','jpg','jpeg','png']) == -1){
				alert('이미지 파일만 업로드 할 수 있습니다.');
				$('input[name=file]').val(''); // 파일을 비운다.
				return;
			}
		}
		
		let formData = new FormData();
		let postId = $(this).data('post-id');
		// alert(postId);
		formData.append("postId", postId);
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('input[name=file]')[0].files[0]);
		
		$.ajax({
			type: "put" //수정은 보통 put. get은 안됨
			,url:"/post/update"
			,data: formData
			,enctype:"multipart/form-data"
			,processData: false
			,contentType: false
			,success: function(data){
				if(data.result == "success"){
					alert('메모가 수정되었습니다.');
					location.reload(true); // 새로고침
				}else{
					alert(data.error_message);
				}
			}
			, error:function(e){
				alert('메모 수정에 실패했습니다. 관리자에게 문의해주세요.');
			}
		});
	});
});
</script>