/*
CREATE SEQUENCE seq_person MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_event MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_chat MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
*/
/* oracle*/
/*
create table users (
  id number primary key,
  firstname varchar2(128) not null,
  lastname varchar2(128) not null,
  mobile varchar2(10) unique,
  email varchar2(128),
  password varchar2(128) not null,
  avtar blob,
  premium number default 0,
  role varchar2(32) default 'FARMER'
);
insert into users
values
  (
    seq_person.nextval,
    'User',
    'Name',
    '9800000000',
    NULL,
    'password',
    NULL
  );
  */
    /*create table events (
    id number primary key,
    day date not null,
    crop varchar2(128) not null,
    eventtype varchar2(128) not null,
    remark varchar2(200),
    user number references users(id) on delete cascade
  );
insert into events
values(
    seq_event.nextval,
    TO_DATE('2020-03-07', 'YYYY-MM-DD'),
    'paddy',
    'Seeding',
    NULL,
    12
  );
create table chats(
    id number primary key,
    c_time TIMESTAMP WITH TIME ZONE,
    content VARCHAR2(512) not null,
    sender number REFERENCES users(id) on delete cascade
  );*/

  /** postgres **/
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
    conclusion text not null
);
/*
create table crop_overviews(
    id serial primary key,
    cpa real ,
    min_prod_time real,
    profit varchar(32)
);


create table weather_details(
    id serial primary key,
    min_temp real,
    max_temp real,
    humidity real,
    rainfall real
);


create table requirements(
    id serial PRIMARY KEY,
    weather integer REFERENCES weather_details(id) on DELETE CASCADE,
    soil varchar(64),
    land varchar(64),
    season VARCHAR(64)
);


CREATE TABLE article_contents(
    id serial PRIMARY key,
    soil_prep text,
    sowing text,
    nurturing text,
    production text,
    coolingoff text,
    extra text
);

create table crop_details(
    id serial primary key,
    name varchar(128) not null,
    crop_overview INTEGER REFERENCES crop_overviews(id) on DELETE CASCADE,
    requirement INTEGER REFERENCES requirements(id) on DELETE CASCADE,
    content INTEGER REFERENCES article_contents(id) on DELETE CASCADE,
    conclusion text
);

create or replace view articles AS
select crop_details.id,
    crop_details.name,
    crop_overviews.cpa,
    crop_overviews.min_prod_time,
    crop_overviews.profit,
    weather_details.min_temp,
    weather_details.max_temp,
    weather_details.humidity,
    weather_details.rainfall,
    requirements.soil,
    requirements.land,
    requirements.season,
    article_contents.soil_prep,
    article_contents.sowing,
    article_contents.nurturing,
    article_contents.production,
    article_contents.coolingoff,
    article_contents.extra,
    crop_details.conclusion
    from crop_details,
    crop_overviews,
    weather_details,
    requirements,
    article_contents
    where crop_overviews.id= crop_details.crop_overview
    and requirements.id =crop_details.requirement
    and weather_details.id=requirements.weather
    and article_contents.id=crop_details.content;
*/

/************/
