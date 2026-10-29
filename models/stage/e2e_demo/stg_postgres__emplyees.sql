select
    employee_id,
    trim(employee_name) as employee_name,
    department_id,
    hire_date,
    upper(trim(employment_status)) as employment_status,
    annual_salary,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'employees') }}
where not coalesce(_fivetran_deleted, false)
