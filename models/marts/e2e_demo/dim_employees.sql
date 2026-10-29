{{ config(
    pre_hook=["{{ set_model_query_tag() }}", "{{ audit_model_event('MODEL_STARTED') }}"],
    post_hook=["{{ audit_model_event('MODEL_MATERIALIZED') }}", "{{ clear_model_query_tag() }}"]
) }}
select {{ surrogate_key('employee_id') }} as employee_sk,
       e.employee_id, e.employee_name, e.department_id, e.department_name,
       e.cost_center, e.hire_date, e.employment_status, s.status_description,
       e.annual_salary, e.updated_at
from {{ ref('int_employee_enriched') }} e
left join {{ ref('employment_status') }} s on e.employment_status = s.status_code
