{{ config(
    materialized='table',
    post_hook="
      insert into OPS.AUDIT.MODEL_ROW_COUNTS
        (model_name, row_count, logged_at)
      select '{{ this }}', count(*), current_timestamp()
      from {{ this }}
    "
) }}

select
    {{ surrogate_key(['employee_id']) }} as employee_sk,
    *
from {{ ref('int_postgres__employee') }}