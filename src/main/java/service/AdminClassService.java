package service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ClassDto;
import mapper.AdminClassMapper;

@Service
public class AdminClassService {
	@Autowired
	AdminClassMapper adminClassMapper;

	public List<ClassDto> getClassList(String searchType, String searchContent,Integer status) {
		return adminClassMapper.getClassList(searchType,searchContent,status);
	}
	
	public void updateStatuses(String classIds, int status) {
        List<String> idList = Arrays.asList(classIds.split(","));
        adminClassMapper.updateStatuses(idList, status);
    }

	public List<ClassDto> getPendingClassList() {
	    return adminClassMapper.selectPendingClassList();
	}
}
