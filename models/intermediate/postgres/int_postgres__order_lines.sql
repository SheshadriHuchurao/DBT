select
 i.order_item_id, i.order_id, i.product_id, o.customer_id, o.store_id, o.employee_id,
 o.order_date, o.sales_channel, o.order_status, o.currency,
 i.quantity, i.unit_price, i.discount_pct, i.tax_rate, i.unit_cost_at_sale,
 {{ money('i.quantity * i.unit_price') }} as gross_amount,
 {{ money('i.quantity * i.unit_price * i.discount_pct') }} as discount_amount,
 {{ money('i.quantity * i.unit_price * (1 - i.discount_pct)') }} as net_amount,
 {{ money('round(i.quantity * i.unit_price * (1 - i.discount_pct), 2) * i.tax_rate') }} as tax_amount,
 {{ money('i.quantity * i.unit_cost_at_sale') }} as cost_amount,
 greatest(o.updated_at, i.updated_at) as source_updated_at
from {{ ref('stg_postgres__order_items') }} i
join {{ ref('stg_postgres__orders') }} o on i.order_id = o.order_id
