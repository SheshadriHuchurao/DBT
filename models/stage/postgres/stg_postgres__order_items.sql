select
    cast("order_item_id" as number) as order_item_id,
    cast("order_id" as number) as order_id,
    cast("product_id" as number) as product_id,
    cast("quantity" as number) as quantity,
    cast("unit_price" as number(12,2)) as unit_price,
    cast("discount_pct" as number(8,4)) as discount_pct,
    cast("tax_rate" as number(8,4)) as tax_rate,
    cast("unit_cost_at_sale" as number(12,2)) as unit_cost_at_sale,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'order_items') }}
