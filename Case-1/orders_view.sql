
/* Корректировка формирования представления orders. 
Была расширена логика формирования данных.
Дата проставления статуса заказа и сам статус хранятся в новой таблице production.OrderStatusLog.*/


create or REPLACE view analysis.orders as (
    select  o.order_id,  
        orl.status_id as status , 
        o.user_id, 
        o.order_ts, 
        o.cost 
    from production.orders o  
        join production.orderstatuslog orl on o.order_id = orl.order_id and o.order_ts = orl.dttm 
    );
