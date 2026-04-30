package controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import dto.Pay;
import mapper.AdminDashboardMapper;
import service.AdminClassService;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired
    private AdminDashboardMapper adminDashboardMapper;

    @Autowired
    private AdminClassService adminClassService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalMember", adminDashboardMapper.selectTotalMember());
        model.addAttribute("monthSales", adminDashboardMapper.selectMonthSales());
        model.addAttribute("totalClass", adminDashboardMapper.selectTotalClass());
        model.addAttribute("pendingCount", adminDashboardMapper.selectPendingCount());
        model.addAttribute("recentPayList", adminDashboardMapper.selectRecentPayList());
        model.addAttribute("classRequestList", adminClassService.getPendingClassList());

        // 팀원 완성 후 연동
        model.addAttribute("hostRequestList", adminDashboardMapper.selectHostRequestList());

        return "admin/dashboard";
    }
}