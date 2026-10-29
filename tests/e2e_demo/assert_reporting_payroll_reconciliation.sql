with f as (
 select count(*) as n, coalesce(sum(net_pay),0) as amount
 from {{ ref('fact_payroll') }} where not is_deleted
), r as (
 select count(*) as n, coalesce(sum(net_pay),0) as amount
 from {{ ref('data_store_employee_salary') }}
)
select f.n as fact_rows, r.n as report_rows, f.amount as fact_amount, r.amount as report_amount
from f cross join r where f.n <> r.n or abs(f.amount-r.amount) > 0.01
