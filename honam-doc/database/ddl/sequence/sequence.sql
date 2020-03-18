drop sequence if exists access_log_seq;
drop sequence if exists api_log_seq;
drop sequence if exists access_log_seq;
drop sequence if exists api_log_seq;
drop sequence if exists menu_seq;
drop sequence if exists role_seq;
drop sequence if exists server_seq;
drop sequence if exists user_group_seq;
drop sequence if exists user_group_role_seq;
drop sequence if exists user_group_menu_seq;


create sequence access_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence api_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence menu_seq increment 1 minvalue 1 maxvalue 999999999999 start 2000 cache 1;
create sequence role_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;
create sequence server_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;
create sequence user_group_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;
create sequence user_group_role_seq increment 1 minvalue 1 maxvalue 999999999999 start 100 cache 1;
create sequence user_group_menu_seq increment 1 minvalue 1 maxvalue 999999999999 start 700 cache 1;