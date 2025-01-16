/*Мы должны обращаться только к объектам из схемы analysis при расчёте витрины.
Чтобы не дублировать данные, которые находятся в этой же базе, мы делаем представления в схеме analysis.
Представления будут отображать данные из схемы production.*/

create or REPLACE view analysis.orderitems as (select * from production.orderitems);
create or REPLACE view analysis.orders as (select * from production.orders);
create or REPLACE view analysis.users as (select * from production.users);
create or REPLACE view analysis.orderstatuslog as (select * from production.orderstatuslog);
create or REPLACE view analysis.products as (select * from production.products);
