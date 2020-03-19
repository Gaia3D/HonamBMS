ALTER TABLE access_log ADD CONSTRAINT access_log_fk FOREIGN KEY (user_id) REFERENCES user_info (user_id);
--ALTER TABLE facility_file_info ADD CONSTRAINT facility_file_info_fk FOREIGN KEY (layer_id) REFERENCES layer (layer_id);
ALTER TABLE api_log ADD CONSTRAINT api_log_user_fk FOREIGN KEY (user_id) REFERENCES user_info (user_id);
ALTER TABLE api_log ADD CONSTRAINT api_log_server_fk FOREIGN KEY (server_id) REFERENCES server (server_id);
ALTER TABLE facility_attribute_info ADD CONSTRAINT facility_attribute_info_fk FOREIGN KEY (layer_id) REFERENCES layer (layer_id);
ALTER TABLE layer ADD CONSTRAINT layer_fk FOREIGN KEY (user_id) REFERENCES user_info (user_id);
ALTER TABLE user_group_role ADD CONSTRAINT user_group_role_group_fk FOREIGN KEY (user_group_id) REFERENCES user_group (user_group_id);
ALTER TABLE user_group_menu ADD CONSTRAINT user_group_menu_menu_fk FOREIGN KEY (menu_id) REFERENCES menu (menu_id);
ALTER TABLE user_group_menu ADD CONSTRAINT user_group_menu_group_fk FOREIGN KEY (user_group_id) REFERENCES user_group (user_group_id);

alter table only bridge_drone_file add constraint bridge_drone_file_fk_bridge_ogc_fid foreign key (ogc_fid) references bridge(ogc_fid);