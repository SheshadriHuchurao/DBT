select employee_id, employee_name, annual_salary, dbt_valid_from, dbt_valid_to
from {{ ref('snap_employees') }} where employee_id = 1 order by dbt_valid_from
