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
				<button type="button" id="saveBtn" class="btn btn-primary">수정</button>
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
});
</script>