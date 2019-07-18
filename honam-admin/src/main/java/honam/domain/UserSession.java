package honam.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 세션에 저장될 사용자 정보
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserSession implements Serializable {
	
	private static final long serialVersionUID = -7648113594557708090L;
	public static final String KEY = "userSession";
	
	/******** 화면 오류 표시용 ********/
	private String errorCode;
	/******* 세션 하이재킹 체크 *******/
	private String loginIp;
	
	// rest api http status code
	private int statusCode;
	
	private String userId;
	private String passw;
	private String korNm;
	private String asgnCd;
	private String asgnname;
	private String deptCd;
	private String deptname;
	private String jobTitNm;
	private String chk;
	private String roles;
	
	// db 용
	private String user_id;
	private String kor_nm;
	private String dept_cd;
	private String job_tit_nm;
	
	// 사용자 그룹명
	private String userGroupName;
	
	
	/********** DB 사용 *************/
	// 고유번호
	// 사용자 그룹 고유번호
	private Integer userGroupId;
	// 이름
	private String userName;
	// 비밀번호
	private String password;
	
	
}
