package dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.User;
import mapper.UserMapper;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private UserMapper userMapper;
	
	private static final String NAMESPACE = "mapper.UserMapper.";
	
	public int checkId(String user_id) {
		return userMapper.checkId(user_id);
	}
	
	public void insertUser(User user) {
		sqlSession.insert(NAMESPACE + "insertUser", user);
	}

	public User loginCheck(String user_id, String user_pw) {
		return userMapper.loginCheck(user_id, user_pw);
	}

	public String findId(String user_name, String user_email) {
		return userMapper.findId(user_name, user_email);
	}

	public int checkUserExist(String user_id, String user_name, String user_email) {
		return userMapper.checkUserExist(user_id, user_name, user_email);
	}

	public void updateTempPw(String user_id, String tempPw) {
		userMapper.updateTempPw(user_id, tempPw);
	}
}
