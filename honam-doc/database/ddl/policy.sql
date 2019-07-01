drop table if exists policy cascade;

-- 운영정책
create table policy(
	policy_id						int,
	
	geoserver_enable				varchar(1)					default 'Y',
	geoserver_wms_version			varchar(5)         			default '1.1.1',
	geoserver_data_url				varchar(256),
	geoserver_data_workspace		varchar(60),
	geoserver_data_store			varchar(60),
	geoserver_user					varchar(256),
	geoserver_password				varchar(256),
	
	layer_source_coordinate			varchar(100)				default 'EPSG:5187',
	layer_target_coordinate			varchar(100)				default 'EPSG:5187',
	layer_init_aerial				varchar(64),
	layer_init_drone				varchar(64),
	layer_init_map_center			varchar(128)				default '236300.7,323100.4',
	layer_init_map_extent			varchar(128)				default '-415909.65,-426336.34,649203.95,865410.62',
	layer_init_map_extent_bonsa     varchar(128)				default '236300.7,323100.4',
	layer_init_map_extent_onsan     varchar(128)				default '232419.35378311927,314704.78265380237',
	layer_init_map_extent_yongyeon  varchar(128)				default '233270.4060969608,318939.2224496673',
	layer_init_map_extent_mohwa     varchar(128)				default '229844.7565116684,341345.7557041153',
	
	vehicle_tp_interval					int						default 30,
	vehicle_172_interval				int						default 30,
	vehicle_material_delivery_interval	int						default 30,
	
	security_session_timeout_yn		char(1)						default 'N',
	security_session_timeout		varchar(4)					default '30',
	security_user_ip_check_yn		char(1)						default 'N',
	security_session_hijacking		char(1)						default '0',
	mobile_workplace_check_yn		char(1)						default 'N',
	
	content_cache_version			int							default 1,
	content_layer_group_root		varchar(60)					default '현대미포조선',
	
	user_upload_type				varchar(256)				default 'shp',
	user_upload_max_filesize		int							default 500,
	user_upload_max_count			int							default 1,
	
	insert_date						timestamp with time zone	default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '운영정책';
comment on column policy.policy_id is '고유번호';

comment on column policy.geoserver_enable is 'geoserver 사용유무';
comment on column policy.geoserver_wms_version is 'geoserver wms 버전';
comment on column policy.geoserver_data_url is 'geoserver 데이터 URL';
comment on column policy.geoserver_data_workspace is 'geoserver 데이터 작업공간';
comment on column policy.geoserver_data_store is 'geoserver 데이터 저장소';
comment on column policy.geoserver_user is 'geoserver 사용자 계정';
comment on column policy.geoserver_password is 'geoserver 비밀번호';
	
comment on column policy.security_session_timeout_yn is '보안 세션 타임아웃. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_timeout is '보안 세션 타임아웃 시간. 기본값 30분';
comment on column policy.security_user_ip_check_yn is '로그인 사용자 IP 체크 유무. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_hijacking is '보안 세션 하이재킹 처리. 0 : 사용안함, 1 : 사용(기본값), 2 : OTP 추가 인증 ';
comment on column policy.mobile_workplace_check_yn is '로그인 시 모바일 사업장 영역 체크. Y : 사용, N 사용안함(기본값)';

comment on column policy.layer_source_coordinate is 'Layer 원본 좌표계';
comment on column policy.layer_target_coordinate is 'Layer 좌표계 정의';
comment on column policy.layer_init_aerial is '기본 항공 레이어';
comment on column policy.layer_init_drone is '기본 드론 레이어';
comment on column policy.layer_init_map_center is 'map center';
comment on column policy.layer_init_map_extent is 'map extent';
comment on column policy.layer_init_map_extent_bonsa is 'map 본사/해양';
comment on column policy.layer_init_map_extent_onsan is 'map 온산';
comment on column policy.layer_init_map_extent_yongyeon is 'map 용연';
comment on column policy.layer_init_map_extent_mohwa is 'map 모화';

comment on column policy.vehicle_tp_interval is 'tp 사용자 화면 갱신 주기. 기본값 30초';
comment on column policy.vehicle_172_interval is '172 차량 사용자 화면 갱신 주기. 기본값 30초';
comment on column policy.vehicle_material_delivery_interval	is '자제배송 차량  사용자 화면 갱신 주기. 기본값 30초';

comment on column policy.content_cache_version is 'css, js 갱신용 cache version';
comment on column policy.content_layer_group_root is '메뉴 그룹 최상위 그룹명';

comment on column policy.user_upload_type is '업로딩 가능 확장자. ';
comment on column policy.user_upload_max_filesize is '최대 업로딩 사이즈(단위M). 기본값 500M';
comment on column policy.user_upload_max_count is '1회, 최대 업로딩 파일 수. 50개';
	
comment on column policy.insert_date is '등록일';