package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminWithdrawDao;

@Service
public class AdminWithdrawService {

	@Autowired
	private AdminWithdrawDao adminWithdrawDao;
	
	public void withdrawUser(String user_id) {
		adminWithdrawDao.withdrawUser(user_id);
	}

	public void withdrawMultiUsers(List<String> user_ids) {
		adminWithdrawDao.withdrawMultiUsers(user_ids);
	}
}
