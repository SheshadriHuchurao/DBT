{{ config(
    pre_hook=["{{ set_model_query_tag() }}", "{{ audit_model_event('MODEL_STARTED') }}"],
    post_hook=["{{ audit_model_event('MODEL_MATERIALIZED') }}", "{{ clear_model_query_tag() }}"]
) }}
select saving_id, {{ surrogate_key('project_id') }} as project_sk,
       project_id, saving_date, baseline_cost, actual_cost,
       savings_amount, savings_pct, approval_status
from {{ ref('int_cost_savings_details') }}
