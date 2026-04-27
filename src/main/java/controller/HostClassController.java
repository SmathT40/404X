package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.CategoryDto;
import dto.ClassDto;
import dto.LecDto;
import dto.User;
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
	public String insertClass(ClassDto dto,HttpSession session, RedirectAttributes rttr) {
		User loginUser = (User) session.getAttribute("loginUser");
	    dto.setUser_id(loginUser.getUser_id());
	    
	    // 2. 파일 업로드 로직이 있다면 여기서 실행 후 파일명만 dto에 세팅
	    // String fileName = fileService.saveFile(file);
	    // dto.setCls_thumbnail(fileName);
		rttr.addFlashAttribute("completeMsg", "클래스 신청이 완료되었습니다.");
		hostClassService.insertClass(dto);
		return "redirect:/host/class/list";
	}
	
	@GetMapping("lectureForm")
	public String lectureForm(HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/404X/main";
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
		return "redirect:/host/class/list";
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
	    return "redirect:/host/class/list"; 
	}
	

}
