drop table if exists public.shipping_status;

CREATE TABLE public.shipping_status(
    shippingid int ,
    status text,
    state text,
    shipping_start_fact_datetime TIMESTAMP,
    shipping_end_fact_datetime TIMESTAMP,
    PRIMARY KEY (shippingid)
);
COMMENT ON COLUMN public.shipping_status.shippingid is 'уникальный идентификатор доставки';
COMMENT ON COLUMN public.shipping_status.status is 'последний актуальный status доставки в таблице shipping по данному shippingid';
COMMENT ON COLUMN public.shipping_status.state is 'последний актуальный state доставки в таблице shipping по данному shippingid';
COMMENT ON COLUMN public.shipping_status.shipping_start_fact_datetime is 'фактическоу время запуска доставки - state = booked';
COMMENT ON COLUMN public.shipping_status.shipping_end_fact_datetime is 'фактическое время выполнение доставки - state = recieved';



with ship_max as (
    select shipping_id,
    	   max(status) as status,
           max(state_datetime) as max_state_datetime,
           max(case when state= 'booked' then shipping.state_datetime end) as shipping_start_fact_datetime,
           max(case when state = 'received' then shipping.state_datetime end) as shipping_end_fact_datetime
    from public.shipping
    group by 1
)
INSERT INTO public.shipping_status
(shippingid, status,state,shipping_start_fact_datetime,shipping_end_fact_datetime)
select sm.shipping_id,
       sm.status,
       sm.max_state_datetime,
       sm.shipping_start_fact_datetime,
       sm.shipping_end_fact_datetime
from ship_max as sm   
-- join public.shipping as s on sm.shipping_id = s.shipping_id
order by 1;

-- Проверяем заполнение таблицы
select * from public.shipping_status limit 10;


