select project_id, sum(hours_worked) as total_hours,
       sum(hours_worked * hourly_cost) as labor_cost
from {{ ref('stg_postgres__timesheets') }}
group by project_id
