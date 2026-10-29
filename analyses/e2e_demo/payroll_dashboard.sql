select * from {{ ref('data_store_department_payroll') }} order by pay_month, department_name
