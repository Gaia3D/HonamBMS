package HonamBMS.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:HonamBMS.properties")
@ConfigurationProperties(prefix = "HonamBMS")
public class PropertiesConfig {
	
	private String osType;
	private boolean callRemoteEnable;
	private String serverIp;
	private String restAuthKey;
		
	// cesium ion token
	private String cesiumIonToken;

}
