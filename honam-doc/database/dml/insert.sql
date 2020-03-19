-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date)
values
	('admin', 1, '슈퍼관리자', '$2a$10$25QJmwhoWX2ZsUXa5ZXFmepnY.W3p33gxiXa4b3j4cCMeV8gOxCJC', 'N', now());

-- 환경설정
insert into policy(	policy_id, password_exception_char)
			values( 1, '<>&''"');


-- 교량 그룹			
insert into bridge_group(bridge_group_id, bridge_group_key, bridge_group_name, goal_performance, color)
values
	(1, 'group_1', '교량 그룹1', 2.78229546116609, null),
	(2, 'group_2', '교량 그룹2', 2.6992813715769, null),
	(3, 'group_3', '교량 그룹3', 3.28133662674884, null),
	(4, 'group_4', '교량 그룹4', 3.43332076086383, null),
	(5, 'group_5', '교량 그룹5', 3.26377151473872, null),
	(6, 'group_6', '교량 그룹6', 2.22174951441254, null),
	(7, 'group_7', '교량 그룹7', 2.04837644534476, null),
	(8, 'group_8', '교량 그룹8', 2.24570245644927, null),
	(9, 'group_9', '교량 그룹9', 3.39397557219178, null),
	(10, 'group_10', '교량 그룹10', 3.88067280053547, null),
	(11, 'group_11', '교량 그룹11', 2.59812790849841, null),
	(12, 'group_12', '교량 그룹12', 2.35731720346683, null),
	(13, 'group_13', '교량 그룹13', 3.97555171454476, null),
	(14, 'group_14', '교량 그룹14', 2.83004750930777, null);
			
commit;
