package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ClassDto;
import dto.LecDto;
import mapper.ClassMapper;
import mapper.HostClassMapper;

@Service
public class HostClassService {
	@Autowired
	HostClassMapper hostClassMapper;
	@Autowired
	ClassMapper classMapper;

	public List<ClassDto> getClassList(String searchContent, String userId, Integer status) {
		return hostClassMapper.getClassList(searchContent,userId,status);
	}

	public void insertClass(ClassDto dto) {
		hostClassMapper.insertClass(dto);
	}
	public void insertLec(LecDto dto) {
		hostClassMapper.insertLec(dto);
	}

	public LecDto getLectureDetail(int lecId) {
		return classMapper.selectLecOne(lecId);
	}

	public void updateLecture(LecDto dto) {
		hostClassMapper.updateLec(dto);
	}
}
