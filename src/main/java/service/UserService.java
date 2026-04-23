package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import dto.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public boolean isIdAvailable(String user_id) {
		int count = userDao.checkId(user_id);
		return count == 0;
	}

	public void joinUser(User user) {
		userDao.insertUser(user);		
	}

}
