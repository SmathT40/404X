package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@Configuration
@ComponentScan(basePackages = {"controller", "service", "interceptor", "config","dao"})
public class MvcConfig implements WebMvcConfigurer{

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/view/",".jsp");
	}
	@Bean
	public MultipartResolver multipartResolver() {
	    CommonsMultipartResolver mr = new CommonsMultipartResolver();
	    mr.setMaxInMemorySize(1024 * 1024);
	    mr.setMaxUploadSize(1024 * 10240);
	    return mr;
	}
}
