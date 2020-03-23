drop sequence if exists bridge_drone_file_seq;
drop sequence if exists data_info_seq;
drop sequence if exists data_info_seq;
drop sequence if exists user_group_seq;

create sequence bridge_drone_file_seq increment 1 minvalue 1 maxvalue 9999999999999999 start 1 cache 1;
create sequence data_group_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;
create sequence data_info_seq increment 1 minvalue 1 maxvalue 9999999999999999 start 1000 cache 1;
create sequence user_group_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;

