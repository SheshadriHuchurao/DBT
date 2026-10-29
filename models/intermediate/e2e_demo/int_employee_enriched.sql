select e.*, d.department_name, d.cost_center
from {{ ref('stg_postgres__employees') }} e
left join {{ ref('stg_postgres__departments') }} d
