package honam.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BridgeDroneFile {
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
}
