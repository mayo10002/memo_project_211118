package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	public boolean existUserByLoginId(String loginId) {
		return userDAO.existUserByLoginId(loginId);
	}
	public int addUser(String loginId, String password, String name, String email ) { // 옆의 password 생애주기는 이 안에서만. 그러니 encrypt를 쓸 필요는 없다.
		return userDAO.insertUser(loginId, password, name, email);
	}

}
