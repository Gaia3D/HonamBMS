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
			
commit;
