package service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.Cls;
import dto.Instructor;
import mapper.InstructorMapper;

@Service
public class InstructorService {
	
	@Autowired
	private InstructorMapper instructorMapper;
	
	public List<Instructor> getInstructorWithClasses() {
		List<Instructor> instructors = instructorMapper.getInstructorList();
		List<Cls> allClasses = instructorMapper.getAllClasses();
		
		for (Instructor instructor : instructors) {
			List<Cls> myClasses = allClasses.stream()
					.filter(cls -> cls.getUserId().equals(instructor.getUserId()))
					.collect(Collectors.toList());
			
			instructor.setClassList(myClasses);
		}
		
		return instructors;
	}
}
