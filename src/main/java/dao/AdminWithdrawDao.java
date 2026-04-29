package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mapper.AdminWithdrawMapper;

@Repository
public class AdminWithdrawDao {

	@Autowired
    private AdminWithdrawMapper adminWithdrawMapper;

    public void withdrawUser(String user_id) {
        adminWithdrawMapper.withdrawUser(user_id);
    }
}
