-- Aggregate both facts independently BEFORE joining to avoid fanout.
with savings as (
 select project_sk, sum(baseline_cost) as baseline_cost, sum(actual_cost) as actual_cost,
        sum(savings_amount) as approved_savings
 from {{ ref('fact_cost_savings') }} where approval_status = 'APPROVED'
 group by project_sk
)
select p.project_id, p.project_name, p.budget_amount,
       coalesce(l.total_hours, 0) as total_hours, coalesce(l.labor_cost, 0) as labor_cost,
       coalesce(s.baseline_cost, 0) as approved_baseline_cost,
       coalesce(s.actual_cost, 0) as approved_actual_cost,
       coalesce(s.approved_savings, 0) as approved_savings,
       s.approved_savings / nullif(s.baseline_cost, 0) * 100 as savings_pct
from {{ ref('dim_projects') }} p
left join savings s on p.project_sk = s.project_sk
left join {{ ref('int_project_labor') }} l on p.project_id = l.project_id
