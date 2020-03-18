drop table if exists bridge cascade;
drop table if exists bridge_group cascade;


-- 교량 정보
create table bridge(
	bridge_id					bigint,
	fac_num						varchar(254)				    not null,
	brg_nam						varchar(100)					not null,
	gru_num				bigint,
	bridge_cm					float,
	bridge_lcc					float,
	bridge_grade				varchar(1),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint bridge_pk 		primary key (fac_num)
);

comment on table bridge is '교량 정보';
comment on column bridge.bridge_id is '교량 고유번호';
comment on column bridge.fac_num is '시설물 번호';
comment on column bridge.brg_nam is '교량 명';
comment on column bridge.bridge_group_id is '교량 그룹 고유번호';
comment on column bridge.bridge_cm is '교량 유지관리 목표 성능';
comment on column bridge.bridge_lcc is '내하성능(Load Carrying Capacity)';
comment on column bridge.bridge_grade is '교량등급';
comment on column bridge.update_date is '수정일';					
comment on column bridge.insert_date is '등록일';					


-- 교량 그룹 정보
create table bridge_group(
	gru_num								bigint,
	bridge_group_cm						float,	
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone		default now(),
	constraint bridge_group_pk			primary key (gru_num)
);

comment on table bridge_group is '교량 그룹 정보';
comment on column bridge_group.gru_num is '교량 그룹 고유번호';
comment on column bridge_group.bridge_group_cm is '교량 그룹의 유지관리 목표 성능';
comment on column bridge_group.update_date is '수정일';
comment on column bridge_group.insert_date is '등록일';
