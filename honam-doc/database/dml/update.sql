UPDATE layer_factory SET enable_yn = 'Y';
UPDATE layer_office_building SET enable_yn = 'Y';
UPDATE layer_etc_sub_building SET enable_yn = 'Y';
UPDATE layer_etc_facility SET enable_yn = 'Y';
UPDATE layer_store_Processing_facility SET enable_yn = 'Y';
UPDATE layer_electric_manhole SET enable_yn = 'Y';
UPDATE layer_sewage_manhole SET enable_yn = 'Y';
UPDATE layer_communication_manhole SET enable_yn = 'Y';
UPDATE layer_gas_manhole SET enable_yn = 'Y';
UPDATE layer_etc_manhole SET enable_yn = 'Y';
UPDATE layer_illumination SET enable_yn = 'Y';
UPDATE layer_bitt SET enable_yn = 'Y';
UPDATE layer_etc_point SET enable_yn = 'Y';
UPDATE layer_rail SET enable_yn = 'Y';
UPDATE layer_road_boundary_area SET enable_yn = 'Y';
UPDATE layer_road_tp_boundary_area SET enable_yn = 'Y';
UPDATE layer_road_center_line SET enable_yn = 'Y';
UPDATE layer_landscape SET enable_yn = 'Y';
UPDATE layer_full_ship_dock SET enable_yn = 'Y';
UPDATE layer_full_ship_guay SET enable_yn = 'Y';
UPDATE layer_lot_number SET enable_yn = 'Y';
UPDATE layer_goliath_crane SET enable_yn = 'Y';
UPDATE layer_jeep_crane SET enable_yn = 'Y';
UPDATE layer_wavy SET enable_yn = 'Y';
UPDATE layer_contour SET enable_yn = 'Y';
UPDATE layer_embankment SET enable_yn = 'Y';
UPDATE layer_fance SET enable_yn = 'Y';
UPDATE layer_etc_terrain SET enable_yn = 'Y';
UPDATE layer_boundary_area SET enable_yn = 'Y';

UPDATE layer_factory SET version = 1;
UPDATE layer_office_building SET version = 1;
UPDATE layer_etc_sub_building SET version = 1;
UPDATE layer_etc_facility SET version = 1;
UPDATE layer_store_Processing_facility SET version = 1;
UPDATE layer_electric_manhole SET version = 1;
UPDATE layer_sewage_manhole SET version = 1;
UPDATE layer_communication_manhole SET version = 1;
UPDATE layer_gas_manhole SET version = 1;
UPDATE layer_etc_manhole SET version = 1;
UPDATE layer_illumination SET version = 1;
UPDATE layer_bitt SET version = 1;
UPDATE layer_etc_point SET version = 1;

UPDATE layer_rail SET version = 1;
UPDATE layer_road_boundary_area SET version = 1;
UPDATE layer_road_tp_boundary_area SET version = 1;
UPDATE layer_road_center_line SET version = 1;
UPDATE layer_landscape SET version = 1;
UPDATE layer_full_ship_dock SET version = 1;
UPDATE layer_full_ship_guay SET version = 1;
UPDATE layer_lot_number SET version = 1;
UPDATE layer_goliath_crane SET version = 1;
UPDATE layer_jeep_crane SET version = 1;
UPDATE layer_wavy SET version = 1;
UPDATE layer_contour SET version = 1;
UPDATE layer_embankment SET version = 1;
UPDATE layer_fance SET version = 1;
UPDATE layer_etc_terrain SET version = 1;
UPDATE layer_boundary_area SET version = 1;

UPDATE layer SET use_yn='N' WHERE layer_key IN('layer_block');

UPDATE layer_file_info SET version=1;

commit;

