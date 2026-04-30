package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.CategoryDto;
import dto.User;
import mapper.CategoryMapper;
import service.CategoryService;

@Controller
@RequestMapping("/category") //ajax로 호출
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    //0430 hto
    
    @Autowired
    private ServletContext servletContext;
    @Autowired CategoryMapper categoryMapper;

    
    private void refreshCategoryContext() {
    	List<Map<String, Object>> updatedList = categoryMapper.selectParentOnly();
        servletContext.setAttribute("clsList", updatedList);
        System.out.println("[System] 카테고리 수정으로 인해 메뉴 리스트가 갱신되었습니다.");
    }
    
    @GetMapping("/sub-list")
    @ResponseBody
    public List<CategoryDto> getSubList(@RequestParam("parent_code") int parentCode) {
        return categoryService.getSubCategories(parentCode);
    }

    //카테고리 추가 
    @PostMapping("/admin/add")
    @ResponseBody
    public String addCategory(CategoryDto dto, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getUser_role() != 2) {
            return "fail";
        }
        
        categoryService.insertCategory(dto);
        refreshCategoryContext();
        return "success";
    }

    //카테고리 삭제
    @PostMapping("/admin/delete")
    @ResponseBody
    public String deleteCategory(@RequestParam int category_code, HttpSession session) {
        // 권한 체크 후 삭제
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getUser_role() != 2) return "fail";
        categoryService.deleteCategory(category_code);
        refreshCategoryContext();
        return "success";
    }
    
    @GetMapping("/admin/list") //
    public String categoryMain(Model model, HttpSession session) {
        // 권한 체크 (관리자만 진입 가능)
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getUser_role() != 2) {
            return "redirect:/"; // 권한 없으면 메인으로
        }

        // 전체 카테고리 목록을 가져와서 JSP에 전달
        List<CategoryDto> list = categoryService.getAllCategories();
        model.addAttribute("categoryList", list);

        return "admin/class/category"; 
    }
    
    @PostMapping("/admin/update")
    @ResponseBody
    public String updateCategory(CategoryDto dto, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getUser_role() != 2) return "fail";

        if (dto.getParent_code() != null && dto.getParent_code() == 0) {
            dto.setParent_code(null);
        }

        categoryService.updateCategory(dto); // 업데이트 서비스 호출
        refreshCategoryContext();
        return "success";
    }
}
