// create a sequence

CREATE SEQUENCE seq_person
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;



create table farmers
( id  number primary key,
firstname varchar2(128) not null,
lastname varchar2(128) not null,
mobile varchar2(12) not null,
email varchar2(128),
password varchar2(128),
avtar blob);


insert into farmers
values ( seq_person.nextval, 'User', 'Name', '9800000000', NULL, 'password', NULL);
