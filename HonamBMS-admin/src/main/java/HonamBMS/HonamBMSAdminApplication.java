package HonamBMS;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootApplication
public class HonamBMSAdminApplication extends SpringBootServletInitializer {

	public static void main(String[] args) throws Exception{
		SpringApplication.run(HonamBMSAdminApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(HonamBMSAdminApplication.class);
	}
}