drop table if exists bridge cascade;
drop table if exists bridge_group cascade;


-- 교량 정보
create table bridge(
	fac_num						varchar(10),
	bridge_group_id				bigint,
	mng_num						int,
	bridge_name					varchar(100)					not null,
	sec_idn						varchar(50),
	mng_org						varchar(5),
	mng_div						varchar(5),
	fac_own						varchar(5),
	fac_sido					varchar(10),
	fac_sgg						varchar(10),
	fac_emd						varchar(10),
	fac_ri						varchar(10),
	start_loc					varchar(10),
	end_loc						varchar(10),
	fac_gra						varchar(1),
	fac_cla						varchar(50),
	fac_kin						varchar(50),
	loc_x						numeric(13,10),
	loc_y						numeric(13,10),
	ufid						varchar(34),
	cnt_name					varchar(50),
	start_ymd					timestamp with time zone,
	end_amd						timestamp with time zone,
	csg_name					varchar(50),
	csm_name					varchar(50),
	csc_name					varchar(50),
	csc_amt						float,
	dsn_name					varchar(50),
	dsg_start					timestamp with time zone,
	dsg_end						timestamp with time zone,
	dsn_wet						varchar(5),
	dsn_drw						varchar(10),
	drw_sub						varchar(10),
	rep_chk						varchar(10),
	dsn_sem						varchar(10),
	isp_name					varchar(50),
	isp_start					timestamp with time zone,
	isp_end						timestamp with time zone,
	isp_rsn						int,
	law_ten						int,
	fac_law						varchar(50),
	trn_ymd						timestamp with time zone,
	fac_rep						varchar(50),
	lic_gov						varchar(50),
	bridge_length				float,
	bridge_hight				float,
	siw_width					float,
	road_width					float,
	eff_width					float,
	total_width					float,
	spa_cnt						float,
	max_len						float,
	uln_cnt						float,
	dln_cnt						float,
	total_lan					float,
	tra_cnt						float,
	uty_spa						varchar(50),
	usp_rep						varchar(20),
	usp_etc						varchar(20),
	upr_rep						varchar(20),
	upr_etc						varchar(20),
	uex_rep						varchar(20),
	uex_etc						varchar(20),
	udp_hight					float,
	dpi_rep						varchar(20),
	dpi_etc						varchar(20),
	dpi_base					varchar(20),
	dty_alt						varchar(20),
	dal_base					varchar(20),
	dcr_rou						varchar(50),
	ddw_max						float,
	bridge_cm					float,
	bridge_grade				varchar(1);
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint bridge_pk 		primary key (fac_num)
);

comment on table bridge is '교량 정보';
comment on column bridge.fac_id is '시설물 번호';
comment on column bridge.bridge_group_id is '교량 그룹 ID';
comment on column bridge.mng_num is '관리번호';
comment on column bridge.bridge_name is '교량 명';
comment on column bridge.sec_idn is '노선'; 						
comment on column bridge.mng_org is '관리주체';						
comment on column bridge.mng_div is '관리주체 구분';						
comment on column bridge.fac_own is '소유자';						
comment on column bridge.fac_sido is '시도';				
comment on column bridge.fac_sgg is '시군구';
comment on column bridge.fac_emd is '읍면동';						
comment on column bridge.fac_ri is '리';						
comment on column bridge.start_loc is '교량위치 시작점';					
comment on column bridge.end_loc is '교량위치 종점';						
comment on column bridge.fac_gra is '시설물 종별';						
comment on column bridge.fac_cla is '시설물 구분';						
comment on column bridge.fac_kin is '시설물 종류';						
comment on column bridge.loc_x is '위치정보 x좌표';						
comment on column bridge.loc_y is '위치정보 y좌표';
comment on column bridge.ufid is '고유식별번호';					
comment on column bridge.cnt_name is '공사명';					
comment on column bridge.start_ymd is '착공일';					
comment on column bridge.end_amd is '준공일';						
comment on column bridge.csg_name is '공사발주자';					
comment on column bridge.csm_name is '공사감독관리관';					
comment on column bridge.csc_name is '시공자';					
comment on column bridge.csc_amt is '시공비';
comment on column bridge.dsn_name is '설계자';
comment on column bridge.dsg_start is '설계시작일';					
comment on column bridge.dsg_end is '설계완료일';						
comment on column bridge.dsn_wet is '설계하중';						
comment on column bridge.dsn_drw is '설계도서보전';						
comment on column bridge.drw_sub is '설계도서사본 공단제출'
comment on column bridge.rep_chk is '보고 유무';						
comment on column bridge.dsn_sem is '내진설계적용여부';						
comment on column bridge.isp_name is '관리자';					
comment on column bridge.isp_start is '감리시작일';					
comment on column bridge.isp_end is '갈리완료일';						
comment on column bridge.isp_rsn is '감리비대상사유';						
comment on column bridge.law_ten is '영10조대상';						
comment on column bridge.fac_law is '시설물관리근거법령';						
comment on column bridge.trn_ymd is '1/2종 시설물 편입일';						
comment on column bridge.fac_rep is '대표 시설물';
comment on column bridge.lic_gov is '인허가기관';						
comment on column bridge.bridge_length is '연장';				
comment on column bridge.bridge_hight is '교고';				
comment on column bridge.siw_width is '보도폭';					
comment on column bridge.road_width	is '차도록';				
comment on column bridge.eff_width is '유효폭';					
comment on column bridge.total_width is '총폭';					
comment on column bridge.spa_cnt is '경간수';						
comment on column bridge.max_len is '최대경간장';						
comment on column bridge.uln_cnt is '상행차로 수';						
comment on column bridge.dln_cnt is '하행차로 수';						
comment on column bridge.total_lan is '차로수 총계';					
comment on column bridge.tra_cnt is '교통량';						
comment on column bridge.uty_spa is '경간구성';						
comment on column bridge.usp_rep is '상부구조 경간형식 대표';
comment on column bridge.usp_etc is '상부구조 경간형식 기타';						
comment on column bridge.upr_rep is '상부구조 받침종류 대표';						
comment on column bridge.upr_etc is '상부구조 받침종류 기타';						
comment on column bridge.uex_rep is '상부구조 신축이음 종류 대표';
comment on column bridge.uex_etc is '상부구조 신축이음 종류 기타';
comment on column bridge.udp_hight is '상부구조 하부통과제한 높이';
comment on column bridge.dpi_rep is '하부구조 교각형식 대표';						
comment on column bridge.dpi_etc is '하부구조 교각형식 기타';						
comment on column bridge.dpi_base is '하부구조 교각 기초 형식';					
comment on column bridge.dty_alt is '하부구조 교대 형식';						
comment on column bridge.dal_base is '하부구조 교대 기초 형식';					
comment on column bridge.dcr_rou is '하부구조 교차노선(교차하천)';						
comment on column bridge.ddw_max is '하부구조 교차하천 최고 수심';
comment on column bridge.bridge_cm is '교량 유지관리 목표 성능';
comment on column bridge.bridge_grade is '등급';
comment on column bridge.update_date is '수정일';					
comment on column bridge.insert_date is '등록일';					


-- 교량 그룹 정보
create table bridge_group(
	bridge_group_id						int,
	bridge_group_cm						float,	
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone		default now(),
	constraint bridge_group_pk			primary key (bridge_group_id)
);

comment on table bridge_group is '교량 그룹 정보';
bridge_group_id.bridge_group_id is '교량 그룹 고유번호';
bridge_group_id.bridge_group_cm is '교량 그룹의 유지관리 목표 성능'
comment on column bridge_group.update_date is '수정일';
comment on column bridge_group.insert_date is '등록일';
