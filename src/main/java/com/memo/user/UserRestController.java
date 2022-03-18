package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;

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
}
