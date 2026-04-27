package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.CategoryDto;
import dto.User;
import service.CategoryService;

@Controller
@RequestMapping("/category") //ajax로 호출
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/sub-list")
    @ResponseBody
    public List<CategoryDto> getSubList(@RequestParam("parent_code") int parentCode) {
        return categoryService.getSubCategories(parentCode);
    }

    // 2. 카테고리 추가 (어드민 전용)
    @PostMapping("/admin/add")
    @ResponseBody
    public String addCategory(CategoryDto dto, HttpSession session) {
        // 권한 체크 로직 (관리자만 가능)
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || loginUser.getUser_role() != 2) {
            return "fail";
        }
        
        categoryService.insertCategory(dto);
        return "success";
    }

    // 3. 카테고리 삭제 (어드민 전용)
    @PostMapping("/admin/delete")
    @ResponseBody
    public String deleteCategory(@RequestParam int category_code, HttpSession session) {
        // 권한 체크 후 삭제 로직
        categoryService.deleteCategory(category_code);
        return "success";
    }
}
