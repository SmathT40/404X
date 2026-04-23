package sitemesh;

import javax.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*") // 모든 요청에 대해 사이트메시 필터 적용
public class SitemeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // 1. 기본 레이아웃 적용 (가장 일반적인 페이지들)
        builder.addDecoratorPath("/*", "main.jsp");

        // 2. 관리자 및 강사 전용 레이아웃 분리
        builder.addDecoratorPath("/admin/*", "admin.jsp");
        builder.addDecoratorPath("/host/*", "host.jsp");

        // 3. 레이아웃 적용 제외 (가장 중요한 부분!)
        // 정적 리소스(이미지, CSS, JS)는 레이아웃을 입힐 필요가 없습니다.
        builder.addExcludedPath("/resources/**");
        
        // [중요] AJAX 요청 경로는 반드시 제외해야 합니다. 
        // 제외 안 하면 AJAX로 불러온 리스트 안에 헤더/푸터가 또 들어갑니다.
        builder.addExcludedPath("/class/listAjax*");
        builder.addExcludedPath("/api/**"); // REST API 등을 쓰신다면 추가
        
        // 로그인/로그아웃 등 전체 레이아웃이 필요 없는 독립 페이지가 있다면 추가
        // builder.addExcludedPath("/user/login-form");
    }
}