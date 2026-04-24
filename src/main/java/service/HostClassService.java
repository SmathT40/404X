package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ClassDto;
import mapper.HostClassMapper;

@Service
public class HostClassService {
	@Autowired
	HostClassMapper hostClassMapper;

	public List<ClassDto> getClassList(String searchContent, String userId, Integer status) {
		return hostClassMapper.getClassList(searchContent,userId,status);
	}
}
