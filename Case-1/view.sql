/*Мы должны обращаться только к объектам из схемы analysis при расчёте витрины.
Чтобы не дублировать данные, которые находятся в этой же базе, мы делаем представления в схеме analysis.
Представления будут отображать данные из схемы production.*/

drop view if exists analysis.orderitems;
drop view if exists  analysis.orders;
drop view if exists  analysis.users ;
drop view if exists analysis.orderstatuslog ;
drop view if exists  analysis.products;


create view analysis.orderitems as (select * from production.orderitems);
create view analysis.orders as (select * from production.orders);
create view analysis.users as (select * from production.users);
create view analysis.orderstatuslog as (select * from production.orderstatuslog);
create view analysis.products as (select * from production.products);
