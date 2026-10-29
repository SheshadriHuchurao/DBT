-- Grain: one employee per pay month. Current department attributes (Type 1).
select f.payroll_id, f.pay_month, e.employee_id, e.employee_name,
       e.department_name, e.employment_status, e.annual_salary as current_annual_salary,
       f.base_pay, f.bonus, f.gross_pay, f.deductions, f.net_pay
from {{ ref('fact_payroll') }} f
join {{ ref('dim_employees') }} e on f.employee_sk = e.employee_sk
where not f.is_deleted
