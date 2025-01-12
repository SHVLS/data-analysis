drop table if exists public.shipping_info;

CREATE TABLE public.shipping_info(
    shippingid int ,
    vendorid int,
    payment_amount NUMERIC(14,2),
    shipping_plan_datetime TIMESTAMP,
    shipping_transfer_id int,
    shipping_agremeent_id int,
    shipping_country_rate_id int,
    PRIMARY KEY (shippingid),
    FOREIGN KEY (shipping_transfer_id) REFERENCES public.shipping_transfer(ID) ON UPDATE cascade,
    FOREIGN KEY (shipping_agremeent_id) REFERENCES public.shipping_agreement(agreementid) ON UPDATE cascade,
    FOREIGN KEY (shipping_country_rate_id) REFERENCES public.shipping_country_rates(ID) ON UPDATE cascade
);
COMMENT ON COLUMN public.shipping_info.shippingid is 'уникальный идентификатор доставки';
COMMENT ON COLUMN public.shipping_info.vendorid is 'уникальный идентификатор вендора';
COMMENT ON COLUMN public.shipping_info.payment_amount is 'сумма платежа покупателя';
COMMENT ON COLUMN public.shipping_info.shipping_plan_datetime is 'плановое дата время доставки';
COMMENT ON COLUMN public.shipping_info.shipping_transfer_id is 'идентификатор типа и модели доставки - связь с таблицей shipping_transfer';
COMMENT ON COLUMN public.shipping_info.shipping_agremeent_id is 'уникальный идентификатор договора с вендором - связь с таблицейshipping_agremeent';
COMMENT ON COLUMN public.shipping_info.shipping_country_rate_id is 'уникальные идентификатор справочной информации по стоимости доставки в странах - связь с таблицей shipping_country_rates';


INSERT INTO public.shipping_info
(shippingid, vendorid,payment_amount,shipping_plan_datetime,shipping_transfer_id,shipping_agremeent_id,shipping_country_rate_id)
select distinct s.shipping_id,
                s.vendor_id,
                s.payment_amount,
                s.shipping_plan_datetime,
                st.id as shipping_transfer_id ,
                cast((regexp_split_to_array(vendor_agreement_description , E'\\:'))[1] as int) as shipping_agremeent_id,
                scr.id as shipping_country_rate_id
from public.shipping as s
left join public.shipping_transfer as st on (regexp_split_to_array(s.shipping_transfer_description , E'\\:'))[1] = st.transfer_type
and (regexp_split_to_array(s.shipping_transfer_description , E'\\:'))[2] = st.transfer_model
left join public.shipping_country_rates scr on s.shipping_country = scr.shipping_country;

-- Проверяем заполнение таблицы 
select * from public.shipping_info limit 10;