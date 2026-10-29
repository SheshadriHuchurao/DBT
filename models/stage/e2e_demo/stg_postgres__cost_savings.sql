select
    saving_id,
    project_id,
    saving_date,
    baseline_cost,
    actual_cost,
    upper(trim(approval_status)) as approval_status,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'cost_savings') }}
where not coalesce(_fivetran_deleted, false)
