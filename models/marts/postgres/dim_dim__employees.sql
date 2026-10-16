{{ config(
    materialized='incremental',
    unique_key='employee_sk',
    incremental_strategy='merge'
) }}

select
    {{ surrogate_key(['employee_id']) }} as employee_sk,
    *
from {{ ref('int_postgres__employee') }}