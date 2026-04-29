package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.User;
import mapper.AdminUserMapper;

@Repository
public class AdminUserDao {

	@Autowired
	private AdminUserMapper adminUserMapper;
	
	public int getUserCount(String keyword) {
		return adminUserMapper.getUserCount(keyword);
	}
	
	public List<User> getUserList(String keyword, int offset, int pageSize) {
		return adminUserMapper.getUserList(keyword, offset, pageSize);
	}
}
