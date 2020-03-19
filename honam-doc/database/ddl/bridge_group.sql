-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists bridge_group cascade;

-- bridge 그룹
create table bridge_group (
	bridge_group_id				integer,
	bridge_group_key			varchar(60)							not null,
	bridge_group_name			varchar(100)						not null,
	user_id						varchar(32),
	goal_performance			numeric(17,15),
	available					boolean								default true,
	view_order					integer								default 1,
	bridge_count				integer								default 0,
	location		 			GEOMETRY(POINT, 4326),
	altitude					numeric(13,7),
	duration					integer,
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint bridge_group_pk 	primary key (bridge_group_id)
);

comment on table bridge_group is 'bridge의 그룹';
comment on column bridge_group.bridge_group_id is '고유번호';
comment on column bridge_group.bridge_group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column bridge_group.bridge_group_name is '그룹명';
comment on column bridge_group.user_id is '사용자 아이디';
comment on column bridge_group.goal_performance is '목표 성능 수치(신뢰도 수치)';
comment on column bridge_group.bridge_count is 'bridge 총 건수';
comment on column bridge_group.view_order is '나열 순서';
comment on column bridge_group.available is 'true : 사용, false : 사용안함';
comment on column bridge_group.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column bridge_group.altitude is '높이';
comment on column bridge_group.duration is 'Map 이동시간';
comment on column bridge_group.description is '설명';
comment on column bridge_group.update_date is '수정일';
comment on column bridge_group.insert_date is '등록일';
