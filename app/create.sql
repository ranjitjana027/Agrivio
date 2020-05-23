
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

/* Notifications */
create table notifications(
  id serial primary key,
  content varchar(200),
  n_time TIMESTAMPTZ default (now() at time zone 'utc'),
  user_id integer references users(id) on delete cascade
);
alter table notifications
add column read bool default false;
insert into notifications(content,user_id)
  values('Hello! A warm welcome from our side. For any issues kindly contact us.',1);
insert into notifications(content,user_id)
  values('Thanks for choosing us.',1);
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

insert into article(title,content,keywords,author)
values('Get Rid of pests with home remedies',
  '<figure><img class="article-image" src="/webProject/assets/img/articles/guides/1/homemade_mosquito_trap.jpg" alt=""></figure>
  <p>The arrival of warm weather means more insects will be out, some of whom will turn out to be garden pests. Homemade traps can be used to identify pests and monitor their activities, and sometimes traps are so effective that they provide a respectable level of control. Here are six homemade traps for garden pests to help you monitor insect life in your garden and warn you when pests are active.</p>
  <div class="article-subheader">Pit Traps for Slugs and Earwigs</div>
  <p>Leaf-eating slugs like to go out at night for a bit of beer, the most popular bait for slug traps. Shallow containers filled with an inch of beer are placed among lettuce, strawberries, or other plants with slug issues, and the slugs come for a drink and then fall in and drown. You also can use sugar water with a light sprinkling of yeast instead of beer, or a thin slurry of flour, yeast and sugar. Slugs are attracted by the fermentation gases, preferring the traps over your plants.</p>
  <p>The bane of container gardeners, earwigs hide under pots during the day and come out at night to chew ragged holes in plants. Shallow containers baited with vegetable oil and a spritz of soy sauce are remarkably effective earwig traps when placed among container plants at night.</p>
  <div class="article-subheader">Sticky Traps for Tiny Insects</div>
  <p>Small insects including aphids, flies, flea beetles, and whiteflies can be caught with sticky traps, which can be made from cards, cups or other objects coated with a sticky substance. Tangle Trap is great because it''s weatherproof, but you will snare plenty of little victims with petroleum jelly or any thick syrup as a sticky coating for your homemade traps.</p>
  <p>It is important to think strategically. In my garden, I have a problem with onion maggots, the larvae of a fast-moving little fly that''s active in late spring. Yellow sticky traps placed among my garlic let me know if it''s looking like a good year or a bad one. If I catch more than a few flies in early May, the plants get covered with row cover.</p>
  <p>A wide variety of insects are attracted to the color yellow, including flies, flea beetles, and cucumber beetles, but some aphids prefer spring green, and thrips are drawn to the color blue. You can paint homemade sticky traps the color you want before applying a sticky coating. Also install any hanging hooks or hardware in your trap before you get out the sticky stuff.</p>
  <div class="article-subheader">Yellow Pan Traps for Aphids and Squash Vine Borers</div>
  <p>If you have ever left a yellow bucket filled with water sitting in your garden, you have probably seen a yellow pan trap in action. Insects are attracted by the color yellow, but end up stuck in the water. Adding a few drops of liquid soap to the water in a pan trap helps insects drown faster by hampering their ability to swim.</p>
  <p>Very shallow containers such as yellow frisbees are fine for catching aphids and other small insects, but deeper vessels that hold more than two inches of water are better for nabbing larger creatures such as the moth whose young become squash vine borers. The large black and orange moths fly during the day, making a loud buzzing noise, starting in early summer. Yellow pan traps placed among squash plants can help you monitor their emergence, robbing this pest of its stealth advantage.</p>
  <div class="article-subheader">Yellow Traps for Cucumber Beetles</div>
  <p>One of the problems with open pan traps is that they may also capture bees and other beneficial insects. To prevent these types of unwanted casualties, you can make jug or bottle traps with entry holes tailored to the size of the pest insect you want to trap. For example, a paper hole punch is a handy tool for making small holes to exclude bees in traps intended for cucumber beetles like the one above. To make the trap work better, cucumber peels added to the jar will work as a lure.</p>
  <p>What if you put out a trap and catch nothing? This is good! Wait a week or two and monitor again, and continue to watch your plants for signs of serious trouble. Some trapping here, some hand picking there, and you may just have an easy season</p>'
  ,
  'guides, pests , home remedies'
  ,
  'Dinesh Kanoria'
);

insert into article(title,content,keywords,author)
  values(
    'Commmon Mistakes in cultivation of Vegetables',
    '<figure><img class="article-image" src="/webProject/assets/img/articles/guides/2/common-mistakes.jpg" alt=""></figure>
    <p>With many new and returning vegetable gardeners among our ranks this year, it''s a good time to highlight common vegetable gardening mistakes, and the best ways to prevent them. I''ve been lecturing on this topic for almost ten years, since my Starter Vegetable Gardens book was published, and these are the seven vegetable gardening mistakes that come up again and again...
    </p>
    <div class="article-subheader">1. Taking On Too Much</div>
    <p>Just as a new cook should not take on a dinner for twelve, new gardeners should limit either the size of the garden or the length of their plant lists. A small garden is fun because you can keep up with the details while learning about your site and soil. Then expand gradually as more plants capture your interest. If you''re looking at a large site, divide the growing season into three parts – spring, summer, and autumn - and grow three crops in each subseason. For example, you might grow potatoes, peas and salad greens in spring, beans, tomatoes and cucumbers in summer, and end the year with broccoli, kale and watermelon radishes.
    </p>
    <div class="article-subheader">2. Being Overly Optimistic About the Weather</div>
    <p>Beautiful spring days lull us into thinking that only happy days are ahead, but then the wind starts blowing cold, or maybe a spring thunderstorm sends down hail that lays plants flat. Most gardeners are also weather addicts, accustomed to carrying the ten-day forecast around in their heads, because cloches, row covers, or wind-taming tunnels must be in place before they are needed. Check out the springtime tips in The Mess of Protecting Plants from Stress and How to Make a Row Cover Tunnel.</p>
    <div class="article-subheader">3. Confusion About Soil</div>
    <p>I''m now used to seeing pictures sent by new gardeners of plants that are undernourished and overwatered, and often deprived of light, too. The gardeners usually did the right things, amending the soil with bagged organic amendments, but that is only step one. Rich, fertile soil is created gradually, as fungi and other soil inhabitants build their invisible cities underfoot. Meantime, prepare the soil with a balanced organic fertilizer and a heaped helping of compost every time you plant anything.</p>
    <div class="article-subheader">4. Allowing Limits on Light</div>
    <p>Plants are solar beings that get most of their energy from sun. Each leaf is a solar collector, so plants make their best growth when every leaf gets all the light it can process. This is why your garden should be in the sunniest spot available, and why you need to thin crowded seedlings so none are deprived of light. If partial shade is unavoidable, you''ll find inspired ideas in Grow Fruits and Vegetables in the Shade. In addition, the Garden Planner has a filter for partial shade tolerance, found by clicking on the Custom Filter button to the left of the plant selection bar.</p>
    <div class="article-subheader">5. Growing Heat-Sensitive Crops in Containers</div>
    <p>Many new gardeners think that growing vegetables in containers is easier than growing them in the ground, which is simply not true. Containers always have a dwarfing effect on plants, and container-grown plants need constant watering and feeding. Root temperatures in containers fluctuate daily, and cool-season plants especially get upset when their roots get too warm. This does not happen in deeply dug or mulched beds, where soil temperatures are more constant. On the plus side, plants that like warm roots such as peppers and eggplant may grow better in containers where summers are cool. From citrus to strawberries, we have a bevy of articles on Growing Edibles in Containers.</p>
    <div class="article-subheader">6. Letting Weeds Take Over</div>
    <p>Weeds are part of Nature''s plan for healing over scarred places in the earth, and if allowed they will pave over every open space with green. You cannot permit this, because the weeds will rob your plants of light, nutrients and water. Weeding is a fact of gardening life, so weed early and often, and keep your weeding tools sharp.</p>
    <div class="article-subheader">7. Giving Up Too Soon</div>
    <p>Every new endeavor involves a learning curve, and gardening in no different. Give yourself time to learn the best practices to follow, study up on your favorite plants, and network with other gardeners to learn about crops and varieties that grow well in your area. The garden is a great teacher. In a few seasons, you''ll go from being a newbie to an old hand.</p>
    ',
    'guides, mistakes, vegetables',
    'Yogesh Valmiki'
  );
