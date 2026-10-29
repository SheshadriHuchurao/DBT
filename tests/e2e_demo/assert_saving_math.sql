select * from {{ ref('fact_cost_savings') }}
where baseline_cost <= 0 or actual_cost < 0
or abs(savings_amount - (baseline_cost-actual_cost)) > 0.01
or baseline_cost is null or actual_cost is null
