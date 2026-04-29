package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.User;
import mapper.AdminHostMapper;

@Service
public class AdminHostService {
	@Autowired
	AdminHostMapper adminHostMapper;
	
    public List<User> getHostList(String keyword, Integer user_role, Integer host_status) {
        return adminHostMapper.selectHostList(keyword, user_role, host_status);
    }
    
    @Transactional
    public void updateToHost(String user_id) {
    	adminHostMapper.updateUserRole(user_id, 1);
    	adminHostMapper.updateHostStatus(user_id, 2);
    }
    
    public void rejectHostRequest(String user_id) {
    	adminHostMapper.updateHostStatus(user_id, 3);
    }
    
    @Transactional
    public void demoteToUser(String user_id) {
    	adminHostMapper.updateUserRole(user_id, 0);
    	adminHostMapper.updateHostStatus(user_id, 0); // 신청 전 상태로 초기화
    }
}