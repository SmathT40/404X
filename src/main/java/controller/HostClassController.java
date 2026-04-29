package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.CategoryDto;
import dto.ClassDto;
import dto.LecDto;
import dto.User;
import service.BoardService;
import service.CategoryService;
import service.ClassService;
import service.HostClassService;

@Controller
@RequestMapping("/host/class")
public class HostClassController {
	@Autowired
	HostClassService hostClassService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	ClassService classService;
	
	@GetMapping("list")
	public String listPage( 
    		@RequestParam(value="searchContent", required=false) String searchContent,
    		@RequestParam(value="status", required=false) Integer status,HttpSession session,Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/404X/main";
	    }
		String userId = loginUser.getUser_id();
		
		List<ClassDto> classlist = hostClassService.getClassList(searchContent,userId,status);
		model.addAttribute("classList", classlist);
        model.addAttribute("searchContent", searchContent);
        model.addAttribute("status", status);
		return "host/class/list"; 
	}
	@GetMapping("classForm")
	public String classForm(Model model) {
        List<CategoryDto> mainList = categoryService.getMainCategories();
        model.addAttribute("categoryList", mainList);
		return "host/class/classForm";
	}
	@PostMapping("insert")
	public String insertClass(ClassDto dto,
	                          @RequestParam(value="thumbnail_file", required=false) MultipartFile thumbnail,
	                          HttpServletRequest request,
	                          HttpSession session, RedirectAttributes rttr) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    dto.setUser_id(loginUser.getUser_id());
	    try {
	        if (thumbnail != null && !thumbnail.isEmpty()) {
	            String thumbnailUrl = hostClassService.uploadThumbnail(thumbnail, request);
	            dto.setCls_thumbnail(thumbnailUrl);
	        }
	        hostClassService.insertClass(dto);
	        rttr.addFlashAttribute("completeMsg", "클래스 신청이 완료되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "redirect:/host/class/list";
	}
	    
	
	@GetMapping("lectureForm")
	public String lectureForm(HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/main";
	    }
	    String userId = loginUser.getUser_id();
	    
	    List<ClassDto> myClassList = hostClassService.getClassList(null, userId, null);
	    model.addAttribute("myClassList", myClassList);
	    return "host/class/lectureForm"; 
	}
	@PostMapping("lecinsert")
	public String insertLec(LecDto dto,RedirectAttributes rttr) {
		hostClassService.insertLec(dto);
		rttr.addFlashAttribute("completeMsg", "강좌 등록이 완료되었습니다.");
		return "redirect:/host/class/status";
	}
	@GetMapping("lecupdate")
	public String updateLec(@RequestParam("lec_id") int lecId, HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) return "redirect:/404X/main";

	    LecDto dto = hostClassService.getLectureDetail(lecId);
	    model.addAttribute("lecDto", dto);

	    List<ClassDto> myClassList = hostClassService.getClassList(null, loginUser.getUser_id(), null);
	    model.addAttribute("myClassList", myClassList);

	    return "host/class/lectureForm"; 
	}
	@PostMapping("lecupdate")
	public String updateLecProcess(LecDto dto, RedirectAttributes rttr) {
	    hostClassService.updateLecture(dto);
	    rttr.addFlashAttribute("completeMsg", "강좌 정보가 성공적으로 수정되었습니다.");
	    return "redirect:/host/class/status"; 
	}
	
	@GetMapping("updateform")
	public String classUpdateForm(@RequestParam("class_id") int classId, HttpSession session, Model model) {
	    //  로그인 체크 (강사 본인인지 확인하는 로직 추가 권장)
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) return "redirect:/404X/main";

	    ClassDto classDto = classService.getClassDetail(classId);
	    model.addAttribute("classDto", classDto);

	    List<CategoryDto> categoryList = categoryService.getMainCategories();
	    model.addAttribute("categoryList", categoryList);

	    return "host/class/classForm"; // 등록과 수정이 같이 쓰는 JSP
	}
	@PostMapping("update")
	public String classUpdate(ClassDto dto,
	                          @RequestParam(value="thumbnail_file", required=false) MultipartFile thumbnail,
	                          HttpServletRequest request,
	                          RedirectAttributes rttr) {
	    try {
	        // =========================================================================
	        // --- 썸네일 업로드 추가 0428 ---
	        // =========================================================================
	        if (thumbnail != null && !thumbnail.isEmpty()) {
	            String thumbnailUrl = hostClassService.uploadThumbnail(thumbnail, request);
	            dto.setCls_thumbnail(thumbnailUrl);
	        }
	        hostClassService.updateClass(dto);
	        rttr.addFlashAttribute("completeMsg", "클래스 정보가 성공적으로 수정되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "redirect:/host/class/list";
	}
	@GetMapping("status")
	public String lectureStatus(HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) return "redirect:/login";

	    // 강사 본인의 ID를 파라미터로 전달
	    String hostId = loginUser.getUser_id();
	    
	    // JOIN 쿼리를 통해 강좌 리스트와 소속 클래스 제목을 함께 가져옴
	    List<LecDto> lectureList = classService.getLecByHost(hostId);
	    
	    model.addAttribute("lectureList", lectureList);
	    return "host/class/status"; // 강좌 현황 페이지
	}
	@Autowired
	private BoardService boardService;

	@ResponseBody
	@PostMapping("/uploadImage")
	public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file,
	                                       HttpServletRequest request) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        response.put("url", boardService.uploadSummernoteImage(file, request));
	    } catch (Exception e) {
	        response.put("error", "업로드 실패");
	    }
	    return response;
	}

}
