{{ config(
    pre_hook=["{{ set_model_query_tag() }}", "{{ audit_model_event('MODEL_STARTED') }}"],
    post_hook=["{{ audit_model_event('MODEL_MATERIALIZED') }}", "{{ clear_model_query_tag() }}"]
) }}
select {{ surrogate_key('project_id') }} as project_sk,
       project_id, project_name, department_id, budget_amount
from {{ ref('stg_postgres__projects') }}
