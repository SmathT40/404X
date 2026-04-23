package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import dto.Instructor;
import service.InstructorService;

@Controller
@RequestMapping("/instructor")
public class InstructorController {
	
	@Autowired
	private InstructorService instructorService;
	
	@GetMapping("/list")
	public String instructor(Model model) {
		List<Instructor> list = instructorService.getInstructorWithClasses();
		model.addAttribute("instructorList", list);
		return "instructor/list";
	}
}
