
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

alter table users
add column dp varchar(200);

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
alter table events
add column remainder boolean default false;

with unique_events as (
select distinct on (day,crop,eventtype) * from events )
delete from events where id not in ( select id from unique_events);

alter table events
add constraint unique_event unique(day,crop,eventtype,user_id);

alter table events
add column removed boolean default false;

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

/* Notifications */
create table notifications(
  id serial primary key,
  content varchar(200),
  n_time TIMESTAMPTZ default (now() at time zone 'utc'),
  user_id integer references users(id) on delete cascade
);
alter table notifications
add column read bool default false;

alter table notifications
add column removed bool default false;
alter table notifications
add column event_id integer references events(id) on delete cascade;

insert into notifications(content,user_id)
  values('Hello! A warm welcome from our side. For any issues kindly contact us.',1);
insert into notifications(content,user_id)
  values('Thanks for choosing us.',1);

/* article renamed to crop_details  */
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

alter table articles rename to crop_details;

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

alter table crop_info add column rabi boolean default false;
alter table crop_info add column kharif boolean default false;
alter table crop_info add column summer boolean default false;

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


/*Plants article*/

create table article(
  id serial primary key,
  keywords text ,
  title varchar(200) not null,
  content text not null
);
alter table article
add column author varchar(100) not null;

alter table article
add column published_on TIMESTAMPTZ default (now() at time zone 'utc');

alter table article
add column thumbnail bytea;

alter table article add  unique(title);

alter table article add column type varchar(20) not null default 'GUIDE';

/* articles */

create table articles(
  id serial primary key,
  title varchar(200) not null unique,
  content text not null,
  keywords varchar(200),
  author varchar(100) not null,
  type varchar(20) not null default 'GUIDE',
  published_on TIMESTAMPTZ default (now() at time zone 'utc'),
  thumbnail varchar(100) not null
);
 alter table articles alter column thumbnail type varchar(500);
 alter table articles alter column thumbnail drop not null;
 insert into articles(title,content,keywords,author,type) select title,content,keywords,author,type from article where id=?;
 alter table articles add column url varchar(100) unique;
 alter table articles rename column url to url_path;
 alter table articles alter column url_path set not null;
 alter table articles add column snippet varchar(200);


/* mesages */
create table messages(
  name varchar(128) not null,
  email varchar(64),
  message text not null,
  primary key(name,message)
)
alter table messages
add column m_time TIMESTAMPTZ default (now() at time zone 'utc');


/* ads */
 create table ads (
   id serial primary key,
   title varchar(200) not null unique,
   category varchar(100) not null,
   code text not null
 );
 /* values for target: 'cropprice'  */
 alter table ads
 rename column category to target;

/* Balance Sheet */

create table balance_sheet(
  id serial primary key,
  t_date date default CURRENT_DATE,
  type varchar(20) check ( type in ('debit', 'credit')),
  amount numeric not null,
  comment text ,
  subject varchar(100),
  user_id integer references users(id) on delete cascade
)

alter table balance_sheet add column removed boolean default false;
