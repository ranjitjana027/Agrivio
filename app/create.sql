
  create table users (
    id serial primary key,
    firstname varchar(128) not null,
    lastname varchar(128) not null,
    mobile char(10) unique not null,
    email varchar(128),
    password varchar(20) not null,
    premium boolean default false,
    role varchar(10) default 'FARMER'
);

alter table users add column joined_on TIMESTAMPTZ default (now() at time zone 'utc');
create or replace view farmers AS
select id, firstname||' '||lastname as fullname, mobile, email, premium
from users
where role='FARMER';

create or replace view experts AS
select id,
    firstname||' '||lastname as fullname,
    mobile,
    email
from users
where role='EXPERT';

create or replace view admins AS
select id,
    firstname||' '||lastname as fullname,
    mobile,
    email
from users
where role='ADMIN';

insert into users(firstname, lastname, mobile, email, password)
values (
    'User',
    'Name',
    '9800000000',
    '',
    'password'
);
insert into users(firstname, lastname, mobile, email, password)
values ( 'Test',
        'Expert',
        '9600000000',
        '',
        'password'
);

create table location_info (
  id serial primary key,
  loc_time TIMESTAMPTZ default (now() at time zone 'utc'),
  user_id integer references users(id) on delete cascade,
  last_location real ARRAY[2],
  last_ip inet
);

SELECT DISTINCT on (user_id) * from  location_info where user_id=1 order by user_id, loc_time desc;

create table events (
    id serial primary key,
    day date not null,
    crop varchar(128) not null,
    eventtype varchar(128) not null,
    remark varchar(200),
    user_id integer references users(id) on delete cascade
);

insert into events(day,crop,eventtype,remark,user_id)
values( TO_DATE('2020-03-07', 'YYYY-MM-DD'),
    'paddy',
    'Seeding',
    '',
    1 );

create table chats
( id serial primary key,
c_time TIMESTAMPTZ default (now() at time zone 'utc'),
content TEXT not null,
sender INTEGER REFERENCES users(id) on delete cascade
);
 alter table chats add column room INTEGER REFERENCES users(id) on delete cascade ;
INSERT INTO chats (content,sender)
VALUES(
    'Good afternoon. How are you?',
    2
);

create or replace view chat_messages AS
  select chats.*, users.firstname||' '|| users.lastname as sender_name from chats , users where chats.sender=users.id;

/* article */
create table articles(
    id serial primary key,
    name varchar(128) not null UNIQUE,
    cpa real not null,
    min_prod_time real not null,
    profit varchar(64) not null,
    min_temp real not null,
    max_temp real not null ,
    humidity real not null,
    rainfall real not null,
    soil varchar(64) not null,
    land varchar(64) not null,
    season VARCHAR(64) not null,
    soil_prep text not null,
    sowing text not null,
    nurturing text not null,
    production text not null,
    coolingoff text not null,
    extra text ,
    conclusion text not null,
    title text,
    other_names text,
    intro text
);

/* crop data */
create table crop_info(
  id serial primary key,
  name varchar(128) not null,
  article_id integer references articles(id) on delete cascade
);
insert into crop_info(name,article_id) values ("rice",1);
insert into crop_info(name) values ('wheat');
insert into crop_info(name) values ('cotton');
insert into crop_info(name) values ('maize');

update crop_info set article_id=2 where id=2;
/* soil data */
create table india_soil_info(
  id serial primary key,
  name varchar(128) not null
);
  insert into india_soil_info(name) values('alluvial');
  insert into india_soil_info(name) values('black');
  insert into india_soil_info(name) values('red');
  insert into india_soil_info(name) values('laterite');
  insert into india_soil_info(name) values('desert');

create table usda_soil_info(
  id serial primary key,
  name varchar(128) not null,
  indian_name integer references india_soil_info(id) on delete cascade
);
insert into usda_soil_info(name,indian_name) values('aquents',1);
insert into usda_soil_info(name,indian_name) values('arents',1);

select id from usda_soil_info where lower(name) in ('aquents','arents');
create or replace view soil_info as
  select A.id, A.name as usda_name, B.name as indian_name from usda_soil_info A, india_soil_info B where A.indian_name=B.id;

create table soil_crop_mapping(
  soil_id integer references usda_soil_info(id) on delete cascade,
  crop_id integer references crop_info(id) on delete cascade
);
 alter table soil_crop_mapping add primary key(soil_id,crop_id);
insert into soil_crop_mapping values(1,1);

select * from crop_info
where id in
( select crop_id from soil_crop_mapping
  where soil_id in
  ( select id from usda_soil_info
    where lower(name) = 'aquents'
  )
);

create or replace view soil_crop_view AS
   select A.id as crop_id, A.name as crop_name, A.article_id, B.id as soil_id, B.name as soil_name from crop_info A, usda_soil_info B, soil_crop_mapping C where C.soil_id=B.id and C.crop_id=A.id;
