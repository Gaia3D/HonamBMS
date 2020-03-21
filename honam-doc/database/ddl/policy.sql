drop table if exists policy cascade;

-- 운영정책
create table policy(
	policy_id								integer,
	
	user_id_min_length						integer				default 5,
	user_fail_signin_count					integer				default 3,
	user_fail_lock_release					varchar(3)			default '30',
	user_last_signin_lock					varchar(3)			default '90',
	user_duplication_signin_yn				char(1)				default 'N',
	user_signin_type						char(1)				default '0',
	user_update_check						char(1)				default '0',
	user_delete_check						char(1)				default '0',
	user_delete_type						char(1)				default '0',
	
	password_change_term 					varchar(3)			default '30',
	password_min_length						integer				default 8,
	password_max_length						integer				default 32,
	password_eng_upper_count 				integer				default 1,
	password_eng_lower_count 				integer				default 1,
	password_number_count 					integer				default 1,
	password_special_char_count 			integer				default 1,
	password_continuous_char_count 			integer				default 3,
	password_create_type					char(1)				default '0',
	password_create_char					varchar(32)			default '!@#',
	password_exception_char					varchar(10)			default '<>&',
	
	security_session_timeout_yn				char(1)				default 'N',
	security_session_timeout				varchar(4)			default '30',
	security_user_ip_check_yn				char(1)				default 'N',
	security_session_hijacking				char(1)				default '0',
	security_log_save_type					char(1)				default '0',
	security_log_save_term					varchar(3)			default '2',
	security_dynamic_block_yn				char(1)				default 'N',
	security_api_result_secure_yn			char(1)				default 'N',
	security_masking_yn						char(1)				default 'Y',
	
	content_cache_version					integer				default 1,
	content_main_widget_count				integer				default 6,
	content_main_widget_interval			integer				default 65,
	content_monitoring_interval				integer				default 1,
	content_statistics_interval				char(1)				default '0',
	content_load_balancing_interval			integer				default 10,
	content_menu_group_root					varchar(60)			default 'NDTP',
	content_user_group_root					varchar(60)			default 'NDTP',
	content_layer_group_root				varchar(60)			default 'NDTP',
	content_data_group_root					varchar(60)			default 'NDTP',
	
	user_upload_type						varchar(256)		default '3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml,jpg,jpeg,gif,png,bmp,dds,zip,mtl,max',
	user_converter_type						varchar(256)		default '3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml',
	user_upload_max_filesize				integer				default 10000,
	user_upload_max_count					integer				default 500,
	shape_upload_type						varchar(256)		default 'cpg,dbf,idx,sbn,sbx,shp,shx,prj,qpj,zip',
	
	basic_globe											varchar(20)			default 'cesium',
	geoserver_enable									boolean				default true,
	geoserver_wms_version								varchar(5)         	default '1.1.1',
	geoserver_data_url									varchar(256)		default 'http://localhost:8080/geoserver',
	geoserver_data_workspace							varchar(60)			default 'honambms',
	geoserver_data_store								varchar(60)			default 'honambms',
	geoserver_user										varchar(256),
	geoserver_password									varchar(256),
	
	geoserver_imageprovider_enable						boolean				default false,
	geoserver_imageprovider_url							varchar(256),
	geoserver_imageprovider_layer_name					varchar(60),
	geoserver_imageprovider_style_name					varchar(60),
	geoserver_imageprovider_parameters_width			integer				default 256,
	geoserver_imageprovider_parameters_height			integer				default 256,
	geoserver_imageprovider_parameters_format			varchar(30),

	geoserver_terrainprovider_enable					boolean				default false,
	geoserver_terrainprovider_url						varchar(256),
	geoserver_terrainprovider_layer_name				varchar(60),
	geoserver_terrainprovider_style_name				varchar(60),
	geoserver_terrainprovider_parameters_width			integer				default 256,
	geoserver_terrainprovider_parameters_height			integer				default 256,
	geoserver_terrainprovider_parameters_format			varchar(30),
	
	init_camera_enable									boolean				default true,
	init_latitude										varchar(30)			default '34.948590',
	init_longitude										varchar(30)			default '126.420914',
	init_altitude										varchar(30)			default '150000.0',
	init_duration										integer				default 3,
	init_default_terrain								varchar(64),
	init_default_fov									numeric(3,2)		default 0,

	lod0												varchar(20)			default '15',
	lod1												varchar(20)			default '60',
	lod2												varchar(20)			default '90',
	lod3												varchar(20)			default '200',
	lod4												varchar(20)			default '1000',
	lod5												varchar(20)			default '50000',

	ssao_radius											numeric(8,2)		default 0.15,
	cull_face_enable									boolean				default false,
	time_line_enable									boolean				default false,
	
	max_partitions_lod0 								integer				default 4,
	max_partitions_lod1 								integer				default 2,
	max_partitions_lod2_or_less 						integer				default 1,
	max_ratio_points_dist_0m 							integer				default 10,
	max_ratio_points_dist_100m 							integer				default 120,
	max_ratio_points_dist_200m 							integer				default 240,
	max_ratio_points_dist_400m 							integer				default 480,
	max_ratio_points_dist_800m 							integer				default 960,
	max_ratio_points_dist_1600m 						integer				default 1920,
	max_ratio_points_dist_over_1600m 					integer				default 3840,
	max_point_size_for_pc								numeric(4,1)		default 40.0,
	min_point_size_for_pc								numeric(4,1)		default 3.0,
	pendent_point_size_for_pc							numeric(4,1)		default 60.0,
	memory_management									boolean				default false,
	
	layer_source_coordinate								varchar(50)			default 'EPSG:4326',
	layer_target_coordinate								varchar(50)			default 'EPSG:4326',
	
	basic_globe											varchar(20)			default 'cesium',
	cesium_ion_token									varchar(256),
	
	insert_date											timestamp with time zone	default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '운영정책';
comment on column policy.policy_id is '고유번호';

comment on column policy.user_id_min_length is '사용자 아이디 최소 길이. 기본값 5';
comment on column policy.user_fail_signin_count is '사용자 사인인 실패 횟수';
comment on column policy.user_fail_lock_release is '사용자 사인인 실패 잠금 해제 기간';
comment on column policy.user_last_signin_lock is '사용자 마지막 사인인으로 부터 잠금 기간';
comment on column policy.user_duplication_signin_yn is '중복 사인인 허용 여부. Y : 허용, N : 허용안함(기본값)';
comment on column policy.user_signin_type is '사용자 사인인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서';
comment on column policy.user_update_check is '사용자 정보 수정시 확인';
comment on column policy.user_delete_check is '사용자 정보 삭제시 확인';
comment on column policy.user_delete_type is '사용자 정보 삭제 방법. 0 : 논리적(기본값), 1 : 물리적(DB 삭제)';

comment on column policy.password_change_term is '패스워드 변경 주기 기본 30일';
comment on column policy.password_min_length is '패스워드 최소 길이 기본 8';
comment on column policy.password_max_length is '패스워드 최대 길이 기본 32';
comment on column policy.password_eng_upper_count is '패스워드 영문 대문자 개수 기본 1';
comment on column policy.password_eng_lower_count is '패스워드 영문 소문자 개수 기본 1';
comment on column policy.password_number_count is '패스워드 숫자 개수 기본 1';
comment on column policy.password_special_char_count is '패스워드 특수 문자 개수 1';
comment on column policy.password_continuous_char_count is '패스워드 연속문자 제한 개수 3';
comment on column policy.password_create_type is '초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자';
comment on column policy.password_create_char is '초기 패스워드 생성 문자열. 엑셀 업로드 등';
comment on column policy.password_exception_char is '패스워드로 사용할수 없는 특수문자(XSS). <,>,&,작은따음표,큰따움표';

comment on column policy.security_session_timeout_yn is '보안 세션 타임아웃. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_timeout is '보안 세션 타임아웃 시간. 기본값 30분';
comment on column policy.security_user_ip_check_yn is '로그인 사용자 IP 체크 유무. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_hijacking is '보안 세션 하이재킹 처리. 0 : 사용안함, 1 : 사용(기본값), 2 : OTP 추가 인증 ';
comment on column policy.security_log_save_type is '보안 로그 저장 방법. 0 : DB(기본값), 1 : 파일';
comment on column policy.security_log_save_term is '보안 로그 보존 기간. 2년 기본값';
comment on column policy.security_dynamic_block_yn is '보안 동적 차단. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_api_result_secure_yn is 'API 결과 암호화 사용. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_masking_yn is '개인정보 마스킹 처리. Y : 사용(기본값), N 사용안함';

comment on column policy.content_cache_version is 'css, js 갱신용 cache version.';
comment on column policy.content_main_widget_count is '메인 화면 위젯 표시 갯수. 기본 6개';
comment on column policy.content_main_widget_interval is '메인 화면 위젯 Refresh 간격. 기본 65초(모니터링 간격 60초에 대한 시간 간격 고려)';
comment on column policy.content_statistics_interval is '통계 기본 검색 기간. 0 : 1년 단위, 1 : 상/하반기, 2 : 분기 단위, 3 : 월 단위';
comment on column policy.content_menu_group_root is '메뉴 그룹 최상위 그룹명';
comment on column policy.content_user_group_root is '사용자 그룹 최상위 그룹명';
comment on column policy.content_layer_group_root is '레이어 그룹 최상위 그룹명';
comment on column policy.content_data_group_root is '데이터 그룹 최상위 그룹명';

comment on column policy.user_upload_type is '업로딩 가능 확장자. 3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml,jpg,jpeg,gif,png,bmp,zip';
comment on column policy.user_converter_type is '변환 가능 확장자. 3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml';
comment on column policy.user_upload_max_filesize is '최대 업로딩 사이즈(단위M). 500M';
comment on column policy.user_upload_max_count is '1회, 최대 업로딩 파일 수. 50개';
comment on column policy.shape_upload_type is 'shape 파일 업로드 가능 확장자';

comment on column policy.geoserver_enable is 'geoserver 사용유무. true : 사용, false : 미사용';
comment on column policy.geoserver_wms_version is 'geoserver wms 버전';
comment on column policy.geoserver_data_url is 'geoserver 데이터 URL';
comment on column policy.geoserver_data_workspace is 'geoserver 데이터 작업공간';
comment on column policy.geoserver_data_store is 'geoserver 데이터 저장소';
comment on column policy.geoserver_user is 'geoserver 사용자 계정';
comment on column policy.geoserver_password is 'geoserver 비밀번호';

comment on column policy.geoserver_imageprovider_enable is 'geoserver imageprovider 사용 유무. 기본 false';
comment on column policy.geoserver_imageprovider_url is 'geoserver imageprovider 요청 URL';
comment on column policy.geoserver_imageprovider_layer_name is 'geoserver imageprovider 로 사용할 레이어명';
comment on column policy.geoserver_imageprovider_style_name is 'geoserver imageprovider 에 사용할 스타일명';
comment on column policy.geoserver_imageprovider_parameters_width is 'geoserver 레이어 이미지 가로크기';
comment on column policy.geoserver_imageprovider_parameters_height is 'geoserver 레이어 이미지 세로크기';
comment on column policy.geoserver_imageprovider_parameters_format is 'geoserver 레이어 포맷형식';

comment on column policy.geoserver_terrainprovider_enable is 'geoserver terrainprovider 사용 유무. 기본 false';
comment on column policy.geoserver_terrainprovider_url is 'geoserver terrainprovider 요청 URL';
comment on column policy.geoserver_terrainprovider_layer_name is 'geoserver terrainprovider 로 사용할 레이어명';
comment on column policy.geoserver_terrainprovider_style_name  is 'geoserver terrainprovider 에 사용할 스타일명';
comment on column policy.geoserver_terrainprovider_parameters_width is 'geoserver 레이어 이미지 가로크기';
comment on column policy.geoserver_terrainprovider_parameters_height is 'geoserver 레이어 이미지 세로크기';
comment on column policy.geoserver_terrainprovider_parameters_format is 'geoserver 레이어 포맷형식';

comment on column policy.init_camera_enable is '초기 카메라 이동 유무. true : 기본, false : 없음';
comment on column policy.init_latitude is '초기 카메라 이동 위도';
comment on column policy.init_longitude is '초기 카메라 이동 경도';
comment on column policy.init_altitude is '초기 카메라 이동 높이';
comment on column policy.init_duration is '초기 카메라 이동 시간. 초 단위';
comment on column policy.init_default_terrain is '기본 Terrain';
comment on column policy.init_default_fov is 'field of view. 기본값 0(1.8 적용)';

comment on column policy.lod0 is 'LOD0. 기본값 15M';
comment on column policy.lod1 is 'LOD1. 기본값 60M';
comment on column policy.lod2 is 'LOD2. 기본값 90M';
comment on column policy.lod3 is 'LOD3. 기본값 200M';
comment on column policy.lod4 is 'LOD4. 기본값 1000M';
comment on column policy.lod5 is 'LOD5. 기본값 50000M';

comment on column policy.ssao_radius is '그림자 반경';
comment on column policy.cull_face_enable is 'cullFace 사용유무. 기본 false';
comment on column policy.time_line_enable is 'timeLine 사용유무. 기본 false';

comment on column policy.max_partitions_lod0 is 'LOD0일시 PointCloud 데이터 파티션 개수. 기본값 4';
comment on column policy.max_partitions_lod1 is 'LOD1일시 PointCloud 데이터 파티션 개수. 기본값 2';
comment on column policy.max_partitions_lod2_or_less is 'LOD2 이상 일시 PointCloud 데이터 파티션 개수. 기본값 1';
comment on column policy.max_ratio_points_dist_0m is '카메라와의 거리가 10미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 10';
comment on column policy.max_ratio_points_dist_100m is '카메라와의 거리가 100미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 120';
comment on column policy.max_ratio_points_dist_200m is '카메라와의 거리가 200미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 240';
comment on column policy.max_ratio_points_dist_400m is '카메라와의 거리가 400미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 480';
comment on column policy.max_ratio_points_dist_800m is '카메라와의 거리가 800미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 960';
comment on column policy.max_ratio_points_dist_1600m is '카메라와의 거리가 1600미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 1920';
comment on column policy.max_ratio_points_dist_over_1600m is '카메라와의 거리가 1600미터 이상일때, PointCloud 점의 갯수의 비율의 분모, 기본값 3840';
comment on column policy.max_point_size_for_pc is 'PointCloud 점의 최대 크기. 기본값 40.0';
comment on column policy.min_point_size_for_pc is 'PointCloud 점의 최소 크기. 기본값 3.0';
comment on column policy.pendent_point_size_for_pc is 'PointCloud 점의 크기 보정치. 높아질수록 점이 커짐. 기본값 60.0';
comment on column policy.memory_management is 'GPU Memory Pool 사용유무. 기본값 false';

comment on column policy.layer_source_coordinate is 'Layer 원본 좌표계';
comment on column policy.layer_target_coordinate is 'Layer 좌표계 정의';

comment on column policy.basic_globe is 'javascript library 3D globe. 기본 cesium';
comment on column policy.cesium_ion_token is 'Cesium ion token 발급. 기본 mago3D';

comment on column policy.insert_date is '등록일';