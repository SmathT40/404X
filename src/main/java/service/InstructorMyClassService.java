package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.InstructorMyClassDao;
import dto.ClassDto;

@Service
public class InstructorMyClassService {
	
	@Autowired
	private InstructorMyClassDao instructorMyClassDao;
	
	public List<ClassDto> getMyClassList(String user_id) {
		return instructorMyClassDao.getMyClassList(user_id);
	}

	public int getTotalPage(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}
}
