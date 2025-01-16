drop table if exists public.shipping_agreement;

create table public.shipping_agreement(
	agreementid int4 primary key,
	agreement_number TEXT,
	agreement_rate NUMERIC(14,3),
	agreement_commission NUMERIC(14,3),
	FOREIGN KEY (agreementid) REFERENCES public.shipping_info(shipping_agremeent_id) ON UPDATE cascade
);
comment on column public.shipping_agreement.agreementid is 'ИД договора';
comment on column public.shipping_agreement.agreement_number is 'Номер договора';
comment on column public.shipping_agreement.agreement_rate is 'Процент на стоимость доставки';
comment on column public.shipping_agreement.agreement_commission is 'Процент от сделки нашей компании';


insert into  public.shipping_agreement
	(agreementid, agreement_number , agreement_rate, agreement_commission)
	select distinct cast(vendor_agreement_description[1] as int4) , 
					vendor_agreement_description[2], 
					cast(vendor_agreement_description[3] as NUMERIC(14,3)), 
					cast(vendor_agreement_description[4] as NUMERIC(14,3)) 
	from ( 
		select regexp_split_to_array(vendor_agreement_description, E'\\:') as vendor_agreement_description 
		from  public.shipping) as sa;   
		
	-- Проверка заполнения
select * from public.shipping_agreement limit 10;
