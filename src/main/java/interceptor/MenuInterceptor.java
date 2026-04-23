package interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import mapper.CategoryMapper;

@Component
public class MenuInterceptor implements HandlerInterceptor {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {

        // 1. 응답이 뷰(JSP)를 향하고 있고, 리다이렉트가 아닐 때만 실행
        if (modelAndView != null && !modelAndView.getViewName().startsWith("redirect:")) {
            
            // 2. 서블릿 객체 가져오기
        	ServletContext application = request.getServletContext();
            
            // 3. 서블릿에서 카테고리 리스트(clsList) 확인
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> clsList = (List<Map<String, Object>>) application.getAttribute("clsList");

            // 4. 서블릿에 데이터가 없는 경우에만 DB 조회 (최초 1회)
            if (clsList == null) {
                clsList = categoryMapper.selectParentOnly();
                
                // 조회한 데이터를 application에 저장 (서버를 닫기 전까지 유지)
                application.setAttribute("clsList", clsList);
                
                // 로깅 (콘솔에서 확인용 - 실제 서비스 시 삭제 가능)
                System.out.println("[MenuInterceptor] DB에서 카테고리를 조회하여 저장했습니다.");
            } else {
                // 데이터가 있으면 그대로 사용 (DB 조회 안 함)
                System.out.println("[MenuInterceptor] 저장된 카테고리 데이터를 재사용합니다.");
            }

            // 5. 최종적으로 ModelAndView에 데이터를 담아 JSP로 전달
            modelAndView.addObject("clsList", clsList);
        }
    }
    //application.removeAttribute("clsList") 서블릿 리셋용. 카테고리 crud에 추가요망
    
}
