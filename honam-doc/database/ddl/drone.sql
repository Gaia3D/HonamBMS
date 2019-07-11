drop table if exists drone_project cascade;
drop table if exists drone_image cascade;

-- 드론 프로젝트 정보
create table drone_project(
	drone_project_id					bigint,
	fac_num								varchar(254)				    not null,
	shooting_date						timestamp with time zone,
	status								char(1)							default	'0',
	drone_image_count					int default 0,
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone		default now(),
	constraint drone_project_pk			primary key (drone_project_id)
);

comment on table drone_project is '드론 프로젝트 정보';
comment on column drone_project.drone_project_id is '드론 프로젝트 고유번호';
comment on column drone_project.fac_num is '시설물 번호';
comment on column drone_project.shooting_date is '촬영 시작 일시';
comment on column drone_project.status is '상태. 0: , 1: ,2: ';
comment on column drone_project.drone_image_count is '개별정사 영상 개수(중복,속도때문)';
comment on column drone_project.update_date is '수정일';
comment on column drone_project.insert_date is '등록일';			


-- 드론 이미지 정보
create table drone_image(
	drone_image_id					bigint,
	drone_project_id				bigint					not null,
	file_name						varchar(256),
	data_type						char(1)					default '0',
	drone_latitude					numeric(13,10),
	drone_longitude					numeric(13,10),
	drone_altitude					numeric(13,10),
	drone_roll						numeric(13,10),
	drone_pitch						numeric(13,10),
	drone_yaw						numeric(13,10),
	shooting_date					timestamp with time zone,
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone default now(),
	constraint drone_image_pk		primary key (drone_image_id)
);

comment on table drone_image is '드론 이미지 정보';
comment on column drone_image.drone_image_id is '드론 이미지 고유번호';
comment on column drone_image.drone_project_id is '드론 프로젝트 고유번호';
comment on column drone_image.data_type is '데이터 타입. 0: 원본 영상, 1 : 개별 정사 영상, 2 : 후처리 영상';
comment on column drone_image.file_name is '파일 이름';
comment on column drone_image.drone_latitude is '드론 위도';
comment on column drone_image.drone_longitude is '드론 경도';
comment on column drone_image.drone_altitude is '드론 높이';
comment on column drone_image.drone_roll is '드론 roll';
comment on column drone_image.drone_pitch is '드론 pitch';
comment on column drone_image.drone_yaw is '드론 흔들림';
comment on column drone_image.shooting_date is '촬영일';
comment on column drone_image.update_date is '수정일';
comment on column drone_image.insert_date is '등록일';
