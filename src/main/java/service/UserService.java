package service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import dto.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private MailService mailService;
	
	public boolean isIdAvailable(String user_id) {
		int count = userDao.checkId(user_id);
		return count == 0;
	}

	public void joinUser(User user) {
		userDao.insertUser(user);		
	}

	public User loginCheck(String user_id, String user_pw) {
		return userDao.loginCheck(user_id, user_pw);
	}
	
	public String findId(String user_name, String user_email) {
		return userDao.findId(user_name, user_email);
	}

	public boolean issueTempPassword(String user_id, String user_name, String user_email) {
		int count = userDao.checkUserExist(user_id, user_name, user_email);
		if (count == 0) {
			return false;
		}
		// 임시 비번 만들어쪙!
		String tempPw = UUID.randomUUID().toString().replace("-", "").substring(0, 8);
		
		// 원래 비번 꺼져주세여!
		userDao.updateTempPw(user_id, tempPw);
		
		// 누가 만드는지는 모르겠지만 메일 로직 만들어라 핫산!
		mailService.sendTempPassword(user_email, tempPw);
		return true;
	}
	
	// =========================================================================
	// --- 네이버 로그인 추가 0427---
	// =========================================================================
	public User findByUserId(String user_id) {
	    return userDao.findByUserId(user_id);
	}

}
