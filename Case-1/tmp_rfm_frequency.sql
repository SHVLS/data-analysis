/*Создаем таблицу, производим расчет и заполнение данных frequency.*/


drop table if exists analysis.tmp_rfm_frequency;

CREATE TABLE analysis.tmp_rfm_frequency (
 user_id INT NOT NULL PRIMARY KEY,
 frequency INT NOT NULL CHECK(frequency >= 1 AND frequency <= 5)
);


with t as (select user_id  ,
	count (order_ts)  -- Кол-во завершенных заказов 
	,  ntile(5) over (ORDER BY count (order_ts) asc) as frequency -- Разделение показателей на 5 групп
	from analysis.orders 
where status = 4  -- Завершенные заказы 
group by 1
order by 2) 


insert into analysis.tmp_rfm_frequency(
select 
  user_id, frequency 
from t);
