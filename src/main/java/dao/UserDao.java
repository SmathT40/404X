package dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.User;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String NAMESPACE = "mapper.UserMapper.";
	
	public int checkId(String user_id) {
		return sqlSession.selectOne(NAMESPACE + "checkId", user_id);
	}
	
	public void insertUser(User user) {
		sqlSession.insert(NAMESPACE + "insertUser", user);
	}
}
