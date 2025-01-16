drop table if exists  public.shipping_country_rates;


CREATE  TABLE public.shipping_country_rates (
	id serial,
	shipping_country text not null,
	shipping_country_base_rate NUMERIC(14,3),
	PRIMARY KEY (ID),
	FOREIGN KEY (ID) REFERENCES public.shipping_info(shipping_country_rate_id) ON UPDATE cascade
);
CREATE INDEX shipping_country_rates_i ON public.shipping_country_rates(shipping_country);
comment on column public.shipping_country_rates.shipping_country is 'Название страны отправки товара';
comment on column public.shipping_country_rates.shipping_country_base_rate is 'Налог на доставку в странуб процент от';


insert into public.shipping_country_rates
	(shipping_country , shipping_country_base_rate )
	select distinct shipping_country,  
					shipping_country_base_rate  
	from  public.shipping; 


-- проверяем, что таблица заполнилась
select * from public.shipping_country_rates limit 10;
