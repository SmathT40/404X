package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.ClassDto;
import mapper.InstructorMyClassMapper;

@Repository
public class InstructorMyClassDao {

	@Autowired
	private InstructorMyClassMapper instructorMyClassMapper;
	
	public List<ClassDto> getMyClassList(String user_id) {
		return instructorMyClassMapper.getMyClassList(user_id);
	}

}
