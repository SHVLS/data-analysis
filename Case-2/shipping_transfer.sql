drop table if exists public.shipping_transfer;


create table public.shipping_transfer(
	ID serial,
	transfer_type text,
	transfer_model text,
	shipping_transfer_rate NUMERIC(14,3),
	primary key (ID),
	FOREIGN KEY (ID) REFERENCES public.shipping_info(shipping_transfer_id) ON UPDATE cascade
);
COMMENT ON COLUMN public.shipping_transfer.transfer_type is 'тип доставки - 1p означает модель когда наша компания берет ответственность за доставку на себя, 3p - вендор ответственнен за отправку заказа самостоятельно';
COMMENT ON COLUMN public.shipping_transfer.transfer_model is 'модель доставки - каким способом заказ доставляется до точки. car - машиной, train - поездом, ship - кораблем, airplane - самолетом, multiplie - комбинированный';
COMMENT ON COLUMN public.shipping_transfer.shipping_transfer_rate is 'процент стоимости доставки для вендора в зависимости от типа и модели доставки, который мы взимаем для покрытия расходов';



INSERT INTO public.shipping_transfer
(transfer_type, transfer_model,shipping_transfer_rate)
select distinct shipping_transfer_description[1] as transfer_type ,
				shipping_transfer_description[2] as transfer_model,
				shipping_transfer_rate  
from ( 
		select shipping_transfer_rate,
				regexp_split_to_array(shipping_transfer_description, E'\\:') as shipping_transfer_description
		from  public.shipping
	) as st;


-- Проверяем заполнение таблицы 
select * from public.shipping_transfer limit 10;