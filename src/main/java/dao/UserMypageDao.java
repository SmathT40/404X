package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.User;
import mapper.UserMypageMapper;

@Repository
public class UserMypageDao {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	
	public User getUserInfo(String user_id) {
		return userMypageMapper.getUserInfo(user_id);
	}

	public void updateUserInfo(User user) {
		userMypageMapper.updateUserInfo(user);
	}

	public void updatePw(String user_id, String newPw) {
		userMypageMapper.updatePw(user_id, newPw);
	}
}
