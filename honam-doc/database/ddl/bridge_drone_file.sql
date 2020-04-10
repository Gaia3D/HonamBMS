-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists bridge_drone_file cascade;

-- bridge 그룹
create table bridge_drone_file (
	upload_drone_file_id			integer,
	ogc_fid							integer,
	user_id							varchar(32),
	file_type						varchar(9)							default 'file',
	file_name						varchar(100)						not null,
	file_real_name					varchar(100)						not null,
	file_path						varchar(256)						not null,
	file_sub_path					varchar(256),
	file_size						varchar(12)							not null,
	file_ext						varchar(20),
	depth							int									default 1,
	error_message					varchar(256),
	insert_date						timestamp with time zone			default now(),
	create_date						timestamp with time zone			default now(),
	location		 				GEOMETRY(POINT, 4326),
	altitude						numeric(13,7),
	bridge_structure				varchar(100),
	constraint bridge_drone_file_pk 	primary key (upload_drone_file_id)
);

comment on table bridge_drone_file is '드론 영상 파일 정보 ';
comment on column bridge_drone_file.upload_drone_file_id is '고유번호';
comment on column bridge_drone_file.ogc_fid is '교량 고유번호';
comment on column bridge_drone_file.user_id is '사용자 아이디';
comment on column bridge_drone_file.file_type is '디렉토리/파일 구분. D : 디렉토리, F : 파일';
comment on column bridge_drone_file.file_name is '파일 이름';
comment on column bridge_drone_file.file_real_name is '파일 실제 이름';
comment on column bridge_drone_file.file_path is '파일 경로';
comment on column bridge_drone_file.file_sub_path is '프로젝트 경로 또는 공통 디렉토리 이하 부터의 파일 경로';
comment on column bridge_drone_file.file_size is '파일 사이즈';
comment on column bridge_drone_file.file_ext is '파일 확장자';
comment on column bridge_drone_file.depth is '계층구조 깊이. 1부터 시작';
comment on column bridge_drone_file.error_message is '오류 메시지';
comment on column bridge_drone_file.insert_date is '등록일';
comment on column bridge_drone_file.create_date is '사진촬영일';
comment on column bridge_drone_file.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column bridge_drone_file.altitude is '높이';
comment on column bridge_drone_file.bridge_structure is '드론이 촬영하는 교량 구조';

commit;