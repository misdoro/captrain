create database captrain;
grant all on captrain.* to captrain@'localhost' identified by "pctpass";
flush privileges;

drop table if exists stations;
create table stations(
id int unsigned NOT NULL,
latitude decimal(12,10),
longitude decimal (12,10),
name text,
PRIMARY KEY  (`id`)
)

