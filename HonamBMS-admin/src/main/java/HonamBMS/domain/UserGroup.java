package HonamBMS.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import HonamBMS.util.FormatUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserGroup {
	
	// 임시 그룹
	public static final Integer GUEST = 2;
	public static final Integer TEMP = 3;
	
	/****** 화면 표시용 *******/
	private String open = "open";
	private String nodeType = "folder";
	private String parentName;
	private Integer userCount;
	// up : 위로, down : 아래로
	private String updateType;

	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Integer userGroupId;
	// 링크 활용 등을 위한 확장 컬럼
	private String groupKey;
	// 그룹명
	private String groupName;
	// 부서번호
	private String deptNo;
	// 부서명
	private String deptName;
	// 조상 고유번호
	private String ancestor;
	// 부모 고유번호
	private Integer parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer viewOrder;
	// 기본 사용 삭제불가, Y : 기본, N : 선택
	private String defaultYn;
	// 사용유무, Y : 사용, N : 사용안함
	private String useYn;
	private String viewUseYn;
	// 자식 존재 유무, Y : 존재, N : 존재안함(기본)
	private String childYn;
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호
	private String status;
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
