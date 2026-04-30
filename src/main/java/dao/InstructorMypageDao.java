package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.User;
import mapper.InstructorMypageMapper;

@Repository
public class InstructorMypageDao {

	@Autowired
	private InstructorMypageMapper instructorMypageMapper;
	
	public User getInstructorInfo(String user_id) {
		return instructorMypageMapper.getInstructorInfo(user_id);
	}

	public void updateInstructorInfo(User user) {
		instructorMypageMapper.updateInstructorInfo(user);
	}

	public void registerInstructor(User user) {
		instructorMypageMapper.registerInstructor(user);
	}
}
