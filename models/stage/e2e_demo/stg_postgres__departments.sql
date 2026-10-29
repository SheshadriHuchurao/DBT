select
    department_id,
    trim(department_name) as department_name,
    cost_center,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'departments') }}
where not coalesce(_fivetran_deleted, false)
