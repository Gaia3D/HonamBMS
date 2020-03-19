-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists user_info cascade;


-- 사용자 기본정보
create table user_info(
	user_id						varchar(32),
	user_group_id				integer								not null,
	user_name					varchar(64)							not null,
	password					varchar(512)						not null,
	salt						varchar(256),
	telephone					varchar(256),
	mobile_phone				varchar(256),
	email						varchar(256),
	messanger					varchar(100),
	postal_code					varchar(6),
	address						varchar(256),
	address_etc					varchar(1000),
	status						varchar(20)							default '0',
	user_role_check_yn			char(1)								default 'Y',
	signin_count				bigint								default 0,
	fail_signin_count			integer								default 0,
	last_signin_date			timestamp with time zone,
	last_password_change_date	timestamp with time zone			default now(),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint user_info_pk primary key(user_id)
);

comment on table user_info is '사용자 기본정보';
comment on column user_info.user_id is '고유번호';
comment on column user_info.user_group_id is '사용자 그룹 고유번호';
comment on column user_info.user_name is '이름';
comment on column user_info.password is '비밀번호';
comment on column user_info.salt is 'SALT';
comment on column user_info.telephone is '전화번호';
comment on column user_info.mobile_phone is '핸드폰 번호';
comment on column user_info.email is '이메일';
comment on column user_info.messanger is '메신저 아이디';
comment on column user_info.postal_code is '우편번호';
comment on column user_info.address is '주소';
comment on column user_info.address_etc is '상세주소';
comment on column user_info.user_role_check_yn is '최초 사인인시 사용자 Role 권한 체크 패스 기능. 기본값 Y : 체크';
comment on column user_info.status is '사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(사인인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호';
comment on column user_info.signin_count is '사인인 횟수';
comment on column user_info.fail_signin_count is '사인인 실패 횟수';
comment on column user_info.last_signin_date is '마지막 사인인 날짜';
comment on column user_info.last_password_change_date is '마지막 사인인 비밀번호 변경 날짜';
comment on column user_info.update_date is '개인정보 수정 날짜';
comment on column user_info.insert_date is '등록일';
