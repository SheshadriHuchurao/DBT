select saving_id, project_id, saving_date, baseline_cost, actual_cost,
       baseline_cost - actual_cost as savings_amount,
       (baseline_cost - actual_cost) / nullif(baseline_cost, 0) * 100 as savings_pct,
       approval_status, updated_at
from {{ ref('stg_postgres__cost_savings') }}