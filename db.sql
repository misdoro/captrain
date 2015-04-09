create database captrain;
grant all on captrain.* to captrain@'localhost' identified by "pctpass";
flush privileges;

\u captrain
drop table if exists stations;
create table stations(
id int unsigned NOT NULL,
latitude decimal(12,10),
longitude decimal (12,10),
name text,
PRIMARY KEY  (`id`)
)

create table usedkeys(
id int unsigned NOT NULL auto_increment,
keystr char(10),
numsta int not null default 0,
PRIMARY KEY  (`id`)
)