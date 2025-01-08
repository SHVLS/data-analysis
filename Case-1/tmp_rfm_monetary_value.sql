/*Создаем таблицу, производим расчет и заполнение данных monetary value.*/

drop table if exists analysis.tmp_rfm_monetary_value ;

CREATE TABLE analysis.tmp_rfm_monetary_value (
 user_id INT NOT NULL PRIMARY KEY,
 monetary_value INT NOT NULL CHECK(monetary_value >= 1 AND monetary_value <= 5)
);


with t as (select user_id  , 
	sum  (cost)  -- Сумма заказа и бонуса
	,  ntile(5) over (ORDER BY sum (cost) asc) as monetary_value -- Разделение показателей на 5 групп
	from analysis.orders 
where status = 4  -- Завершенные заказы 
group by 1
order by 2) 


insert into analysis.tmp_rfm_monetary_value(
select 
  user_id, monetary_value 
from t);
