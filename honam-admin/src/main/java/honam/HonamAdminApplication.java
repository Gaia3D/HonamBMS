package honam;

import javax.servlet.http.HttpSessionBindingListener;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import honam.listener.Gaia3dHttpSessionBindingListener;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootApplication
public class HonamAdminApplication extends SpringBootServletInitializer {
	
	public static void main(String[] args) {
		SpringApplication.run(HonamAdminApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(HonamAdminApplication.class);
	}
	
	/**
	 * Cross-Origin Resouces Sharing
	 * @return
	 */
	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("GET", "POST", "PUT", "DELETE").allowedOrigins("*")
					.allowedHeaders("*");
			}
		};
	}
	
	@Bean
	public HttpSessionBindingListener httpSessionBindingListener() {
		log.info(" $$$ HonamAdminApplication registerListener $$$ ");
		return new Gaia3dHttpSessionBindingListener();
	}
}