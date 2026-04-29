package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserWithdrawDao;

@Service
public class UserWithdrawService {

	@Autowired
	private UserWithdrawDao userWithdrawDao;
	
	public boolean withdrawUser(String user_id, String user_pw) {
		int result = userWithdrawDao.withdrawUser(user_id, user_pw);
		return result > 0;
	}
}
