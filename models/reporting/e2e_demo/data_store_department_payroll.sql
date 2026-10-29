select pay_month, department_name, count(distinct employee_id) as employees_paid,
       sum(gross_pay) as gross_pay, sum(deductions) as deductions, sum(net_pay) as net_pay
from {{ ref('data_store_employee_salary') }}
group by pay_month, department_name
