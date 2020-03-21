package honam.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:honam.properties")
@ConfigurationProperties(prefix = "honam")
public class PropertiesConfig {

    private String osType;
    // 로그인 등 레거시 시스템의 경우 로컬, 개발환경에서는 mock을 사용하고 운영에서는 실제 소스를 사용
    private boolean mockEnable;
    private boolean callRemoteEnable;
    private String serverIp;
    private String restAuthKey;

    // http, https
    private String restTemplateMode;

    /**
     * mock(로컬), rest(블럭 물류 모니터링 시스템을 REST API 로 호출), db(인사 DB를 이용)
     * rest는 종속이라서 하고 싶지 않지만 SSO 같은게 문제가 생기면 해야 할지도
     */
    //private String loginType;
    //private String restLoginUrl;

    //private String outputDir;
    //private String logBaseDir;
    //private String logBaseName;

    private String uploadDir;

    //private String gdalCmdPath;

    //private String mapDefaultLayer;

	// cesium ion token
	private String cesiumIonToken;

	// F4D 파일이 변환되는 Root 경로 이자, mago3DJS 에서 요청되는 파일의 Root 경로. ServletConfig 에서 매핑
    private String dataServiceDir;
    // 사용자용
    private String userDataServiceDir;
    private String userDataServicePath;
}
