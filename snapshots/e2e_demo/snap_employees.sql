{% snapshot snap_employees %}
{{ config(
    target_database='PROD', target_schema='SNAPSHOTS',
    unique_key='employee_id', strategy='timestamp', updated_at='updated_at',
    invalidate_hard_deletes=true
) }}
-- Source has a trigger that advances updated_at whenever a row changes.
-- Snapshot source state, not a transformed gold table.
select employee_id, employee_name, department_id, hire_date,
       employment_status, annual_salary, updated_at
from {{ source('postgres_landing', 'employees') }}
where not coalesce(_fivetran_deleted, false)
{% endsnapshot %}
