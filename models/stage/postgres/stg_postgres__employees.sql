with final as (
    select
    cast("employee_id" as number) as employee_id,
    trim("employee_name") as employee_name,
    cast("store_id" as number) as store_id,
    trim("job_title") as job_title,
    cast("hire_date" as date) as hire_date,
    cast("updated_at" as timestamp_ntz) as updated_at
from {{ source('postgres_source', 'employees') }}
)

select * from final
