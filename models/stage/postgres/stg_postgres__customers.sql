with final as 
(select
    cast("customer_id" as number) as customer_id,
    trim("customer_name") as customer_name,
    lower(trim("email")) as email,
    trim("city") as city,
    trim("loyalty_tier") as loyalty_tier,
    cast("signup_date" as date) as signup_date,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'customers') }}
)

select * from final
