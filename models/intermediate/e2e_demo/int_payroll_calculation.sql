{{ config(materialized='view') }}
-- No physical table/view. dbt embeds this SQL as a CTE in its consumers.
select payroll_id, employee_id, pay_month, base_pay, bonus, deductions,
       base_pay + bonus as gross_pay,
       base_pay + bonus - deductions as net_pay,
       updated_at, source_synced_at, is_deleted
from {{ ref('stg_postgres__payroll') }}
