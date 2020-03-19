-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date)
values
	('admin', 1, '슈퍼관리자', '$2a$10$25QJmwhoWX2ZsUXa5ZXFmepnY.W3p33gxiXa4b3j4cCMeV8gOxCJC', 'N', now());

-- 환경설정
insert into policy(	policy_id, password_exception_char)
			values( 1, '<>&''"');


commit;
