ALTER TABLE bridge ADD COLUMN bridge_cm float;
ALTER TABLE bridge ADD COLUMN bridge_lcc float;
ALTER TABLE bridge ADD COLUMN bridge_grade varchar(1);
ALTER TABLE bridge ADD COLUMN bridge_model smallint;
ALTER TABLE bridge ADD COLUMN update_date timestamp with time zone;
ALTER TABLE bridge ADD COLUMN insert_date timestamp with time zone default now();

comment on column bridge.bridge_cm is '교량 유지관리 목표 성능';
comment on column bridge.bridge_lcc is '내하성능(Load Carrying Capacity)';
comment on column bridge.bridge_grade is '교량등급';
comment on column bridge.update_date is '수정일';                    
comment on column bridge.insert_date is '등록일';    

commit;

UPDATE bridge set 
bridge_grade = 'B';

commit;