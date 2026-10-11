select
    cast("payment_id" as number) as payment_id,
    cast("order_id" as number) as order_id,
    trim("payment_method") as payment_method,
    cast("amount" as number(12,2)) as amount,
    trim("payment_status") as payment_status,
    cast("payment_timestamp" as timestamp_ntz) as payment_timestamp,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'payments') }}
