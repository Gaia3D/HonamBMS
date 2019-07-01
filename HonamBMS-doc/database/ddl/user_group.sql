-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists user_info cascade;

drop table if exists user_group cascade;
drop table if exists user_group_role cascade;
drop table if exists user_group_menu cascade;

-- 그룹 관리를 위한 사용자 추가 정보
create table user_info(
	user_id						varchar(32),
	user_group_id				int									not null,
	user_name					varchar(64)							not null,
	dept_no						varchar(30),
	dept_name					varchar(64),
	position					varchar(30),
	status						char(1)								default '0',
	login_count					int									default 0,
	fail_login_count			int									default 0,
	last_login_date				timestamp with time zone,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint user_info_pk primary key(user_id)
);

comment on table user_info is '사용자 기본정보';
comment on column user_info.user_id is '고유번호(사번)';
comment on column user_info.user_group_id is '사용자 그룹 고유번호';
comment on column user_info.user_name is '이름';
comment on column user_info.dept_no is '부서번호';
comment on column user_info.dept_name is '부서명';
comment on column user_info.position is '직급';
comment on column user_info.status is '사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호';
comment on column user_info.login_count is '로그인 횟수';
comment on column user_info.fail_login_count is '로그인 실패 횟수';
comment on column user_info.last_login_date is '마지막 로그인 날짜';
comment on column user_info.update_date is '수정일';
comment on column user_info.insert_date is '등록일';

-- 사용자 그룹
create table user_group(
	user_group_id				int,
	group_key					varchar(60)							not null ,
	group_name					varchar(100)						not null,
	dept_no						char(30),
	ancestor					varchar(60),
	parent						int									default 1,
	depth						int									default 1,
	view_order					int									default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint user_group_pk 	primary key (user_group_id)	
);

comment on table user_group is '사용자 그룹';
comment on column user_group.user_group_id is '고유번호';
comment on column user_group.group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column user_group.group_name is '그룹명';
comment on column user_group.dept_no is '부서번호. 확장성 때문';
comment on column user_group.ancestor is '조상 고유번호';
comment on column user_group.parent is '부모 고유번호';
comment on column user_group.depth is '깊이';
comment on column user_group.view_order is '나열 순서';
comment on column user_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column user_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column user_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column user_group.description is '설명';
comment on column user_group.insert_date is '등록일';

-- 사용자 그룹별 Role
create table user_group_role (
	user_group_role_id				int,
	user_group_id					int 									not null,
	role_id							int	 									not null,
	insert_date						timestamp with time zone				default now(),
	constraint user_group_role_pk 	primary key (user_group_role_id)
);

comment on table user_group_role is '사용자 그룹별 Role';
comment on column user_group_role.user_group_role_id is '고유번호';
comment on column user_group_role.user_group_id is '사용자 그룹 고유키';
comment on column user_group_role.role_id is 'Role 고유키';
comment on column user_group_role.insert_date is '등록일';

-- 사용자 그룹 권한
create table user_group_menu(
	user_group_menu_id				int,
	user_group_id					int 								not null,
	menu_id							int 								not null,
	all_yn							char(1)								default 'N',
	read_yn							char(1)								default 'N',
	write_yn						char(1)								default 'N',
	update_yn						char(1)								default 'N',
	delete_yn						char(1)								default 'N',
	insert_date						timestamp with time zone			default now(),
	constraint user_group_menu_pk 	primary key (user_group_menu_id)
);

comment on table user_group_menu is '사용자 그룹 메뉴';
comment on column user_group_menu.user_group_menu_id is '고유번호';
comment on column user_group_menu.user_group_id is '사용자 그룹 고유키';
comment on column user_group_menu.menu_id is '메뉴 고유키';
comment on column user_group_menu.all_yn is '메뉴 접근 모든 권한';
comment on column user_group_menu.read_yn is '읽기 권한';
comment on column user_group_menu.write_yn is '쓰기 권한';
comment on column user_group_menu.update_yn is '수정 권한';
comment on column user_group_menu.delete_yn is '삭제 권한';
comment on column user_group_menu.insert_date is '등록일';
