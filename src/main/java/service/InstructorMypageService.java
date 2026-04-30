package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.InstructorMypageDao;
import dto.User;

@Service
public class InstructorMypageService {

	@Autowired
	private InstructorMypageDao instructorMypageDao;
	
	public User getInstructorInfo(String user_id) {
		return instructorMypageDao.getInstructorInfo(user_id);
	}

	public void updateInstructorInfo(User user) {
		instructorMypageDao.updateInstructorInfo(user);
	}

	public void registerInstructor(User user) {
		instructorMypageDao.registerInstructor(user);
	}

}
