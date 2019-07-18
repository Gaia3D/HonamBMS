package honam.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 파일 기본 정보 관리 클래스
 * @author Cheon JeongDae
 *
 */
public class FileInfo {
	
	// 사용자 ID
	private String userId;
	// 파일명 : 실제파일명 + date
	private String fileName;
	// 실제 파일명
	private String fileRealName;
	// 파일 경로
	private String filePath;
	// 파일 용량
	private String fileSize;
	// 파일 확장자
	private String fileExt;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileExt() {
		return fileExt;
	}
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public Date getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	
	@Override
	public String toString() {
		return "FileInfo [userId=" + userId + ", fileName=" + fileName + ", fileRealName=" + fileRealName
				+ ", filePath=" + filePath + ", fileSize=" + fileSize + ", fileExt=" + fileExt + ", updateDate="
				+ updateDate + ", insertDate=" + insertDate + "]";
	}
}
