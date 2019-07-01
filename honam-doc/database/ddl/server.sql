drop table if exists server cascade;

-- 서버 관리
create table server (
	server_id			int							not null,
	system_name			varchar(60)					not null,
	service_type		varchar(45),
	server_ip			varchar(45)					not null,
	api_key				varchar(45)					not null,
	url_scheme			varchar(45)					not null,
	url_host			varchar(45)					not null,
	url_port			int							not null,
	url_path			varchar(45),			
	status				char(1)						default '0',
	delete_yn			char(1)						default 'N',
	description			varchar(256),
	update_date			timestamp with time zone	default now(),
	insert_date			timestamp with time zone	default now(),
	constraint server_pk primary key (server_id)	
);

comment on table server is '서버 관리';
comment on column server.server_id is '서버 관리 ID';
comment on column server.system_name is '시스템명. (block, facility)';
comment on column server.service_type is '서비스 유형. 0: Policy Service, 1: Layer Service';
comment on column server.server_ip is '서버 IP';
comment on column server.api_key is 'API KEY';
comment on column server.url_scheme is '프로토콜';
comment on column server.url_host is '호스트';
comment on column server.url_port is '포트';
comment on column server.url_path is '리소스 경로';
comment on column server.status is '상태. 0: 사용, 1: 미사용';
comment on column server.delete_yn is '삭제 가능 여부. Y: 삭제 가능, N: 삭제 불가능';
comment on column server.description is '설명';
comment on column server.update_date is '수정일';
comment on column server.insert_date is '등록일';