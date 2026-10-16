select * from 
{{ ref (fact_fact__order_items)}}
where quantity < 0