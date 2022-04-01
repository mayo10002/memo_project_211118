package com.memo.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	@Autowired
	private PostBO postBO;
	
	@RequestMapping("/post_list_view")
	public String postListView(
			@RequestParam(value="prevId", required = false)Integer prevIdParam,
			@RequestParam(value="nextId", required = false)Integer nextIdParam,
			Model model,
			HttpServletRequest request) {
		//세션의 값을 확인하여 지금 로그인이 되었는지 확인해야 함
		// 비로그인 :로그인 페이지로 리다이렉트
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId"); // 비로그인 상태에서 타임라인을 볼 수도 있기 때문에 int가 아니라 null이 가능한 Integer로 지정해줘야 한다.
		if(userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
			
		List<Post> postList = postBO.getPostListByUserId(userId, prevIdParam, nextIdParam);
		
		int prevId = 0;
		int nextId = 0;
		if(postList.isEmpty() == false) { // postList가 없는 경우 에러 발생 방지
			prevId = postList.get(0).getId();
			nextId = postList.get(postList.size() - 1).getId();
			
			// 이전이나 다음이 없는 경우 nextId, prevId를 0으로 세팅한다. (jsp에서 0인지 검사) 
			// 마지막 페이지인지 검사 => nextID 0으로
			if(postBO.isLastPage(userId, nextId)) {
				nextId = 0;
			}
			// 첫 번째 페이지인지 검사 => prevId 0으로
			if(postBO.isFirstPage(userId, prevId)) {
				prevId = 0;
			}
		}
		model.addAttribute("prevId", prevId); // 리스트 중 가장 앞쪽(제일 큰 값)  id
		model.addAttribute("nextId", nextId); // 리스트 중 가장 뒷쪽(제일 작은값) id
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "post/post_list");
		
		return "template/layout";
	}
	
	@RequestMapping("/post_create_view")
	public String postCreateView(Model model){
		// TODO 세션이 있는 경우에만 글쓰기 가능
		model.addAttribute("viewName", "post/post_create");
		return "template/layout";
		
	}
	
	@RequestMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postId") int postId,
			Model model) {
		// TODO 세션이 있는 경우에만 글 상세페이지로 이동 가능 
		
		// DB select
		Post post = postBO.getPostById(postId);
		model.addAttribute("post", post);
		
		model.addAttribute("viewName","post/post_detail");
		return "template/layout";
	}
}
