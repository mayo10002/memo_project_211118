package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String,Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId){
		Map<String, Boolean> result = new HashMap<>();
		
		result.put("result", userBO.existUserByLoginId(loginId));
		
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp( // RequestParam은 꼭 id값이 아니라 name 값으로!
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email){
		//암호화 - password hashing
		String encryptPassword = EncryptUtils.md5(password);
		
		// db insert
		int row = userBO.addUser(loginId, encryptPassword, name, email);
		// response
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		if( row < 1 ) {
			result.put("result", "error");
		}
		
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId")String loginId,
			@RequestParam("password")String password,
			HttpServletRequest request
			){
		// 암호화 - password hashing
		String encryptPassword =  EncryptUtils.md5(password);
		
		// DB login, 해싱된 password 셀렉트
		
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		if(user != null) {
			// 결과가 있으면 로그인 처리
			result.put("result" , "success");
			
			HttpSession session = request.getSession();			
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			// 로그인 된 사람의 가벼운 정보만 쓴다.
		}else { // 없으면 에러
			result.put("result" , "error");
			result.put("error_message" , "존재하지 않는 사용자입니다.");
		}
		
		
		// return
		return result;
	}
}
