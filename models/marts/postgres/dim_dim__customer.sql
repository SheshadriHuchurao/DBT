{{ config(
    pre_hook="{{ audit('MODEL_STARTED', 'customer') }}"
) }}

-- Keep your existing customer SELECT query here

select  {{ surrogate_key(['customer_id']) }} as customer_sk, *
from {{ ref('int_postgres__customers') }}