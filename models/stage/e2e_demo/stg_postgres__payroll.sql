select
    payroll_id,
    employee_id,
    pay_month,
    base_pay,
    bonus,
    deductions,
    updated_at,
    _fivetran_synced as source_synced_at,
    coalesce(_fivetran_deleted, false) as is_deleted
from {{ source('postgres_landing', 'payroll') }}
