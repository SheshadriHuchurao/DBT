select
    project_id,
    trim(project_name) as project_name,
    department_id,
    budget_amount,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'projects') }}
where not coalesce(_fivetran_deleted, false)
