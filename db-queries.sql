-- 1-1 1-N N-N

select * from countries;
select * from cities;
select * from regions;

select count(*) from countries;

select avg(latitude), avg(longitude)
from cities
where country_id = 176;


select city.name, country.name
from cities city
left join countries country on city.country_id = country.id
where country_id != 0;


select * from countries;

select country.name, count(*)
from cities city
left join countries country on city.country_id = country.id
where char_length(country.name) < 12
group by country.name
having count(*) <= 2
order by count(*) desc;



select
       countries.name,
       (select count(*) from cities where cities.country_id = countries.id) as count
from countries
order by count desc;



--

explain select *
from cities
left join cities tmp on cities.country_id = tmp.country_id and CHAR_LENGTH(cities.name) > CHAR_LENGTH(tmp.name)
where tmp.id is null
and cities.country_id < 50
and cities.country_id != 0;


explain select
       countries.name,
       (select cities.name from cities where cities.country_id = countries.id order by char_length(name) desc limit 1 ) as count
from countries
order by count desc;




---- POSTGRESQL

drop table items;
create table items(
    id serial primary key,
    name text
);


select * from items;
insert into items(name) values ('Щеночек'), ('Солнцезащитная маска'), ('Железная бита'), ('лосьон для бритья');

drop table items_users;
create table items_users(
    item_id int REFERENCES items(id),
    user_id int REFERENCES users(id),
    unique(item_id, user_id)
);

select * from items_users;
select * from items;

insert into items_users values (1, 3);





select items.name, users.login
from items
left join items_users on items.id = items_users.item_id
left join users on items_users.user_id =  users.id
where items.id = 1;


select users.login
from items
left join items_users on items.id = items_users.item_id
left join users on items_users.user_id =  users.id
where items.id = 1;


select i.name
from users
left join items_users on items_users.user_id = users.id
left join items i on items_users.item_id = i.id
where users.id = 3;
