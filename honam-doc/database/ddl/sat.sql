drop table if exists sat cascade;

-- 위성영상 결과
create table sat(
	id						    bigint,
	fac_num						varchar(254)				    not null,
	displacement				double precesion,
	date						integer,
	gem							geometry,
	constraint sat_pk 		primary key (id)
);

comment on table sat is '위성영상 결과';
comment on column sat.id is '위성결과 고유번호';
comment on column sat.fac_num is '시설물 번호';
comment on column sat.displacement is '변위 값';
comment on column sat.date is '날짜';
comment on column sat.gem is 'Geometry(Point) 정보';
