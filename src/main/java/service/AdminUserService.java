package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminUserDao;
import dto.User;

@Service
public class AdminUserService {

	@Autowired
	private AdminUserDao adminUserDao;
	
	public int getUserCount(String keyword) {
		return adminUserDao.getUserCount(keyword);
	}

	public List<User> getUserList(String keyword, int offset, int pageSize) {
		return adminUserDao.getUserList(keyword, offset, pageSize);
	}

}
