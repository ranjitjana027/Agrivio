

CREATE SEQUENCE seq_person
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;


CREATE SEQUENCE seq_event 
MINVALUE 1
START WITH 1 
INCREMENT BY 1 
CACHE 10;


CREATE SEQUENCE seq_chat 
MINVALUE 1
START WITH 1 
INCREMENT BY 1 
CACHE 10;

create table users 
(
    id number primary key, 
    firstname varchar2(128) not null, 
    lastname varchar2(128) not null, 
    mobile varchar2(12) unique, 
    email varchar2(128), 
    password varchar2(128) not null, 
    avtar blob,
    premium number default 0,
    role varchar2(32) default 'FARMER'
);


insert into users
values ( seq_person.nextval, 'User', 'Name', '9800000000', NULL, 'password', NULL);


create table events
(
    id number primary key,
    day date not null,
    crop varchar2(128) not null,
    eventtype varchar2(128) not null,
    remark varchar2(200) ,
    user number  references users(id) on delete cascade
);

insert into events
values( seq_event.nextval, TO_DATE('2020-03-07', 'YYYY-MM-DD'), 'paddy','Seeding', NULL, 12);

create table chats(
    id number primary key,
    c_time TIMESTAMP WITH TIME ZONE,
    content VARCHAR2(512) not null,
    sender number REFERENCES users(id) on delete cascade
);



