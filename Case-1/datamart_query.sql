/*Заполнение витрины.*/


insert into analysis.rfm_segments 
select user_id, 
	recency, 	
	frequency,	
	monetary_value 
from  analysis.tmp_rfm_frequency 
	join analysis.tmp_rfm_recency  using  (user_id)
	join analysis.tmp_rfm_monetary_value using (user_id);
	