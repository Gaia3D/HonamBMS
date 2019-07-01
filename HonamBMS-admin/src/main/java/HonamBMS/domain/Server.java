package honambms.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonFormat;

import honambms.util.FormatUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Server {
	
	private Search search;
	
	// 서버 관리 ID
	private	Integer serverId;
	// 서비스명
	@NotBlank
	private String systemName;
	// 서비스 유형
	private String serviceType;
	// 서버 IP
	private String serverIp;
	
	// 화면 표시용
	private String viewApiKey;
	// API KEY
	private String apiKey;
	// 프로토콜
	private String urlScheme;
	// 호스트
	private String urlHost;
	// 포트
	private int urlPort;
	// 리소스 경로
	private String urlPath;
	// 상태. 0: 사용, 1: 미사용
	private String status;
	// 삭제 가능 여부. Y: 삭제 가능, N: 삭제 불가능
	private String defaultYn;
	// 설명
	private String description;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;
	
	public String getViewInsertDate() {
		if(getInsertDate() == null) {
			return "";
		}
		
		String tempDate = FormatUtil.getViewDateyyyyMMddHHmmss(getInsertDate());
		return tempDate.substring(0, 19);
	}
}
