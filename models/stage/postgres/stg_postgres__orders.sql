select
    cast("order_id" as number) as order_id,
    cast("customer_id" as number) as customer_id,
    cast("store_id" as number) as store_id,
    cast("employee_id" as number) as employee_id,
    cast("order_date" as date) as order_date,
    trim("sales_channel") as sales_channel,
    trim("order_status") as order_status,
    trim("currency") as currency,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'orders') }}
