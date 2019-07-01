drop index if exists api_log_2019_idx;
drop index if exists api_log_2020_idx;
drop index if exists api_log_2021_idx;
drop index if exists api_log_2022_idx;
drop index if exists api_log_2023_idx;
drop index if exists api_log_2024_idx;
drop index if exists api_log_2025_idx;
drop index if exists api_log_2026_idx;
drop index if exists api_log_2027_idx;
drop index if exists api_log_2028_idx;
drop index if exists api_log_2029_idx;
drop index if exists api_log_2030_idx;
drop index if exists api_log_2031_idx;
drop index if exists api_log_2032_idx;
drop index if exists api_log_2033_idx;


create index api_log_2019_idx on api_log_2019 using btree(insert_date desc);
create index api_log_2020_idx on api_log_2020 using btree(insert_date desc);
create index api_log_2021_idx on api_log_2021 using btree(insert_date desc);
create index api_log_2022_idx on api_log_2022 using btree(insert_date desc);
create index api_log_2023_idx on api_log_2023 using btree(insert_date desc);
create index api_log_2024_idx on api_log_2024 using btree(insert_date desc);
create index api_log_2025_idx on api_log_2025 using btree(insert_date desc);
create index api_log_2026_idx on api_log_2026 using btree(insert_date desc);
create index api_log_2027_idx on api_log_2027 using btree(insert_date desc);
create index api_log_2028_idx on api_log_2028 using btree(insert_date desc);
create index api_log_2029_idx on api_log_2029 using btree(insert_date desc);
create index api_log_2030_idx on api_log_2030 using btree(insert_date desc);
create index api_log_2031_idx on api_log_2031 using btree(insert_date desc);
create index api_log_2032_idx on api_log_2032 using btree(insert_date desc);
create index api_log_2033_idx on api_log_2033 using btree(insert_date desc);
