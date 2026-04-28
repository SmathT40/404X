package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	public void updateClass(ClassDto dto) {
		hostClassMapper.updateClass(dto);
	}
	
	// =========================================================================
	// --- 썸네일 업로드 추가 0428 ---
	// =========================================================================
	public String uploadThumbnail(MultipartFile file, HttpServletRequest request) throws Exception {
	    String uploadPath = request.getServletContext().getRealPath("/resources/upload/thumbnail/");
	    java.io.File dir = new java.io.File(uploadPath);
	    if (!dir.exists()) dir.mkdirs();
	    
	    String fileName = java.util.UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	    file.transferTo(new java.io.File(uploadPath + fileName));
	    return request.getContextPath() + "/resources/upload/thumbnail/" + fileName;
	}
}
