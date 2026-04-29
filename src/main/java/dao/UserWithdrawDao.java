package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mapper.UserWithdrawMapper;

@Repository
public class UserWithdrawDao {

	@Autowired
	private UserWithdrawMapper userWithdrawMapper;
	
	public int withdrawUser(String user_id, String user_pw) {
		return userWithdrawMapper.withdrawUser(user_id, user_pw);
	}
}
