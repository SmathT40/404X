package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import interceptor.AuthInterceptor;
import interceptor.MenuInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private MenuInterceptor menuInterceptor;
    @Autowired
    AuthInterceptor autuInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(menuInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**", "/admin/**", "/login");
	    registry.addInterceptor(new AuthInterceptor())
        .addPathPatterns("/**/admin/**", "/host/**")
        .excludePathPatterns("/user/login", "/resources/**");

    }

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
        .addResourceLocations("/resources/");
	}
}
