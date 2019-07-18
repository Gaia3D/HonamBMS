-- 환경설정
insert into policy(policy_id, geoserver_data_url, geoserver_data_workspace, geoserver_data_store, geoserver_user, geoserver_password, layer_source_coordinate, layer_target_coordinate)
  values(1, 'http://localhost:8080/geoserver', 'honambms', 'honambms', 'admin', 'gaia#d', 'EPSG:5187', 'EPSG:5187');


-- 사용자 그룹 등록
insert into user_group(
    user_group_id, group_key, group_name, ancestor, parent, depth, view_order, default_yn, use_yn, child_yn, description
) values(
  1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 0, 1, 1, 'Y', 'Y', 'Y', '슈퍼 관리자'
),
(
  2, 'EMPLOYEE', '직원', 0, 0, 1, 2, 'Y', 'Y', 'Y', '직원'
),
(
  4, 'TEMP', '임시 사용자', 0, 0, 1, 4, 'Y', 'Y', 'Y', '임시'
);

-- 슈퍼 관리자 등록
insert into user_info(
    user_id, user_group_id, user_name, dept_name, position
) values (
    'admin', 1, '슈퍼관리자', 'IT', '책임'
);

-- 사용자 그룹 권한 등록
insert into user_group_role(
  user_group_role_id, user_group_id, role_id
) values (
    1, 1, 1
),
(
    2, 1, 2
),
(
    3, 1, 3
);

insert into user_group_menu(
    user_group_menu_id, user_group_id, menu_id
) values (
    1, 1, 1
),
(
    2, 1, 2
),
(
    3, 1, 7
);


-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
    (0, '0', '1', '[관리자 사이트]', '[ADMIN]', 0, -1, 0, 1, null, null, null, null, 'Y', 'Y', 'N'),
    (1, '0', '1', '사용자 그룹', 'USER GROUP', 0, 0 , 1, 1, '/user/list-group', null, 'userGroupMenu', null, 'Y', 'Y', 'Y'),
    (11, '0', '1', '사용자 그룹목록', 'USER GROUP', 0, 1 , 2, 1, '/user/list-group', null, 'userGroupMenu', null, 'Y', 'Y', 'Y'),
    (12, '0', '1', '사용자 그룹등록/수정', 'USER GROUP', 0, 1 , 2, 2, '/user/groups/tree', '/user/list-group', 'userGroupMenu', null, 'N', 'Y', 'N'),
    (13, '0', '1', '사용자 그룹 메뉴', 'USER GROUP', 0, 1 , 2, 3, '/user/group/{rest}/menu', '/user/list-group', 'userGroupMenu', null, 'N', 'Y', 'N'),
    (14, '0', '1', '사용자 그룹 ROLE', 'USER GROUP', 0, 1 , 2, 4, '/user/group/{rest}/role', '/user/list-group', 'userGroupMenu', null, 'N', 'Y', 'N'),
    (2, '0', '1', '레이어', 'LAYER', 0, 0 , 1, 2, '/layer/list', null, 'layerMenu', null, 'Y', 'Y', 'Y'),
    (21, '0', '1', '레이어 목록', 'LAYER', 0, 2 , 2, 1, '/layer/list', null, 'layerMenu', null, 'Y', 'Y', 'Y'),
    (22, '0', '1', '레이어 수정', 'LAYER', 0, 2 , 2, 2, '/layers/{rest}', '/layer/list', 'layerMenu', null, 'N', 'Y', 'N'),
    (23, '0', '1', '레이어 등록', 'LAYER', 0, 2 , 2, 3, '/layer/tree', '/layer/list', 'layerMenu', null, 'N', 'Y', 'N'),
    (3, '0', '1', 'API', 'API CALL', 0, 0 , 1, 3, '/apilog/list', null, 'apiMenu', null, 'Y', 'Y', 'Y'),
    (31, '0', '1', 'API 사용 목록', 'API CALL', 0, 3 , 2, 1, '/apilog/list', null, 'apiMenu', null, 'Y', 'Y', 'Y'),
    (32, '0', '1', 'API 사용 목록(Ajax)', 'API CALL', 0, 3 , 2, 2, '/apilogs', '/apilog/list', 'apiMenu', null, 'N', 'Y', 'N'),
    (4, '0', '1', 'Access 로그', 'ACCESS LOG', 0, 0 , 1, 4, '/access/list', null, 'logMenu', null, 'Y', 'Y', 'Y'),
    (41, '0', '1', 'Access 로그', 'ACCESS LOG', 0, 4 , 2, 1, '/access/list', null, 'logMenu', null, 'Y', 'Y', 'Y'),
    (42, '0', '1', 'Access 로그(Ajax)', 'ACCESS LOG', 0, 4 , 2, 2, '/accesses', '/access/list', 'logMenu', null, 'N', 'Y', 'N'),
    (5, '0', '1', '서버', 'SERVER', 0, 0 , 1, 5, '/server/list', null, 'serverMenu', null, 'Y', 'Y', 'Y'),
    (51, '0', '1', '서버 목록', 'SERVER', 0, 5 , 2, 1, '/server/list', null, 'serverMenu', null, 'Y', 'Y', 'Y'),
    (52, '0', '1', '서버 등록', 'SERVER', 0, 5 , 2, 2, '/server/input', '/server/list', 'serverMenu', null, 'N', 'Y', 'Y'),
    (53, '0', '1', '서버 수정', 'SERVER', 0, 5 , 2, 3, '/servers/{rest}', '/server/list', 'serverMenu', null, 'N', 'Y', 'N'),
    (6, '0', '1', 'Role', 'ROLE', 0, 0 , 1, 6, '/role/list', null, 'roleMenu', null, 'Y', 'Y', 'Y'),
    (61, '0', '1', 'Role 목록', 'ROLE', 0, 6 , 2, 1, '/role/list', null, 'roleMenu', null, 'Y', 'Y', 'Y'),
    (62, '0', '1', 'Role 등록', 'ROLE', 0, 6 , 2, 2, '/role/input', '/role/list', 'roleMenu', null, 'N', 'Y', 'Y'),
    (63, '0', '1', 'Role 수정', 'ROLE', 0, 6 , 2, 3, '/roles/{rest}', '/role/list', 'roleMenu', null, 'N', 'Y', 'N'),
    (7, '0', '1', '메뉴', 'MENU', 0, 0 , 1, 7, '/menus', null, 'menuMenu', null, 'Y', 'Y', 'Y'),
    (71, '0', '1', '메뉴', 'MENU', 0, 7 , 2, 1, '/menus', null, 'menuMenu', null, 'Y', 'Y', 'Y'),
    (8, '0', '1', '사용자', 'USER', 0, 0 , 1, 8, '/user/list', null, 'userMenu', null, 'Y', 'Y', 'Y'),
    (81, '0', '1', '사용자 목록', 'USER', 0, 8 , 2, 1, '/user/list', null, 'userMenu', null, 'Y', 'Y', 'Y'),
    (82, '0', '1', '사용자 등록', 'USER', 0, 8 , 2, 2, '/user/input', '/user/list', 'userMenu', null, 'N', 'Y', 'Y'),
    (83, '0', '1', '사용자 수정', 'USER', 0, 8 , 2, 3, '/user/modify', '/user/list', 'userMenu', null, 'N', 'Y', 'N'),
    (9, '0', '1', '환경 설정', 'CONFIGURATION', 0, 0 , 1, 9, '/policy', null, 'policyMenu', null, 'Y', 'Y', 'Y'),
    (91, '0', '1', '환경 설정', 'CONFIGURATION', 0, 9 , 2, 1, '/policy', null, 'policyMenu', null, 'Y', 'Y', 'Y');



-- Role 등록
insert into role(role_id, role_name, role_key, role_target, role_type, use_yn, default_yn)
values
    (1, '관리자 사이트 로그인 권한', 'ADMIN_LOGIN', '1', '0', 'Y', 'Y'),
    (2, '사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (3, '레이어 관리 권한', 'ADMIN_LAYER_MANAGE', '1', '0', 'Y', 'Y');


commit;
