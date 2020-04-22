-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists sensor_data cascade;


-- 사용자 기본정보
create table sensor_data(
	sensor_data_id			serial,
	sensorid				varchar(10),
	time					timestamp with time zone,
	mean_value				numeric(10,10),
	max_value				numeric(9,9),
	condition				integer
);




-- csv 파일 받아서 넣어야함 

\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC001.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC002.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC003.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC004.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC005.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC006.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC007.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC008.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC009.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC010.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC011.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC012.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC013.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC014.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC015.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC016.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC017.csv' WITH DELIMITER ',' CSV header;
\copy sensor_data(sensorid,time, mean_value, max_value,condition) from 'D:\sensor\ACC018.csv' WITH DELIMITER ',' CSV header;
