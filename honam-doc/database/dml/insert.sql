-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date)
values
	('admin', 1, '슈퍼관리자', '$2a$10$25QJmwhoWX2ZsUXa5ZXFmepnY.W3p33gxiXa4b3j4cCMeV8gOxCJC', 'N', now());

-- 환경설정
insert into policy(	policy_id, password_exception_char)
			values( 1, '<>&''"');


-- 교량 그룹			
insert into bridge_group(bridge_group_id, bridge_group_key, bridge_group_name, goal_performance, color, start_area, end_area)
values
	(1, 'group_1', '그룹1', 2.78, null, 'gwangju', 'suncheon'),
	(2, 'group_2', '그룹2', 2.70, null, 'gwangju', 'suncheon'),
	(3, 'group_3', '그룹3', 3.28, null, 'gwangju', 'suncheon'),
	(4, 'group_4', '그룹4', 3.43, null, 'gwangju', 'suncheon'),
	(5, 'group_5', '그룹5', 3.26, null, 'gwangju', 'suncheon'),
	(6, 'group_6', '그룹6', 2.22, null, 'gwangju', 'suncheon'),
	(7, 'group_7', '그룹7', 2.045, null, 'gwangju', 'suncheon'),
	(8, 'group_8', '그룹8', 2.25, null, 'gwangju', 'suncheon'),
	(9, 'group_9', '그룹9', 3.39, null, 'gwangju', 'suncheon'),
	(10, 'group_10', '그룹10', 3.88, null, 'gwangju', 'suncheon'),
	(11, 'group_11', '그룹11', 2.60, null, 'suncheon', 'yeosu'),
	(12, 'group_12', '그룹12', 2.36, null, 'suncheon', 'yeosu'),
	(13, 'group_13', '그룹13', 3.98, null, 'suncheon', 'yeosu'),
	(14, 'group_14', '그룹14', 2.83, null, 'suncheon', 'yeosu');
			
insert into data_group (
	data_group_id, data_group_name, data_group_key, data_group_path, data_group_target, sharing, user_id, 
	ancestor, parent, depth, view_order, children, basic, available,  
	metainfo)
values (
	1, '기본', 'basic', 'infra/basic/', 'admin', 'public', 'admin',
	1, 0, 1, 1, 0, true, true,
	TO_JSON('{"isPhysical": false}'::json)
);

insert into data_info (
	data_id, data_group_id, data_key, data_name, data_type, mapping_type, metainfo, location, altitude)
values 
	(1, 1, 'YS-0009', '덕양교', 'obj', 'boundingboxcenter', TO_JSON('{"isPhysical": true}'::json), ST_GeomFromText('POINT(127.6353538849569 34.79933057924463)', 4326), 40),
	(2, 1, 'GW-0043', '마동IC', '3ds', 'boundingboxcenter', TO_JSON('{"isPhysical": true}'::json), ST_GeomFromText('POINT(127.70251116099134 34.93164289937602)', 4326), 40)
;	
	
commit;
