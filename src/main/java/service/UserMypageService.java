package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserMypageDao;
import dto.User;

@Service
public class UserMypageService {

	@Autowired
	private UserMypageDao userMypageDao;
	
	public User getUserInfo(String user_id) {
		return userMypageDao.getUserInfo(user_id);
	}
	
	public void updateUserInfo(User user) {
		userMypageDao.updateUserInfo(user);
	}

	public void updatePw(String user_id, String newPw) {
		userMypageDao.updatePw(user_id, newPw);
	}
}
