package HonamBMS.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class APILog {
	
	private Search search;
	
	// 고유키
	private Long apiLogId;
	// client 고유키
	private Integer serverId;
	// client 명(중복 허용)
	private String serverName;
	// request ip
	private String requestIp;
	// 사용자 아이디
	private String userId;
	// url
	private String url;
	// http status code
	private Integer statusCode;
	// message
	private String message;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;
	
	public String getViewMessage() {
		if(this.message == null || "".equals(this.message)) {
			return "";
		}
		
		if(this.message.length() > 30) {
			return this.message.substring(0, 30) + "...";
		}
		
		return this.message;
	}
}
