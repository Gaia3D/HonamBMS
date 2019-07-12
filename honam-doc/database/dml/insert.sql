-- 환경설정
insert into policy(policy_id, geoserver_data_url, geoserver_data_workspace, geoserver_data_store, geoserver_user, geoserver_password, layer_source_coordinate, layer_target_coordinate)
  values(1, 'http://localhost:8080/geoserver', 'hhi', 'hhi', 'admin', 'geoserver', 'EPSG:5187', 'EPSG:5187');


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


-- server 등록
insert into server (server_id, system_name, server_ip, api_key, url_scheme, url_host, url_port, url_path)
values(1, '블록 물류 모니터링 시스템', '127.0.0.0', 'api_key', 'http', 'localhost', 8888, '/layer/list');


-- layer 등록
insert into layer
    (layer_id, layer_key, layer_name, view_type, layer_style, geometry_type, ancestor, parent, depth, view_order, z_index,
    shape_insert_yn, status, use_yn, block_default_yn, label_display_yn, mobile_default_yn)
values
  (1, 'layer_main_facility', '주요 시설물', 'wms', null, 'polygon', 'layer_main_facility', 0, 1, 1, 1, 'N', '1', 'Y', 'Y', 'N', 'N'),
    (11, 'layer_building', '건물', 'wms', null, 'polygon', 'layer_main_facility', 1, 2, 1, 2, 'N', '1', 'Y', 'Y', 'N', 'N'),
      (111, 'layer_factory', '공장', 'wms', '#000000', 'polygon', 'layer_main_facility', 11, 3, 1, 3, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
      (112, 'layer_office_building', '사무동', 'wms', '#0100FF', 'polygon', 'layer_main_facility', 11, 3, 2, 4, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
      (113, 'layer_etc_sub_building', '기타 건물', 'wms', '#00FFFF', 'polygon', 'layer_main_facility', 11, 3, 3, 5, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
    (12, 'layer_other_facility', '기타 시설물', 'wms', null, 'polygon', 'layer_main_facility', 1, 2, 2, 6, 'N', '1', 'Y', 'Y', 'N', 'N'),
      (121, 'layer_etc_facility', '기타 시설물', 'wms', '#A52A2A', 'polygon', 'layer_main_facility', 12, 3, 1, 7, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
      (122, 'layer_store_processing_facility', '저장 및 처리시설', 'wms', '#800080', 'polygon', 'layer_main_facility', 12, 3, 2, 8, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
    (13, 'layer_other_point', '기타 지점물', 'wms', null, 'point', 'layer_main_facility', 1, 2, 3, 9, 'N', '1', 'Y', 'Y', 'N', 'N'),
      (131, 'layer_electric_manhole', '전기맨홀', 'wms', '#FF0000', 'point', 'layer_main_facility', 13, 3, 1, 10, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (132, 'layer_sewage_manhole', '하수맨홀', 'wms', '#FF00FF', 'point', 'layer_main_facility', 13, 3, 2, 11, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (133, 'layer_communication_manhole', '통신맨홀', 'wms', '#008000', 'point', 'layer_main_facility', 13, 3, 3, 12, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (134, 'layer_gas_manhole', '가스맨홀', 'wms', '#FF0000', 'point', 'layer_main_facility', 13, 3, 4, 13, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (135, 'layer_etc_manhole', '기타맨홀', 'wms', '#000000', 'point', 'layer_main_facility', 13, 3, 5, 14, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (136, 'layer_illumination', '조명', 'wms', '#000000', 'point', 'layer_main_facility', 13, 3, 6, 15, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (137, 'layer_bitt', 'BITT', 'wms', '#0100FF', 'point', 'layer_main_facility', 13, 3, 7, 16, 'Y', '1', 'Y', 'N', 'Y', 'N'),
      (138, 'layer_etc_point', '기타 지점물', 'wms', '#000000', 'point', 'layer_main_facility', 13, 3, 8, 17, 'Y', '1', 'Y', 'N', 'Y', 'N'),
  (2, 'layer_rail', '레일', 'wms', '#000000', 'line', 'layer_rail', 0, 1, 2, 18, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (3, 'layer_road', '도로', 'wms', null, 'polygon', 'layer_road', 0, 1, 3, 19, 'N', '1', 'Y', 'Y', 'N', 'N'),
    (31, 'layer_road_boundary_area', '도로 경계면', 'wms', '#FFA500', 'polygon', 'layer_road', 3, 2, 1, 20, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
    (32, 'layer_road_tp_boundary_area', 'TP도로 경계면', 'wms', '#FFA500', 'polygon', 'layer_road', 3, 2, 2, 21, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
    (33, 'layer_road_center_line', '도로 중심선', 'wms', '#FFA500', 'line', 'layer_road', 3, 2, 3, 22, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (4, 'layer_landscape', '조경', 'wms', '#008000', 'polygon', 'layer_landscape', 0, 1, 4, 23, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (5, 'layer_boundary_area', '경계구역', 'wms', '#D8BFD8', 'polygon', 'layer_boundary_area', 0, 1, 5, 24, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (6, 'layer_full_ship_dock', '도크', 'wms', '#000000', 'polygon', 'layer_full_ship_dock', 0, 1, 6, 25, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (7, 'layer_full_ship_quay', '안벽', 'wms', '#000000', 'line', 'layer_full_ship_quay', 0, 1, 7, 26, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (8, 'layer_lot_number', '지번', 'wms', '#FF00FF', 'polygon', 'layer_lot_number', 0, 1, 8, 27, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (9, 'layer_crane', '크레인', 'wms', null, 'polygon', 'layer_crane', 0, 1, 9, 28, 'N', '1', 'Y', 'Y', 'N', 'N'),
    (81, 'layer_goliath_crane', '골리앗 크레인', 'wms', '#000000', 'polygon', 'layer_crane', 8, 2, 1, 29, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
    (82, 'layer_jeep_crane', '짚 크레인', 'wms', '#000000', 'polygon', 'layer_crane', 8, 2, 2, 30, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (10, 'layer_block', '블록', 'wms', '#000000', 'polygon', 'layer_block', 0, 1, 10, 31, 'Y', '1', 'Y', 'Y', 'Y', 'N'),
  (110, 'layer_terrain', '지형', 'wms', null, 'line', 'layer_terrain', 0, 1, 11, 32, 'N', '1', 'Y', 'Y', 'N', 'N'),
    (1101, 'layer_wavy', '표고', 'wms', '#808080', 'point', 'layer_terrain', 10, 2, 1, 33, 'Y', '1', 'Y', 'N', 'Y', 'N'),
    (1102, 'layer_contour', '등고', 'wms', '#808080', 'line', 'layer_terrain', 10, 2, 2, 34, 'Y', '1', 'Y', 'N', 'Y', 'N'),
    (1103, 'layer_embankment', '제방', 'wms', '#808080', 'line', 'layer_terrain', 10, 2, 3, 35, 'Y', '1', 'Y', 'N', 'Y', 'N'),
    (1104, 'layer_fance', '담장', 'wms', '#808080', 'line', 'layer_terrain', 10, 2, 4, 36, 'Y', '1', 'Y', 'N', 'Y', 'N'),
    (1105, 'layer_etc_terrain', '기타 지형 구조물', 'wms', '#808080', 'line', 'layer_terrain', 10, 2, 5, 37, 'Y', '1', 'Y', 'N', 'Y', 'N');
commit;

-- layer file 등록
insert into layer_file_info
    (layer_file_info_id, layer_id, layer_file_info_group_id, user_id, enable_yn,
        file_name, file_real_name, file_path, file_size, file_ext, shape_encoding, update_date, insert_date)
values
    (1, 111, 3, 'admin', 'Y', 'layer_factory_00000000.dbf', 'layer_factory_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (2, 111, 3, 'admin', 'Y', 'layer_factory_00000000.shx', 'layer_factory_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (3, 111, 3, 'admin', 'Y', 'layer_factory_00000000.shp', 'layer_factory_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (4, 112, 6, 'admin', 'Y', 'layer_office_building_00000000.dbf', 'layer_office_building_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (5, 112, 6, 'admin', 'Y', 'layer_office_building_00000000.shx', 'layer_office_building_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (6, 112, 6, 'admin', 'Y', 'layer_office_building_00000000.shp', 'layer_office_building_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (7, 113, 9, 'admin', 'Y', 'layer_etc_sub_building_00000000.dbf', 'layer_etc_sub_building_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (8, 113, 9, 'admin', 'Y', 'layer_etc_sub_building_00000000.shx', 'layer_etc_sub_building_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (9, 113, 9, 'admin', 'Y', 'layer_etc_sub_building_00000000.shp', 'layer_etc_sub_building_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (10, 121, 12, 'admin', 'Y', 'layer_etc_facility_00000000.dbf', 'layer_etc_facility_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (11, 121, 12, 'admin', 'Y', 'layer_etc_facility_00000000.dbf', 'layer_etc_facility_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (12, 121, 12, 'admin', 'Y', 'layer_etc_facility_00000000.dbf', 'layer_etc_facility_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (13, 122, 15, 'admin', 'Y', 'layer_store_processing_facility_00000000.shx', 'layer_store_processing_facility_00000000.shx', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (14, 122, 15, 'admin', 'Y', 'layer_store_processing_facility_00000000.shx', 'layer_store_processing_facility_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (15, 122, 15, 'admin', 'Y', 'layer_store_processing_facility_00000000.shx', 'layer_store_processing_facility_00000000.shx', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (16, 131, 18, 'admin', 'Y', 'layer_electric_manhole_00000000.dbf', 'layer_electric_manhole_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (17, 131, 18, 'admin', 'Y', 'layer_electric_manhole_00000000.shx', 'layer_electric_manhole_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (18, 131, 18, 'admin', 'Y', 'layer_electric_manhole_00000000.shp', 'layer_electric_manhole_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (19, 132, 21, 'admin', 'Y', 'layer_sewage_manhole_00000000.dbf', 'layer_sewage_manhole_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (20, 132, 21, 'admin', 'Y', 'layer_sewage_manhole_00000000.shx', 'layer_sewage_manhole_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (21, 132, 21, 'admin', 'Y', 'layer_sewage_manhole_00000000.shp', 'layer_sewage_manhole_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (22, 133, 24, 'admin', 'Y', 'layer_communication_manhole_00000000.dbf', 'layer_communication_manhole_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (23, 133, 24, 'admin', 'Y', 'layer_communication_manhole_00000000.shx', 'layer_communication_manhole_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (24, 133, 24, 'admin', 'Y', 'layer_communication_manhole_00000000.shp', 'layer_communication_manhole_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (25, 134, 27, 'admin', 'Y', 'layer_gas_manhole_00000000.dbf', 'layer_gas_manhole_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (26, 134, 27, 'admin', 'Y', 'layer_gas_manhole_00000000.shx', 'layer_gas_manhole_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (27, 134, 27, 'admin', 'Y', 'layer_gas_manhole_00000000.shp', 'layer_gas_manhole_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (28, 135, 30, 'admin', 'Y', 'layer_etc_manhole_00000000.dbf', 'layer_etc_manhole_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (29, 135, 30, 'admin', 'Y', 'layer_etc_manhole_00000000.shx', 'layer_etc_manhole_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (30, 135, 30, 'admin', 'Y', 'layer_etc_manhole_00000000.shp', 'layer_etc_manhole_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (31, 135, 33, 'admin', 'Y', 'layer_illumination_00000000.dbf', 'layer_illumination_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (32, 135, 33, 'admin', 'Y', 'layer_illumination_00000000.shx', 'layer_illumination_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (33, 135, 33, 'admin', 'Y', 'layer_illumination_00000000.shp', 'layer_illumination_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (34, 136, 36, 'admin', 'Y', 'layer_bitt_00000000.dbf', 'layer_bitt_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (35, 136, 36, 'admin', 'Y', 'layer_bitt_00000000.shx', 'layer_bitt_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (36, 136, 36, 'admin', 'Y', 'layer_bitt_00000000.shp', 'layer_bitt_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (37, 137, 39, 'admin', 'Y', 'layer_etc_point_00000000.dbf', 'layer_etc_point_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (38, 137, 39, 'admin', 'Y', 'layer_etc_point_00000000.shx', 'layer_etc_point_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (39, 137, 39, 'admin', 'Y', 'layer_etc_point_00000000.shp', 'layer_etc_point_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (40, 2, 42, 'admin', 'Y', 'layer_rail_00000000.dbf', 'layer_rail_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (41, 2, 42, 'admin', 'Y', 'layer_rail_00000000.shx', 'layer_rail_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (42, 2, 42, 'admin', 'Y', 'layer_rail_00000000.shp', 'layer_rail_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (43, 31, 45, 'admin', 'Y', 'layer_road_boundary_area_00000000.dbf', 'layer_road_boundary_area_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (44, 31, 45, 'admin', 'Y', 'layer_road_boundary_area_00000000.shx', 'layer_road_boundary_area_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (45, 31, 45, 'admin', 'Y', 'layer_road_boundary_area_00000000.shp', 'layer_road_boundary_area_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (46, 32, 48, 'admin', 'Y', 'layer_road_tp_boundary_area_00000000.dbf', 'layer_road_tp_boundary_area_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (47, 32, 48, 'admin', 'Y', 'layer_road_tp_boundary_area_00000000.shx', 'layer_road_tp_boundary_area_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (48, 32, 48, 'admin', 'Y', 'layer_road_tp_boundary_area_00000000.shp', 'layer_road_tp_boundary_area_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (49, 33, 51, 'admin', 'Y', 'layer_road_center_line_00000000.dbf', 'layer_road_center_line_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (50, 33, 51, 'admin', 'Y', 'layer_road_center_line_00000000.shx', 'layer_road_center_line_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (51, 33, 51, 'admin', 'Y', 'layer_road_center_line_00000000.shp', 'layer_road_center_line_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (52, 4, 54, 'admin', 'Y', 'layer_landscape_00000000.dbf', 'layer_landscape_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (53, 4, 54, 'admin', 'Y', 'layer_landscape_00000000.shx', 'layer_landscape_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (54, 4, 54, 'admin', 'Y', 'layer_landscape_00000000.shp', 'layer_landscape_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (55, 6, 57, 'admin', 'Y', 'layer_full_ship_dock_00000000.dbf', 'layer_full_ship_dock_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (56, 6, 57, 'admin', 'Y', 'layer_full_ship_dock_00000000.shx', 'layer_full_ship_dock_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (57, 6, 57, 'admin', 'Y', 'layer_full_ship_dock_00000000.shp', 'layer_full_ship_dock_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (58, 7, 60, 'admin', 'Y', 'layer_full_ship_quay_00000000.dbf', 'layer_full_ship_quay_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (59, 7, 60, 'admin', 'Y', 'layer_full_ship_quay_00000000.shx', 'layer_full_ship_quay_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (60, 7, 60, 'admin', 'Y', 'layer_full_ship_quay_00000000.shp', 'layer_full_ship_quay_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (61, 8, 63, 'admin', 'Y', 'layer_lot_number_00000000.dbf', 'layer_lot_number_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (62, 8, 63, 'admin', 'Y', 'layer_lot_number_00000000.shx', 'layer_lot_number_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (63, 8, 63, 'admin', 'Y', 'layer_lot_number_00000000.shp', 'layer_lot_number_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (64, 91, 66, 'admin', 'Y', 'layer_goliath_crane_00000000.dbf', 'goliath_crane_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (65, 91, 66, 'admin', 'Y', 'layer_goliath_crane_00000000.shx', 'goliath_crane_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (66, 91, 66, 'admin', 'Y', 'layer_goliath_crane_00000000.shp', 'goliath_crane_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (67, 92, 69, 'admin', 'Y', 'layer_jeep_crane_00000000.dbf', 'jeep_crane_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (68, 92, 69, 'admin', 'Y', 'layer_jeep_crane_00000000.shx', 'jeep_crane_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (69, 92, 69, 'admin', 'Y', 'layer_jeep_crane_00000000.shp', 'jeep_crane_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (70, 10, 72, 'admin', 'Y', 'layer_block_00000000.dbf', 'layer_block_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (71, 10, 72, 'admin', 'Y', 'layer_block_00000000.shx', 'layer_block_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (72, 10, 72, 'admin', 'Y', 'layer_block_00000000.shp', 'layer_block_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (73, 1101, 75, 'admin', 'Y', 'layer_wavy_00000000.dbf', 'layer_wavy_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (74, 1101, 75, 'admin', 'Y', 'layer_wavy_00000000.shx', 'layer_wavy_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (75, 1101, 75, 'admin', 'Y', 'layer_wavy_00000000.shp', 'layer_wavy_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (76, 1102, 78, 'admin', 'Y', 'layer_contour_00000000.dbf', 'layer_contour_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (77, 1102, 78, 'admin', 'Y', 'layer_contour_00000000.shx', 'layer_contour_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (78, 1102, 78, 'admin', 'Y', 'layer_contour_00000000.shp', 'layer_contour_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (79, 1103, 81, 'admin', 'Y', 'layer_embankment_00000000.dbf', 'layer_embankment_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (80, 1103, 81, 'admin', 'Y', 'layer_embankment_00000000.shx', 'layer_embankment_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (81, 1103, 81, 'admin', 'Y', 'layer_embankment_00000000.shp', 'layer_embankment_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (82, 1104, 84, 'admin', 'Y', 'layer_fance_00000000.dbf', 'layer_fance_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (83, 1104, 84, 'admin', 'Y', 'layer_fance_00000000.shx', 'layer_fance_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (84, 1104, 84, 'admin', 'Y', 'layer_fance_00000000.shp', 'layer_fance_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (85, 1105, 87, 'admin', 'Y', 'layer_etc_terrain_00000000.dbf', 'layer_etc_terrain_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (86, 1105, 87, 'admin', 'Y', 'layer_etc_terrain_00000000.shx', 'layer_etc_terrain_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (87, 1105, 87, 'admin', 'Y', 'layer_etc_terrain_00000000.shp', 'layer_etc_terrain_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW()),
    (88, 5, 90, 'admin', 'Y', 'layer_boundary_area_00000000.dbf', 'layer_boundary_area_00000000.dbf', '/data/shp_data/2019/', 0, 'dbf', 'CP949', NOW(), NOW()),
    (89, 5, 90, 'admin', 'Y', 'layer_boundary_area_00000000.shx', 'layer_boundary_area_00000000.shx', '/data/shp_data/2019/', 0, 'shx', 'CP949', NOW(), NOW()),
    (90, 5, 90, 'admin', 'Y', 'layer_boundary_area_00000000.shp', 'layer_boundary_area_00000000.shp', '/data/shp_data/2019/', 0, 'shp', 'CP949', NOW(), NOW());
commit;
