alter table properties rename column weight to atomic_mass;

alter table properties rename melting_point to melting_point_celsius;
alter table properties rename boiling_point to boiling_point_celsius;

alter table properties alter melting_point_celsius set not null;
alter table properties alter boiling_point_celsius set not null;

alter table elements add unique (symbol);
alter table elements add unique (name);

alter table elements alter symbol set not null;
alter table elements alter name set not null;

alter table properties add constraint fk_atomic_number foreign key (atomic_number) references elements(atomic_number);

create table types(type_id serial primary key, type varchar(20) not null);
insert into types(type) values ('metal'), ('nonmetal'), ('metalloid');

alter table properties add column type_id integer references types(type_id);
update properties set type_id = (select type_id from types where types.type = properties.type);
alter table properties alter type_id set not null;

update elements set symbol = initcap(symbol);

alter table properties alter column atomic_mass type decimal;
update properties set atomic_mass = atomic_mass::real;

insert into elements(atomic_number, symbol, name) values(9, 'F', 'Fluorine');
insert into properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values(9, 'nonmetal', 18.998, -220, -188.1, 2);

insert into elements(atomic_number, symbol, name) values(10, 'Ne', 'Neon');
insert into properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values(10, 'nonmetal', 20.18, -248.6, -246.1, 2);

delete from properties where atomic_number = 1000;
delete from elements where atomic_number = 1000;

alter table properties drop column type;