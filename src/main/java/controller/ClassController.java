package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.ClassDto;
import dto.ClsReplyDto;
import dto.LecDto;
import dto.User;
import service.CategoryService;
import service.ClassService;
import service.ClsReplyService;
import service.UserClassroomService;

@RequestMapping("/class")
@Controller
public class ClassController {
	@Autowired
	CategoryService categoryService;
	@Autowired
	ClassService classService;
	@Autowired
	ClsReplyService clsReplyService;
	@Autowired
	UserClassroomService userClassroomService;
	
	@GetMapping("/classtest")
	public String classTest() {
		return "class/classtest"; 
	}
	@GetMapping("/category")
	public String categoryPage(@RequestParam("code") int code, Model model) {
	    // 서비스에서 한 번에 묶인 데이터를 가져옴
	    model.addAttribute("categoryData", categoryService.getCategoryDetail(code));
	    return "class/list";
	}
	@GetMapping("/list")
    public String classList(
            @RequestParam(value = "cat", required = false) Integer catCode,
            @RequestParam(value = "sub", required = false) Integer subCode,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
		
		//추천강의3개선정
		List<ClassDto> featuredList = classService.getFeaturedClassList();
	    model.addAttribute("featuredList", featuredList);
	    
        model.addAttribute("categoryList", categoryService.getMainCategories());
        if (catCode != null) {
            model.addAttribute("subCategoryList", categoryService.getSubCategories(catCode));
        }

        Map<String, Object> result = classService.getClassListData(catCode, subCode, page);
        model.addAttribute("classList", result.get("classList"));
        model.addAttribute("totalPage", result.get("totalPage"));
        model.addAttribute("currentPage", page);
        
        // JSP에서 active 클래스 처리를 위해 현재 코드 저장
        model.addAttribute("currentCat", catCode);
        model.addAttribute("currentSub", subCode);

        return "class/list";
    }
	@GetMapping("/detail")
    public String classDetail(@RequestParam("id") int id, Model model) {
        
        // 1. 서비스 재탕해서 데이터 가져오기
        ClassDto dto = classService.getClassDetail(id);
        // 2. 만약 데이터가 없으면 목록으로 튕겨내기 (안전장치)
        if(dto == null) {
            return "redirect:/class/list";
        }
        
        // 3. JSP에서 쓸 이름 'cls'로 모델에 담기
        model.addAttribute("cls", dto);
        
        //댓글 데이터 가져오기
        List<ClsReplyDto> replyList = clsReplyService.getReplyList(id,null);
        model.addAttribute("replyList", replyList);
        
        return "class/detail"; // WEB-INF/view/class/detail.jsp 로 연결
    }
	
	@GetMapping("/watch") // 실제 주소: /class/watch
    public String watchPage(int lec_id, int class_id, Model model,HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		LecDto lec = classService.getLecOne(lec_id);
		if (loginUser == null) {
		    return "redirect:/user/login"; 
		}
		if(loginUser.getUser_role() < 1) {
			boolean isStudent = userClassroomService.checkEnrollment(loginUser.getUser_id(), class_id);
			if (!isStudent) {
				return "redirect:/class/leclist?class_id=" + class_id + "&error=auth";
			}
		}
		LecDto prevLec = classService.getPrev(class_id,lec.getLec_no());
		LecDto nextLec = classService.getNext(class_id,lec.getLec_no());
		List<ClsReplyDto> replyList = clsReplyService.getReplyList(class_id, lec_id);
		model.addAttribute("lec", lec); 
		model.addAttribute("prev", prevLec);
	    model.addAttribute("next", nextLec);
	    model.addAttribute("replyList", replyList);
        return "class/watch";
    }
	
	@GetMapping("/leclist")
	public String lecList(int class_id,Model model) {
		List<LecDto> list = classService.getLecList(class_id);
		model.addAttribute("leclist", list);
		return "class/leclist"; 
	}
	

}
