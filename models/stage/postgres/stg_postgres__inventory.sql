with final as (
select
    cast("inventory_id" as number) as inventory_id,
    cast("product_id" as number) as product_id,
    cast("store_id" as number) as store_id,
    cast("inventory_date" as date) as inventory_date,
    cast("quantity_on_hand" as number) as quantity_on_hand,
    cast("reorder_level" as number) as reorder_level,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'inventory') }}
)

select * from final;

