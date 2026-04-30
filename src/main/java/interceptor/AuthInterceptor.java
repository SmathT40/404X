package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import dto.User;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login?msg=" + java.net.URLEncoder.encode("로그인이 필요합니다.", "UTF-8"));
            return false;
        }

        String uri = request.getRequestURI();
        int role = loginUser.getUser_role();

        // 2. 관리자 페이지 접근 제어
        if (uri.contains("/admin") && role != 9) {
            response.sendRedirect(request.getContextPath() + "/?msg=" + java.net.URLEncoder.encode("관리자만 접근 가능합니다.", "UTF-8"));
            return false;
        }

        // 3. 호스트 페이지 접근 제어
        if (uri.contains("/host") && role < 1 && role != 9) {
            response.sendRedirect(request.getContextPath() + "/?msg=" + java.net.URLEncoder.encode("호스트 권한이 없습니다.", "UTF-8"));
            return false;
        }

        return true; 
    }
}