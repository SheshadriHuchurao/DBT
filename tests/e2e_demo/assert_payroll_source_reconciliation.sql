-- Detect missing changes, duplicates and delete propagation errors.
with source_totals as (
 select count(*) as n, coalesce(sum(base_pay + bonus - deductions),0) as amount
 from {{ ref('stg_postgres__payroll') }} where not is_deleted
), target_totals as (
 select count(*) as n, coalesce(sum(net_pay),0) as amount
 from {{ ref('fact_payroll') }} where not is_deleted
)
select s.n as source_rows, t.n as target_rows, s.amount as source_amount, t.amount as target_amount
from source_totals s cross join target_totals t
where s.n <> t.n or abs(s.amount - t.amount) > 0.01
