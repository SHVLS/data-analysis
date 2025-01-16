/*Создаем таблицу, производим расчет и заполнение данных recency.*/


DROP TABLE analysis.tmp_rfm_recency;


CREATE TABLE analysis.tmp_rfm_recency (
	user_id INT NOT NULL PRIMARY KEY,
	recency INT NOT NULL CHECK(recency >= 1 AND recency <= 5)
); 


with ord as (select user_id  ,
	max (order_ts)  -- самый последний выполненый заказ
	,  ntile(5) over (ORDER BY max (order_ts) asc) as recency -- Разделение показателей на 5 групп
	from analysis.orders 
where status = 4  -- Завершенные заказы 
group by 1
order by 2) 


insert into analysis.tmp_rfm_recency(
	select 
	user_id, 
	recency 
	from ord
);
