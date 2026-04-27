package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ClassDto;
import dto.LecDto;
import mapper.ClassMapper;

@Service
public class ClassService {
    @Autowired private ClassMapper classMapper;

    public Map<String, Object> getClassListData(Integer catCode, Integer subCode, int page) {
        int pageSize = 9;
        Map<String, Object> params = new HashMap<>();
        params.put("catCode", catCode);
        params.put("subCode", subCode);
        params.put("offset", (page - 1) * pageSize);
        params.put("limit", pageSize);

        Map<String, Object> result = new HashMap<>();
        result.put("classList", classMapper.selectClassList(params));
        result.put("totalPage", (int) Math.ceil((double) classMapper.selectClassCount(params) / pageSize));
        return result;
    }
    public List<ClassDto> getFeaturedClassList() {
        return classMapper.selectFeaturedList();
    }
    public ClassDto getClassDetail(int id) {
        return classMapper.selectClassDetail(id);
    }
    public List<LecDto> getLecList(int id) {
    	return classMapper.selectLecList(id);
    }
	public LecDto getLecOne(int id) {
		return classMapper.selectLecOne(id);
	}
	public LecDto getPrev(int id, int no) {
		return classMapper.getPrev(id,no);
	}
	public LecDto getNext(int id, int no) {
		return classMapper.getNext(id,no);
	}
//	public void insertClass(ClassDto dto) {
//		classMapper.insertClass(dto);
//	}
//	public void insertLec(LecDto dto) {
//		classMapper.insertLec(dto);
//	}
}