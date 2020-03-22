package honam.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BridgeDroneFile extends Search {

	/****** 화면 표시용 *******/
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;

	private Integer uploadDroneFileId;
	private Integer ogcFid;
	private String userId;
	private String fileType;
	private String fileName;
	private String fileRealName;
	private String filePath;
	private String fileSubPath;
	private String fileSize;
	private String fileExt;
	private int depth;
	private String errorMessage;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date insertDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date createDate;
	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 높이
	private BigDecimal altitude;
}
