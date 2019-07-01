drop sequence if exists access_log_seq;
drop sequence if exists api_log_seq;


create sequence access_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence api_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
