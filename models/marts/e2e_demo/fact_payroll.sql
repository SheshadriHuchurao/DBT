{{ config(
    materialized='incremental', incremental_strategy='merge',
    unique_key='payroll_id', on_schema_change='fail',
    pre_hook=["{{ set_model_query_tag() }}", "{{ audit_model_event('MODEL_STARTED') }}"],
    post_hook=["{{ audit_model_event('MODEL_MATERIALIZED') }}", "{{ clear_model_query_tag() }}"]
) }}
-- Keep tombstones so MERGE can update previously loaded deleted records.
-- Dimension attributes are NOT cached here: reports join the current dimensions.
select payroll_id, {{ surrogate_key('employee_id') }} as employee_sk,
       employee_id, pay_month, base_pay, bonus, deductions, gross_pay, net_pay,
       updated_at, source_synced_at, is_deleted,
       current_timestamp() as dbt_processed_at
from {{ ref('int_payroll_calculation') }}
{% if is_incremental() %}
where source_synced_at >= (
  select dateadd(day, -{{ var('incremental_lookback_days', 3) }},
         coalesce(max(source_synced_at), '1900-01-01'::timestamp_tz)) from {{ this }}
)
or is_deleted
{% endif %}
