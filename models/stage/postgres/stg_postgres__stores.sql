select
    cast("store_id" as number) as store_id,
    trim("store_name") as store_name,
    trim("city") as city,
    trim("region") as region,
    cast("opened_date" as date) as opened_date,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'stores') }}