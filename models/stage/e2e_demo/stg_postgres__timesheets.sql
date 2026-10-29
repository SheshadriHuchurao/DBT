select
    timesheet_id,
    employee_id,
    project_id,
    work_date,
    hours_worked,
    hourly_cost,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'timesheets') }}
where not coalesce(_fivetran_deleted, false)
