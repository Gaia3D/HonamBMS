-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists sensor_data cascade;


-- 사용자 기본정보
create table sensor_data(
	sensor_data_id			serial,
	sensorid				varchar(10),
	time					timestamp with time zone,
	min_value				numeric(10,10),
	max_value				numeric(9,9),
	condition				integer
);




-- csv 파일 받아서 넣어야함 

\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC001.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC002.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC003.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC004.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC005.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC006.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC007.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC008.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC009.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC010.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC011.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC012.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC013.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC014.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC015.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC016.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC017.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, min_value, max_value,condition) from 'D:\ACC\ACC018.csv' WITH DELIMITER ',' CSV header;
