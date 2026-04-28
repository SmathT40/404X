package service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	public void updateFeatured(List<String> idList) {
	    // 전체 비노출 처리
		adminClassMapper.resetAllFeatured(); 
	    // 선택된 ID들만 노출 처리 (최대 3개는 쿼리나 로직에서 cut)
		if (idList != null && !idList.isEmpty()) {
			adminClassMapper.updateFeatured(idList);
		}
	}
}
